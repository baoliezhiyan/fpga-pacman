#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xil_io.h"
#include "sleep.h"

// ==========================================
// 解决 Xilinx 宏定义与 USB 协议栈枚举的命名冲突
// ==========================================
#undef FALSE
#undef TRUE

// USB 驱动协议栈头文件
#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/USB.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/transfer.h"
#include "lw_usb/HID.h"

// ==========================================
// 你的 AXI 硬件寄存器映射
// ==========================================
#define PACMAN_BASEADDR XPAR_PACMAN_AXI4_GRAPHICS_0_S00_AXI_BASEADDR
#define REG_PACMAN_X 0
#define REG_PACMAN_Y 4

// ==========================================
// 游戏物理常量定义
// ==========================================
#define PACMAN_RADIUS 16   // 吃豆人半径
#define SCREEN_WIDTH  640  // 屏幕宽度
#define SCREEN_HEIGHT 480  // 屏幕高度

// ==========================================
// USB 键盘常量与外部变量
// ==========================================
extern HID_DEVICE hid_device;
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };

#define KEY_W 0x1A
#define KEY_S 0x16
#define KEY_A 0x04
#define KEY_D 0x07

// 提取设备信息的辅助函数 (已清理未使用变量警告)
BYTE GetDriverandReport(BYTE addr) {
    BYTE i;
    BYTE device = 0xFF;
    DEV_RECORD* tpl_ptr;

    xil_printf("Reached USB_STATE_RUNNING (0x40)\n");
    for (i = 1; i < USB_NUMDEVICES; i++) {
        tpl_ptr = GetDevtable(i);
        if (tpl_ptr->epinfo != NULL) {
            xil_printf("Device: %d %s \n", i, devclasses[tpl_ptr->devclass]);
            device = tpl_ptr->devclass;
        }
    }
    return device;
}

// ==========================================
// 碰撞预测函数 (当前仅包含屏幕物理边缘)
// ==========================================
// 返回 1 表示撞墙(越界)，返回 0 表示安全
int check_collision(int next_x, int next_y) {
    // 考虑吃豆人的物理半径，确保任何一个像素都不会离开屏幕
    if (next_x - PACMAN_RADIUS < 0) return 1;                  // 撞左边界
    if (next_x + PACMAN_RADIUS > SCREEN_WIDTH - 1) return 1;   // 撞右边界
    if (next_y - PACMAN_RADIUS < 0) return 1;                  // 撞上边界
    if (next_y + PACMAN_RADIUS > SCREEN_HEIGHT - 1) return 1;  // 撞下边界

    // 之后你想加墙壁，直接把判断条件写在这个 return 0 之前即可
    return 0;
}

int main() {
    // 1. 基础平台初始化
    init_platform();

    xil_printf("Initializing MAX3421E USB Controller...\n");
    MAX3421E_init();
    xil_printf("Initializing USB Protocol Stack...\n");
    USB_init();

    // 2. 吃豆人物理状态初始化
    int x_pos = 320;
    int y_pos = 240;
    int step = 3;             // 每次移动像素数，决定吃豆人速度
    BYTE current_key = 0;     // 缓存当前按下的方向键

    // USB 状态机变量
    BYTE rcode;
    BOOT_KBD_REPORT kbdbuf;
    BYTE runningdebugflag = 0;
    BYTE errorflag = 0;
    BYTE device = 0;
    BYTE addr = 1;

    xil_printf("Pac-Man Engine Ready. Waiting for USB Keyboard...\n");

    // 3. 游戏与 USB 主循环
    while (1) {
        // --- A. 维持 USB 硬件与协议栈运行 ---
        MAX3421E_Task();
        USB_Task();

        // --- B. 键盘读取逻辑 ---
        if (GetUsbTaskState() == USB_STATE_RUNNING) {
            if (!runningdebugflag) {
                runningdebugflag = 1;
                device = GetDriverandReport(addr);
            } else if (device == 1) { // 确认是键盘接入

                rcode = kbdPoll(&kbdbuf);

                if (rcode == 0) {
                    current_key = kbdbuf.keycode[0];
                }
                else if (rcode != hrNAK) {
                    continue;
                }
            }
        }
        else if (GetUsbTaskState() == USB_STATE_ERROR) {
            if (!errorflag) {
                errorflag = 1;
                xil_printf("USB Error State\n");
            }
            current_key = 0;
        }
        else {
            if (runningdebugflag) {
                runningdebugflag = 0;
                MAX3421E_init();
                USB_init();
            }
            errorflag = 0;
            current_key = 0;
        }

        // --- C. 游戏物理引擎更新 (预测碰撞) ---
        // 假设吃豆人按键指令走一步，算出未来坐标
        int next_x = x_pos;
        int next_y = y_pos;

        switch (current_key) {
            case KEY_W: next_y -= step; break;
            case KEY_S: next_y += step; break;
            case KEY_A: next_x -= step; break;
            case KEY_D: next_x += step; break;
            default: break;
        }

        // 调用碰撞预测函数，如果安全 (返回0) 才实际更新坐标
        if (check_collision(next_x, next_y) == 0) {
            x_pos = next_x;
            y_pos = next_y;
        }

        // --- D. 写入硬件 AXI 总线，驱动 HDMI 显示 ---
        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_X, x_pos);
        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_Y, y_pos);

        // --- E. 帧率控制 ---
        usleep(16000);
    }

    cleanup_platform();
    return 0;
}
