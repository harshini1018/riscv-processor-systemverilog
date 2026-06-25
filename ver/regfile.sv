
module regfile(
    input logic i_clk,
    input logic i_rst,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic rd_write_control,
    input logic [31:0] rd_write_val,
    output logic [31:0] rs1_val,
    output logic [31:0] rs2_val
);

logic [31:0] regs [0:31];
 integer i;



always @(*) begin 
    rs1_val = regs[rs1];
    rs2_val = regs[rs2];
end
always @ ( posedge i_clk or negedge i_rst )begin
     
 
    if ( !i_rst) begin
        for (i=0;i<32; i++)
       regs[i]  <= 0;
        
    end 
    else if (rd_write_control && rd != 0)  begin  
        regs[rd] <= rd_write_val;  
    end      
end 

generate 
    for(genvar ii=0;ii<32;ii+=1) begin: gen_reg_temp
    wire[31:0] reg_dump;
    assign reg_dump=regs[ii];
    end
    endgenerate



`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/regfile.vcd");
        $dumpvars(0, regfile);
    end
`endif

endmodule
