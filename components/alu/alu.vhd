library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity ALU is
  port (
    i_operand1    : IN STD_LOGIC_VECTOR (31 downto 0);
    i_operand2    : IN STD_LOGIC_VECTOR (31 downto 0);
    o_output      : OUT STD_LOGIC_VECTOR (31 downto 0);
    i_opCode      : IN STD_LOGIC_VECTOR(3 downto 0);
    o_Cout          : OUT STD_LOGIC;
    i_shiftAmount : IN STD_LOGIC_VECTOR (4 downto 0)
  );
end ALU ;

architecture arch of  ALU is

Signal s_tempOutput : STD_LOGIC_VECTOR (32 downto 0);
Signal s_input1 : STD_LOGIC_VECTOR (32 downto 0);
Signal s_input2 : STD_LOGIC_VECTOR (32 downto 0);

begin
  s_input1 <= '0'& i_operand1 ;
  s_input2 <= '0'& i_operand2 ;
  
  s_tempOutput <= s_input1 AND s_input2 when i_opCode="0000" else
              s_input1 OR s_input2 when i_opCode="0001" else
              NOT s_input1 when i_opCode="0010" else
              -- DEC
<<<<<<< HEAD
              std_logic_vector(
                to_signed(
                  to_integer( unsigned( i_operand1 )) - 1
                  , 33)) when i_opCode="0011" else
              -- ADD
              std_logic_vector(
                to_signed(
                  to_integer( unsigned( s_input1 ))
                 +
                  to_integer( unsigned( s_input2 ))
                  , 33))   when i_opCode="0100" else
              -- SUB
              std_logic_vector(
                to_signed(
                  to_integer( unsigned( s_input1 ))
                 -
                  to_integer( unsigned( s_input2 ))
                  , 33))   when i_opCode="0101" else
              -- INC 
              std_logic_vector(
                to_signed(
                  to_integer( unsigned( i_operand1 )) + 1
                  , 33)) when i_opCode="0110" else
=======
              std_logic_vector(to_signed(to_integer(unsigned(s_input1)) -1 ,33) ) when i_opCode="0011" else
              -- ADD
              std_logic_vector (to_signed(
                to_integer(unsigned(s_input1)) + to_integer(unsigned(s_input2))
              ,33))   when i_opCode="0100" else
              -- SUB
              std_logic_vector (to_signed(
                to_integer(unsigned(s_input1)) - to_integer(unsigned(s_input2))
              ,33))   when i_opCode="0101" else
              -- INC 
              std_logic_vector(to_signed(to_integer(unsigned(s_input1)) +1 ,33) ) when i_opCode="0110" else
>>>>>>> 22a81336c858ba49b9ad44e0f9a9c640210826e4
              --SHR 
              '0' & std_logic_vector(
                shift_right(unsigned(i_operand1), to_integer(unsigned(i_shiftAmount)))
                ) when i_opCode="0111" else
              --SHL
              '0' & std_logic_vector(
                shift_left(unsigned(i_operand1), to_integer(unsigned(i_shiftAmount)))
                ) when i_opCode="1000" ; 

 

o_Cout <= s_tempOutput(32) when i_opCode="0100" or i_opCode="0100" else -- ADD/SUB
          i_operand1(0)    when i_opCode="0111" else -- SHR
          i_operand1(31)    when i_opCode="1000" ;  -- SHL
          

o_output <= s_tempOutput(31 downto 0); 


end architecture ; -- arch