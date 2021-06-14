vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata 10 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 100 -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata B25E -fillradix hexadecimal /processor/instructionMemory/ram(16)
mem load -filltype value -filldata B37E -fillradix hexadecimal /processor/instructionMemory/ram(17)
mem load -filltype value -filldata B49E -fillradix hexadecimal /processor/instructionMemory/ram(18)
mem load -filltype value -filldata C912 -fillradix hexadecimal /processor/instructionMemory/ram(19)
mem load -filltype value -filldata 5 -fillradix hexadecimal /processor/instructionMemory/ram(20)
mem load -filltype value -filldata 611E -fillradix hexadecimal /processor/instructionMemory/ram(21)
mem load -filltype value -filldata 621E -fillradix hexadecimal /processor/instructionMemory/ram(22)
mem load -filltype value -filldata 691E -fillradix hexadecimal /processor/instructionMemory/ram(23)
mem load -filltype value -filldata 6A1E -fillradix hexadecimal /processor/instructionMemory/ram(24)
mem load -filltype value -filldata B5BE -fillradix hexadecimal /processor/instructionMemory/ram(25)
mem load -filltype value -filldata DAA8 -fillradix hexadecimal /processor/instructionMemory/ram(26)
mem load -filltype value -filldata 200 -fillradix hexadecimal /processor/instructionMemory/ram(27)
mem load -filltype value -filldata D9A8 -fillradix hexadecimal /processor/instructionMemory/ram(28)
mem load -filltype value -filldata 202 -fillradix hexadecimal /processor/instructionMemory/ram(29)
mem load -filltype value -filldata D3A8 -fillradix hexadecimal /processor/instructionMemory/ram(30)
mem load -filltype value -filldata 202 -fillradix hexadecimal /processor/instructionMemory/ram(31)
mem load -filltype value -filldata D4A8 -fillradix hexadecimal /processor/instructionMemory/ram(32)
mem load -filltype value -filldata 200 -fillradix hexadecimal /processor/instructionMemory/ram(33)
