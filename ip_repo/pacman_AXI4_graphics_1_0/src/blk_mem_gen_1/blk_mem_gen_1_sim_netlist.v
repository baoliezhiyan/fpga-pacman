// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May  7 21:51:56 2026
// Host        : LAPTOP-KGNOGRA4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Vivado/MyProjects/ip_repo/pacman_AXI4_graphics_1_0/src/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [39:0]douta;

  wire [4:0]addra;
  wire clka;
  wire [39:0]douta;
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
  wire [39:0]NLW_U0_doutb_UNCONNECTED;
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [39:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.5256 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_1.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "30" *) 
  (* C_READ_DEPTH_B = "30" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "40" *) 
  (* C_READ_WIDTH_B = "40" *) 
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
  (* C_WRITE_DEPTH_A = "30" *) 
  (* C_WRITE_DEPTH_B = "30" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "40" *) 
  (* C_WRITE_WIDTH_B = "40" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[39:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[39:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30240)
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
