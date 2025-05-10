module pipeline_4_stage (input clk, input reset);

//Instruction opcodes
localparam ADD = 2'b00,
           SUB = 2'b01,
           LOAD = 2'b10;

//Instruction memory
reg [15:0] instr_mem [0:7];

//Register file
reg [7:0] reg_file [0:7];

//Data memory
reg [7:0] data_mem [0:15];

//Program counter
reg [2:0] pc;

//Pipeline registers
reg [15:0] IF_ID_instr;
reg [1:0] ID_EX_opcode;
reg [2:0] ID_EX_rs, ID_EX_rt, ID_EX_rd;
reg [7:0] ID_EX_reg_rs_data, ID_EX_reg_rt_data;
reg [2:0] EX_WB_rd;
reg [7:0] EX_WB_alu_result;
reg EX_WB_reg_write;

//Fetch Stage
always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        pc <= 0;
        IF_ID_instr <= 0;
      end
    else
      begin
        IF-ID_instr <= instr_mem[pc];
        pc <= pc+1;
      end
  end

//Decode Stage
always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        ID_EX_opcode <= 0;
        ID_EX_rs <= 0;
        ID_EX_rt <= 0;
        ID_EX_rd <= 0;
        ID_EX_reg_rs_data <= 0;
        ID_EX_reg_rt_data <= 0;
      end
    else
      begin
        ID_EX_opcode <= IF_ID_instr[15:14];
        ID_EX_rs <= IF_ID_instr[13:11];
        ID_EX_rt <= IF_ID_instr[10:8];
        ID_EX_rd <= IF_ID_instr[7:5];
        ID_EX_reg_rs_data <= reg_file[IF_ID_instr[13:11]];
        ID_EX_reg_rt_data <= reg_file[IF_ID_instr[10:8]]
      end
  end

//Execute Stage
always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        EX_WB_rd <= 0;
        EX_WB_alu_result <= 0;
        EX_WB_reg_write <= 0;
      end
    else
      begin
        case(ID_EX_opcode)
          ADD : begin
                  EX_WB_alu_result <= ID_EX_reg_rs_data + ID_EX_reg_rt_data;
                  EX_WB_reg_write <= 1;
                end
          SUB : begin
                  EX_WB_alu_result <= ID_EX_reg_rs_data - ID_EX_reg_rt_data;
                  EX_WB_reg_write <= 1;
                end
          LOAD : begin
                   EX_WB_alu_result <= data_mem[ID_EX_reg_rs_data]; //Assume rs holds memory address
                   EX_WB_reg_write <= 1;
                 end
          default : begin
                      EX_WB_alu_result <= 0;
                      EX_WB_reg_write <= 0;
                    end
        endcase
        EX_WB_rd <= ID_EX_rd;
      end
  end

//Write Back Stage
always@(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        //Do nothing
      end
    else
      begin
        if(EX_WB_reg_write)
          begin
            reg_file[EX_WB_rd] <= EX_WB_alu_result;
          end
      end
  end

endmodule