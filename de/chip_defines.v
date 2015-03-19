//Common defines
`define WORD_DATA_WIDTH  32
`define BLOCK_DATA_WIDTH 128

// flow_cntr module defines
`define FLOW_CNTR_COUNT_WORD_CYCLES 			5:0
`define FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH 6
`define LAST_CYCLE_OF_ENCRPT							`FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH'h28
`define SWITH_MIXCOLUMN_OFF_AFTER 				32'h25

// key_expansion defines
`define SEED_KEY_WIDTH 						128
`define KEY_EXPN_CNTR_CYCLES 			1:0
`define KEY_EXPN_CNTR_WIDTH 			2
`define KEY_EXPN_CNTR_RCON_CYCLES 5:2
`define KEY_EXPN_CNTR_RCON_WIDTH  4

//Block seperation into the words and bytes
`define FIRST_WRD       31:0
`define SECOND_WRD      63:32
`define THIRD_WRD       95:64
`define FOURTH_WRD      127:96

`define FIRST_WRD_BYTE  7:0
`define SECOND_WRD_BYTE 15:8
`define THIRD_WRD_BYTE  23:16
`define FOURTH_WRD_BYTE 31:24

//Sbox
`define sbox_w 16
`define sbox_h 16
