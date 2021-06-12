library ieee;
use ieee.std_logic_1164.all;



entity execMemory IS
	PORT(
        clk                 : IN STD_LOGIC ; 
		-- inputs to buffer
        i_aluData           : IN STD_LOGIC_VECTOR(31 downto 0) ;
		i_PC_plus_one       : IN STD_LOGIC_VECTOR(15 downto 0 ); -- maybe can be changed
        i_readData1         : IN STD_LOGIC_VECTOR(31 downto 0);
        i_controlSignals    : IN STD_LOGIC_VECTOR(7 downto 0);
        i_writeAddress      : IN STD_LOGIC_VECTOR(2 downto 0) ;
        
        -- outputs 
        o_aluData           : OUT STD_LOGIC_VECTOR(31 downto 0) ;
		o_PC_plus_one       : OUT STD_LOGIC_VECTOR(15 downto 0 ); -- maybe can be changed
        o_readData1         : OUT STD_LOGIC_VECTOR(31 downto 0);
        o_controlSignals    : OUT STD_LOGIC_VECTOR(7 downto 0);
        o_writeAddress      : OUT STD_LOGIC_VECTOR(2 downto 0) ;
		);
END execMemory;

Architecture a_execMemory OF execMemory IS
BEGIN
	process (clk)
	begin
        IF (rising_edge(clk) ) THEN
        o_aluData           <= i_aluData;
		o_PC_plus_one       <= i_PC_plus_one;
        o_readData1         <= i_readData1;
        o_controlSignals    <= i_controlSignals;
        o_writeAddress      <= i_writeAddress;
		END IF;
	end process;
end a_execMemory;


