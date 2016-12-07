onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /flow_cntr_test_top/flow_cntr/clk
add wave -noupdate /flow_cntr_test_top/flow_cntr/block_data_in
add wave -noupdate /flow_cntr_test_top/flow_cntr/block_data_in_vld
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_x_word_store_1
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_x_word_store_2
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_x_word_store_3
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_x_word_store_4
add wave -noupdate /flow_cntr_test_top/flow_cntr/reset
add wave -noupdate /flow_cntr_test_top/flow_cntr/rnd_key_gen
add wave -noupdate /flow_cntr_test_top/flow_cntr/counter_on
add wave -noupdate /flow_cntr_test_top/flow_cntr/sbox_available
add wave -noupdate /flow_cntr_test_top/flow_cntr/key_available
add wave -noupdate /flow_cntr_test_top/flow_cntr/data_accept
add wave -noupdate /flow_cntr_test_top/flow_cntr/word_out_comb
add wave -noupdate /flow_cntr_test_top/flow_cntr/word_out_comb_vld
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_y_word_store_1
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_y_word_store_2
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_y_word_store_3
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_y_word_store_4
add wave -noupdate /flow_cntr_test_top/flow_cntr/is_mod_1_to_4
add wave -noupdate /flow_cntr_test_top/flow_cntr/input_cycle
add wave -noupdate /flow_cntr_test_top/flow_cntr/word_in_comb
add wave -noupdate /flow_cntr_test_top/flow_cntr/word_in_comb_vld
add wave -noupdate /flow_cntr_test_top/flow_cntr/mix_column_off
add wave -noupdate /flow_cntr_test_top/flow_cntr/reg_flow_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {348800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 368
configure wave -valuecolwidth 110
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1392280 ps}
