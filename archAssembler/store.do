vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
mem load -filltype value -filldata D9A8 -fillradix hexadecimal /processor/instructionMemory/ram(0)
mem load -filltype value -filldata 200 -fillradix hexadecimal /processor/instructionMemory/ram(1)
