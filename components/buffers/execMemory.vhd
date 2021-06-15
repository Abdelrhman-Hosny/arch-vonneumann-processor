library ieee;
use ieee.std_logic_1164.all;



entity execMemory IS
    port(
        clk                 : IN STD_LOGIC ; 
        i_isFlush           : IN STD_LOGIC ; 
        i_isJump              :IN  STD_LOGIC ; 
            -- inputs to buffer
            i_aluData           : IN STD_LOGIC_VECTOR(31 downto 0) ;
                i_PC_plus_one       : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
            i_readData1         : IN STD_LOGIC_VECTOR(31 downto 0);
            i_controlSignals    : IN STD_LOGIC_VECTOR(7 downto 0);
            i_writeAddress      : IN STD_LOGIC_VECTOR(2 downto 0) ;
            
            -- outputs 
            o_aluData           : OUT STD_LOGIC_VECTOR(31 downto 0) ;
                o_PC_plus_one       : OUT STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
            o_readData1         : OUT STD_LOGIC_VECTOR(31 downto 0);
            o_controlSignals    : OUT STD_LOGIC_VECTOR(7 downto 0);
            o_writeAddress      : OUT STD_LOGIC_VECTOR(2 downto 0);
            o_isJump            : OUT  STD_LOGIC 
    );
END execMemory;

Architecture a_execMemory OF execMemory IS
BEGIN
	process (clk,i_isFlush)
	begin
        IF i_isFlush='1' and falling_edge(clk) THEN
        o_controlSignals    <= "10000000";
        ELSIF (rising_edge(clk) ) THEN
        o_aluData           <= i_aluData;
		o_PC_plus_one       <= i_PC_plus_one;
        o_readData1         <= i_readData1;
        o_controlSignals    <= i_controlSignals;
        o_writeAddress      <= i_writeAddress;
        o_isJump            <= i_isJump ;
		END IF;
	end process;
end a_execMemory;


