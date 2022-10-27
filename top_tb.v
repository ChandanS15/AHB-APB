module top_tb();

							reg hclk, hresetn;
						   wire hwrite, hreadyin;
							wire [1:0] htrans;
							wire [31:0]  prdata, haddr, hwdata;
							wire [1:0] hresp;
							wire [31:0] hrdata;
						   wire hreadyout, penable_out, pwrite_out;
						   wire [2:0] pselx_out;
						   wire [31:0] paddr_out, pwdata_out, paddr, pwdata;
							wire penable, pwrite;
						   wire [2:0]	pselx;	
							

							
							
							 ahb_master AHB_MASTER 		( .hclk(hclk) ,     .hresetn(hresetn) , .hreadyout(hreadyout) , .hrdata(hrdata) ,   .hresp(hresp) , 
							                             .hwrite(hwrite) , .hreadyin(hreadyin),.haddr(haddr),   		 .hwdata(hwdata) ,   .htrans(htrans) );
						 
						    bridge_top  BRIDGE_TOP	( .hclk(hclk) , 		.hresetn(hresetn), .hwrite(hwrite), 		   .hreadyin(hreadyin) , .htrans(htrans) , .hwdata(hwdata) , 
															  .haddr(haddr), 		.prdata(prdata),   .hreadyout(hreadyout) ,   .penable(penable),    .pwrite(pwrite) , .hrdata(hrdata) , 	
															  .paddr(paddr), 	   .pwdata(pwdata),   .pselx(pselx) );
													
							 apb_interface  APB_INTERFACE 	( .hclk(hclk) , 				 .hresetn(hresetn) ,     .pwrite(pwrite) ,       .penable(penable) ,       .pselx(pselx) , 
																		  .paddr(paddr) , 			 .pwdata(pwdata) ,  		 .pwrite_out(pwrite_out) , .penable_out(penable_out) , .pselx_out(pselx_out) , 
																		  .paddr_out(paddr_out) ,   .pwdata_out(pwdata_out) , .prdata(prdata), .hreadyout(hreadyout) );
													
													
													
													
		initial begin
			hclk = 1'b0;
			forever #10 hclk = ~hclk;
			end
			
			
			task reset;
				begin
					@ (negedge hclk);
					hresetn = 1'b0;
					@ (negedge hclk);
					hresetn = 1'b1;
					end
			endtask
			
			initial begin
			reset;
			//AHB_MASTER.single_write();
			AHB_MASTER.single_read();
			
			#200; $finish;
			end
			endmodule
					
					