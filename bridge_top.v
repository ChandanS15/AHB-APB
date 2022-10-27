/* Bridge Top with AHB Slave and APB Controller */


module bridge_top ( input hclk, hresetn, hwrite, hreadyin,
							input [1:0] htrans,
							input [31:0] hwdata , haddr, prdata,
							output hreadyout, penable, pwrite,
							output [31:0] paddr, pwdata, hrdata,
							output [2:0] pselx );
							


wire [31:0] hwdata_1, hwdata_2, haddr_1, haddr_2 ;
wire [2:0] temp_selx;
wire valid, hwrite_reg_1, hwrite_reg_2 ;
wire [1:0] hresp;


ahb_slave_interface AHB_SLAVE(  .hclk(hclk) , 						.hresetn(hresetn) , 	.hreadyin(hreadyin) , 	.hwrite(hwrite) , 	.htrans(htrans) , 
										  .hwdata(hwdata) , 		   		.haddr(haddr) , 		.prdata(prdata) , 		.valid(valid) , 	   .hwrite_reg_1(hwrite_reg_1) , 
										  .hwrite_reg_2(hwrite_reg_2) ,	.haddr_1(haddr_1) , 	.haddr_2(haddr_2) , 	   .hwdata_1(hwdata_1) ,.hwdata_2(hwdata_2) ,
										  .temp_selx(temp_selx) ,        .hresp(hresp) , 		.hrdata(hrdata)  );

apb_controller APB_CONTROLLER ( 	 .hclk(hclk) , 			.hresetn(hresetn) ,  .hwrite_reg_1(hwrite_reg_1) , .hwrite_reg_2(hwrite_reg_2),	.hwrite(hwrite) , 	 .valid(valid) ,
											 .haddr(haddr) ,  		.haddr_1(haddr_1) , 	.haddr_2(haddr_2) , 			   .hwdata(hwdata), 					.hwdata_1(hwdata_1) ,
											 .hwdata_2(hwdata_2) ,  .prdata(prdata) , 	.temp_selx(temp_selx)	,	   .paddr(paddr) , 					.pwdata(pwdata), 
											 .pwrite(pwrite) ,	   .penable(penable) ,  .hreadyout(hreadyout),		   .pselx(pselx)	);
													
endmodule
 							