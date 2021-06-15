vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata 611E -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 621E -fillradix hexadecimal /processor/instructionMemory/ram(1)
mem load -filltype value -filldata 691E -fillradix hexadecimal /processor/instructionMemory/ram(2)
mem load -filltype value -filldata 6A1E -fillradix hexadecimal /processor/instructionMemory/ram(3)
