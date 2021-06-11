vsim -gui work.ram
# vsim -gui work.ram 
# Start time: 17:48:23 on Jun 11,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.ram(sync_ram_a)
mem load -skip 0 -filltype inc -filldata 0 -fillradix symbolic -startaddress 0 -endaddress 1000 /ram/ram
add wave -position insertpoint  \
sim:/ram/address \
sim:/ram/dataout \
sim:/ram/ram
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESC  Hostname: dell-PC  ProcessID: 1880
#           Attempting to use alternate WLF file "./wlftadhdxt".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftadhdxt
force -freeze sim:/ram/address 0 0
run
force -freeze sim:/ram/address 1 0
run
force -freeze sim:/ram/address 50 0
run
force -freeze sim:/ram/address 3d1 0
run
quit -sim