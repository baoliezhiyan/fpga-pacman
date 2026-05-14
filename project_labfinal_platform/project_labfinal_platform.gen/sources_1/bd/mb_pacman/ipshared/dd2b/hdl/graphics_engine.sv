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
    input  logic [3:0]  ghost_returning_status, 
    
    input  logic [31:0] text_reg0,
    input  logic [31:0] text_reg1,
    input  logic [31:0] text_reg2,
    input  logic [31:0] text_reg3,
    input  logic [31:0] text_reg4,
    
    input  logic        s00_axi_aclk,  
    
    output logic [7:0]  VGA_R, VGA_G, VGA_B,
    output logic        VGA_HS, VGA_VS, active_nblank  
);

    logic [9:0] DrawX, DrawY;
    logic sync, vsync_internal;

    vga_controller vga_inst (
        .pixel_clk(vga_clk), .reset(~reset_n), .hs(VGA_HS), .vs(vsync_internal),
        .active_nblank(active_nblank), .sync(sync), .drawX(DrawX), .drawY(DrawY)             
    );
    assign VGA_VS = vsync_internal;

    logic [9:0] GameX, GameY;
    assign GameX = DrawX - 10'd192;
    assign GameY = DrawY - 10'd64;

    logic in_game_window, in_maze_area, in_ui_area;
    assign in_game_window = (GameX < 10'd640) && (GameY < 10'd640);
    assign in_maze_area   = in_game_window && (GameY < 10'd480);
    assign in_ui_area     = in_game_window && (GameY >= 10'd480);

    logic [4:0] frame_counter; logic last_vsync, frame_select;
    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin frame_counter <= 0; last_vsync <= 0; end 
        else begin
            last_vsync <= vsync_internal;
            if (!last_vsync && vsync_internal) begin
                if (frame_counter >= 31) frame_counter <= 0; else frame_counter <= frame_counter + 1;
            end
        end
    end
    assign frame_select = (frame_counter >= 24) ? 1'b1 : 1'b0;

    logic [12:0] rom_address; logic [23:0] rom_data;
    blk_mem_gen_0 sprite_rom (.clka(vga_clk), .addra(rom_address), .douta(rom_data));

    logic is_pacman; logic [7:0] pacman_R, pacman_G, pacman_B; 
    logic is_ui_pacman; logic [23:0] ui_pacman_color;

    int rx_maze, ry_maze, rx_ui, ry_ui;
    always_comb begin
        rom_address = 13'b0; 
        rx_maze = int'(GameX + 1) - int'(pacman_x - 16); ry_maze = int'(GameY) - int'(pacman_y - 16);
        rx_ui = int'(GameX + 1) - 20; ry_ui = int'(GameY) - 540;

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

    int curr_rx_maze, curr_ry_maze, curr_rx_ui, curr_ry_ui;
    always_comb begin
        is_pacman = 1'b0; pacman_R = 8'h0; pacman_G = 8'h0; pacman_B = 8'h0;
        is_ui_pacman = 1'b0; ui_pacman_color = 24'h0;
        curr_rx_maze = int'(GameX) - int'(pacman_x - 16); curr_ry_maze = int'(GameY) - int'(pacman_y - 16);
        curr_rx_ui = int'(GameX) - 20; curr_ry_ui = int'(GameY) - 540;

        if (in_maze_area && curr_rx_maze >= 0 && curr_rx_maze < 32 && curr_ry_maze >= 0 && curr_ry_maze < 32) begin
            if (rom_data != 24'h000000) begin is_pacman = 1'b1; pacman_R = rom_data[23:16]; pacman_G = rom_data[15:8]; pacman_B = rom_data[7:0]; end
        end 
        else if (in_ui_area && curr_rx_ui >= 0 && curr_rx_ui < 32 && curr_ry_ui >= 0 && curr_ry_ui < 32) begin
            if (rom_data != 24'h000000) begin is_ui_pacman = 1'b1; ui_pacman_color = rom_data; end
        end
    end

    // ======================================================
    // B. 地图 ROM 与 幽灵逻辑 (省略繁琐连线，保持原有逻辑)
    // ======================================================
    logic [4:0] map_addr; logic [39:0] map_row_data;
    assign map_addr = in_maze_area ? GameY[8:4] : 5'd0;
    blk_mem_gen_1 map_rom (.clka(vga_clk), .addra(map_addr), .douta(map_row_data));

    logic is_wall; logic [5:0] tile_x;
    always_comb begin
        tile_x = in_maze_area ? GameX[9:4] : 6'd0;
        if (in_maze_area) is_wall = map_row_data[39 - tile_x]; else is_wall = 1'b0;
    end

    logic [4:0] ghost_anim_cnt; logic ghost_frame_select; 
    always_ff @(posedge vga_clk) begin
        if (!reset_n) ghost_anim_cnt <= 0; else if (!last_vsync && vsync_internal) ghost_anim_cnt <= ghost_anim_cnt + 1;
    end
    assign ghost_frame_select = ghost_anim_cnt[4];

    logic [10:0] ghost_rom_addr; logic [23:0] ghost_rom_data;
    logic [1:0] ghost1_dir, ghost2_dir, ghost3_dir, ghost4_dir;
    assign ghost1_dir = all_ghost_dirs[1:0]; assign ghost2_dir = all_ghost_dirs[3:2]; assign ghost3_dir = all_ghost_dirs[5:4]; assign ghost4_dir = all_ghost_dirs[7:6];
    
    blk_mem_gen_3 ghost_rom (.clka(vga_clk), .addra(ghost_rom_addr), .douta(ghost_rom_data));

    logic is_ghost_area; logic [23:0] active_ghost_color; logic [1:0] active_ghost_dir; int active_ghost_x, active_ghost_y, next_X;

    always_comb begin
        is_ghost_area = 1'b0; ghost_rom_addr = 0; active_ghost_color = 24'h0; active_ghost_dir = 2'b00; active_ghost_x = 0; active_ghost_y = 0;
        next_X = GameX + 1; 
        if (in_maze_area) begin
            if (next_X >= ghost1_x - 16 && next_X < ghost1_x + 16 && GameY >= ghost1_y - 16 && GameY < ghost1_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFF0000; active_ghost_dir = ghost1_dir; active_ghost_x = ghost1_x; active_ghost_y = ghost1_y;
            end else if (next_X >= ghost2_x - 16 && next_X < ghost2_x + 16 && GameY >= ghost2_y - 16 && GameY < ghost2_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFFB8FF; active_ghost_dir = ghost2_dir; active_ghost_x = ghost2_x; active_ghost_y = ghost2_y;
            end else if (next_X >= ghost3_x - 16 && next_X < ghost3_x + 16 && GameY >= ghost3_y - 16 && GameY < ghost3_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'h00FFFF; active_ghost_dir = ghost3_dir; active_ghost_x = ghost3_x; active_ghost_y = ghost3_y;
            end else if (next_X >= ghost4_x - 16 && next_X < ghost4_x + 16 && GameY >= ghost4_y - 16 && GameY < ghost4_y + 16) begin
                is_ghost_area = 1'b1; active_ghost_color = 24'hFFB852; active_ghost_dir = ghost4_dir; active_ghost_x = ghost4_x; active_ghost_y = ghost4_y;
            end
        end
        if (is_ghost_area) begin
            int rx_lookahead = next_X - (active_ghost_x - 16); int ry_lookahead = GameY - (active_ghost_y - 16);
            ghost_rom_addr = (ghost_frame_select * 1024) + (ry_lookahead * 32) + rx_lookahead;
        end
    end

    logic power_mode_active, power_mode_flashing, is_returning;
    assign power_mode_active = ghost_status[0]; assign power_mode_flashing = ghost_status[1];

    always_comb begin
        is_returning = 1'b0;
        if (is_ghost_area) begin
            if      (active_ghost_x == ghost1_x && ghost_returning_status[0]) is_returning = 1'b1;
            else if (active_ghost_x == ghost2_x && ghost_returning_status[1]) is_returning = 1'b1;
            else if (active_ghost_x == ghost3_x && ghost_returning_status[2]) is_returning = 1'b1;
            else if (active_ghost_x == ghost4_x && ghost_returning_status[3]) is_returning = 1'b1;
        end
    end

    logic draw_dynamic_pupil, draw_sclera; int px_offset, py_offset, current_rx, current_ry;
    localparam int PUPIL_L_X = 8, PUPIL_L_Y = 12, PUPIL_R_X = 20, PUPIL_R_Y = 12;

    always_comb begin
        draw_dynamic_pupil = 1'b0; draw_sclera = 1'b0; px_offset = 0; py_offset = 0;
        if (!power_mode_active || is_returning) begin
            case (active_ghost_dir)
                2'b00: px_offset = 2; 2'b10: px_offset = -2;
                2'b11: py_offset = 2; 2'b01: py_offset = -2;
            endcase
        end
        current_rx = GameX - (active_ghost_x - 16); current_ry = GameY - (active_ghost_y - 16);

        if (is_ghost_area) begin
            if ((current_rx >= PUPIL_L_X - 1 + px_offset && current_rx < PUPIL_L_X + 5 + px_offset && current_ry >= PUPIL_L_Y - 1 + py_offset && current_ry < PUPIL_L_Y + 5 + py_offset) ||
                (current_rx >= PUPIL_R_X - 1 + px_offset && current_rx < PUPIL_R_X + 5 + px_offset && current_ry >= PUPIL_R_Y - 1 + py_offset && current_ry < PUPIL_R_Y + 5 + py_offset)) draw_sclera = 1'b1;
            if ((current_rx >= PUPIL_L_X + 1 + px_offset && current_rx < PUPIL_L_X + 4 + px_offset && current_ry >= PUPIL_L_Y + 1 + py_offset && current_ry < PUPIL_L_Y + 4 + py_offset) ||
                (current_rx >= PUPIL_R_X + 1 + px_offset && current_rx < PUPIL_R_X + 4 + px_offset && current_ry >= PUPIL_R_Y + 1 + py_offset && current_ry < PUPIL_R_Y + 4 + py_offset)) draw_dynamic_pupil = 1'b1;
        end
    end

    // 豆子逻辑
    logic [10:0] axi_dot_addr; logic axi_dot_data, axi_dot_toggle;
    assign axi_dot_addr = dot_cmd_reg[10:0]; assign axi_dot_data = dot_cmd_reg[11]; assign axi_dot_toggle = dot_cmd_reg[31];
    logic toggle_q1, toggle_q2, toggle_q3, dot_we;
    always_ff @(posedge s00_axi_aclk or negedge reset_n) begin
        if (!reset_n) begin toggle_q1 <= 0; toggle_q2 <= 0; toggle_q3 <= 0; end else begin toggle_q1 <= axi_dot_toggle; toggle_q2 <= toggle_q1; toggle_q3 <= toggle_q2; end
    end
    assign dot_we = (toggle_q2 ^ toggle_q3);

    logic [9:0] dot_scan_x, dot_scan_y; logic [10:0] read_dot_addr; logic is_dot_here;
    assign dot_scan_x = GameX - 10'd8; assign dot_scan_y = GameY - 10'd8;
    assign read_dot_addr = in_maze_area ? (dot_scan_y[8:4] * 40 + dot_scan_x[9:4]) : 11'd0;
    blk_mem_gen_2 dot_ram (.clka(s00_axi_aclk), .wea(dot_we), .addra(axi_dot_addr), .dina(axi_dot_data), .clkb(vga_clk), .addrb(read_dot_addr), .doutb(is_dot_here));

    logic [4:0] blink_counter; logic draw_super_dot, draw_dot;
    always_ff @(posedge vga_clk) begin
        if (!reset_n) blink_counter <= 0; else if (!last_vsync && vsync_internal) begin
            if (blink_counter >= 29) blink_counter <= 0; else blink_counter <= blink_counter + 1;
        end
    end
    always_comb begin
        draw_super_dot = 1'b0;
        if (in_maze_area && frame_select == 1'b0) begin 
            if (super_dot_status[0] && GameX >= 138 && GameX <= 150 && GameY >= 138 && GameY <= 150) draw_super_dot = 1'b1;
            if (super_dot_status[1] && GameX >= 490 && GameX <= 502 && GameY >= 138 && GameY <= 150) draw_super_dot = 1'b1;
            if (super_dot_status[2] && GameX >= 138 && GameX <= 150 && GameY >= 378 && GameY <= 390) draw_super_dot = 1'b1;
            if (super_dot_status[3] && GameX >= 490 && GameX <= 502 && GameY >= 378 && GameY <= 390) draw_super_dot = 1'b1;
        end
        if (in_maze_area && is_dot_here && (dot_scan_x[3:0] >= 6 && dot_scan_x[3:0] <= 9) && (dot_scan_y[3:0] >= 6 && dot_scan_y[3:0] <= 9)) draw_dot = 1'b1; else draw_dot = 1'b0;
    end
    
    function logic is_digit_pixel(input [3:0] num, input [9:0] dx, input [9:0] dy);
        logic [6:0] seg;
        case(num)
            4'h0: seg = 7'b1111110; 4'h1: seg = 7'b0110000; 4'h2: seg = 7'b1101101; 4'h3: seg = 7'b1111001; 4'h4: seg = 7'b0110011;
            4'h5: seg = 7'b1011011; 4'h6: seg = 7'b1011111; 4'h7: seg = 7'b1110000; 4'h8: seg = 7'b1111111; 4'h9: seg = 7'b1111011; default: seg = 7'b0000000;
        endcase
        is_digit_pixel = 1'b0;
        if (dx >= 0 && dx < 20 && dy >= 0 && dy < 30) begin
            if (seg[6] && dy < 3)  is_digit_pixel = 1'b1; if (seg[5] && dx > 17 && dy < 15) is_digit_pixel = 1'b1;
            if (seg[4] && dx > 17 && dy > 15) is_digit_pixel = 1'b1; if (seg[3] && dy > 27) is_digit_pixel = 1'b1;
            if (seg[2] && dx < 3  && dy > 15) is_digit_pixel = 1'b1; if (seg[1] && dx < 3  && dy < 15) is_digit_pixel = 1'b1;
            if (seg[0] && dy > 13 && dy < 17) is_digit_pixel = 1'b1;
        end
    endfunction

    function logic get_ascii_pixel(input [7:0] char_code, input [2:0] dx, input [2:0] dy);
        logic [63:0] bitmap;
        case (char_code)
            8'h30: bitmap = 64'h3c666e7666663c00; 8'h31: bitmap = 64'h1838181818187e00; 
            8'h32: bitmap = 64'h3c66063c60607e00; 8'h33: bitmap = 64'h3c66063c06663c00; 
            8'h34: bitmap = 64'h6666667e06060600; 8'h35: bitmap = 64'h7e60607c06663c00; 
            8'h36: bitmap = 64'h3c60607c66663c00; 8'h37: bitmap = 64'h7e06060c18181800; 
            8'h38: bitmap = 64'h3c66663c66663c00; 8'h39: bitmap = 64'h3c66663e06063c00; 
            8'h41: bitmap = 64'h183c66667e666600; 8'h42: bitmap = 64'h7c66667c66667c00; 
            8'h43: bitmap = 64'h3c66606060663c00; 8'h44: bitmap = 64'h786c6666666c7800; 
            8'h45: bitmap = 64'h7e60607860607e00; 8'h46: bitmap = 64'h7e60607860606000; 
            8'h47: bitmap = 64'h3c66606e66663c00; 8'h48: bitmap = 64'h6666667e66666600; 
            8'h49: bitmap = 64'h3c18181818183c00; 8'h4A: bitmap = 64'h0e0c0c0c0c6c3800; 
            8'h4B: bitmap = 64'h666c7870786c6600; 8'h4C: bitmap = 64'h6060606060607e00; 
            8'h4D: bitmap = 64'h63777f6b63636300; 8'h4E: bitmap = 64'h66767e7e6e666600; 
            8'h4F: bitmap = 64'h3c66666666663c00; 8'h50: bitmap = 64'h7c66667c60606000; 
            8'h51: bitmap = 64'h3c6666666a643a00; 8'h52: bitmap = 64'h7c66667c786c6600; 
            8'h53: bitmap = 64'h3c66603c06663c00; 8'h54: bitmap = 64'h7e18181818181800; 
            8'h55: bitmap = 64'h6666666666663c00; 8'h56: bitmap = 64'h66666666663c1800; 
            8'h57: bitmap = 64'h6363636b7f776300; 8'h58: bitmap = 64'h66663c183c666600; 
            8'h59: bitmap = 64'h6666663c18181800; 8'h5A: bitmap = 64'h7e060c1830607e00; 
            8'h3A: bitmap = 64'h0018180018180000; // :
            8'h21: bitmap = 64'h1818181800181800; // !
            default: bitmap = 64'h0000000000000000; // Space
        endcase
        // 从 64位 阵列中抽取当前坐标像素 (翻转坐标使其正向显示)
        get_ascii_pixel = bitmap[((7-dy)*8) + (7-dx)];
    endfunction

    // 3. 将 5 个寄存器拼装为 20 字符长度的数组
    logic [7:0] text_array [0:19];
    assign text_array[0] = text_reg0[31:24]; assign text_array[1] = text_reg0[23:16]; assign text_array[2] = text_reg0[15:8]; assign text_array[3] = text_reg0[7:0];
    assign text_array[4] = text_reg1[31:24]; assign text_array[5] = text_reg1[23:16]; assign text_array[6] = text_reg1[15:8]; assign text_array[7] = text_reg1[7:0];
    assign text_array[8] = text_reg2[31:24]; assign text_array[9] = text_reg2[23:16]; assign text_array[10]= text_reg2[15:8]; assign text_array[11]= text_reg2[7:0];
    assign text_array[12]= text_reg3[31:24]; assign text_array[13]= text_reg3[23:16]; assign text_array[14]= text_reg3[15:8]; assign text_array[15]= text_reg3[7:0];
    assign text_array[16]= text_reg4[31:24]; assign text_array[17]= text_reg4[23:16]; assign text_array[18]= text_reg4[15:8]; assign text_array[19]= text_reg4[7:0];


    // ======================================================
    // D. 终极渲染流水线
    // ======================================================
    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; end 
        else if (active_nblank) begin
            if (!in_game_window) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; end 
            
            else if (in_ui_area) begin
                VGA_R <= 8'h22; VGA_G <= 8'h22; VGA_B <= 8'h22; 
                
                if (is_ui_pacman) begin
                    VGA_R <= ui_pacman_color[23:16]; VGA_G <= ui_pacman_color[15:8]; VGA_B <= ui_pacman_color[7:0];
                end
                else if (GameX >= 55 && GameX <= 65 && GameY >= 551 && GameY <= 561) begin
                    logic [9:0] loc_x = GameX - 55; logic [9:0] loc_y = GameY - 551;
                    if (loc_x == loc_y || loc_x + 1 == loc_y || loc_x == loc_y + 1 || loc_x + loc_y == 10 || loc_x + loc_y == 9 || loc_x + loc_y == 11) begin
                        VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; 
                    end
                end
                else if (GameX >= 80 && GameX < 100 && GameY >= 540 && GameY < 570) begin
                    if (is_digit_pixel(lives[3:0], GameX - 80, GameY - 540)) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'h00; end
                end
                
                // 💡 [新增] 静态文本: 完美对齐的 "SCORE:" (缩放两倍)
                else if (GameX >= 270 && GameX < 366 && GameY >= 548 && GameY < 564) begin
                    int c_idx = (GameX - 270) >> 4;   // 除以 16 找字符索引
                    int c_dx  = (GameX - 270) % 16;   // 0-15 局部坐标
                    int c_dy  = GameY - 548;          // 0-15 局部高度
                    logic [7:0] sc_char;
                    case (c_idx)
                        0: sc_char = 8'h53; // S
                        1: sc_char = 8'h43; // C
                        2: sc_char = 8'h4F; // O
                        3: sc_char = 8'h52; // R
                        4: sc_char = 8'h45; // E
                        5: sc_char = 8'h3A; // :
                        default: sc_char = 8'h20;
                    endcase
                    // 局部坐标右移 1 位实现硬件放大 2 倍
                    if (get_ascii_pixel(sc_char, c_dx[3:1], c_dy[3:1])) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end
                end

                // 原始 5 位分数
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
                
                // 💡 [新增] 动态提示区: 底部中心 20 字符 (缩放两倍)
                else if (GameX >= 160 && GameX < 480 && GameY >= 580 && GameY < 596) begin
                    int dyn_idx = (GameX - 160) >> 4; 
                    int dyn_dx  = (GameX - 160) % 16;
                    int dyn_dy  = GameY - 580;
                    if (get_ascii_pixel(text_array[dyn_idx], dyn_dx[3:1], dyn_dy[3:1])) begin 
                        VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'h00; // 💡 提示词渲染为醒目的黄色
                    end
                end
            end
            
            else if (in_maze_area) begin
                if (is_wall) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF; end 
                else if (is_pacman) begin VGA_R <= pacman_R; VGA_G <= pacman_G; VGA_B <= pacman_B; end 
                else if (is_ghost_area && ghost_rom_data != 24'h000000) begin
                    if (is_returning) begin
                        if (draw_dynamic_pupil) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF; end 
                        else if (draw_sclera) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end 
                        else begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; end
                    end 
                    else if (power_mode_active) begin
                        if (draw_dynamic_pupil) begin VGA_R <= 8'h88; VGA_G <= 8'h88; VGA_B <= 8'h88; end 
                        else if (ghost_rom_data == 24'h0000FF || ghost_rom_data == 24'hFFFFFF) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF; end 
                        else if (ghost_rom_data == 24'hFF0000) begin
                            if (power_mode_flashing && ghost_anim_cnt[3]) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end 
                            else begin VGA_R <= 8'h00; VGA_G <= 8'h33; VGA_B <= 8'hFF; end
                        end 
                        else begin VGA_R <= ghost_rom_data[23:16]; VGA_G <= ghost_rom_data[15:8]; VGA_B <= ghost_rom_data[7:0]; end
                    end 
                    else begin
                        if (draw_dynamic_pupil) begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; end 
                        else if (ghost_rom_data == 24'h0000FF || ghost_rom_data == 24'hFFFFFF) begin VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'hFF; end 
                        else if (ghost_rom_data == 24'hFF0000) begin VGA_R <= active_ghost_color[23:16]; VGA_G <= active_ghost_color[15:8]; VGA_B <= active_ghost_color[7:0]; end 
                        else begin VGA_R <= ghost_rom_data[23:16]; VGA_G <= ghost_rom_data[15:8]; VGA_B <= ghost_rom_data[7:0]; end
                    end
                end 
                else if (draw_super_dot) begin VGA_R <= 8'hFF; VGA_G <= 8'hCC; VGA_B <= 8'hAA; end 
                else if (draw_dot) begin VGA_R <= 8'hFF; VGA_G <= 8'hCC; VGA_B <= 8'hAA; end 
                else begin VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; end
            end
        end else begin
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end
    end
endmodule