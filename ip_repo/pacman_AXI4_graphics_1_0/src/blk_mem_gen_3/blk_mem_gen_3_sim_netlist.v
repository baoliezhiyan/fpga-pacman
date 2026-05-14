// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun May 10 00:00:57 2026
// Host        : LAPTOP-KGNOGRA4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Vivado/MyProjects/ip_repo/pacman_AXI4_graphics_1_0/src/blk_mem_gen_3/blk_mem_gen_3_sim_netlist.v
// Design      : blk_mem_gen_3
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_3,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_3
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [23:0]douta;

  wire [10:0]addra;
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
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [23:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.66155 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_3.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_3.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
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
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "24" *) 
  (* C_WRITE_WIDTH_B = "24" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_3_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 36240)
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
