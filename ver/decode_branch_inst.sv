
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_branch_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [12:0] imm,
    output logic [2:0] branch_control
);


   
     always @(*) begin 
        rs2 =instruction_code[24:20];
        rs1=instruction_code[19:15];
        imm= {instruction_code[31],instruction_code[7 ], instruction_code[30:25] ,instruction_code[11:8], 1'b0};

    case ( instruction_code[14:12]  ) 

    3'h0 : branch_control =`BEQ ;
    3'h1 : branch_control =`BNE ;
    3'h4 : branch_control =`BLT ;
    3'h5 : branch_control =`BGE ;
    3'h6 : branch_control =`BLTU ;
     3'h7 : branch_control =`BGEU ;
    
default : branch_control = 0 ;



    endcase
    end 
    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_branch_inst.vcd");
        $dumpvars(0, decode_branch_inst);
    end
`endif

endmodule
