vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
add wave -position end  sim:/processor/registerFileLabel/R1_OUT
add wave -position end  sim:/processor/registerFileLabel/R2_OUT
add wave -position end sim:/processor/datamemory0/*
add wave -position end sim:/processor/buffer_memWB/*
add wave -position end  sim:/processor/wbData
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata C912 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 50 -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata CA12 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(3)
mem load -filltype value -filldata 581E -fillradix hexadecimal /processor/instructionMemory/ram(4)
mem load -filltype value -filldata 611E -fillradix hexadecimal /processor/instructionMemory/ram(5)
mem load -filltype value -filldata 621E -fillradix hexadecimal /processor/instructionMemory/ram(6)
mem load -filltype value -filldata 691E -fillradix hexadecimal /processor/instructionMemory/ram(7)
mem load -filltype value -filldata 6A1E -fillradix hexadecimal /processor/instructionMemory/ram(8)
