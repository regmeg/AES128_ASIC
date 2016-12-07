all:
	vlog -sv mix_columns_if.sv mix_columns_test_top.sv mix_columns_tb.sv /home/user/final_year_project/asic_project/de/mix_columns.v +incdir+/home/user/final_year_project/asic_project/de

run:
	vsim -sv_lib aes -sv_seed random -c -do "run -all" mix_columns_test_top
