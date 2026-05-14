# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\Vivado\MyProjects\project_labfinal_platform\vitis_workspace\pacman_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\Vivado\MyProjects\project_labfinal_platform\vitis_workspace\pacman_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {pacman_platform}\
-hw {D:\Vivado\MyProjects\project_labfinal_platform\mb_pacman_wrapper.xsa}\
-proc {microblaze_0} -os {standalone} -out {D:/Vivado/MyProjects/project_labfinal_platform/vitis_workspace}

platform write
platform generate -domains 
platform active {pacman_platform}
platform clean
bsp reload
bsp setdriver -ip pacman_AXI4_graphics_0 -driver generic -ver 3.0 3.1
bsp write
bsp reload
catch {bsp regenerate}
platform clean
platform generate
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
bsp reload
platform generate
platform clean
platform generate
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform clean
platform clean
platform generate
bsp reload
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains standalone_domain 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform active {pacman_platform}
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Vivado/MyProjects/project_labfinal_platform/mb_pacman_wrapper.xsa}
platform generate -domains 
