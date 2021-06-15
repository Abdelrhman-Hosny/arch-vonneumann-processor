vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata C912 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata 991E -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata CA12 -fillradix hexadecimal /processor/instructionMemory/ram(3)
mem load -filltype value -filldata 15 -fillradix hexadecimal /processor/instructionMemory/ram(4)
mem load -filltype value -filldata CB12 -fillradix hexadecimal /processor/instructionMemory/ram(5)
mem load -filltype value -filldata 15 -fillradix hexadecimal /processor/instructionMemory/ram(6)
mem load -filltype value -filldata CC12 -fillradix hexadecimal /processor/instructionMemory/ram(7)
mem load -filltype value -filldata 15 -fillradix hexadecimal /processor/instructionMemory/ram(8)
