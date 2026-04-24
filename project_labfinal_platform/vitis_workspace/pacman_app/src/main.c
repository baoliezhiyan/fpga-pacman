#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xil_io.h"
#include "sleep.h"

// 解决宏定义冲突
#undef FALSE
#undef TRUE

// USB 头文件
#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/USB.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/transfer.h"
#include "lw_usb/HID.h"

#define PACMAN_BASEADDR XPAR_PACMAN_AXI4_GRAPHICS_0_S00_AXI_BASEADDR
#define REG_PACMAN_X 0
#define REG_PACMAN_Y 4

#define PACMAN_RADIUS 16

extern HID_DEVICE hid_device;
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };

#define KEY_W 0x1A
#define KEY_S 0x16
#define KEY_A 0x04
#define KEY_D 0x07

BYTE GetDriverandReport(BYTE addr) {
    BYTE i;
    BYTE device = 0xFF;
    DEV_RECORD* tpl_ptr;
    for (i = 1; i < USB_NUMDEVICES; i++) {
        tpl_ptr = GetDevtable(i);
        if (tpl_ptr->epinfo != NULL) {
            device = tpl_ptr->devclass;
        }
    }
    return device;
}

// ==========================================
// 游戏物理：AABB 碰撞检测
// ==========================================
// px, py: 吃豆人中心坐标 | r: 吃豆人半径
// rx1, rx2: 墙壁左、右边界 | ry1, ry2: 墙壁上、下边界
int check_rect_collision(int px, int py, int r, int rx1, int rx2, int ry1, int ry2) {
    int pac_left   = px - r;
    int pac_right  = px + r;
    int pac_top    = py - r;
    int pac_bottom = py + r;

    // 当且仅当四个方向都发生重叠时，才算真正撞上
    if (pac_left < rx2 && pac_right > rx1 && pac_top < ry2 && pac_bottom > ry1) {
        return 1;
    }
    return 0;
}

// 预测函数：如果走到 (next_x, next_y) 是否会撞墙
int check_collision(int next_x, int next_y) {
    int r = PACMAN_RADIUS;

    // 1. 外部边框围墙 (和 SystemVerilog 里的绘制坐标严格对应)
    if (check_rect_collision(next_x, next_y, r, 10,  20,  10, 469)) return 1; // 左墙
    if (check_rect_collision(next_x, next_y, r, 619, 629, 10, 469)) return 1; // 右墙
    if (check_rect_collision(next_x, next_y, r, 20,  619, 10,  20)) return 1; // 顶墙
    if (check_rect_collision(next_x, next_y, r, 20,  619, 459, 469)) return 1; // 底墙

    // 2. 内部障碍墙壁
    if (check_rect_collision(next_x, next_y, r, 100, 540, 100, 120)) return 1; // 墙A(上)
    if (check_rect_collision(next_x, next_y, r, 100, 540, 360, 380)) return 1; // 墙B(下)
    if (check_rect_collision(next_x, next_y, r, 300, 340, 180, 300)) return 1; // 墙C(柱)

    return 0; // 安全
}

int main() {
    init_platform();
    MAX3421E_init();
    USB_init();

    // 初始位置设定在安全区域（比如地图左侧）
    int x_pos = 50;
    int y_pos = 240;
    int step = 3;
    BYTE current_key = 0;

    BYTE rcode;
    BOOT_KBD_REPORT kbdbuf;
    BYTE runningdebugflag = 0, errorflag = 0, device = 0, addr = 1;

    xil_printf("Pac-Man Engine Ready.\n");

    while (1) {
        MAX3421E_Task();
        USB_Task();

        if (GetUsbTaskState() == USB_STATE_RUNNING) {
            if (!runningdebugflag) {
                runningdebugflag = 1;
                device = GetDriverandReport(addr);
            } else if (device == 1) {
                rcode = kbdPoll(&kbdbuf);
                if (rcode == 0) current_key = kbdbuf.keycode[0];
                else if (rcode != hrNAK) continue;
            }
        } else if (GetUsbTaskState() == USB_STATE_ERROR) {
            if (!errorflag) errorflag = 1;
            current_key = 0;
        } else {
            if (runningdebugflag) {
                runningdebugflag = 0;
                MAX3421E_init();
                USB_init();
            }
            errorflag = 0;
            current_key = 0;
        }

        // 物理更新与预测
        int next_x = x_pos;
        int next_y = y_pos;

        switch (current_key) {
            case KEY_W: next_y -= step; break;
            case KEY_S: next_y += step; break;
            case KEY_A: next_x -= step; break;
            case KEY_D: next_x += step; break;
            default: break;
        }

        // AABB 碰撞阻挡判定
        if (check_collision(next_x, next_y) == 0) {
            x_pos = next_x;
            y_pos = next_y;
        }

        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_X, x_pos);
        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_Y, y_pos);

        usleep(16000);
    }

    cleanup_platform();
    return 0;
}
