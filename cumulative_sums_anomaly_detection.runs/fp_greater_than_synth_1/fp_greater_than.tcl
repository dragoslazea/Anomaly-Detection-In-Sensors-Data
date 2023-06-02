# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.cache/wt [current_project]
set_property parent.project_path C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.xci
set_property is_locked true [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1 -new_name fp_greater_than -ip [get_ips fp_greater_than]]

if { $cached_ip eq {} } {

synth_design -top fp_greater_than -part xc7a35tcpg236-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix fp_greater_than_ fp_greater_than.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fp_greater_than_stub.v
 lappend ipCachedFiles fp_greater_than_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fp_greater_than_stub.vhdl
 lappend ipCachedFiles fp_greater_than_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fp_greater_than_sim_netlist.v
 lappend ipCachedFiles fp_greater_than_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fp_greater_than_sim_netlist.vhdl
 lappend ipCachedFiles fp_greater_than_sim_netlist.vhdl

 config_ip_cache -add -dcp fp_greater_than.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips fp_greater_than]
}

rename_ref -prefix_all fp_greater_than_

write_checkpoint -force -noxdef fp_greater_than.dcp

catch { report_utilization -file fp_greater_than_utilization_synth.rpt -pb fp_greater_than_utilization_synth.pb }

if { [catch {
  file copy -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than.dcp c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than.dcp c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than_stub.v c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than_stub.vhdl c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than_sim_netlist.v c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/fp_greater_than_synth_1/fp_greater_than_sim_netlist.vhdl c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.ip_user_files/ip/fp_greater_than]} {
  catch { 
    file copy -force c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.v C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.ip_user_files/ip/fp_greater_than
  }
}

if {[file isdir C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.ip_user_files/ip/fp_greater_than]} {
  catch { 
    file copy -force c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_stub.vhdl C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.ip_user_files/ip/fp_greater_than
  }
}
