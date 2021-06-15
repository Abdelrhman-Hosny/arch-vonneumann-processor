vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata CD12 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 0 -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata D2A8 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata 0 -fillradix hexadecimal /processor/instructionMemory/ram(3)
mem load -filltype value -filldata 2248 -fillradix hexadecimal /processor/instructionMemory/ram(4)
