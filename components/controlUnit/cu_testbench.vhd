library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench ;

architecture arch of testbench is

    component controlUnit
    port(
        i_instruction : IN std_logic_vector(4 downto 0);
        o_outputControl : OUT std_logic_vector(16 downto 0)
    );
    end component;

    signal t_instruction : std_logic_vector( 4 downto 0);
    signal t_outputControl : std_logic_vector(16 downto 0);


begin
    

    process
    begin
        -- test conditional jumps
        t_instruction <=  "10000"; --zero
        wait for 50ps;
        ASSERT ( t_outputControl = "00010010100000110" )
        REPORT "JZ_Error"
        SEVERITY ERROR;
    
        t_instruction <=  "10001"; --negative
        wait for 50ps;
        ASSERT ( t_outputControl = "00010010010000110" )
        REPORT "JN_Error"
        SEVERITY ERROR;
        
        t_instruction <=  "10010"; --carry
        wait for 50ps;
        ASSERT ( t_outputControl = "00010010000000110" )
        REPORT "JC_Error"
        SEVERITY ERROR;

        -- test uncoditional jumps

        t_instruction <=  "10011"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00110000110000110" )
        REPORT "JMP_Error"
        SEVERITY ERROR;
    
        
        -- test ALU

        t_instruction <=  "00000"; -- AND
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "AND_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00001"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "or_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00010"; -- AND
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "NOT_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00011"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "DEC_Error"
        SEVERITY ERROR;

        
        t_instruction <=  "00100"; -- AND
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "ADD_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00101"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "SUB_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00110"; -- AND
        wait for 50ps;
        ASSERT ( t_outputControl = "00010001110000011" )
        REPORT "INC_Error"
        SEVERITY ERROR;
        
        
        t_instruction <=  "00111"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010101110000011" )
        REPORT "SHR_Error"
        SEVERITY ERROR;

        t_instruction <=  "01000"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010101110000011" )
        REPORT "SHL_Error"
        SEVERITY ERROR;

        -- OUT
        t_instruction <=  "10101"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00011000110000110" )
        REPORT "OUT_Error"
        SEVERITY ERROR;

        -- IN
        t_instruction <=  "10110"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00010000110000101" )
        REPORT "IN_Error"
        SEVERITY ERROR;

        -- CALL
        t_instruction <=  "01111"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "00000000110101000" )
        REPORT "CALL_Error"
        SEVERITY ERROR;

        -- SETC
        
        t_instruction <=  "01001"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "01010001110000000" )
        REPORT "SETC_Error"
        SEVERITY ERROR;

        
        t_instruction <=  "01010"; 
        wait for 50ps;
        ASSERT ( t_outputControl = "10010001110000000" )
        REPORT "CLRC_Error"
        SEVERITY ERROR;

        

    end process ; -- 
    
    u1: controlUnit port map(t_instruction, t_outputControl);



end arch ; -- arch