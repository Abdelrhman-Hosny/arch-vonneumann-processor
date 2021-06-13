vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 100 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata 481E -fillradix hexadecimal /processor/instructionMemory/ram(16)
mem load -filltype value -filldata 581E -fillradix hexadecimal /processor/instructionMemory/ram(17)
mem load -filltype value -filldata 501E -fillradix hexadecimal /processor/instructionMemory/ram(18)
mem load -filltype value -filldata 1124 -fillradix hexadecimal /processor/instructionMemory/ram(19)
mem load -filltype value -filldata 312C -fillradix hexadecimal /processor/instructionMemory/ram(20)
mem load -filltype value -filldata B13E -fillradix hexadecimal /processor/instructionMemory/ram(21)
mem load -filltype value -filldata B25E -fillradix hexadecimal /processor/instructionMemory/ram(22)
mem load -filltype value -filldata 1244 -fillradix hexadecimal /processor/instructionMemory/ram(23)
mem load -filltype value -filldata 312C -fillradix hexadecimal /processor/instructionMemory/ram(24)
mem load -filltype value -filldata 1A46 -fillradix hexadecimal /processor/instructionMemory/ram(25)
mem load -filltype value -filldata A93E -fillradix hexadecimal /processor/instructionMemory/ram(26)
mem load -filltype value -filldata AA5E -fillradix hexadecimal /processor/instructionMemory/ram(27)
