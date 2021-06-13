vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 100 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata B13E -fillradix hexadecimal /processor/instructionMemory/ram(16)
mem load -filltype value -filldata B25E -fillradix hexadecimal /processor/instructionMemory/ram(17)
mem load -filltype value -filldata B37E -fillradix hexadecimal /processor/instructionMemory/ram(18)
mem load -filltype value -filldata B49E -fillradix hexadecimal /processor/instructionMemory/ram(19)
mem load -filltype value -filldata A572 -fillradix hexadecimal /processor/instructionMemory/ram(20)
mem load -filltype value -filldata 2428 -fillradix hexadecimal /processor/instructionMemory/ram(21)
mem load -filltype value -filldata 2CAA -fillradix hexadecimal /processor/instructionMemory/ram(22)
mem load -filltype value -filldata 4C0 -fillradix hexadecimal /processor/instructionMemory/ram(23)
mem load -filltype value -filldata 942 -fillradix hexadecimal /processor/instructionMemory/ram(24)
mem load -filltype value -filldata 4210 -fillradix hexadecimal /processor/instructionMemory/ram(25)
mem load -filltype value -filldata 2 -fillradix hexadecimal /processor/instructionMemory/ram(26)
mem load -filltype value -filldata 3A0E -fillradix hexadecimal /processor/instructionMemory/ram(27)
mem load -filltype value -filldata 3 -fillradix hexadecimal /processor/instructionMemory/ram(28)
mem load -filltype value -filldata C208 -fillradix hexadecimal /processor/instructionMemory/ram(29)
mem load -filltype value -filldata FFFF -fillradix hexadecimal /processor/instructionMemory/ram(30)
mem load -filltype value -filldata 2228 -fillradix hexadecimal /processor/instructionMemory/ram(31)
