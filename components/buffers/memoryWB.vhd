library ieee;
use ieee.std_logic_1164.all;



entity memoryWB IS
	PORT(
        clk                 : IN STD_LOGIC ;
        i_isFlush           : IN STD_LOGIC ;
		-- inputs to buffer
        i_aluData           : IN STD_LOGIC_VECTOR(31 downto 0) ;
		i_memoryData        : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
        i_controlSignals    : IN STD_LOGIC_VECTOR(2 downto 0);
        i_writeAddress      : IN STD_LOGIC_VECTOR(2 downto 0) ;
        
        -- outputs 
        o_aluData           : OUT STD_LOGIC_VECTOR(31 downto 0) ;
		o_memoryData        : OUT STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
        o_controlSignals    : OUT STD_LOGIC_VECTOR(2 downto 0);
        o_writeAddress      : OUT STD_LOGIC_VECTOR(2 downto 0) 
        
		);
END memoryWB;

Architecture a_memoryWB OF memoryWB IS
BEGIN
	process (clk,i_isFlush)
	begin
        IF i_isFlush='1' and rising_edge(clk) THEN
        o_controlSignals<= "000" ;
        ELSIF (rising_edge(clk) ) THEN
        o_aluData           <= i_aluData;
		o_memoryData        <= i_memoryData;
        o_controlSignals    <= i_controlSignals;
        o_writeAddress      <= i_writeAddress;
		END IF;
	end process;
end a_memoryWB;


