// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May  7 14:34:37 2026
// Host        : LAPTOP-KGNOGRA4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Vivado/MyProjects/ip_repo/pacman_AXI4_graphics_1_0/src/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [23:0]douta;

  wire [11:0]addra;
  wire clka;
  wire [23:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [23:0]NLW_U0_doutb_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [23:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "3" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     6.979199 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "24" *) 
  (* C_READ_WIDTH_B = "24" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "24" *) 
  (* C_WRITE_WIDTH_B = "24" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[23:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[23:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 61088)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
