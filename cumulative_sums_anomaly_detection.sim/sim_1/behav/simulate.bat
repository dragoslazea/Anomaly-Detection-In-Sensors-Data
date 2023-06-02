@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim tb_int_cumulative_sums_detector_behav -key {Behavioral:sim_1:Functional:tb_int_cumulative_sums_detector} -tclbatch tb_int_cumulative_sums_detector.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
