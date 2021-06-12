library ieee;
use ieee.std_logic_1164.all;



entity decodeExecBuffer IS
	PORT(
        clk                 : IN STD_LOGIC ; 
		-- inputs to buffer
        i_readData1, i_readData2 : IN std_logic_vector( 31 downto 0);
        i_readData1Address, i_readData2Address : IN std_logic_vector(2 downto 0);
        i_writeAddress1 : IN std_logic_vector( 2 downto 0);
        i_PCNext : IN std_logic_vector(15 downto 0 );
        i_cuSignals : IN std_logic_vector(20 downto 0);
        i_immediate : IN std_logic_vector(31 downto 0);
        -- output to buffer
        o_readData1         , o_readData2 : OUT std_logic_vector( 31 downto 0);
        o_readData1Address, o_readData2Address : OUT std_logic_vector(2 downto 0);
        o_writeAddress1          : OUT std_logic_vector( 2 downto 0);
        o_PCNext                 : OUT std_logic_vector(15 downto 0 );
        o_cuSignals              : OUT std_logic_vector(20 downto 0);
        o_immediate              : OUT std_logic_vector(31 downto 0)
		);
END decodeExecBuffer;

Architecture a_decodeExecBuffer OF decodeExecBuffer IS
BEGIN
	process (clk)
	begin
        IF (rising_edge(clk) ) THEN
        o_readData1             <= i_readData1     ;   
        o_readData1Address<= i_readData1Address;
        o_writeAddress1   <= i_writeAddress1   ;
        o_PCNext          <= i_PCNext          ;
        o_cuSignals       <= i_cuSignals       ;
        o_immediate       <= i_immediate   ;
        o_readData2 <= i_readData2    ;
        o_readData2Address <= i_readData2Address;
		END IF;
	end process;
end a_decodeExecBuffer;


