/* Signals
   input signals  Hclk 			- global clock signal
					   Hresetn   	- global reset signal
					   Hwrite    	- W/R(1/0) Signal
					   Hreadyin  	- high indicates transfer complete
					   Htrans[1:0]  - type of tranfer - idle, busy, seq, non-seq
					   Haddr[31:0]  - 32-bit system address
					   Hwdata[31:0] - transfer data via write data bus(master writes to the slave)
					   Hresp[1:0]   - status response
					   Hrdata[31:0] - transfer data via read data bus(master reads from slave)
	output signals Valid
						Haddr1[31:0]
						Haddr2[31:0]
						Hwdata[31:0]
						Hwdata2[31:0]
						Hwritereg
						tempselx[2:0] - Selecting the peripheral on the memory stack */

module ahb_slave_interface(   input  hclk, hresetn, hreadyin, hwrite,
										input  [1:0] htrans,
										input  [31:0] hwdata, haddr, prdata,
										output reg valid,
										output reg [31:0] haddr_1, haddr_2, hwdata_1, hwdata_2,
										output reg [2:0]  temp_selx,
										output reg hwrite_reg_1,hwrite_reg_2,
										output reg [1:0] hresp,
										output [31:0] hrdata
										);
						
						
	
// 2-staged address,write-data and hwrite_reg pipeline
	
			always @ (posedge hclk)
				begin
					if(!hresetn)
						begin
							haddr_1 <= 0;
							haddr_2 <= 0;
						end
						
					else
						begin
							haddr_1 <= haddr;
							haddr_2 <= haddr_1;
				end
			end	
	
always @ (posedge hclk)
				begin
					if(!hresetn)
						begin
							hwdata_1 <= 0;
							hwdata_2 <= 0;
						end
						
					else
						begin
							hwdata_1 <= hwdata;
							hwdata_2 <= hwdata_1;
						end
				end	
			
always @ (posedge hclk)
				begin
					if(!hresetn)
						begin
							hwrite_reg_1 <= 0;
							hwrite_reg_2 <= 0;
						end
						
					else
						begin
							hwrite_reg_1 <= hwrite;
							hwrite_reg_2 <= hwrite_reg_1;
						end
				end	
				
//generating valid signal

always @(*)
		begin
			if(hreadyin == 1 && haddr>=32'h8000_0000 && haddr < 32'h8c00_0000 && htrans == 2'b10 || htrans == 2'b11)
		     valid = 1'b1;
			else
			  valid = 1'b0;
		end
		
//selecting the pheripherals from the memory stack

always @(*)
		begin
			if(haddr>=32'h8000_000 && haddr<32'h8400_0000)
				temp_selx = 3'b001;
			else
			if(haddr>=32'h8400_000 && haddr<32'h8800_0000)
				temp_selx = 3'b010;
			else
			if(haddr>=32'h8800_000 && haddr<32'h8c00_0000)
				temp_selx = 3'b100;
		end
		
		assign hrdata = prdata;
		
endmodule
			
				