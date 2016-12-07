//Chip defines define the size of common signals and registers, for convience purposes, as it is easier to change the values if necessary at one place then at many.

//Set timescale for simulations
`timescale 1 ns / 10 ps //delay (#) operator is set to 1ns, with 100ps precission.

//Common defines
`define WORD_DATA_WIDTH  32
`define BLOCK_DATA_WIDTH 128

// flow_cntr module defines
`define FLOW_CNTR_COUNT_WORD_CYCLES 			5:0
`define FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH 6
`define LAST_CYCLE_OF_ENCRPT							`FLOW_CNTR_COUNT_WORD_CYCLES_WIDTH'h28 //10 cycles
`define SWITH_MIXCOLUMN_OFF_AFTER 				32'h25 

// key_expansion defines
`define SEED_KEY_WIDTH 						128
`define KEY_EXPN_CNTR_CYCLES 			1:0
`define KEY_EXPN_CNTR_WIDTH 			2
`define KEY_EXPN_CNTR_RCON_CYCLES 5:2
`define KEY_EXPN_CNTR_RCON_WIDTH  4

//Block seperation into the words and bytes
`define FOURTH_WRD       31:0
`define THIRD_WRD        63:32
`define SECOND_WRD       95:64
`define FIRST_WRD        127:96

`define FIRST_WRD_BYTE  7:0
`define SECOND_WRD_BYTE 15:8
`define THIRD_WRD_BYTE  23:16
`define FOURTH_WRD_BYTE 31:24

//Sbox
`define sbox_w 16
`define sbox_h 16



