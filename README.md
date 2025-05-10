# PIPELINE-PROCESSOR-DESIGN

*COMPANY*: CODTECH IT SOLUTIONS

*NAME*: PALREDDY JWALITHA REDDY

*INTERN ID*: CT4MKLN

*DOMAIN*: VLSI

*DURATION*: 16 WEEKS

*MENTOR*: NEELA SANTHOSH

*DESCRIPTION*: The 4-stage pipelined processor here is a simple, educational design aimed at demonstrating the basic concepts of instruction pipelining in a CPU. It supports three primary instructions ADD, SUB, and LOAD, which are sufficient to illustrate data processing and memory access operations. The pipeline is divided into four sequrntial stages Instruction Fetch (IF), Instruction Decode (ID) , Execute (EX), and write Back or store (WB). Each stage processes one part of an instruction per clock cycle, allowing multiple instructions to be in different stages simultaneously, thus increasing throughput.
In the Instruction Fetch (IF) stage, the processor retrieves the next instruction from the instruction memory using the program counter (PC). The instruction is then passed to the next stage through a pipeline register. The PC is incremented to point to the next instruction, allowing the pipeline to continue smoothly.
Im the Instruction Decode (ID) stage, the fetched instruction is decoded to extract the opcode and operand register addresses. This stage also reads the values of the source registers from the register file. The decoded information, along with the operand values, is passed to the next stage through another set of pipeline registers.
The Execute (EX) stage performs the actual operation specified by the instruction. For ADD and SUB, the arithmetic logic unit (ALU) adds or subtracts the source register values. For the LOAD instruction, the data memory is accessed using the address contained in one of the source registers, simulating a read operation. The result of the execution and the destination register address are stored in pipeline registers for the final stage.
The Write Back or Store (WB) stage completes the insruction execution by writing the result of the EX stage into the destination register in the register file. Only if the instruction is an arithmetic or load operation does this stage modify the register file otherwise, it does nothing.
Overall, this process provides a foundational understanding of how pipelining works in modern CPUs. It illustrates how instructions are divided across multiple stages and how pipelining increases instructions throughput by overlapping operations.
