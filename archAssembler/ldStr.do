vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata C912 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata CD12 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata 15 -fillradix hexadecimal /processor/instructionMemory/ram(3)
mem load -filltype value -filldata D9A8 -fillradix hexadecimal /processor/instructionMemory/ram(4)
mem load -filltype value -filldata 200 -fillradix hexadecimal /processor/instructionMemory/ram(5)
mem load -filltype value -filldata D2A8 -fillradix hexadecimal /processor/instructionMemory/ram(6)
mem load -filltype value -filldata 200 -fillradix hexadecimal /processor/instructionMemory/ram(7)
