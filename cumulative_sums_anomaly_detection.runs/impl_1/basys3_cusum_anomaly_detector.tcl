proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.cache/wt [current_project]
  set_property parent.project_path C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.xpr [current_project]
  set_property ip_output_repo C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.runs/synth_1/basys3_cusum_anomaly_detector.dcp
  add_files -quiet c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_adder_subtracter/fp_adder_subtracter.dcp
  set_property netlist_only true [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_adder_subtracter/fp_adder_subtracter.dcp]
  add_files -quiet c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo.dcp
  set_property netlist_only true [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo.dcp]
  add_files -quiet c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.dcp
  set_property netlist_only true [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than.dcp]
  read_xdc -mode out_of_context -ref fp_adder_subtracter -cells U0 c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_adder_subtracter/fp_adder_subtracter_ooc.xdc
  set_property processing_order EARLY [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_adder_subtracter/fp_adder_subtracter_ooc.xdc]
  read_xdc -mode out_of_context -ref fifo -cells inst c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo_ooc.xdc
  set_property processing_order EARLY [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo_ooc.xdc]
  read_xdc -ref fifo -cells inst c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo/fifo.xdc
  set_property processing_order EARLY [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fifo/fifo/fifo.xdc]
  read_xdc -mode out_of_context -ref fp_greater_than -cells U0 c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_ooc.xdc
  set_property processing_order EARLY [get_files c:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/sources_1/ip/fp_greater_than/fp_greater_than_ooc.xdc]
  read_xdc C:/CTI/Licenta/cumulative_sums_anomaly_detection/cumulative_sums_anomaly_detection.srcs/constrs_1/imports/Downloads/Basys3_test_env.xdc
  link_design -top basys3_cusum_anomaly_detector -part xc7a35tcpg236-1
  write_hwdef -file basys3_cusum_anomaly_detector.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force basys3_cusum_anomaly_detector_opt.dcp
  catch { report_drc -file basys3_cusum_anomaly_detector_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force basys3_cusum_anomaly_detector_placed.dcp
  catch { report_io -file basys3_cusum_anomaly_detector_io_placed.rpt }
  catch { report_utilization -file basys3_cusum_anomaly_detector_utilization_placed.rpt -pb basys3_cusum_anomaly_detector_utilization_placed.pb }
  catch { report_control_sets -verbose -file basys3_cusum_anomaly_detector_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force basys3_cusum_anomaly_detector_routed.dcp
  catch { report_drc -file basys3_cusum_anomaly_detector_drc_routed.rpt -pb basys3_cusum_anomaly_detector_drc_routed.pb -rpx basys3_cusum_anomaly_detector_drc_routed.rpx }
  catch { report_methodology -file basys3_cusum_anomaly_detector_methodology_drc_routed.rpt -rpx basys3_cusum_anomaly_detector_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file basys3_cusum_anomaly_detector_timing_summary_routed.rpt -rpx basys3_cusum_anomaly_detector_timing_summary_routed.rpx }
  catch { report_power -file basys3_cusum_anomaly_detector_power_routed.rpt -pb basys3_cusum_anomaly_detector_power_summary_routed.pb -rpx basys3_cusum_anomaly_detector_power_routed.rpx }
  catch { report_route_status -file basys3_cusum_anomaly_detector_route_status.rpt -pb basys3_cusum_anomaly_detector_route_status.pb }
  catch { report_clock_utilization -file basys3_cusum_anomaly_detector_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force basys3_cusum_anomaly_detector_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  catch { write_mem_info -force basys3_cusum_anomaly_detector.mmi }
  write_bitstream -force -no_partial_bitfile basys3_cusum_anomaly_detector.bit 
  catch { write_sysdef -hwdef basys3_cusum_anomaly_detector.hwdef -bitfile basys3_cusum_anomaly_detector.bit -meminfo basys3_cusum_anomaly_detector.mmi -file basys3_cusum_anomaly_detector.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

