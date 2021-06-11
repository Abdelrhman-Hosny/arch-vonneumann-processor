vsim -gui work.datamemory
# vsim -gui work.datamemory 
# Start time: 00:46:40 on Jun 12,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.datamemory(datamemory_a)
add wave -position insertpoint  \
sim:/datamemory/CLK \
sim:/datamemory/i_writeEnable \
sim:/datamemory/i_readEnable \
sim:/datamemory/i_address \
sim:/datamemory/i_writeData \
sim:/datamemory/o_dataout \
sim:/datamemory/dataMemory
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESC  Hostname: dell-PC  ProcessID: 1880
#           Attempting to use alternate WLF file "./wlftyqj77a".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftyqj77a
force -freeze sim:/datamemory/CLK 1 0, 0 {50 ps} -r 100
mem load -skip {} -filltype inc -filldata 0 -fillradix hexadecimal -startaddress 0 -endaddress 1024 /datamemory/dataMemory
force -freeze sim:/datamemory/i_readEnable 0 0
force -freeze sim:/datamemory/i_address 0 0
force -freeze sim:/datamemory/i_readEnable 1 0
run
run
force -freeze sim:/datamemory/i_address 1 0
run
force -freeze sim:/datamemory/i_address A 0
run
run
force -freeze sim:/datamemory/i_writeEnable 1 0
force -freeze sim:/datamemory/i_readEnable 0 0
force -freeze sim:/datamemory/i_address 0 0
force -freeze sim:/datamemory/i_writeData 00001111 0
run
force -freeze sim:/datamemory/i_writeEnable 0 0
force -freeze sim:/datamemory/i_readEnable 1 0
force -freeze sim:/datamemory/i_address 2 0
run
force -freeze sim:/datamemory/i_address 0 0
run
force -freeze sim:/datamemory/i_address 1 0
run

