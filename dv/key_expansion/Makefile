all:
	vlog -sv key_expansion_if.sv key_expansion_test_top.sv key_expansion_tb.sv subbytes_init_tb.sv /home/user/final_year_project/asic_project/de/key_expansion.v /home/user/final_year_project/asic_project/dv/subbytes/subbytes_if.sv /home/user/final_year_project/asic_project/de/sbox_lut.v +incdir+/home/user/final_year_project/asic_project/de

run:
	vsim -sv_lib aes -sv_seed random -c -do "run -all" key_expansion_test_top
