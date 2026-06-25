 
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);



   
    
   always @(*) begin 
     rs2=instruction_code[24:20];
        rs1=instruction_code[19:15];
        rd=instruction_code[11:7];

    case ({ instruction_code[14:12] , instruction_code[31:25 ] } ) 

    {3'h0,7'h0} :       alu_control = `ADD ;

    {3'h0,7'h20}: alu_control = `SUB ;

    {3'h4,7'h0}: alu_control = `XOR ; 
   
    {3'h6,7'h0}: alu_control =  `OR ;
   
    {3'h7,7'h0}: alu_control = `AND ; 
   
    {3'h1,7'h0}:alu_control = `SLL ; 
   
    {3'h5,7'h0}: alu_control = `SRL ; 
   
    
    {3'h5,7'h20}: alu_control = `SRA ; 

    {3'h2,7'h0}: alu_control = `SLT ;

    {3'h3,7'h0}: alu_control = `SLTU ; 

    default : alu_control = 5'd0 ;
    
    



    endcase
   end


    


`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_reg_inst.vcd");
        $dumpvars(0, decode_reg_inst);
    end
`endif

endmodule
