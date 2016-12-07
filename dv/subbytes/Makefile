all:
	vlog -sv subbytes_if.sv subbytes_test_top.sv subbytes_tb.sv /home/user/final_year_project/asic_project/de/sbox_lut.v +incdir+/home/user/final_year_project/asic_project/de

run:
	vsim -sv_lib aes -sv_seed random -c -do "run -all" subbytes_test_top
