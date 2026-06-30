module traffic_light_controller (
  input clk,
  input rst,
  input ped_request,
  //North
  output reg N_R,
  output reg N_Y,
  output reg N_G,
  //East
  output reg E_R,
  output reg E_Y,
  output reg E_G,
  //South
  output reg S_R,
  output reg S_Y,
  output reg S_G,
  //West
  output reg W_R,
  output reg W_Y,
  output reg W_G,
  //Paedastrians
  output reg PED_R,
  output reg PED_G
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
  WY = 4'd11,
  PED_AFTER_N =4'd12,
  PED_AFTER_S = 4'd13;
  //signal time
  localparam Green_time = 20,
  Red_time = 2,
  Yellow_time =4,
  Ped_time = 10;


  //present state and next state
  reg [3:0]current_state;
  reg [3:0]next_state;
  reg [7:0]count;
  reg [7:0]max_count;
  
  
  //state register
  always@(posedge clk or posedge rst)begin
    if(rst) 
    current_state <= AR1;
    else  begin
        if(count == max_count)
        current_state <= next_state;
     end
  end

  always@(posedge clk or posedge rst)begin
    if(rst) 
    count<=0;
    else begin
       if(count == max_count)
        count<=0;
        else
        count<=count+1;
    end
     end
   
   
  // next state logic and maxcount
  always@(*) begin
   
    case(current_state)
      AR1 : begin 
        next_state = NG;
        max_count=Red_time;
      end
      NG :begin 
        next_state = NY;
        max_count=Green_time;
        end
      NY: begin 
        next_state = AR2;
        max_count=Yellow_time;
        end
      AR2 : begin 
        next_state =ped_request?PED_AFTER_N:EG;
        max_count=  Red_time;
        end
      PED_AFTER_N: begin 
        next_state = EG;
        max_count = Ped_time;
      end  
      EG : begin 
        next_state = EY;
        max_count=Green_time;
        end
      EY : begin 
        next_state = AR3;
        max_count=Yellow_time;
        end
      AR3 : begin 
        next_state = SG;
        max_count=Red_time;
        end
      SG : begin 
        next_state = SY;
        max_count=Green_time;
        end  
      SY : begin 
        next_state = AR4;
        max_count=Yellow_time;
        end  
      AR4 : begin 
        next_state = ped_request? PED_AFTER_S: WG;
        max_count=Red_time;
        end  
      PED_AFTER_S: begin 
        next_state = WG;
        max_count = Ped_time;
      end    
      WG : begin 
        next_state = WY;
        max_count=Green_time;
        end 
      WY : begin 
        next_state = AR1;
        max_count=Yellow_time;
        end  
        default:begin
          next_state=AR1;
          max_count=Red_time;
        end
    endcase
  end
    //output logic
     always@(*) begin
     N_R = 0;
    N_Y = 0;
    N_G = 0;
    E_R = 0;
    E_Y = 0;
    E_G = 0;
    S_R = 0;
    S_Y = 0;
    S_G = 0;
    W_R = 0;
    W_Y = 0;
    W_G = 0;
    PED_G=0;
    PED_R=0;
    case (current_state)
    AR1 : begin 
        PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
      end
      NG :begin 
         PED_R=1;
        N_G =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end
      NY: begin 
         PED_R=1;
        N_Y =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end
      AR2 : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end
      PED_AFTER_N: begin 
         PED_G=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
      end  
      EG : begin 
         PED_R=1;
        N_R =1;
        E_G =1;
        S_R =1;
        W_R =1;
        end
      EY : begin 
         PED_R=1;
        N_R =1;
        E_Y =1;
        S_R =1;
        W_R =1;
        end
      AR3 : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end
      SG : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_G =1;
        W_R =1;
        end  
      SY : begin 
        PED_R=1;
        N_R =1;
        E_R =1;
        S_Y =1;
        W_R =1;
        end  
      AR4 : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end  
      PED_AFTER_S: begin 
         PED_G=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
      end    
      WG : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_G =1;
        end 
      WY : begin 
         PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_Y =1;
        end  
        default:begin
          PED_R=1;
        N_R =1;
        E_R =1;
        S_R =1;
        W_R =1;
        end
      
    endcase
     end
  
endmodule