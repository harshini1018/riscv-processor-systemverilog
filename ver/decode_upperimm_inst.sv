
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_upperimm_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [31:0] imm,
    output logic [4:0] alu_control
);



    

     assign rd = instruction_code[11:7];
     assign imm = {instruction_code [31:12],{12{1'b0}} };
    always @(* ) begin 
    case (instruction_code[6:0]) 
    7'b0110111 : begin 
         
          
        alu_control = `LUI ;
            
       
          end 
    
    7'b0010111 : begin 

         alu_control = `AUIPC ;

    end
    default : alu_control = 0;     
        
     endcase 
    end 
    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_upperimm_inst.vcd");
        $dumpvars(0, decode_upperimm_inst);
    end
`endif

endmodule
