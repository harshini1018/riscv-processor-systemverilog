
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module branch(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] pc_prev,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [2:0] branch_control,
    output logic pc_update_control,
    output logic [31:0] pc_update_val,
    output logic ignore_curr_inst
);


   
    always @(*) begin
        
        
        case  (branch_control ) 
           `BEQ : begin 
            if ( rs1_val == rs2_val) begin 
             
            pc_update_control = 1'b1 ;
            
            pc_update_val = pc_prev + imm ;
             end 
             else  begin 
             pc_update_control = 1'b0 ;
            
             pc_update_val = 0;    
             end 
           end 
        
         
            `BNE : begin
            if (rs1_val != rs2_val) begin 
            pc_update_control = 1'b1 ;
           
            pc_update_val = pc_prev + imm ;
            end
            else  begin 
             pc_update_control = 1'b0 ;
            
             pc_update_val = 0; 
            end 
            end
            

            `BLT : begin
            if (rs1_val  < rs2_val) begin 
            
                  pc_update_control = 1'b1 ;
            
                    pc_update_val = pc_prev + imm ;


            end 
            else begin 
                   pc_update_control = 1'b0 ;
            
                pc_update_val = 0; 
            end 
            end

            `BGE : begin
            if (rs1_val >= rs2_val) begin 
           
              pc_update_control = 1'b1 ;
            
              pc_update_val = pc_prev + imm ;
            end
            else begin 
               pc_update_control = 1'b0 ;
        
               pc_update_val = 0; 
            end 
            end

           `BLTU : begin
            if (rs1_val < rs2_val ) begin 
            
              pc_update_control = 1'b1 ;
            
              pc_update_val = pc_prev + imm ;
            end
            else begin 
              pc_update_control = 1'b0 ;
            
              pc_update_val = 0; 
            end 
            end 

           `BGEU : begin
            if (rs1_val >= rs2_val ) begin 
           
              pc_update_control = 1'b1 ;
            
               pc_update_val = pc_prev + imm ;
            end
            else begin 
              pc_update_control = 1'b0 ;
            
              pc_update_val = 0; 
            end 
            end 


            default:  begin
            
              pc_update_control = 1'b0 ;
            
              pc_update_val = 0; 

            end 
        endcase
        

     end 
     always @( posedge i_clk or negedge i_rst) begin
        if (! i_rst) begin 
            ignore_curr_inst<= 0 ;
        end 
        else if (pc_update_control) begin
            ignore_curr_inst <= 1 ;
         end 
         else begin 
            ignore_curr_inst <= 0;
         end 
        
     end
    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/branch.vcd");
        $dumpvars(0, branch);
    end
`endif

endmodule
