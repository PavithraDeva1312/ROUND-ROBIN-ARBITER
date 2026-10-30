module rrarbiter(clk, rst, req, grant, grant_acq);

parameter [3:0]r1 = 4'b0001;
parameter [3:0]r2 = 4'b0010;
parameter [3:0]r3 = 4'b0100;
parameter [3:0]r4 = 4'b1000;

input clk, rst;
input [3:0] req;
output reg[3:0] grant;
output reg grant_acq;

reg [1:0]priority_ptr;

always @(posedge clk) begin
   if(rst) begin 
      grant = 4'b0000;
      grant_acq= 1'b0;
	  priority_ptr = 2'b00;
   end

   else begin
   grant = 4'b0000;
   grant_acq = 1'b0;
      case (priority_ptr)

       2'b00 : begin
	     if (req[0]) begin
		    grant = r1;
            grant_acq = 1;
	        priority_ptr = 2'b01;
		 end


	     else if (req[1]) begin
		    grant = r2;
            grant_acq = 1;
	        priority_ptr = 2'b10;
		 end

	     else if (req[2]) begin
		    grant = r3;
            grant_acq = 1;
	        priority_ptr = 2'b11;
		 end
	     else if (req[3]) begin
		    grant = r4;
            grant_acq = 1;
	        priority_ptr = 2'b00;
		 end
	end
    
	2'b01 : begin
	     if (req[1]) begin
		    grant = r2;
            grant_acq = 1;
	        priority_ptr = 2'b10;
		 end

	     else if (req[2]) begin
		    grant = r3;
            grant_acq = 1;
	        priority_ptr = 2'b11;
		 end
	     else if (req[3]) begin
		    grant = r4;
            grant_acq = 1;
	        priority_ptr = 2'b00;
		 end
         else if (req[0]) begin
		    grant = r1;
            grant_acq = 1;
	        priority_ptr = 2'b01;
		 end
      end

	  2'b10 : begin
         if (req[2]) begin
		    grant = r3;
            grant_acq = 1;
	        priority_ptr = 2'b11;
		 end
	     else if (req[3]) begin
		    grant = r4;
            grant_acq = 1;
	        priority_ptr = 2'b00;
		 end
         else if (req[0]) begin
		    grant = r1;
            grant_acq = 1;
	        priority_ptr = 2'b01;
		 end
         else if (req[1]) begin
		    grant = r2;
            grant_acq = 1;
	        priority_ptr = 2'b10;
		 end
	end
     2'b11 : begin
       if (req[3]) begin
		    grant = r4;
            grant_acq = 1;
	        priority_ptr = 2'b00;
		 end
         else if (req[0]) begin
		    grant = r1;
            grant_acq = 1;
	        priority_ptr = 2'b01;
		 end
         else if (req[1]) begin
		    grant = r2;
            grant_acq = 1;
	        priority_ptr = 2'b10;
		 end

         else if (req[2]) begin
		    grant = r3;
            grant_acq = 1;
	        priority_ptr = 2'b11;
		 end
		 
	   end
	endcase

  end 
end
endmodule

