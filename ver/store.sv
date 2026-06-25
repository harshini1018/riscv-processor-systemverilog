
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module store(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [31:0] imm,
    input logic [2:0] store_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_write_data,
    output logic [3:0] mem_byte_en
);



 always @(*) begin
        
        
        case  (store_control) 
        `SW : begin 
            stall_pc = 1'b1 ;
            mem_byte_en = 4'b1111; 
            mem_rw_mode = 1'b0 ;
            mem_addr = imm + rs1_val ; 
            mem_write_data = rs2_val ;

             end 

        `SB : begin
            stall_pc = 1'b1 ;
            
            mem_rw_mode = 1'b0 ;
            mem_addr = imm + rs1_val ; 
            
               case (mem_addr[1:0])
               2'b00 : begin 
                mem_byte_en = 4'b0001 ;
                mem_write_data[7:0] = rs2_val[7:0];

               end
               2'b01 : begin 
                mem_byte_en = 4'b0010 ;
                mem_write_data[15:8] = rs2_val[7:0];

               end
               2'b10 : begin 
                mem_byte_en = 4'b0100 ;
                mem_write_data[23:16] = rs2_val[7:0];

               end
               2'b11 : begin 
                mem_byte_en = 4'b1000 ;
                mem_write_data[32:24] = rs2_val[7:0];

               end

                endcase 
        end

        `SH : begin
            stall_pc = 1'b1 ;
            
            mem_rw_mode = 1'b0 ;
            mem_addr = imm + rs1_val ; 
            
               case (mem_addr[1:0])
               2'b00 : begin 
                mem_byte_en = 4'b0011 ;
                mem_write_data[15:0] = rs2_val[15:0];

               end
               2'b01 : begin 
                mem_byte_en = 4'b0011 ;
                mem_write_data[15:0] = rs2_val[15:0];

               end
               2'b10 : begin 
                mem_byte_en = 4'b1100 ;
                mem_write_data[32:16] = rs2_val[15:0];

               end
               2'b11 : begin 
                mem_byte_en = 4'b1100 ;
                mem_write_data[32:16] = rs2_val[15:0];

               end

                endcase 
                
             end 
        default : begin 
            stall_pc = 1'b0 ;
            mem_byte_en = 4'b0000; 
            mem_rw_mode = 1'b1 ;
            mem_addr = 0 ; 
            mem_write_data = 0 ;


             end 
        
         
            

            
        endcase
        

     end 
     always @( posedge i_clk or negedge i_rst) begin
        if (! i_rst) begin 
            ignore_curr_inst<= 0 ;
        end 
        else if (store_control) begin
            ignore_curr_inst <= 1 ;
         end 
         else begin 
            ignore_curr_inst <= 0;
         end 
        
     end
    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/store.vcd");
        $dumpvars(0, store);
    end
`endif

endmodule
