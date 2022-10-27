// AHB MAster

	
module ahb_master (input hclk, hresetn, hreadyout,
						 input [31:0] hrdata,
						 input [1:0] hresp,
						 output reg hwrite, hreadyin, 
						 output reg [31:0] haddr, hwdata,
						 output reg [1:0] htrans );

reg [2:0] hburst; //single, 4, 16...
reg [2:0] hsize;  //size 8, 16, 32. ...

task single_write();
	begin
		@(posedge hclk)
			#1
				begin
					hwrite = 1;						// read operation selected by the ahb master
					htrans = 2'd2;					// type of transfer idle(2'd0) busy (2'd1) seq ( 2'd2) non-seq (2'd3)	
					hsize = 0;						//
					hburst = 0;						// high indicates transfer complete
					hreadyin =1;
					haddr = 32'h8000_0001;		// selecting the peripheral memory (memory mapping)
				end
		@(posedge hclk)
			#1
				begin
					htrans = 2'd0;					// end of single transfer i.e idle state
					hwdata =8'h80;					// sending data of value 80
				end
	end
endtask

task single_read();
	begin
		@(posedge hclk)
			begin
				hwrite = 0;
				htrans = 2'd2;
				hburst = 0;
				hreadyin = 1;
				haddr = 32'h8000_0001;
			end
			@(posedge hclk)
				begin
					htrans = 2'd0;
					end
	end
endtask
endmodule
		
						 