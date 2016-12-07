module switches(); 
	//import  "DPI-C" function void aes_encrypt(input bit[127:0] in,output bit[127:0] out, input bit[127:0] key, int keysize);
	import "DPI-C" function void aes_encrypt_block_wide_add_rnd_key_test(input bit[127:0] in, output bit[127:0] out, input bit[127:0] key);
	
	bit[127:0] key;
	bit[127:0] block_data;
	bit[127:0] out_block_data;
        initial 
                begin 
                        key[127:0] = 128'h3736733c3c3956744730746a59;
                        block_data[127:0] = 128'h72226b625f216a332045272156;
                        aes_encrypt_block_wide_add_rnd_key_test(block_data,out_block_data, key);
                        $display("key = 0x%h, data_in = 0x%h, data_out = 0x%h", key,block_data, out_block_data);
                        $display("result should be = 0x%h", key ^ block_data);
                        $finish;
	end
endmodule




