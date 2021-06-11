vsim -gui work.controlunit(arch)
# End time: 17:54:33 on Jun 11,2021, Elapsed time: 3:49:55
# Errors: 0, Warnings: 10
# vsim -gui work.controlunit(arch) 
# Start time: 17:54:33 on Jun 11,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.controlunit(arch)
add wave -position insertpoint  \
sim:/controlunit/i_instruction \
sim:/controlunit/o_outputControl \
sim:/controlunit/s_wbEnable \
sim:/controlunit/s_wbSelector \
sim:/controlunit/s_SPEnable \
sim:/controlunit/s_addSubSP \
sim:/controlunit/s_memRead \
sim:/controlunit/s_memWrite \
sim:/controlunit/s_ccrEnable \
sim:/controlunit/s_immRegSelector \
sim:/controlunit/s_condJumpEnable \
sim:/controlunit/s_flagJumpSelector
force -freeze sim:/controlunit/i_instruction 00000 0
run