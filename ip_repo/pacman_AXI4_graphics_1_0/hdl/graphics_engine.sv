`timescale 1ns / 1ps

module graphics_engine (
    input  logic        vga_clk,       // VGA 用的 25MHz 时钟
    input  logic        reset_n,       // 低有效复位
    
    // 从 AXI 寄存器传入的数据 (必须与 S00_AXI.v 中的例化连线一一对应)
    input  logic [9:0]  pacman_x,
    input  logic [9:0]  pacman_y,
    input  logic [9:0]  ghost1_x,
    input  logic [9:0]  ghost1_y,
    input  logic [3:0]  game_status,
    
    // VGA/HDMI 输出信号
    output logic [7:0]  VGA_R,
    output logic [7:0]  VGA_G,
    output logic [7:0]  VGA_B,
    output logic        VGA_HS,
    output logic        VGA_VS,
    output logic        active_nblank  // 高=有效显示区域(非消隐)
);

    logic [9:0] DrawX, DrawY;
    logic sync;

    // 1. 实例化你导入的 VGA 控制器
    vga_controller vga_inst (
        .pixel_clk(vga_clk),          // 接入 25MHz 时钟 [cite: 239]
        .reset(~reset_n),             // VGA_controller 需要高电平复位，所以取反 [cite: 240]
        .hs(VGA_HS),                  // [cite: 240]
        .vs(VGA_VS),                  // [cite: 240]
        .active_nblank(active_nblank),// 高电平表示有效显示区域 [cite: 241]
        .sync(sync),                  // [cite: 241]
        .drawX(DrawX),                // [cite: 241]
        .drawY(DrawY)                 // [cite: 242]
    );

    // 2. 画圆逻辑：判断当前像素点是否在吃豆人内部
    logic is_pacman;
    int DistX, DistY;
    int Size = 16; // 吃豆人半径
    
    always_comb begin
        // 将无符号数转换为有符号数相减，防止负坐标下溢出问题
        DistX = int'(DrawX) - int'(pacman_x);
        DistY = int'(DrawY) - int'(pacman_y);
        
        if ( (DistX*DistX + DistY*DistY) <= (Size*Size) )
            is_pacman = 1'b1;
        else
            is_pacman = 1'b0;
    end

    // ================= 新增：墙壁渲染逻辑 =================
    logic is_wall;
    always_comb begin
        is_wall = 1'b0; // 默认不是墙
        
        // 1. 外部边框围墙 (留出10像素黑边防裁剪，墙体厚度10像素)
        // 覆盖范围 X:10~629, Y:10~469
        if (DrawX >= 10 && DrawX <= 629 && DrawY >= 10 && DrawY <= 469) begin
            // 掏空中间部分作为游玩区域
            if (DrawX < 20 || DrawX > 619 || DrawY < 20 || DrawY > 459)
                is_wall = 1'b1;
        end
        
        // 2. 内部墙壁 A (顶部横墙)
        if (DrawX >= 100 && DrawX <= 540 && DrawY >= 100 && DrawY <= 120) 
            is_wall = 1'b1;
            
        // 3. 内部墙壁 B (底部横墙)
        if (DrawX >= 100 && DrawX <= 540 && DrawY >= 360 && DrawY <= 380) 
            is_wall = 1'b1;

        // 4. 内部墙壁 C (中心柱子)
        if (DrawX >= 300 && DrawX <= 340 && DrawY >= 180 && DrawY <= 300) 
            is_wall = 1'b1;
    end
    // ======================================================

    // 3. 像素颜色输出流水线
    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end else if (active_nblank) begin 
            
            // 渲染优先级：墙壁 > 吃豆人 > 背景
            if (is_wall) begin
                VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'hFF; // 经典的深蓝色墙壁
            end else if (is_pacman) begin
                VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'h00; // 黄色吃豆人
            end else begin
                VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; // 黑色背景
            end

        end else begin
            // 扫描消隐期必须输出全黑
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end
    end

endmodule