module switches(); 

	initial 
		begin 
			if($test$plusargs("plusarg_a")) $display("TEST: plusarg_a "); 
			if ($test$plusargs("plusarg_b")) $display("TEST: plusarg_b ");
			else  $display("TEST: no plusargs ");
			$finish;
end 
endmodule 
