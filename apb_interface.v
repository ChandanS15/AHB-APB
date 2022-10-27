module apb_interface  ( input hclk, hresetn , pwrite , penable,
								input [2:0] pselx,
								input [31:0] paddr, pwdata,
								output pwrite_out, penable_out,
								output hreadyout,
								output [2:0] pselx_out,
								output [31:0] paddr_out, pwdata_out,
								output reg [31:0] prdata );
								
assign penable_out = penable;
assign pwrite_out  = pwrite;
assign pselx_out  = pselx;
assign paddr_out  = paddr;
assign pwdata_out = pwdata;


always @ (*)

	begin
		if(pwrite == 0 && penable == 1)		// pwrite 0 states read data
			prdata = {$random}%256;
		else
		prdata = 0;
   end
endmodule