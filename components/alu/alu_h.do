vsim -gui work.alu(arch)
# vsim -gui work.alu(arch) 
# Start time: 13:58:10 on Jun 11,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.alu(arch)
add wave -position insertpoint  \
sim:/alu/i_operand1 \
sim:/alu/i_operand2 \
sim:/alu/o_output \
sim:/alu/i_opCode \
sim:/alu/i_Cin \
sim:/alu/o_Cout \
sim:/alu/i_shiftAmount

force -freeze sim:/alu/i_shiftAmount 10'd3 0
force -freeze sim:/alu/i_operand1 16'h0FF0 0
force -freeze sim:/alu/i_opCode 1000 0
run
force -freeze sim:/alu/i_operand1 16'h0FF00000 0
force -freeze sim:/alu/i_shiftAmount 00100 0
run
force -freeze sim:/alu/i_opCode 0111 0
run
force -freeze sim:/alu/i_shiftAmount 11111 0
run
force -freeze sim:/alu/i_opCode 1000 0
run
