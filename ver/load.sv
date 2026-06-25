
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr
);

logic [1:0] temp1 ;
  logic [2:0] temp;
    assign mem_rw_mode = 1'b1 ; 
   
    always @(*) begin 
        if (load_control!=`LD_NOP) begin
            stall_pc = 1'b1 ;
            mem_addr = rs1_val + imm ;
           

         end 
        else  begin
            stall_pc = 1'b0 ;
            mem_addr = 0 ;
            
           
         

         end  
    end 
    always @(posedge i_clk or negedge i_rst ) begin
        
        if (!i_rst) begin
            
            rd_write_control <= 0;
            
            rd_out <= 0;
            ignore_curr_inst <= 0;
            temp1 <= 0 ;
         temp <= 0 ;
            
            
        end
        else if (stall_pc)
        begin 
            rd_write_control <= 1'b1;
            
            rd_out <= rd_in;
            ignore_curr_inst <= 1'b1 ;
            temp1 <= mem_addr[1:0] ;
         temp <= load_control ;
            
         end
          else begin 
             rd_write_control <= 0;
            
            rd_out <= 0;
            ignore_curr_inst <= 0;
            temp1 <= 0 ;
         temp <= 0 ;
            

          end 
    end 
    always @(*) begin
    
    if (rd_write_control) begin 
        
        case (temp) 
               `LW :  begin
                rd_write_val = mem_data ;
                end 

            

           

               `LB : begin
                
            
                case (temp1)
                2'b00 : begin 
                rd_write_val = {{24{mem_data[7]}},mem_data[7:0]} ;

                end
                2'b01 : begin 
                rd_write_val = {{24{mem_data[15]}},mem_data[15:8] };


                end
                2'b10 : begin 
                 rd_write_val = {{24{mem_data[23]}},mem_data[23:16] } ;


                end
                2'b11 : begin 
                rd_write_val = { {24{mem_data[31]}},mem_data[31:24] } ;



                end

                endcase 
                end

                `LH : begin
                
            
                case (temp1)
                2'b00 : begin 
                rd_write_val = {{16{mem_data[15]}},mem_data[15:0]} ;

                end
                2'b01 : begin 
                rd_write_val = {{16{mem_data[15]}},mem_data[15:0] };


                end
                2'b10 : begin 
                 rd_write_val = {{16{mem_data[31]}},mem_data[31:16] } ;


                end
                2'b11 : begin 
                rd_write_val = { {16{mem_data[31]}},mem_data[31:16] } ;



                end

                endcase 
                end

                `LBU : begin
                
             
            
                case (temp1)
                2'b00 : begin 
                rd_write_val = {{24{1'b0}},mem_data[7:0]} ;

                end
                2'b01 : begin 
                rd_write_val = {{24{1'b0}},mem_data[15:8] };


                end
                2'b10 : begin 
                 rd_write_val = {{24{1'b0}},mem_data[23:16] } ;


                end
                2'b11 : begin 
                rd_write_val = { {24{1'b0}},mem_data[31:24] } ;



                end

                endcase 
                end
            
               `LHU : begin
                
             
            
                case (temp1)
                2'b00 : begin 
                rd_write_val = {{16{1'b0}},mem_data[15:0]} ;

                end
                2'b01 : begin 
                rd_write_val = {{16{1'b0}},mem_data[15:0] };


                end
                2'b10 : begin 
                 rd_write_val = {{16{1'b0}},mem_data[31:16] } ;


                end
                2'b11 : begin 
                rd_write_val = { {16{1'b0}},mem_data[31:16] } ;



                end

                endcase 

             end 
             default :  begin
             rd_write_val = 0 ;
             end 
            endcase

         
     end 

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/load.vcd");
        $dumpvars(0, load);
    end
`endif

endmodule
