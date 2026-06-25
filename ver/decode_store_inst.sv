
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_store_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [11:0] imm,
    output logic [2:0] store_control
);



   
   always @(*) begin 
rs2 =instruction_code[24:20];
        rs1=instruction_code[19:15];
        imm[4:0]=instruction_code[11:7] ;
        imm [11:5] = instruction_code[31:25] ;
        case (instruction_code[14:12])
        3'h0 : store_control = `SB ;
        3'h1 : store_control = `SH ;
        3'h2 : store_control = `SW ;
        default : store_control = 0 ;

        endcase


   end 


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_store_inst.vcd");
        $dumpvars(0, decode_store_inst);
    end
`endif

endmodule
