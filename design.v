module traffic_light_controller (
  input clk,input rst,
  output reg NS_R,
  output reg NS_Y'
  output reg NS_G,
  output reg EW_R,
  output reg EW_Y,
  output reg EW_G
);
  localparam S0 = 2'b00,//both red
  S1 = 3'd0, //NS green,EW red
  S2 = 3'd1, //NS yellow,EW red
  S3 = 3'd2,//NS red,EW green
  S4 = 3'd3 ;//NS red,EW yellow

  //present state and next state
  reg [2:0]current_state;
  reg [2:0]next_state;
  //state register
  always@(posedge clk or posedge rst)begin
    if(rst)
    current_state <= S0;
    else
    current_state <= next_state; 

  end
  // next state logic
  always@(*) begin
    case(current_state)
      S0 : next_state = S1;
      S1 : next_state = S2;
      S2 : next_state = S3;
      S3 : next_state = S4;
      S4 : next_state = S1;
    endcase
  end
endmodule