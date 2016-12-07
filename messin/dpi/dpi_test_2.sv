module switches(); 
	//import  "DPI-C" function void aes_encrypt(input bit[127:0] in,output bit[127:0] out, input bit[127:0] key, int keysize);
	import "DPI-C" function void get_sboxvalues(output bit[2047:0] out);
	
	bit[2047:0] out_block_data;
        initial 
                begin 
												get_sboxvalues(out_block_data);
                        $display("packed sbox is = 0x%h", out_block_data);
                        $finish;
	end
endmodule




