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
    int DistX, DistY, Size;
    
    assign DistX = DrawX - pacman_x;
    assign DistY = DrawY - pacman_y;
    assign Size = 16; // 吃豆人半径
    
    always_comb begin
        // 圆的方程: (x - x0)^2 + (y - y0)^2 <= r^2
        if ( (DistX*DistX + DistY*DistY) <= (Size*Size) )
            is_pacman = 1'b1;
        else
            is_pacman = 1'b0;
    end

    // 3. 像素颜色输出流水线
    always_ff @(posedge vga_clk) begin
        if (!reset_n) begin
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end else if (active_nblank) begin // 在有效显示区域内 [cite: 241]
            if (is_pacman) begin
                VGA_R <= 8'hFF; VGA_G <= 8'hFF; VGA_B <= 8'h00; // 黄色吃豆人
            end else begin
                VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00; // 黑色背景
            end
        end else begin
            // 扫描消隐期必须输出全黑，否则显示器无法同步
            VGA_R <= 8'h00; VGA_G <= 8'h00; VGA_B <= 8'h00;
        end
    end

endmodule