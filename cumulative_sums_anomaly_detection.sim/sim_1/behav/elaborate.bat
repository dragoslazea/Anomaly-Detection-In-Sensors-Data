@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto deec0a88529941b7a41dcbf5f3da5bee -m64 --debug typical --relax --mt 2 -L axis_infrastructure_v1_1_0 -L fifo_generator_v13_1_3 -L axis_data_fifo_v1_1_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_int_cumulative_sums_detector_behav xil_defaultlib.tb_int_cumulative_sums_detector xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
