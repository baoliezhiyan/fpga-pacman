// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sat May  9 13:58:08 2026
// Host        : LAPTOP-KGNOGRA4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Vivado/MyProjects/ip_repo/pacman_AXI4_graphics_1_0/src/blk_mem_gen_2/blk_mem_gen_2_sim_netlist.v
// Design      : blk_mem_gen_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_2,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_2
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [0:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [0:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [0:0]dina;
  wire [0:0]doutb;
  wire [0:0]wea;
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
  wire [0:0]NLW_U0_douta_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     1.968537 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_2.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1200" *) 
  (* C_READ_DEPTH_B = "1200" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "1" *) 
  (* C_READ_WIDTH_B = "1" *) 
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
  (* C_WRITE_DEPTH_A = "1200" *) 
  (* C_WRITE_DEPTH_B = "1200" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "1" *) 
  (* C_WRITE_WIDTH_B = "1" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_2_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(1'b0),
        .douta(NLW_U0_douta_UNCONNECTED[0]),
        .doutb(doutb),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19424)
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
