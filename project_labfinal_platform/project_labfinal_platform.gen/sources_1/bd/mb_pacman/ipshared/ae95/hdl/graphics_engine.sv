`timescale 1ns / 1ps

module graphics_engine (
    input  logic        vga_clk,       
    input  logic        reset_n,       
    
    input  logic [9:0]  pacman_x, pacman_y,
    input  logic [1:0]  pacman_dir,
    input  logic [9:0]  ghost1_x, ghost1_y, ghost2_x, ghost2_y,
    input  logic [9:0]  ghost3_x, ghost3_y, ghost4_x, ghost4_y,
    input  logic [7:0]  all_ghost_dirs,
    input  logic [3:0]  ghost_status,
    input  logic [31:0] game_score,
    input  logic [3:0]  lives,
    input  logic [31:0] dot_cmd_reg,
    input  logic [3:0]  super_dot_status,
    input  logic        s00_axi_aclk,  
    
    output logic [7:0]  VGA_R, VGA_G, VGA_B,
    output logic        VGA_HS, VGA_VS, active_nblank  
);

    logic [9:0] DrawX, DrawY;
    logic sync, vsync_internal;

    vga_controller vga_inst (
        .pixel_clk(vga_clk),
        .reset(~reset_n),
        .hs(VGA_HS),
        .vs(vsync_internal),
        .active_nblank(active_nblank),
        .sync(sync),
        .drawX(DrawX),
        .drawY(DrawY)             
    );
    assign VGA_VS = vsync_internal;

    // ======================================================
    // 💡 核心魔法：平行宇宙坐标系 (居中对齐 640x640)
    // 1024x768 屏幕中抠出 640x640。X偏移=(1024-640)/2=192，Y偏移=(768-640)/2=64
    // ======================================================
    logic [9:0] GameX, GameY;
    assign GameX = DrawX - 10'd192;
    assign GameY = DrawY - 10'd64;

    logic in_game_window, in_maze_area, in_ui_area;
    // 无符号减法下溢出必定大于 640，巧妙实现双向边界保护
    assign in_game_window = (GameX < 10'd640) && (GameY < 10'd640);
    assign in_maze_area   = in_game_window && (GameY < 10'd480);
    assign in_ui_area     = in_game_window && (GameY >= 10'd480);

    // ======================================================
    // 1. 硬件自动动画控制器 (3:1 比例)
    // ======================================================
    logic [4:0] frame_counter;
    logic last_vsync, frame_select;

    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin
            frame_counter <= 0; last_vsync <= 0;
        end else begin
            last_vsync <= vsync_internal;
            if (!last_vsync && vsync_internal) begin
                if (frame_counter >= 31) frame_counter <= 0;
                else frame_counter <= frame_counter + 1;
            end
        end
    end
    assign frame_select = (frame_counter >= 24) ? 1'b1 : 1'b0;

    // ======================================================
    // 2. BRAM 彩色显存例化 (Sprite ROM)
    // ======================================================
    logic [12:0] rom_address;
    logic [23:0] rom_data;

    blk_mem_gen_0 sprite_rom (
        .clka(vga_clk),
        .addra(rom_address),
        .douta(rom_data)
    );

    logic is_pacman;
    logic [7:0] pacman_R, pacman_G, pacman_B; 
    logic is_ui_pacman;
    logic [23:0] ui_pacman_color;

    // ======================================================
    // 💡 第一部分：纯粹的 BRAM 地址预读 (Lookahead)
    // 负责在 GameX 时刻，计算出 GameX+1 需要读取哪个像素的地址
    // ======================================================
    int rx_maze, ry_maze, rx_ui, ry_ui;
    always_comb begin
        rom_address = 13'b0; // 默认读取透明像素
        
        rx_maze = int'(GameX + 1) - int'(pacman_x - 16);
        ry_maze = int'(GameY) - int'(pacman_y - 16);
        
        rx_ui = int'(GameX + 1) - 20; 
        ry_ui = int'(GameY) - 540;

        if (in_maze_area && rx_maze >= 0 && rx_maze < 32 && ry_maze >= 0 && ry_maze < 32) begin
            int mx, my;
            case (pacman_dir)
                2'b00: begin mx = rx_maze;      my = ry_maze;      end
                2'b01: begin mx = 31 - ry_maze; my = rx_maze;      end
                2'b10: begin mx = 31 - rx_maze; my = ry_maze;      end
                2'b11: begin mx = ry_maze;      my = 31 - rx_maze; end
            endcase
            rom_address = (frame_select * 1024) + (my * 32) + mx;
        end 
        else if (in_ui_area && rx_ui >= 0 && rx_ui < 32 && ry_ui >= 0 && ry_ui < 32) begin
            rom_address = (0 * 1024) + (ry_ui * 32) + rx_ui; 
        end
    end

    // ======================================================
    // 3. 地图 ROM 与墙壁判断
    // ======================================================
    logic [4:0] map_addr;
    logic [39:0] map_row_data;
    
    assign map_addr = in_maze_area ? GameY[8:4] : 5'd0;

    blk_mem_gen_1 map_rom (
        .clka(vga_clk), .addra(map_addr), .douta(map_row_data)
    );

    logic is_wall;
    logic [5:0] tile_x;
    always_comb begin
        tile_x = in_maze_area ? GameX[9:4] : 6'd0;
        if (in_maze_area) is_wall = map_row_data[39 - tile_x];
        else is_wall = 1'b0;
    end

    // ======================================================
    // 4. 幽灵逻辑
    // ======================================================
    logic is_ghost1, is_ghost2, is_ghost3, is_ghost4;
    assign is_ghost1 = in_maze_area && (GameX >= ghost1_x - 16 && GameX <= ghost1_x + 16 && GameY >= ghost1_y - 16 && GameY <= ghost1_y + 16);
    assign is_ghost2 = in_maze_area && (GameX >= ghost2_x - 16 && GameX <= ghost2_x + 16 && GameY >= ghost2_y - 16 && GameY <= ghost2_y + 16);
    assign is_ghost3 = in_maze_area && (GameX >= ghost3_x - 16 && GameX <= ghost3_x + 16 && GameY >= ghost3_y - 16 && GameY <= ghost3_y + 16);
    assign is_ghost4 = in_maze_area && (GameX >= ghost4_x - 16 && GameX <= ghost4_x + 16 && GameY >= ghost4_y - 16 && GameY <= ghost4_y + 16);

    logic [4:0] ghost_anim_cnt;
    logic ghost_frame_select; 
    
    always_ff @(posedge vga_clk) begin
        if (!reset_n) ghost_anim_cnt <= 0;
        else if (!last_vsync && vsync_internal) ghost_anim_cnt <= ghost_anim_cnt + 1;
    end
    assign ghost_frame_select = ghost_anim_cnt[4];

    logic [10:0] ghost_rom_addr;
    logic [23:0] ghost_rom_data;
    logic [1:0] ghost1_dir, ghost2_dir, ghost3_dir, ghost4_dir;

    assign ghost1_dir = all_ghost_dirs[1:0]; assign ghost2_dir = all_ghost_dirs[3:2];
    assign ghost3_dir = all_ghost_dirs[5:4]; assign ghost4_dir = all_ghost_dirs[7:6];
    
    blk_mem_gen_3 ghost_rom (
        .clka(vga_clk), .addra(ghost_rom_addr), .douta(ghost_rom_data)
    );

    logic is_ghost_area;
    logic [23:0] active_ghost_color;
    logic [1:0]  active_ghost_dir;
    int active_ghost_x, active_ghost_y, next_X;

    always_comb begin
        is_ghost_area = 1'b0; ghost_rom_addr = 0;
        active_ghost_color = 24'h000000; active_ghost_dir = 2'b00;
        active_ghost_x = 0; active_ghost_y = 0;
        
        next_X = GameX + 1; // 使用 GameX 预读
        
        if (in_maze_area) begin
            if (next_X >= ghost1_x - 16 && next_X < ghost1_x + 16 && GameY >= ghost1_y - 16 && GameY < ghost1_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFF0000;
                active_ghost_dir = ghost1_dir; active_ghost_x = ghost1_x; active_ghost_y = ghost1_y;
            end else if (next_X >= ghost2_x - 16 && next_X < ghost2_x + 16 && GameY >= ghost2_y - 16 && GameY < ghost2_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFFB8FF;
                active_ghost_dir = ghost2_dir; active_ghost_x = ghost2_x; active_ghost_y = ghost2_y;
            end else if (next_X >= ghost3_x - 16 && next_X < ghost3_x + 16 && GameY >= ghost3_y - 16 && GameY < ghost3_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'h00FFFF;
                active_ghost_dir = ghost3_dir; active_ghost_x = ghost3_x; active_ghost_y = ghost3_y;
            end else if (next_X >= ghost4_x - 16 && next_X < ghost4_x + 16 && GameY >= ghost4_y - 16 && GameY < ghost4_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFFB852;
                active_ghost_dir = ghost4_dir; active_ghost_x = ghost4_x; active_ghost_y = ghost4_y;
            end
        end

        if (is_ghost_area) begin
            int rx_lookahead = next_X - (active_ghost_x - 16);
            int ry_lookahead = GameY - (active_ghost_y - 16);
            ghost_rom_addr = (ghost_frame_select * 1024) + (ry_lookahead * 32) + rx_lookahead;
        end
    end

    logic power_mode_active, power_mode_flashing;
    assign power_mode_active = ghost_status[0]; assign power_mode_flashing = ghost_status[1];

    logic draw_dynamic_pupil;
    int px_offset, py_offset, current_rx, current_ry;
    localparam int PUPIL_L_X = 8, PUPIL_L_Y = 12, PUPIL_R_X = 20, PUPIL_R_Y = 12;

    always_comb begin
        draw_dynamic_pupil = 1'b0; px_offset = 0; py_offset = 0;
        if (!power_mode_active) begin
            case (active_ghost_dir)
                2'b00: px_offset = 1; 2'b10: px_offset = -1;
                2'b11: py_offset = 1; 2'b01: py_offset = -2;
            endcase
        end

        current_rx = GameX - (active_ghost_x - 16);
        current_ry = GameY - (active_ghost_y - 16);

        if (is_ghost_area) begin
            if ((current_rx >= PUPIL_L_X + px_offset && current_rx < PUPIL_L_X + px_offset + 3 && current_ry >= PUPIL_L_Y + py_offset && current_ry < PUPIL_L_Y + py_offset + 3) ||
                (current_rx >= PUPIL_R_X + px_offset && current_rx < PUPIL_R_X + px_offset + 3 && current_ry >= PUPIL_R_Y + py_offset && current_ry < PUPIL_R_Y + py_offset + 3)) begin
                draw_dynamic_pupil = 1'b1;
            end
        end
    end

    // ======================================================
    // 5. 豆子逻辑
    // ======================================================
    logic [10:0] axi_dot_addr; logic axi_dot_data, axi_dot_toggle;
    assign axi_dot_addr = dot_cmd_reg[10:0]; assign axi_dot_data = dot_cmd_reg[11]; assign axi_dot_toggle = dot_cmd_reg[31];

    logic toggle_q1, toggle_q2, toggle_q3, dot_we;
    always_ff @(posedge s00_axi_aclk or negedge reset_n) begin
        if (!reset_n) begin toggle_q1 <= 0; toggle_q2 <= 0; toggle_q3 <= 0; end 
        else begin toggle_q1 <= axi_dot_toggle; toggle_q2 <= toggle_q1; toggle_q3 <= toggle_q2; end
    end
    assign dot_we = (toggle_q2 ^ toggle_q3);

    logic [9:0] dot_scan_x, dot_scan_y;
    logic [10:0] read_dot_addr; logic is_dot_here;

    assign dot_scan_x = GameX - 10'd8; assign dot_scan_y = GameY - 10'd8;
    assign read_dot_addr = in_maze_area ? (dot_scan_y[8:4] * 40 + dot_scan_x[9:4]) : 11'd0;
    
    blk_mem_gen_2 dot_ram (
        .clka(s00_axi_aclk), .wea(dot_we), .addra(axi_dot_addr), .dina(axi_dot_data),
        .clkb(vga_clk), .addrb(read_dot_addr), .doutb(is_dot_here)
    );

    logic [4:0] blink_counter; logic super_dot_blink, draw_super_dot, draw_dot;
    always_ff @(posedge vga_clk) begin
        if (!reset_n) blink_counter <= 0;
        else if (!last_vsync && vsync_internal) begin
            if (blink_counter >= 29) blink_counter <= 0;
            else blink_counter <= blink_counter + 1;
        end
    end
    assign super_dot_blink = (blink_counter < 20) ? 1'b1 : 1'b0;

    always_comb begin
        draw_super_dot = 1'b0;
        if (in_maze_area && frame_select == 1'b0) begin 
            if (super_dot_status[0] && GameX >= 138 && GameX <= 150 && GameY >= 138 && GameY <= 150) draw_super_dot = 1'b1;
            if (super_dot_status[1] && GameX >= 490 && GameX <= 502 && GameY >= 138 && GameY <= 150) draw_super_dot = 1'b1;
            if (super_dot_status[2] && GameX >= 138 && GameX <= 150 && GameY >= 378 && GameY <= 390) draw_super_dot = 1'b1;
            if (super_dot_status[3] && GameX >= 490 && GameX <= 502 && GameY >= 378 && GameY <= 390) draw_super_dot = 1'b1;
        end

        if (in_maze_area && is_dot_here && (dot_scan_x[3:0] >= 6 && dot_scan_x[3:0] <= 9) && (dot_scan_y[3:0] >= 6 && dot_scan_y[3:0] <= 9)) draw_dot = 1'b1;
        else draw_dot = 1'b0;
    end

    // ======================================================
    // 6. UI 七段数码管生成
    // ======================================================
    function logic is_digit_pixel(input [3:0] num, input [9:0] dx, input [9:0] dy);
        logic [6:0] seg;
        case(num)
            4'h0: seg = 7'b1111110; 4'h1: seg = 7'b0110000; 4'h2: seg = 7'b1101101;
            4'h3: seg = 7'b1111001; 4'h4: seg = 7'b0110011; 4'h5: seg = 7'b1011011;
            4'h6: seg = 7'b1011111; 4'h7: seg = 7'b1110000; 4'h8: seg = 7'b1111111;
            4'h9: seg = 7'b1111011; default: seg = 7'b0000000;
        endcase
        is_digit_pixel = 1'b0;
        if (dx >= 0 && dx < 20 && dy >= 0 && dy < 30) begin
            if (seg[6] && dy < 3)  is_digit_pixel = 1'b1;                           // Top
            if (seg[5] && dx > 17 && dy < 15) is_digit_pixel = 1'b1;                // TR
            if (seg[4] && dx > 17 && dy > 15) is_digit_pixel = 1'b1;                // BR
            if (seg[3] && dy > 27) is_digit_pixel = 1'b1;                           // Bot
            if (seg[2] && dx < 3  && dy > 15) is_digit_pixel = 1'b1;                // BL
            if (seg[1] && dx < 3  && dy < 15) is_digit_pixel = 1'b1;                // TL
            if (seg[0] && dy > 13 && dy < 17) is_digit_pixel = 1'b1;                // Mid
        end
    endfunction

    // ======================================================
    // 7. 终极渲染流水线
    // ======================================================
    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end else if (active_nblank) begin
            
            // 如果不在 640x640 窗口内，显示影院级纯黑边框
            if (!in_game_window) begin
                VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
            end 
            // 如果进入底部的 UI 区域
            else if (in_ui_area) begin
                VGA_R <= 8'h22; VGA_G <= 8'h22; VGA_B <= 8'h22; // 默认底色深灰
                
                // 💡 1. 画 UI 里的吃豆人头像
                if (is_ui_pacman) begin
                    VGA_R <= ui_pacman_color[23:16]; VGA_G <= ui_pacman_color[15:8]; VGA_B <= ui_pacman_color[7:0];
                end
                
                // 💡 2. 手工绘制加粗的 'X' 号 (中心点 X=60, Y=556)
                else if (GameX >= 55 && GameX <= 65 && GameY >= 551 && GameY <= 561) begin
                    logic [9:0] loc_x = GameX - 55;
                    logic [9:0] loc_y = GameY - 551;
                    if (loc_x == loc_y || loc_x + 1 == loc_y || loc_x == loc_y + 1 ||
                        loc_x + loc_y == 10 || loc_x + loc_y == 9 || loc_x + loc_y == 11) begin
                        VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; 
                    end
                end

                // 💡 3. 血量 HP 
                else if (GameX >= 80 && GameX < 100 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(lives[3:0], GameX - 80, GameY - 540)) begin
                        VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'h00; // HP 变成吃豆人的黄色
                    end
                end
                
                // 💡 4. 位移后的 5 位分数 (万, 千, 百, 十, 个)
                else if (GameX >= 390 && GameX < 410 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(game_score[19:16], GameX - 390, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end
                else if (GameX >= 420 && GameX < 440 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(game_score[15:12], GameX - 420, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end
                else if (GameX >= 450 && GameX < 470 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(game_score[11:8], GameX - 450, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end
                else if (GameX >= 480 && GameX < 500 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(game_score[7:4], GameX - 480, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end
                else if (GameX >= 510 && GameX < 530 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(game_score[3:0], GameX - 510, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end
            end
            // 正常游戏区 (迷宫)
            else if (in_maze_area) begin
                if (is_wall) begin
                    VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF;
                end else if (is_pacman) begin
                    VGA_R <= pacman_R; VGA_G <= pacman_G; VGA_B <= pacman_B; 
                end else if (is_ghost_area && ghost_rom_data != 24'h000000) begin
                    if (power_mode_active) begin
                        if (draw_dynamic_pupil) begin
                            VGA_R <= 8'h88; VGA_G <= 8'h88; VGA_B <= 8'h88;
                        end else if (ghost_rom_data == 24'h0000FF || ghost_rom_data == 24'hFFFFFF) begin
                            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF;
                        end else if (ghost_rom_data == 24'hFF0000) begin
                            if (power_mode_flashing && ghost_anim_cnt[3]) begin
                                VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; 
                            end else begin
                                VGA_R <= 8'h00; VGA_G <= 8'h33; VGA_B <= 8'hFF; 
                            end
                        end else begin
                            VGA_R <= ghost_rom_data[23:16]; VGA_G <= ghost_rom_data[15:8]; VGA_B <= ghost_rom_data[7:0];
                        end
                    end else begin
                        if (draw_dynamic_pupil) begin
                            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
                        end else if (ghost_rom_data == 24'h0000FF || ghost_rom_data == 24'hFFFFFF) begin
                            VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF;
                        end else if (ghost_rom_data == 24'hFF0000) begin
                            VGA_R <= active_ghost_color[23:16]; VGA_G <= active_ghost_color[15:8]; VGA_B <= active_ghost_color[7:0];
                        end else begin
                            VGA_R <= ghost_rom_data[23:16]; VGA_G <= ghost_rom_data[15:8]; VGA_B <= ghost_rom_data[7:0];
                        end
                    end
                end else if (draw_super_dot) begin
                    VGA_R <= 8'hFF; VGA_G <= 8'hCC; VGA_B <= 8'hAA;
                end else if (draw_dot) begin
                    VGA_R <= 8'hFF; VGA_G <= 8'hCC; VGA_B <= 8'hAA; 
                end else begin
                    VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
                end
            end

        end else begin
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end
    end
endmodule