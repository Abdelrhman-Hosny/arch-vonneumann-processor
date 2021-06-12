vsim -gui work.processor
# vsim -gui work.processor 
# Start time: 14:40:16 on Jun 12,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.processor(arch)
# Loading work.adder(arch)
# Loading work.mux4x1(arch)
# Loading work.my_ndff_pc(a_nmy_dff)
# Loading work.ram(sync_ram_a)
# Loading work.fetchdecode(a_fetchdecode)
# Loading work.registerfile(arch)
# Loading work.my_3x8decoder(a_my_3x8decoder)
# Loading work.my_ndff_regfile(a_nmy_dff)
# Loading work.mux8x1registerfile(arch)
# Loading work.controlunit(arch)
# Loading work.mux2x1(arch)
# Loading work.alu(arch)
add wave -position insertpoint  \
sim:/processor/CLK \
sim:/processor/bo_fd_instruction \
sim:/processor/bo_fd_immediate \
sim:/processor/bo_fd_PC_plus_one \
sim:/processor/valPC \
sim:/processor/PC_plus_one \
sim:/processor/pcSelector \
sim:/processor/memory \
sim:/processor/condJumpAddress \
sim:/processor/uncondJumpAddress \
sim:/processor/MuxPCOutput \
sim:/processor/PC \
sim:/processor/Instruction \
sim:/processor/Immediate \
sim:/processor/extendedImmediate \
sim:/processor/readData1 \
sim:/processor/readData2 \
sim:/processor/s_outputControl \
sim:/processor/s_aluOutput \
sim:/processor/s_aluCout \
sim:/processor/aluOperand1 \
sim:/processor/aluOperand2 \
sim:/processor/aluOperand2TempHolder \
sim:/processor/valSP \
sim:/processor/SP_plus_one \
sim:/processor/SP \
sim:/processor/wbData
force -freeze sim:/processor/CLK 1 0, 0 {250 ps} -r 500
mem load -filltype value -filldata 4009 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 07E1 -fillradix hexadecimal /processor/instructionMemory/ram(1)
add wave -position insertpoint  \
sim:/processor/registerFileLabel/R0_OUT
add wave -position insertpoint  \
sim:/processor/registerFileLabel/R1_OUT
mem load -filltype value -filldata 0101 -fillradix hexadecimal /processor/instructionMemory/ram(2)
force -freeze sim:/processor/registerFileLabel/R0_OUT 16'h11110000 0
force -freeze sim:/processor/registerFileLabel/R1_OUT 01010101 0