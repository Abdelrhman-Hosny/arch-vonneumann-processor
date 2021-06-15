library ieee;
use ieee.std_logic_1164.all;



entity fetchDecode IS
	PORT(
        clk           : IN STD_LOGIC ; 
		-- inputs to buffer
        i_Instruction : IN STD_LOGIC_VECTOR(15 downto 0) ;
		i_immediate   : IN STD_LOGIC_VECTOR(15 downto 0);
        i_PC_plus_one : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
        i_enable      : IN STD_LOGIC ;
        i_F_Flush     : IN STD_LOGIC ;
        
        -- outputs 
        o_Instruction : OUT STD_LOGIC_VECTOR(15 downto 0) ;
		o_immediate   : OUT STD_LOGIC_VECTOR(15 downto 0);
        o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 downto 0 ) -- maybe can be changed
		);
END fetchDecode;

Architecture a_fetchDecode OF fetchDecode IS
BEGIN
	process (clk,i_F_Flush,i_enable)
	begin
        IF (i_F_Flush = '1' and falling_edge(clk) ) THEN -- flushing asyncronous ! 
            o_Instruction(15 downto 11)<= "01011" ;
            o_immediate<= (others=>'0');
            o_PC_plus_one<= (others=>'0');
		ELSIF (rising_edge(clk) and i_enable='1') THEN
            -- since when i_enable ='0'-> we need to stall (come from Hazard det) 
            o_Instruction<= i_Instruction;
            o_immediate<= i_immediate;
            o_PC_plus_one<= i_PC_plus_one;
		END IF;
	end process;
end a_fetchDecode;


