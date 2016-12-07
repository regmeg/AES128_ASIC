module rand_test();

	class input_data;
		rand bit[9:0] key;
		rand bit[9:0] block_data;
	endclass
	
	initial begin
	$display("seed is %d",$get_initial_random_seed);
		for (int i = 0 ; i < 3; i ++) begin
			gen_key_and_block_data();
		end
		$finish;
	end
	
	task gen_key_and_block_data();
	input_data input_d;
	input_d = new();
	input_d.randomize;
	$display("rand gen key is 0x%x and data is 0x%x",input_d.key, input_d.block_data);
	endtask
	
	
endmodule 

//make the seed testst , ahahaha
