#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xparameters.h"
#include "xuartlite_l.h"
#include "xil_io.h"
#include "sleep.h"

// 取消重定义冲突
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
#define UART_BASEADDR XPAR_UARTLITE_0_BASEADDR
#define REG_PACMAN_X    0
#define REG_PACMAN_Y    4
#define REG_GHOST1_X    8
#define REG_GHOST1_Y    12
#define REG_GHOST2_X    16
#define REG_GHOST2_Y    20
#define REG_GHOST3_X    24
#define REG_GHOST3_Y    28
#define REG_GHOST4_X    32
#define REG_GHOST4_Y    36
#define REG_GAME_SCORE  40
#define REG_GHOST_STATUS 44
#define REG_LIVES       48
#define REG_PACMAN_DIR  56
#define REG_DOT_CMD     60
#define REG_SUPER_DOT   64
#define REG_GHOST_DIRS  68
#define REG_GHOST_RETURNING 72 

#define REG_TEXT0       76
#define REG_TEXT1       80
#define REG_TEXT2       84
#define REG_TEXT3       88
#define REG_TEXT4       92

#define TILE_SIZE 16
#define PACMAN_RADIUS 14 

// 游戏全局变量
int game_started = 0;
int score = 0;
int hp = 9;                  
int invincibility_timer = 0;   
int is_paused = 0;
int is_game_over = 0; 
int is_dead = 0;        
int cheat_level_target = 0; 
int total_dots = 0;   
int total_dots_max = 0; 
int current_level = 1;  

int x_pos = 320;
int y_pos = 32;
int current_dx = 0, current_dy = 0;
int desired_dx = 0, desired_dy = 0;
int current_dir = 0;

extern HID_DEVICE hid_device;
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };

#define KEY_W 0x1A
#define KEY_S 0x16
#define KEY_A 0x04
#define KEY_D 0x07
#define KEY_Q 0x14 
#define KEY_E 0x08 
#define KEY_1 0x1E
#define KEY_2 0x1F
#define KEY_3 0x20
#define KEY_R 0x15
#define KEY_H 0x0B

typedef enum {
    GHOST_IDLE,
    GHOST_EXITING,
    GHOST_SCATTER,
    GHOST_DEAD,
    GHOST_RETURNING, 
    GHOST_IN_HOUSE   
} GhostState;

typedef struct {
    int x; int y;
    int target_x; int target_y;
    int dir;       
    GhostState state;
    int original_mode; 
    int panic_timer;   
    int spawn_x; 
    int spawn_y; 
} Ghost;

#define MODE_RANDOM  0
#define MODE_TRACK   1
#define MODE_TAIL    2 
#define MODE_FLEE    3 

Ghost ghosts[4]; 

const int dir_dx[4] = {1, 0, -1, 0};
const int dir_dy[4] = {0, -1, 0, 1};

struct Point { int x; int y; };
struct Point inky_patrol_points[3] = {
    {320, 32},   
    {32, 448},   
    {608, 448}   
};

#define POWER_MODE_FLASH_TIME 120 

int power_mode_timer = 0; 
uint8_t dot_map[30][40] = {0}; 
uint32_t dot_toggle = 0;       
uint32_t super_dot_state = 0x0F; 

struct SuperDot { int cx; int cy; int bit; };
struct SuperDot super_dots[4] = {
    {144, 144, 0x01}, 
    {496, 144, 0x02}, 
    {144, 384, 0x04}, 
    {496, 384, 0x08}  
};

extern const uint8_t level_map[30][40] = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 2, 2, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
    {1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1},
    {1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
};

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

void set_hw_dot(int tx, int ty, int has_dot) {
    int addr = ty * 40 + tx; 
    dot_toggle ^= 0x80000000; 
    uint32_t cmd = dot_toggle | (has_dot << 11) | addr;
    Xil_Out32(PACMAN_BASEADDR + REG_DOT_CMD, cmd);
}

void update_ui_text(const char* str) {
    uint32_t regs[5] = {0};
    for (int i = 0; i < 5; i++) {
        uint32_t val = 0;
        for(int j = 0; j < 4; j++) {
            char c = str[i*4 + j];
            if (c == 0) c = ' ';
            if (c >= 'a' && c <= 'z') c -= 32;
            val |= ((uint32_t)c) << (8 * (3 - j));
        }
        regs[i] = val;
    }
    Xil_Out32(PACMAN_BASEADDR + REG_TEXT0, regs[0]);
    Xil_Out32(PACMAN_BASEADDR + REG_TEXT1, regs[1]);
    Xil_Out32(PACMAN_BASEADDR + REG_TEXT2, regs[2]);
    Xil_Out32(PACMAN_BASEADDR + REG_TEXT3, regs[3]);
    Xil_Out32(PACMAN_BASEADDR + REG_TEXT4, regs[4]);
}

void load_level() {
    x_pos = 320; y_pos = 32;
    current_dx = 0; current_dy = 0; 
    desired_dx = 0; desired_dy = 0; 
    current_dir = 0;
    
    ghosts[0] = (Ghost){304, 240, 32, 32, 1, GHOST_IDLE, MODE_TRACK, 0, 304, 240};
    ghosts[1] = (Ghost){336, 240, 608, 32, 1, GHOST_IDLE, MODE_TRACK, 0, 336, 240};
    ghosts[2] = (Ghost){304, 272, 32, 448, 1, GHOST_IDLE, MODE_TRACK, 0, 304, 272};
    ghosts[3] = (Ghost){336, 272, 608, 448, 1, GHOST_IDLE, (current_level >= 2) ? MODE_TAIL : MODE_RANDOM, 0, 336, 272};

    for(int y=0; y<30; y++) {
        for(int x=0; x<40; x++) {
            if(dot_map[y][x]) { dot_map[y][x] = 0; set_hw_dot(x, y, 0); }
        }
    }

    total_dots = 4;
    super_dot_state = 0x0F;
    for (int y = 0; y < 29; y++) {
        for (int x = 0; x < 39; x++) {
            if (level_map[y][x] == 0 && level_map[y+1][x] == 0 && level_map[y][x+1] == 0 && level_map[y+1][x+1] == 0) {
                if (x >= 18 && x <= 21 && y >= 13 && y <= 17) continue;
                if (x == 19 && y == 1) continue;
                if ((x == 8 && y == 8) || (x == 30 && y == 8) || (x == 8 && y == 23) || (x == 30 && y == 23)) continue;

                dot_map[y][x] = 1;      
                set_hw_dot(x, y, 1);    
                total_dots++;           
            }
        }
    }
    total_dots_max = total_dots; 
    Xil_Out32(PACMAN_BASEADDR + REG_SUPER_DOT, super_dot_state);

    is_game_over = 0;
    is_paused = 0;
    is_dead = 0;      
    game_started = 0; 
    power_mode_timer = 0;
}

int check_rect_collision(int px, int py, int r, int rx1, int rx2, int ry1, int ry2) {
    int pac_left   = px - r;
    int pac_right  = px + r;
    int pac_top    = py - r;
    int pac_bottom = py + r;

    if (pac_left < rx2 && pac_right > rx1 && pac_top < ry2 && pac_bottom > ry1) {
        return 1;
    }
    return 0;
}

int is_solid(int tile_x, int tile_y, int dy) {
    if (level_map[tile_y][tile_x] == 1) return 1; 
    if (level_map[tile_y][tile_x] == 2) {
        if (dy < 0) return 0; 
        else return 1; 
    }
    return 0; 
}

int check_collision(int next_x, int next_y, int dy) {
    int left   = next_x - PACMAN_RADIUS;
    int right  = next_x + PACMAN_RADIUS;
    int top    = next_y - PACMAN_RADIUS;
    int bottom = next_y + PACMAN_RADIUS;

    int tile_left   = left / TILE_SIZE;
    int tile_right  = right / TILE_SIZE;
    int tile_top    = top / TILE_SIZE;
    int tile_bottom = bottom / TILE_SIZE;

    if (tile_left < 0 || tile_right >= 40 || tile_top < 0 || tile_bottom >= 30) return 1;

    if (is_solid(tile_left, tile_top, dy)) return 1;
    if (is_solid(tile_right, tile_top, dy)) return 1;
    if (is_solid(tile_left, tile_bottom, dy)) return 1;
    if (is_solid(tile_right, tile_bottom, dy)) return 1;

    return 0; 
}

int check_ghost_collision(int next_x, int next_y, int dy) {
    int left   = next_x - 12; 
    int right  = next_x + 12;
    int top    = next_y - 12;
    int bottom = next_y + 12;

    int tile_left   = left / TILE_SIZE;
    int tile_right  = right / TILE_SIZE;
    int tile_top    = top / TILE_SIZE;
    int tile_bottom = bottom / TILE_SIZE;

    if (tile_left < 0 || tile_right >= 40 || tile_top < 0 || tile_bottom >= 30) return 1;

    if (is_solid(tile_left, tile_top, dy)) return 1;
    if (is_solid(tile_right, tile_top, dy)) return 1;
    if (is_solid(tile_left, tile_bottom, dy)) return 1;
    if (is_solid(tile_right, tile_bottom, dy)) return 1;

    return 0; 
}

void ghost_decision_engine(Ghost *g, int mode) {
    if (g->x % TILE_SIZE != 0 || g->y % TILE_SIZE != 0) {
        g->x += dir_dx[g->dir] * 2; 
        g->y += dir_dy[g->dir] * 2;
        return;
    }

    int valid_dirs[4];
    int num_valid = 0;

    for (int d = 0; d < 4; d++) {
        if (d == ((g->dir + 2) % 4)) continue;
        if (!check_ghost_collision(g->x + dir_dx[d] * 16, g->y + dir_dy[d] * 16, dir_dy[d])) {
            valid_dirs[num_valid++] = d;
        }
    }

    if (num_valid == 0) {
        g->dir = (g->dir + 2) % 4; 
    } 
    else if (num_valid == 1) {
        g->dir = valid_dirs[0];
    }
    else {
        if (mode == MODE_RANDOM) {
            g->dir = valid_dirs[rand() % num_valid];
        } 
        else if (mode == MODE_TRACK || mode == MODE_TAIL || mode == MODE_FLEE) {
            int best_dir = valid_dirs[0];
            int min_dist = 99999999;
            
            for (int i = 0; i < num_valid; i++) {
                int d = valid_dirs[i];
                int next_x = g->x + dir_dx[d] * 16;
                int next_y = g->y + dir_dy[d] * 16;
                
                int dist = (next_x - g->target_x) * (next_x - g->target_x) + 
                           (next_y - g->target_y) * (next_y - g->target_y);
                           
                if (dist < min_dist) {
                    min_dist = dist;
                    best_dir = d;
                }
            }

            if (mode == MODE_FLEE) {
                int flee_dirs[4];
                int flee_count = 0;
                for (int i = 0; i < num_valid; i++) {
                    if (valid_dirs[i] != best_dir) flee_dirs[flee_count++] = valid_dirs[i];
                }
                if (flee_count > 0) g->dir = flee_dirs[rand() % flee_count];
                else g->dir = best_dir; 
            } else {
                g->dir = best_dir; 
            }
        }
    }

    g->x += dir_dx[g->dir] * 2;
    g->y += dir_dy[g->dir] * 2;
}

int main() {
    init_platform();
    MAX3421E_init();
    USB_init();

    int step = 2;
    BYTE current_key = 0;
    BYTE rcode;
    BOOT_KBD_REPORT kbdbuf;
    BYTE runningdebugflag = 0, errorflag = 0, device = 0, addr = 1;

    int input_timer = 0;
    const int BUFFER_TIME = 20; 
    unsigned int global_frame_counter = 0;

    int usb_poll_counter = 0;

    xil_printf("Pac-Man Engine Ready.\n");

    load_level(); 
    
    xil_printf("Game Start! Control via USB Keyboard or UART Terminal.\n");

    while (1) {
        MAX3421E_Task();
        USB_Task();

        usb_poll_counter++;
        if (usb_poll_counter >= 5) {
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
            
            usb_poll_counter = 0;
        }

        char unified_key = 0;

        if (current_key == KEY_W) unified_key = 'W';
        else if (current_key == KEY_S) unified_key = 'S';
        else if (current_key == KEY_A) unified_key = 'A';
        else if (current_key == KEY_D) unified_key = 'D';
        else if (current_key == KEY_Q) unified_key = 'Q'; 
        else if (current_key == KEY_E) unified_key = 'E'; 
        else if (current_key == KEY_1) unified_key = '1'; 
        else if (current_key == KEY_2) unified_key = '2'; 
        else if (current_key == KEY_3) unified_key = '3'; 
        else if (current_key == KEY_R) unified_key = 'R'; 
        else if (current_key == KEY_H) unified_key = 'H'; 

        while (!XUartLite_IsReceiveEmpty(UART_BASEADDR)) {
            char uart_key = XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
            if (uart_key == 'w' || uart_key == 'W') unified_key = 'W';
            if (uart_key == 's' || uart_key == 'S') unified_key = 'S';
            if (uart_key == 'a' || uart_key == 'A') unified_key = 'A';
            if (uart_key == 'd' || uart_key == 'D') unified_key = 'D';
            if (uart_key == 'q' || uart_key == 'Q') unified_key = 'Q'; 
            if (uart_key == 'e' || uart_key == 'E') unified_key = 'E'; 
            if (uart_key == '1') unified_key = '1'; 
            if (uart_key == '2') unified_key = '2'; 
            if (uart_key == '3') unified_key = '3'; 
            if (uart_key == 'r' || uart_key == 'R') unified_key = 'R'; 
            if (uart_key == 'h' || uart_key == 'H') unified_key = 'H'; 
        }

        current_key = 0; 

        if (unified_key == 'H') {
            if (hp < 9) {
                hp++;
            }
        }

        if (unified_key == 'Q' && !is_paused && !is_game_over && !is_dead) {
            is_paused = 1;
            cheat_level_target = 0; 
        }
        else if (unified_key == 'E') {
            if (is_paused && !is_game_over && !is_dead) {
                is_paused = 0;
            }
            else if (is_game_over && total_dots <= 0) {
                if (current_level < 3) {
                    current_level++;
                    load_level();
                } 
            }
        }
        else if (unified_key == '1' && is_paused) cheat_level_target = 1;
        else if (unified_key == '2' && is_paused) cheat_level_target = 2;
        else if (unified_key == '3' && is_paused) cheat_level_target = 3;
        
        else if (unified_key == 'R') {
            if (is_dead || (is_game_over && current_level == 3)) {
                current_level = 1; hp = 9; score = 0;
                load_level();
            } else if (is_paused && cheat_level_target != 0) {
                current_level = cheat_level_target; hp = 9; score = 0;
                load_level();
            }
        }

        if (!is_paused && !is_dead) {  

            if (power_mode_timer > 0) power_mode_timer--;
            
            uint32_t current_ghost_status = 0;
            if (power_mode_timer > 0) {
                current_ghost_status |= 0x01; 
                if (power_mode_timer <= POWER_MODE_FLASH_TIME) {
                    current_ghost_status |= 0x02; 
                }
            }
            Xil_Out32(PACMAN_BASEADDR + REG_GHOST_STATUS, current_ghost_status);

            if (unified_key == 'W' || unified_key == 'A' || unified_key == 'S' || unified_key == 'D') {
                if (!game_started) {
                    game_started = 1;
                    for(int i=0; i<4; i++) ghosts[i].state = GHOST_EXITING; 
                }

                if (unified_key == 'W') { desired_dx = 0; desired_dy = -step; }
                if (unified_key == 'S') { desired_dx = 0; desired_dy = step;  }
                if (unified_key == 'A') { desired_dx = -step; desired_dy = 0; }
                if (unified_key == 'D') { desired_dx = step; desired_dy = 0;  }
                input_timer = BUFFER_TIME; 
            }

            if (input_timer > 0) {
                input_timer--;
            } else {
                desired_dx = 0;
                desired_dy = 0;
            }

            int turned = 0; 

            if (desired_dx != 0 || desired_dy != 0) {
                int next_x_des = x_pos + desired_dx;
                int next_y_des = y_pos + desired_dy;

                if (desired_dx != 0 && current_dx == 0) {
                    next_y_des = ((y_pos + 8) / TILE_SIZE) * TILE_SIZE;
                } else if (desired_dy != 0 && current_dy == 0) {
                    next_x_des = ((x_pos + 8) / TILE_SIZE) * TILE_SIZE;
                }

                if (check_collision(next_x_des + desired_dx * 4, next_y_des + desired_dy * 4, desired_dy) == 0) {
                    if (check_collision(next_x_des, next_y_des, desired_dy) == 0) {
                        x_pos = next_x_des;
                        y_pos = next_y_des;
                        current_dx = desired_dx;
                        current_dy = desired_dy;

                        if (current_dx > 0) current_dir = 0;
                        else if (current_dx < 0) current_dir = 2;
                        else if (current_dy < 0) current_dir = 1;
                        else if (current_dy > 0) current_dir = 3;

                        desired_dx = 0; 
                        desired_dy = 0;
                        input_timer = 0;
                        turned = 1; 
                    }
                }
            }

            if (!turned && (current_dx != 0 || current_dy != 0)) {
                if (check_collision(x_pos + current_dx, y_pos + current_dy, current_dy) == 0) {
                    x_pos += current_dx;
                    y_pos += current_dy;
                }
            }

            global_frame_counter++; 

            int slowdown = (current_level == 1) ? 5 : (current_level == 2 ? 10 : 0);
            int should_ghosts_move = (slowdown == 0) || (global_frame_counter % slowdown != 0);

            if (game_started) {
                for (int i = 0; i < 4; i++) {
                    
                    if (ghosts[i].state == GHOST_RETURNING) {
                        for(int spd = 0; spd < 2; spd++) { 
                            if (ghosts[i].x < ghosts[i].spawn_x) ghosts[i].x += 2;
                            else if (ghosts[i].x > ghosts[i].spawn_x) ghosts[i].x -= 2;
                            if (ghosts[i].y < ghosts[i].spawn_y) ghosts[i].y += 2;
                            else if (ghosts[i].y > ghosts[i].spawn_y) ghosts[i].y -= 2;
                        }
                        if (ghosts[i].x == ghosts[i].spawn_x && ghosts[i].y == ghosts[i].spawn_y) ghosts[i].state = GHOST_IN_HOUSE;
                    }
                    else if (ghosts[i].state == GHOST_IN_HOUSE) {
                        if (power_mode_timer == 0) ghosts[i].state = GHOST_EXITING;
                    }
                    else if (should_ghosts_move || (i == 0 && current_level == 3)) {
                        
                        if (i == 0 && current_level == 3 && power_mode_timer == 0 && !should_ghosts_move) {
                            int extra_move = 0;
                            if (total_dots <= total_dots_max / 10 && global_frame_counter % 10 == 0) extra_move = 1; 
                            else if (total_dots <= total_dots_max / 4 && global_frame_counter % 20 == 0) extra_move = 1; 
                            if (!extra_move) continue;
                        } else if (!should_ghosts_move) {
                            continue; 
                        }

                        if (ghosts[i].state == GHOST_EXITING) {
                            if (ghosts[i].x < 320) { ghosts[i].x += 2; ghosts[i].dir = 0; }
                            else if (ghosts[i].x > 320) { ghosts[i].x -= 2; ghosts[i].dir = 2; }
                            else {
                                ghosts[i].y -= 2; ghosts[i].dir = 1;
                                if (ghosts[i].y <= 192) ghosts[i].state = GHOST_SCATTER;
                            }
                        } 
                        else if (ghosts[i].state == GHOST_SCATTER) {
                            if (ghosts[i].panic_timer > 0) ghosts[i].panic_timer--;

                            if (ghosts[i].panic_timer > 0) {
                                ghost_decision_engine(&ghosts[i], MODE_RANDOM);
                            }
                            else if (power_mode_timer > 0) {
                                if (current_level == 3) {
                                    ghosts[i].target_x = x_pos; ghosts[i].target_y = y_pos;
                                    ghost_decision_engine(&ghosts[i], MODE_FLEE); 
                                } else {
                                    ghost_decision_engine(&ghosts[i], MODE_RANDOM); 
                                }
                            }
                            else {
                                if (i == 0) {
                                    ghosts[0].target_x = x_pos; ghosts[0].target_y = y_pos;
                                    ghost_decision_engine(&ghosts[0], MODE_TRACK);
                                }
                                else if (i == 1) {
                                    ghosts[1].target_x = x_pos + dir_dx[current_dir] * 128;
                                    ghosts[1].target_y = y_pos + dir_dy[current_dir] * 128;
                                    if (ghosts[1].target_x < 32) ghosts[1].target_x = 32;
                                    if (ghosts[1].target_x > 608) ghosts[1].target_x = 608;
                                    if (ghosts[1].target_y < 32) ghosts[1].target_y = 32;
                                    if (ghosts[1].target_y > 448) ghosts[1].target_y = 448;
                                    ghost_decision_engine(&ghosts[1], MODE_TRACK);
                                }
                                else if (i == 2) {
                                    if (abs(ghosts[2].x - ghosts[2].target_x) < 8 && abs(ghosts[2].y - ghosts[2].target_y) < 8) {
                                        int current_idx = 0;
                                        for(int j=0; j<3; j++) if (ghosts[2].target_x == inky_patrol_points[j].x) { current_idx = j; break; }
                                        int next_idx = (current_idx + 1 + (rand() % 2)) % 3;
                                        ghosts[2].target_x = inky_patrol_points[next_idx].x;
                                        ghosts[2].target_y = inky_patrol_points[next_idx].y;
                                    }
                                    ghost_decision_engine(&ghosts[2], MODE_TRACK);
                                }
                                else if (i == 3) {
                                    if (current_level >= 2) {
                                        ghosts[3].target_x = x_pos - dir_dx[current_dir] * 64;
                                        ghosts[3].target_y = y_pos - dir_dy[current_dir] * 64;
                                        ghost_decision_engine(&ghosts[3], MODE_TAIL); 
                                    } else {
                                        ghost_decision_engine(&ghosts[3], MODE_RANDOM);
                                    }
                                }
                            }
                        }
                    }
                }
            }

            int dot_tx = (x_pos - 8) / TILE_SIZE;
            int dot_ty = (y_pos - 8) / TILE_SIZE;

            if (dot_tx >= 0 && dot_tx < 40 && dot_ty >= 0 && dot_ty < 30) {
                if (dot_map[dot_ty][dot_tx] == 1) { 
                    dot_map[dot_ty][dot_tx] = 0;    
                    set_hw_dot(dot_tx, dot_ty, 0);  
                    score += 10;                    
                    total_dots--;
                }
            }

            for (int i = 0; i < 4; i++) {
                if ((super_dot_state & super_dots[i].bit) &&
                    abs(x_pos - super_dots[i].cx) <= 8 && abs(y_pos - super_dots[i].cy) <= 8) {
                    
                    super_dot_state &= ~super_dots[i].bit; 
                    Xil_Out32(PACMAN_BASEADDR + REG_SUPER_DOT, super_dot_state); 
                    total_dots--;
                    score += 100;
                    
                    if (current_level == 1) power_mode_timer = 900;      
                    else if (current_level == 2) power_mode_timer = 600; 
                    else power_mode_timer = 480;                         

                    for (int j = 0; j < 4; j++) {
                        if (ghosts[j].state == GHOST_SCATTER) ghosts[j].dir = (ghosts[j].dir + 2) % 4;
                    }
                }
            }

            if (invincibility_timer > 0) invincibility_timer--;

            for (int i = 0; i < 4; i++) {
                if (ghosts[i].state == GHOST_SCATTER && 
                    abs(x_pos - ghosts[i].x) < 22 && abs(y_pos - ghosts[i].y) < 22) {
                    
                    if (power_mode_timer > 0) {
                        score += 400;
                        if (current_level == 1) {
                            ghosts[i].state = GHOST_DEAD;
                            ghosts[i].x = 3000; ghosts[i].y = 3000;
                        } else {
                            ghosts[i].state = GHOST_RETURNING;
                        }
                    } 
                    else {
                        if (invincibility_timer == 0) {
                            hp -= 1; 
                            invincibility_timer = 90; 
                            ghosts[i].dir = (ghosts[i].dir + 2) % 4; 
                            ghosts[i].panic_timer = 300;             
                            
                            if (hp <= 0) {
                                is_dead = 1;
                                is_paused = 1;
                            }
                        }
                    }
                }
            }
            
            if (total_dots <= 0 && !is_game_over) {
                is_game_over = 1;
                is_paused = 1; 
            }
        }

        if (is_dead || (is_game_over && current_level == 3)) {
            update_ui_text(" PRESS R TO RESTART ");
        } else if (is_game_over) {
            update_ui_text("PRESS E TO NEXT LVL ");
        } else if (is_paused) {
            update_ui_text(" PRESS E TO RESUME  ");
        } else {
            char ui_msg[21] = " LEVEL: X  Q: PAUSE ";
            ui_msg[8] = '0' + current_level;
            update_ui_text(ui_msg);
        }

        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_X, x_pos);
        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_Y, y_pos);
        Xil_Out32(PACMAN_BASEADDR + REG_PACMAN_DIR, current_dir);

        uint32_t display_score = 0;
        display_score |= (score % 10);                   
        display_score |= ((score / 10) % 10) << 4;       
        display_score |= ((score / 100) % 10) << 8;      
        display_score |= ((score / 1000) % 10) << 12;    
        display_score |= ((score / 10000) % 10) << 16;   
        
        Xil_Out32(PACMAN_BASEADDR + REG_GAME_SCORE, display_score);
        Xil_Out32(PACMAN_BASEADDR + REG_LIVES, hp);

        Xil_Out32(PACMAN_BASEADDR + REG_GHOST1_X, ghosts[0].x);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST1_Y, ghosts[0].y);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST2_X, ghosts[1].x);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST2_Y, ghosts[1].y);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST3_X, ghosts[2].x);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST3_Y, ghosts[2].y);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST4_X, ghosts[3].x);
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST4_Y, ghosts[3].y);
        
        uint32_t ghost_ret_status = 0;
        if (ghosts[0].state == GHOST_RETURNING || ghosts[0].state == GHOST_IN_HOUSE) ghost_ret_status |= 0x01;
        if (ghosts[1].state == GHOST_RETURNING || ghosts[1].state == GHOST_IN_HOUSE) ghost_ret_status |= 0x02;
        if (ghosts[2].state == GHOST_RETURNING || ghosts[2].state == GHOST_IN_HOUSE) ghost_ret_status |= 0x04;
        if (ghosts[3].state == GHOST_RETURNING || ghosts[3].state == GHOST_IN_HOUSE) ghost_ret_status |= 0x08;
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST_RETURNING, ghost_ret_status);

        uint32_t packed_dirs = 0;
        for (int i = 0; i < 4; i++) {
            packed_dirs |= (ghosts[i].dir << (i * 2));
        }
        Xil_Out32(PACMAN_BASEADDR + REG_GHOST_DIRS, packed_dirs);

        usleep(16000);
    }

    cleanup_platform();
    return 0;
}