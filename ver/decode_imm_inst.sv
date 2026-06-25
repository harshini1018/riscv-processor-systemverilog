
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_imm_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);



   always @(*) begin 
     imm =instruction_code[31:20];
        rs1=instruction_code[19:15];
        rd=instruction_code[11:7];

    case ( instruction_code[14:12]  ) 

    {3'h0} :       alu_control = `ADDI ;

   
    {3'h4}: alu_control = `XORI ; 
   
    {3'h6}: alu_control =  `ORI ;
   
    {3'h7}: alu_control = `ANDI ; 
   
    {3'h1}:alu_control = `SLLI ; 
   
    {3'h5}:begin
    if (instruction_code[31:25] ==0 ) begin
     alu_control = `SRLI ; 
    end
     else if (instruction_code[31:25] == 7'h20) begin
      alu_control = `SRAI ; 
    end
    else begin 
        alu_control= 0;
    end 
    end

    {3'h2}: alu_control = `SLTI ;

    {3'h3}: alu_control = `SLTIU ; 

    default : alu_control = 5'd0 ;
   
    
    
   endcase
   end


    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_imm_inst.vcd");
        $dumpvars(0, decode_imm_inst);
    end
`endif

endmodule
