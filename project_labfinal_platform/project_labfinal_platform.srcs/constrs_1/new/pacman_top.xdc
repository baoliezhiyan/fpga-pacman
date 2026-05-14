# 1. 系统核心时钟与复位
create_clock -period 10.000 -name clk_100 -waveform {0.000 5.000} [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
set_property PACKAGE_PIN N15 [get_ports clk_100MHz]

set_property IOSTANDARD LVCMOS25 [get_ports reset_rtl_0]
set_property PACKAGE_PIN J2 [get_ports reset_rtl_0]

# 2. UART 串口
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_0_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_0_txd]
set_property PACKAGE_PIN B16 [get_ports uart_rtl_0_rxd]
set_property PACKAGE_PIN A16 [get_ports uart_rtl_0_txd]

# 3. HDMI 输出 (匹配 mb_pacman_wrapper 名称)
# HDMI 时钟
set_property -dict { PACKAGE_PIN V17   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_clk_n}]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_clk_p}]

# HDMI 数据 N 端
set_property -dict { PACKAGE_PIN U18   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_n[0]}]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_n[1]}]
set_property -dict { PACKAGE_PIN T14   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_n[2]}]

# HDMI 数据 P 端
set_property -dict { PACKAGE_PIN U17   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_p[0]}]
set_property -dict { PACKAGE_PIN R16   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_p[1]}]
set_property -dict { PACKAGE_PIN R14   IOSTANDARD TMDS_33 } [get_ports {hdmi_tx_0_tmds_data_p[2]}]

# -------------------------------------------------------------------------
# 4. USB 接口 (SPI 与 GPIO 控制) - 从 Lab6 移植并适配新 Wrapper 命名
# -------------------------------------------------------------------------

# GPIO Interrupt (Input) -> 对应 wrapper 里的 gpio_rtl_1_tri_i
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_1_tri_i[0]}]
set_property PACKAGE_PIN T13 [get_ports {gpio_rtl_1_tri_i[0]}]

# GPIO Reset (Output) -> 对应 wrapper 里的 gpio_rtl_0_tri_o
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_0_tri_o[0]}]
set_property PACKAGE_PIN V13 [get_ports {gpio_rtl_0_tri_o[0]}]

# SPI Signals: AXI Quad SPI 默认 io0 为 MOSI, io1 为 MISO
# SPI MOSI
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_io0_io]
set_property PACKAGE_PIN V15 [get_ports SPI_0_0_io0_io]

# SPI MISO
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_io1_io]
set_property PACKAGE_PIN U12 [get_ports SPI_0_0_io1_io]

# SPI SCLK
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_sck_io]
set_property PACKAGE_PIN V14 [get_ports SPI_0_0_sck_io]

# SPI SS (Chip Select)
set_property IOSTANDARD LVCMOS33 [get_ports {SPI_0_0_ss_io[0]}]
set_property PACKAGE_PIN T12 [get_ports {SPI_0_0_ss_io[0]}]

# -------------------------------------------------------------------------
# 5. 时序约束 (修复跨时钟域 Setup 违例)
# -------------------------------------------------------------------------
set_false_path -from [get_clocks clk_out1_mb_pacman_clk_wiz_1_0_1] -to [get_clocks clk_out2_mb_pacman_clk_wiz_1_0_1]
set_false_path -from [get_clocks clk_out2_mb_pacman_clk_wiz_1_0_1] -to [get_clocks clk_out1_mb_pacman_clk_wiz_1_0_1]