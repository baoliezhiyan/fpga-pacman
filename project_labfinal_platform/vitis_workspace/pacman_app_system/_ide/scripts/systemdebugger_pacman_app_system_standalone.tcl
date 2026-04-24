# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Vivado\MyProjects\project_labfinal_platform\vitis_workspace\pacman_app_system\_ide\scripts\systemdebugger_pacman_app_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Vivado\MyProjects\project_labfinal_platform\vitis_workspace\pacman_app_system\_ide\scripts\systemdebugger_pacman_app_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "RealDigital Boo 887100000000A" && level==0 && jtag_device_ctx=="jsn1-0362f093-0"}
fpga -file D:/Vivado/MyProjects/project_labfinal_platform/vitis_workspace/pacman_app/_ide/bitstream/download.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/Vivado/MyProjects/project_labfinal_platform/vitis_workspace/pacman_platform/export/pacman_platform/hw/mb_pacman_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/Vivado/MyProjects/project_labfinal_platform/vitis_workspace/pacman_app/Debug/pacman_app.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
