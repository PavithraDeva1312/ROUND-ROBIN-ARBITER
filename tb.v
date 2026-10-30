`include "arbiter.v"

module tb;
reg clk, rst;
reg [3:0] req;
wire[3:0] grant;
wire grant_acq;

rrarbiter dut(.clk(clk), .rst(rst),.req(req), .grant(grant), .grant_acq(grant_acq));

always #5 clk = ~clk;
initial begin

 clk = 0;
 $monitor("time=%0t rst=%b req=%b grant=%b grant_acq=%b",
              $time, rst, req, grant, grant_acq);

    rst = 1;
    req = 4'b0000;

    #10;
    rst = 0;

    @(negedge clk);
    req = 4'b1111;

    repeat(4) @(negedge clk);

    req = 4'b1100;
    repeat(4) @(negedge clk);

    req = 4'b1010;
    repeat(4) @(negedge clk);
    req = 4'b0001;
    repeat(2) @(negedge clk);

    req = 4'b0000;
    repeat(2) @(negedge clk);
    #50;
    $finish;
end

endmodule


