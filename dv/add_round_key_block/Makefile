all:
	vlog -sv add_round_key_block_if.sv add_round_key_block_test_top.sv add_round_key_block_tb.sv /home/user/final_year_project/asic_project/de/add_round_key_block.v +incdir+/home/user/final_year_project/asic_project/de
	
run: 
	vsim -sv_lib aes -sv_seed random -c -do "run -all" add_round_key_block_test_top
