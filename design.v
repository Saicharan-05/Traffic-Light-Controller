module traffic_light_controller (
  input clk,
  input rst,

  //North
  output reg N_R,
  output reg N_Y'
  output reg N_G,
  //East
  output reg E_R,
  output reg E_Y,
  output reg E_G,
  //South
  output reg S_R,
  output reg S_Y'
  output reg S_G,
  //West
  output reg W_R,
  output reg W_Y,
  output reg W_G,
  //Paedastrians
  output reg PED_NS,
  output reg PED_EW
);
//state declarations
  localparam AR1 = 4'd0,//all red
  NG = 4'd1, 
  NY = 4'd2, 
  AR2 = 4'd3,
  EG = 4'd4 ,
  EY = 4'd5,
  AR3 = 4'd6,
  SG = 4'd7,
  SY = 4'd8,
  AR4 = 4'd9,
  WG = 4'd10,
  WY = 4'd11;

  //present state and next state
  reg [3:0]current_state;
  reg [3:0]next_state;
  reg [3:0]count;
  
  //state register
  always@(posedge clk or posedge rst)begin
    if(rst) begin
    current_state <= AR1;
    count<=0;
    end
    else begin
      if(count == max_count)begin
        current_state <= next_state;
        count<=0;
         end
      else begin
        count<=count+1;
      end
    end
   end
   
   
  // next state logic and maxcount
  always@(*) begin
    case(current_state)
      S0 : begin 
        next_state = S1;
        max_count=2;
      end
      S1 :begin 
        next_state = S2;
        max_count=5;
        end
      S2 : begin 
        next_state = S3;
        max_count=2;
        end
      S3 : begin 
        next_state = S4;
        max_count=5;
        end
      S4 : begin 
        next_state = S1;
        max_count=2;
        end
        default:begin
          next_state=S0;
          max_count=2;
        end
    endcase
    //output logic
     always@(*) begin
    case (current_state)
      S0:begin
        NS_R=1;
        EW_R=1;
      end 
      S1:begin
        NS_G=1;
        EW_R=1;
      end
      S2:begin
        NS_Y=1;
        EW_R=1;
      end
      S3:begin
        NS_R=1;
        EW_G=1;
      end
      S4:begin
        NS_R=1;
        EW_Y=1;
      end
      default: 
    endcase
     end
  end
endmodule