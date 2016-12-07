all:
	vlog -sv flow_cntr_if.sv flow_cntr_test_top.sv flow_cntr_tb.sv /home/user/final_year_project/asic_project/de/flow_cntr.v +incdir+/home/user/final_year_project/asic_project/de
	
run: 
	vsim -sv_lib aes -sv_seed random -c -do "run -all" flow_cntr_test_top
