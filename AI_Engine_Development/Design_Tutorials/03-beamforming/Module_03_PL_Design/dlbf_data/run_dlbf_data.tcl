

#Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
#SPDX-License-Identifier: X11


set IP_NAME "dlbf_data"
set IP_REPO "build"

set project "project_dlbf_data"
create_project $project ./$project -part [lindex $argv 1] -force

add_files -norecurse ./hdl/dlbf_data.v
add_files -norecurse ./hdl/dlbf_data_master.v
add_files -norecurse ./hdl/dlbf_data_cntrl.v
add_files -norecurse ./hdl/dlbf_data_csr_cntrl.v
add_files -norecurse ./hdl/dlbf_data_cdc.v
add_files -norecurse ./hdl/dlbf_data_xpm_sync_fifo.v
add_files -norecurse ./hdl/dlbf_data_ram2axis_64b.v
add_files -norecurse ./hdl/dlbf_data_xpm_ram.v
add_files -norecurse ../data/dlbf_din0_hex.mem
add_files -norecurse ../data/dlbf_din1_hex.mem
add_files -norecurse ../data/dlbf_din2_hex.mem
add_files -norecurse ../data/dlbf_din3_hex.mem

create_bd_design "design_dlbf_data"
#set argv [lindex $argv 1]
#set argc 1
source ./bd_${IP_NAME}.tcl

make_wrapper -files [get_files ./$project/$project.srcs/sources_1/bd/design_${IP_NAME}/design_${IP_NAME}.bd] -top
add_files -norecurse ./$project/$project.srcs/sources_1/bd/design_${IP_NAME}/hdl/design_${IP_NAME}_wrapper.v

import_files

set_property top ${IP_NAME} [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

save_bd_design
validate_bd_design

reset_target all [get_files  ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd]
generate_target all [get_files ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd]

export_ip_user_files -of_objects  [get_files  ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd] -sync -no_script -force -quiet

set bypass [lindex $argv 0]
if {$bypass!="NO_SIM"} {
  delete_ip_run [get_files -of_objects [get_fileset sources_1] ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd]
  generate_target all [get_files  ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd]
  export_ip_user_files -of_objects [get_files ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd] -no_script -sync -force -quiet
  create_ip_run [get_files -of_objects [get_fileset sources_1] ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd]

  launch_runs -jobs 32 synth_1
  wait_on_run synth_1

  export_simulation -of_objects [get_files ./$project/$project.srcs/sources_1/bd/${design_name}/${design_name}.bd] -directory ./$project/$project.ip_user_files/sim_scripts -ip_user_files_dir ./$project/$project.ip_user_files -ipstatic_source_dir ./$project/$project.ip_user_files/ipstatic -lib_map_path [list {modelsim=./$project/$project.cache/compile_simlib/modelsim} {questa=./$project/$project.cache/compile_simlib/questa} {ies=./$project/$project.cache/compile_simlib/ies} {xcelium=./$project/$project.cache/compile_simlib/xcelium} {vcs=./$project/$project.cache/compile_simlib/vcs} {riviera=./$project/$project.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
}

ipx::package_project -root_dir [pwd]/../${IP_REPO}/${IP_NAME} -vendor xilinx.com -library user -taxonomy /UserIP -import_files -set_current false -force
ipx::unload_core [pwd]/../${IP_REPO}/${IP_NAME}/component.xml
ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory ../${IP_REPO}/${IP_NAME} [pwd]/../${IP_REPO}/${IP_NAME}/component.xml
update_compile_order -fileset sources_1
ipx::associate_bus_interfaces -busif M00_AXIS:M01_AXIS:M02_AXIS:M03_AXIS -clock m_axis_clk [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::move_temp_component_back -component [ipx::current_core]
close_project -delete
set_property  ip_repo_paths  [pwd]/../${IP_REPO}/${IP_NAME} [current_project]
update_ip_catalog

package_xo -kernel_name ${IP_NAME} -ctrl_protocol user_managed -ip_directory [pwd]/../${IP_REPO}/${IP_NAME} -xo_path [pwd]/../${IP_REPO}/${IP_NAME}.xo -force -output_kernel_xml [pwd]/kernel_${IP_NAME}_auto.xml


