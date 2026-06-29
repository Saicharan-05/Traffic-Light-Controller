module traffic_light_controller (
  input clk,input rst,
  output reg NS_R,
  output reg NS_Y'
  output reg NS_G,
  output reg EW_R,
  output reg EW_Y,
  output reg EW_G
);
  localparam S0 = 3'd0,//both red
  S1 = 3'd1, //NS green,EW red
  S2 = 3'd2, //NS yellow,EW red
  S3 = 3'd3,//NS red,EW green
  S4 = 3'd4 ;//NS red,EW yellow

  //present state and next state
  reg [2:0]current_state;
  reg [2:0]next_state;
  reg [3:0]count;
  reg[3:0] max_count;
  //state register
  always@(posedge clk or posedge rst)begin
    if(rst) begin
    current_state <= S0;
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