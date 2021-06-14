# starts sim and adds clock
startingLines = [
    'vsim -gui work.processor',
    'add wave -position insertpoint  \\',
    'sim:/processor/CLK',
    'force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200'
]
# mapping from instruction to op Code and ALU OPCode
opToOpCodeReset = {
            'RESET': '10111' 
            }

opToOpCodeBranch = {
    'JZ': '10000', 'JN': '10001', 
    'JC': '10010', 'JMP': '10011', 
    'RET': '01110','CALL': '01111',
}
opToOpCodeMemory = {
    'LDM': '11001', 'LDD': '11010', 
    'STD': '11011', 'PUSH': '01100', 
    'POP': '01101', 
}
opToOpCodeTwoOperand = {
    'AND': '00000', 'OR': '00001',
    'ADD': '00100', 'SUB': '00101', 
    'SHR': '00111', 'SHL': '01000',
    'MOV': '10100', 'IADD': '11000'
}

opToOpCodeOneOperand = {
    'NOT': '00010', 'DEC': '00011', 
    'INC': '00110', 'SETC': '01001', 
    'CLRC': '01010', 'NOP': '01011', 
    'OUT': '10101', 'IN': '10110'
}

opToAluOpCode = {
                'AND': '0000', 'OR': '0001',
                'NOT': '0010', 'DEC': '0011',
                'ADD': '0100', 'SUB': '0101',
                'INC': '0110', 'SHR': '0111',
                'SHL': '1000', 'SETC': '1111',
                'CLRC': '1111', 'NOP': '1111',
                'PUSH': '1111', 'POP': '1111',
                'RET': '1111', 'CALL': '1111',
                'JZ': '1111', 'JN': '1111',
                'JC': '1111', 'JMP': '1111',
                'MOV': '1001', 'OUT': '1111',
                'IN': '1111', 'RESET': '1111',
                'IADD': '0100', 'LDM': '1001',
                'LDD': '0100', 'STD': '0100'}

registerAddress = {
                'R0' : '000' ,
                'R1' : '001' ,
                'R2' : '010' ,
                'R3' : '011' ,
                'R4' : '100' ,
                'R5' : '101' ,
                'R6' : '110' ,
                'R7' : '111' 
                }
# file name
rootDir = 'arch-vonneumann-processor\\archAssembler\\'
fileName= 'memory'
# instructions in the end
instructions= []
instructionsOrder = []
currentMemoryIndex = None

# reading file
with open(rootDir + fileName+ '.asm', 'r') as f:
    lines = f.readlines()
    for line in lines:
        # removes spaces
        lineNoSpaces= ' '.join(line.split()).upper()
        # skips commented and empty lines
        if(lineNoSpaces.startswith('#') or lineNoSpaces == ''):
            continue
        # removes comments from line
        lineNoComments = lineNoSpaces[0: lineNoSpaces.find('#') - 1] if (lineNoSpaces.find('#') != -1) else lineNoSpaces
        # split line intro individual components
        # 'OUT R1' -> ['OUT' , 'R1']
        lineArray = lineNoComments.split(' ')
        # handles org instruction
        if(lineArray[0] == '.ORG'):
            currentMemoryIndex = int(lineArray[1],16)
            continue
        ## One operand instructions
        if (lineArray[0] in opToOpCodeOneOperand.keys()):
            # getting opcode and alu opcode
            opCodeTemp = opToOpCodeOneOperand[lineArray[0]]
            aluOpCodeTemp = opToAluOpCode[lineArray[0]]

            # check if instructions is something like SETC
            # i.e no register address
            if(len(lineArray) == 1):
                registerAddress1, registerAddress2 = '000', '000'
            else:
                # if not we get the address
                registerAddress1, registerAddress2 = registerAddress[lineArray[1]], registerAddress[lineArray[1]]
            # add instruction instruction list
            instructions.append(opCodeTemp + registerAddress1 + registerAddress2 + aluOpCodeTemp + '0')
        elif (lineArray[0] in opToOpCodeTwoOperand.keys()):
            # getting opcode and alu opcode
            opCodeTemp = opToOpCodeTwoOperand[lineArray[0]]
            aluOpCodeTemp = opToAluOpCode[lineArray[0]]
            # getting the two operands from instruction
            # getting address of first register
            operationOperands = lineArray[1].split(',')
            registerAddress1 = registerAddress[operationOperands[0]]
            # checks if the 2nd instruction has an immediate or not
            if ( operationOperands[1] in registerAddress.keys()):
                registerAddress2 = registerAddress[operationOperands[1]]
                immediateTemp = None
                instructions.append(opCodeTemp + registerAddress2 + registerAddress1 + aluOpCodeTemp + '0')
            else:
                immediateTemp = operationOperands[1]
                registerAddress2 = '000'
                instructions.append(opCodeTemp + registerAddress1 + registerAddress2 + aluOpCodeTemp + '0')
            # adds instruction 1 to instructions list
            
            # if there's an immediate add it to the list
            if (immediateTemp != None):
                instructions.append(bin(int('0x' + immediateTemp.lower(), 16)))
                instructionsOrder.append(currentMemoryIndex)
                currentMemoryIndex += 1
        elif (lineArray[0] in opToOpCodeMemory.keys()):
            # get alu op code and op code
            opCodeTemp = opToOpCodeMemory[lineArray[0]]
            aluOpCodeTemp = opToAluOpCode[lineArray[0]]
            operationOperands = lineArray[1].split(',')
            registerAddress1 = registerAddress[operationOperands[0]]
            if ( lineArray[0] in ['POP', 'PUSH'] ):
                instructions.append( opCodeTemp + registerAddress1 + '000' + aluOpCodeTemp + '0')
            elif ( lineArray[0] in ['STD' , 'LDD'] ):
                operandTwoComponents = operationOperands[1].split('(')
                immediateTemp = operandTwoComponents[0]
                registerAddress2 = registerAddress[operandTwoComponents[1][:-1]]
                # add instruction to instructions list
                instructions.append(opCodeTemp + registerAddress1 + registerAddress2 + aluOpCodeTemp + '0')
                # add immediate
                instructions.append(bin(int('0x' + immediateTemp.lower(), 16)))
                # add instruction order and increment
                instructionsOrder.append(currentMemoryIndex)
                currentMemoryIndex += 1
            elif ( lineArray[0] == 'LDM'):
                
                instructions.append( opCodeTemp + registerAddress1 + '000' + aluOpCodeTemp + '0')
                immediateTemp = operationOperands[1]
                # add immediate
                instructions.append(bin(int('0x' + immediateTemp.lower(), 16)))
                # add instruction order and increment
                instructionsOrder.append(currentMemoryIndex)
                currentMemoryIndex += 1




        else:
            # for the instruction after org
            instructions.append(bin(int('0x' + lineArray[0].lower(), 16)))

        instructionsOrder.append(currentMemoryIndex)
        # increment memroy address to write into after instruction
        if(currentMemoryIndex != None): currentMemoryIndex += 1
          
instructionsHex = [ hex(int(i,2)).upper()[2:] for i in instructions ]


with open(rootDir + fileName + '.do', 'w') as f:
    for line in startingLines:
        f.write(line)
        f.write('\n')
    
    for (instruction , instructionOrder) in zip(instructionsHex, instructionsOrder) :
        f.write('mem load -filltype value -filldata {} -fillradix hexadecimal /processor/instructionMemory/ram({})'.format(instruction, instructionOrder))
        f.write('\n')
