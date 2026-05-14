module vga_controller (
    input        pixel_clk,        // 65 MHz clock
    input        reset,            // reset signal
    output logic hs,               // Horizontal sync pulse
    output logic vs,               // Vertical sync pulse
    output logic active_nblank,    // High = active
    output logic sync,
    output logic [9:0] drawX,      // horizontal coordinate (0-1023)
    output logic [9:0] drawY       // vertical coordinate (0-767)
);

    // 1024x768 @ 60Hz (Pixel Clock: 65 MHz)
    parameter [10:0] hpixels = 11'd1343; // 1024 + 24 + 136 + 160 - 1
    parameter [9:0]  vlines  = 10'd805;  // 768 + 3 + 6 + 29 - 1
    
    logic [10:0] hc;
    logic [9:0]  vc;
    
    assign sync = 1'b0;

    always_ff @ (posedge pixel_clk or posedge reset) begin
        if (reset) begin 
            hc <= 0;
            vc <= 0;
        end else if (hc == hpixels) begin 
            hc <= 0;
            if (vc == vlines) vc <= 0;
            else vc <= vc + 1;
        end else begin 
            hc <= hc + 1;
        end 
    end 
   
    // 在有效显示区域内，hc 只有 0~1023，完美兼容 10-bit 的 drawX
    assign drawX = (hc >= 11'd1024) ? 10'd0 : hc[9:0];
    assign drawY = vc;
   
    always_ff @ (posedge reset or posedge pixel_clk) begin
        if (reset) hs <= 1'b0;
        else if (hc >= 11'd1048 && hc < 11'd1184) hs <= 1'b0;
        else hs <= 1'b1;
    end
	 
    always_ff @ (posedge reset or posedge pixel_clk) begin
        if (reset) vs <= 1'b0;
        else if (vc >= 10'd771 && vc < 10'd777) vs <= 1'b0;
        else vs <= 1'b1;
    end
       
    always_comb begin 
        if (hc >= 11'd1024 || vc >= 10'd768) active_nblank = 1'b0;
        else active_nblank = 1'b1;
    end 
endmodule