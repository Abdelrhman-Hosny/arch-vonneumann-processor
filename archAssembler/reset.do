vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata 581E -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 581E -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata 581E -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata C912 -fillradix hexadecimal /processor/instructionMemory/ram(3)
mem load -filltype value -filldata 1 -fillradix hexadecimal /processor/instructionMemory/ram(4)
mem load -filltype value -filldata CA12 -fillradix hexadecimal /processor/instructionMemory/ram(5)
mem load -filltype value -filldata 2 -fillradix hexadecimal /processor/instructionMemory/ram(6)
mem load -filltype value -filldata CB12 -fillradix hexadecimal /processor/instructionMemory/ram(7)
mem load -filltype value -filldata 3 -fillradix hexadecimal /processor/instructionMemory/ram(8)
mem load -filltype value -filldata CC12 -fillradix hexadecimal /processor/instructionMemory/ram(9)
mem load -filltype value -filldata 4 -fillradix hexadecimal /processor/instructionMemory/ram(10)
mem load -filltype value -filldata CD12 -fillradix hexadecimal /processor/instructionMemory/ram(11)
mem load -filltype value -filldata 5 -fillradix hexadecimal /processor/instructionMemory/ram(12)
mem load -filltype value -filldata B81E -fillradix hexadecimal /processor/instructionMemory/ram(13)
