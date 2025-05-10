module pipeline_4_stage_tb;

reg clk;
reg reset;

//Instantiate the CPU
pipeline_4_stage cpu(.clk(clk), .reset(reset));

//Clock generation
intial
  begin
    clk = 0;
    forever #5 clk = ~clk; //10ns clock period
  end

//Test sequence
intial
  begin
    //Initialize data and register memory manually
      reset = 1;
      #10;
      reset = 0;
    
    //Initialize instruction memory manually
    //ADD R3 = R1 + R2  
    cpu.instr_mem[0] = {2'b00, 3'd1, 3'd2, 3'd3, 5'd0};
    //SUB R4 = R3 - R1
    cpu.instr_mem[1] = {2'b01, 3'd3, 3'd1, 3'd4, 5'd0};
    //LOAD R6 = MEM[R5]
    cpu.instr_mem[2] = {2'b10, 3'd5, 3'd0, 3'd6, 5'd0};

    //Initialize registers
    cpu.reg_file[1] = 8'd10;
    cpu.reg_file[2] = 8'd5;
    cpu.reg_file[5] = 8'd3; //Address to load from
    cpu.data_mem[3] = 8'd99; //Value in memory

    //Run simulation for some cycles
    #100;

    //Display result
    $display("R3(should be 15) = %d", cpu.reg_file[3]);
    $display("R4(should be 5) = %d", cpu.reg_file[4]);
    $display("R6(should be 99) = %d", cpu.reg_file[6]);

    //Optionally print all registers
    $display("----Register File----");
    for(int i=0; i<8; i=i+1)
    $display("R%d = %d", i, cpu.reg_file[i]);
    $finish;
  end

endmodule