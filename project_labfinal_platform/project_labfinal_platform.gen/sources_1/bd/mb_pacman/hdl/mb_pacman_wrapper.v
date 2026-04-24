//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Fri Apr 24 09:43:09 2026
//Host        : LAPTOP-KGNOGRA4 running 64-bit major release  (build 9200)
//Command     : generate_target mb_pacman_wrapper.bd
//Design      : mb_pacman_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mb_pacman_wrapper
   (SPI_0_0_io0_io,
    SPI_0_0_io1_io,
    SPI_0_0_sck_io,
    SPI_0_0_ss_io,
    clk_100MHz,
    gpio_rtl_0_tri_o,
    gpio_rtl_1_tri_i,
    hdmi_tx_0_tmds_clk_n,
    hdmi_tx_0_tmds_clk_p,
    hdmi_tx_0_tmds_data_n,
    hdmi_tx_0_tmds_data_p,
    reset_rtl_0,
    uart_rtl_0_rxd,
    uart_rtl_0_txd);
  inout SPI_0_0_io0_io;
  inout SPI_0_0_io1_io;
  inout SPI_0_0_sck_io;
  inout [0:0]SPI_0_0_ss_io;
  input clk_100MHz;
  output [0:0]gpio_rtl_0_tri_o;
  input [0:0]gpio_rtl_1_tri_i;
  output hdmi_tx_0_tmds_clk_n;
  output hdmi_tx_0_tmds_clk_p;
  output [2:0]hdmi_tx_0_tmds_data_n;
  output [2:0]hdmi_tx_0_tmds_data_p;
  input reset_rtl_0;
  input uart_rtl_0_rxd;
  output uart_rtl_0_txd;

  wire SPI_0_0_io0_i;
  wire SPI_0_0_io0_io;
  wire SPI_0_0_io0_o;
  wire SPI_0_0_io0_t;
  wire SPI_0_0_io1_i;
  wire SPI_0_0_io1_io;
  wire SPI_0_0_io1_o;
  wire SPI_0_0_io1_t;
  wire SPI_0_0_sck_i;
  wire SPI_0_0_sck_io;
  wire SPI_0_0_sck_o;
  wire SPI_0_0_sck_t;
  wire [0:0]SPI_0_0_ss_i_0;
  wire [0:0]SPI_0_0_ss_io_0;
  wire [0:0]SPI_0_0_ss_o_0;
  wire SPI_0_0_ss_t;
  wire clk_100MHz;
  wire [0:0]gpio_rtl_0_tri_o;
  wire [0:0]gpio_rtl_1_tri_i;
  wire hdmi_tx_0_tmds_clk_n;
  wire hdmi_tx_0_tmds_clk_p;
  wire [2:0]hdmi_tx_0_tmds_data_n;
  wire [2:0]hdmi_tx_0_tmds_data_p;
  wire reset_rtl_0;
  wire uart_rtl_0_rxd;
  wire uart_rtl_0_txd;

  IOBUF SPI_0_0_io0_iobuf
       (.I(SPI_0_0_io0_o),
        .IO(SPI_0_0_io0_io),
        .O(SPI_0_0_io0_i),
        .T(SPI_0_0_io0_t));
  IOBUF SPI_0_0_io1_iobuf
       (.I(SPI_0_0_io1_o),
        .IO(SPI_0_0_io1_io),
        .O(SPI_0_0_io1_i),
        .T(SPI_0_0_io1_t));
  IOBUF SPI_0_0_sck_iobuf
       (.I(SPI_0_0_sck_o),
        .IO(SPI_0_0_sck_io),
        .O(SPI_0_0_sck_i),
        .T(SPI_0_0_sck_t));
  IOBUF SPI_0_0_ss_iobuf_0
       (.I(SPI_0_0_ss_o_0),
        .IO(SPI_0_0_ss_io[0]),
        .O(SPI_0_0_ss_i_0),
        .T(SPI_0_0_ss_t));
  mb_pacman mb_pacman_i
       (.SPI_0_0_io0_i(SPI_0_0_io0_i),
        .SPI_0_0_io0_o(SPI_0_0_io0_o),
        .SPI_0_0_io0_t(SPI_0_0_io0_t),
        .SPI_0_0_io1_i(SPI_0_0_io1_i),
        .SPI_0_0_io1_o(SPI_0_0_io1_o),
        .SPI_0_0_io1_t(SPI_0_0_io1_t),
        .SPI_0_0_sck_i(SPI_0_0_sck_i),
        .SPI_0_0_sck_o(SPI_0_0_sck_o),
        .SPI_0_0_sck_t(SPI_0_0_sck_t),
        .SPI_0_0_ss_i(SPI_0_0_ss_i_0),
        .SPI_0_0_ss_o(SPI_0_0_ss_o_0),
        .SPI_0_0_ss_t(SPI_0_0_ss_t),
        .clk_100MHz(clk_100MHz),
        .gpio_rtl_0_tri_o(gpio_rtl_0_tri_o),
        .gpio_rtl_1_tri_i(gpio_rtl_1_tri_i),
        .hdmi_tx_0_tmds_clk_n(hdmi_tx_0_tmds_clk_n),
        .hdmi_tx_0_tmds_clk_p(hdmi_tx_0_tmds_clk_p),
        .hdmi_tx_0_tmds_data_n(hdmi_tx_0_tmds_data_n),
        .hdmi_tx_0_tmds_data_p(hdmi_tx_0_tmds_data_p),
        .reset_rtl_0(reset_rtl_0),
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd));
endmodule
