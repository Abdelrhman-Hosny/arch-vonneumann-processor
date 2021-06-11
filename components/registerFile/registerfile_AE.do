vsim -gui work.registerfile
# vsim -gui work.registerfile 
# Start time: 21:06:11 on Jun 11,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.registerfile(arch)
# Loading work.my_3x8decoder(a_my_3x8decoder)
# Loading work.my_ndff_regfile(a_nmy_dff)
# Loading work.mux8x1registerfile(arch)
add wave -position insertpoint  \
sim:/registerfile/CLK \
sim:/registerfile/RST \
sim:/registerfile/write_enable \
sim:/registerfile/read_register1_address \
sim:/registerfile/read_register2_address \
sim:/registerfile/register1_data \
sim:/registerfile/register2_data \
sim:/registerfile/write_address \
sim:/registerfile/write_register \
sim:/registerfile/write_address_decoded \
sim:/registerfile/R0_OUT \
sim:/registerfile/R1_OUT \
sim:/registerfile/R2_OUT \
sim:/registerfile/R3_OUT \
sim:/registerfile/R4_OUT \
sim:/registerfile/R5_OUT \
sim:/registerfile/R6_OUT \
sim:/registerfile/R7_OUT \
sim:/registerfile/read_output1 \
sim:/registerfile/read_output2
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESC  Hostname: dell-PC  ProcessID: 1880
#           Attempting to use alternate WLF file "./wlft7wgax1".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft7wgax1
force -freeze sim:/registerfile/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/write_enable 1 0
force -freeze sim:/registerfile/write_address 0 0
force -freeze sim:/registerfile/write_register 10101010 0
run
run
force -freeze sim:/registerfile/write_enable 0 0
force -freeze sim:/registerfile/read_register1_address 0 0
run
run
force -freeze sim:/registerfile/read_register2_address 0 0
run
run
run
run
force -freeze sim:/registerfile/write_enable 1 0
force -freeze sim:/registerfile/write_address 1 0
force -freeze sim:/registerfile/write_register 000 0
run
force -freeze sim:/registerfile/write_address 2 0
force -freeze sim:/registerfile/write_register 10 0
run
force -freeze sim:/registerfile/write_enable 0 0
force -freeze sim:/registerfile/read_register1_address 0 0
run
force -freeze sim:/registerfile/read_register1_address 1 0
run
force -freeze sim:/registerfile/read_register2_address 2 0
run
run
force -freeze sim:/registerfile/read_register2_address 0 0
run
run
run
run
force -freeze sim:/registerfile/write_enable 1 0
force -freeze sim:/registerfile/write_address 7 0
force -freeze sim:/registerfile/write_register 11111111 0
run
force -freeze sim:/registerfile/write_enable 0 0
force -freeze sim:/registerfile/read_register1_address 7 0
run
run
force -freeze sim:/registerfile/read_register2_address 1 0
run
force -freeze sim:/registerfile/read_register2_address 5 0
run