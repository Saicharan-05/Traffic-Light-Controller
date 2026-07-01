`timescale 1ns/1ps
module tb;
reg clk;
reg rst;
reg ped_request;
wire N_G,N_R,N_Y;
wire E_G,E_R,E_Y;
wire S_G,S_R,S_Y;
wire W_G,W_R,W_Y;
wire PED_G,PED_R;
traffic_light_controller dut(
.clk(clk),
.rst(rst),
.ped_request(ped_request),
.N_G(N_G),.N_R(N_R),.N_Y(N_Y),
.E_G(E_G),.E_R(E_R),.E_Y(E_Y),
.S_G(S_G),.S_R(S_R),.S_Y(S_Y),
.W_G(W_G),.W_R(W_R),.W_Y(W_Y),
.PED_G(PED_G),.PED_R(PED_R)
);
always
#5 clk = ~clk;
initial begin
  $dumpfile("trafic.vcd");
  $dumpvars(0,tb);
  clk = 0;
  rst = 1;
  ped_request = 0;

  #20 rst = 0;
  
  #100 ped_request = 1;
  

  #5000 $finish;
end
endmodule