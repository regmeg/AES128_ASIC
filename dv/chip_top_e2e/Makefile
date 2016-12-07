all:
	vlog -sv chip_top_if.sv chip_top_test_top.sv chip_top_tb.sv /home/user/final_year_project/asic_project/de/flow_cntr.v /home/user/final_year_project/asic_project/de/key_expansion.v /home/user/final_year_project/asic_project/de/add_round_key_block.v /home/user/final_year_project/asic_project/de/mix_columns.v /home/user/final_year_project/asic_project/de/sbox_lut.v /home/user/final_year_project/asic_project/de/add_round_key_word.v /home/user/final_year_project/asic_project/de/chip_top.v  +incdir+/home/user/final_year_project/asic_project/de

run:
	vsim -sv_lib aes -sv_seed random -c -do "run -all" chip_top_test_top
