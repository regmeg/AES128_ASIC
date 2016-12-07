onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /chip_top_test_top/chip_top/key_expansion/reg_key_expn
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/data_in_vld
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/seed_key_vld
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/block_data_out
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/block_data_out_vld
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/seed_key
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_block/data_in
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/rnd_key_gen
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/mix_column_off
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_x_word_store_1
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_x_word_store_2
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_x_word_store_3
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_x_word_store_4
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_y_word_store_1
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_y_word_store_2
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_y_word_store_3
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/reg_y_word_store_4
add wave -noupdate /chip_top_test_top/chip_top/flow_cntr/word_out_comb
add wave -noupdate /chip_top_test_top/chip_top/sbox_lut/sub_bytes_val
add wave -noupdate /chip_top_test_top/chip_top/sbox_lut/sub_bytes_sbox_data
add wave -noupdate /chip_top_test_top/chip_top/mix_columns/word_in_comb_sub_bytes
add wave -noupdate /chip_top_test_top/chip_top/mix_columns/word_out_comb_mix_column
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_word/word_in_comb_mix_column
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_word/word_out_comb
add wave -noupdate /chip_top_test_top/chip_top/add_round_key_word/rnd_word_key_val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {450000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 480
configure wave -valuecolwidth 100
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
WaveRestoreZoom {349080 ps} {932040 ps}
