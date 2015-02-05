`define BLOCK_DATA_WIDTH 128
`define CPU_DATA_WIDTH 64
`define REG_PNTR_CNTR_WIDTH 4
`define REG_PNTR_CNTR_FIRST 3:0
`define REG_PNTR_CNTR_SECOND 7:4
`define REG_PNTR_CNTR_THIRD 11:8
`define REG_PNTR_CNTR_FOURTH 15:12
`define CPU_READ_AND_VALID_BOTH_HIGH 0

//Block seperation into the words
`define first_wrd     31:0
`define second_wrd  63:32
`define third_wrd     95:64
`define fourth_wrd    127:96

//Key expansion wrds for different stages
//Preliminary stage
`define zero_1_wrd 31:0
`define zero_2_wrd 63:32
`define zero_3_wrd 95:64
`define zero_4_wrd 127:96
//First stage
`define zero_5_wrd 159:128
`define zero_6_wrd 191:160
`define zero_7_wrd 223:192
`define zero_8_wrd 255:224
//Second stage
`define zero_9_wrd 287:256
`define one_0_wrd  319:288
`define one_1_wrd  351:320
`define one_2_wrd  383:352
//Thirds stage
`define one_3_wrd 415:384
`define one_4_wrd 447:416
`define one_5_wrd 479:448
`define one_6_wrd 511:480
//Fourth stage
`define one_7_wrd 543:512
`define one_8_wrd 575:544
`define one_9_wrd 607:576
`define two_0_wrd 639:608
//Fith stage
`define two_1_wrd 671:640
`define two_2_wrd 703:672
`define two_3_wrd 735:704
`define two_4_wrd 767:736
//Sixth stage
`define two_5_wrd 799:768
`define two_6_wrd 831:800
`define two_7_wrd 863:832
`define two_8_wrd 895:864
//Seventh stage
`define two_9_wrd   927:896
`define three_0_wrd 959:928
`define three_1_wrd 991:960
`define three_2_wrd 1023:992
//Eight stage
`define three_3_wrd 1055:1024
`define three_4_wrd 1087:1056
`define three_5_wrd 1119:1088
`define three_6_wrd 1151:1120
//Ninth stage
`define three_7_wrd 1183:1152
`define three_8_wrd 1215:1184
`define three_9_wrd 1247:1216
`define four_0_wrd  1279:1248
//Tenth stage
`define four_1_wrd 1311:1280
`define four_2_wrd 1343:1312
`define four_3_wrd 1375:1344
`define four_4_wrd 1407:1376
