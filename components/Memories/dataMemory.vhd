LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

-- LITTLE_ENDIAN dataMemory
ENTITY dataMemory IS
PORT (
		CLK             : IN std_logic;
        i_writeEnable   : IN std_logic;
        i_readEnable    : IN std_logic;
        i_address       : IN std_logic_vector(31 DOWNTO 0); -- depends onsize of memory 
        i_writeData     : IN std_logic_vector(31 DOWNTO 0); -- same size as Register
		o_dataout       : OUT std_logic_vector(31 DOWNTO 0) -- same size as Register
	  );
END ENTITY dataMemory;

ARCHITECTURE dataMemory_a OF dataMemory IS 
-- SIZE WILL BE RELATIVE TO PC (NOW 16 BITS)
--1/2 * 2^16 = 32768
-- 1024 as program crash
	TYPE dataMemory_type IS ARRAY(0 TO 1048575) of std_logic_vector(15 DOWNTO 0); -- DataMemory is 16 bits
	SIGNAL dataMemory : dataMemory_type ;
BEGIN
    
    process( CLK,i_address,i_writeEnable,i_writeData )
    begin
        if falling_edge(CLK) and i_writeEnable ='1' then
            dataMemory(to_integer(unsigned((i_address)))) <= i_writeData(15 downto 0);
            dataMemory(to_integer(unsigned((i_address)))+1) <= i_writeData(31 downto 16);
        elsif i_readEnable='1' then -- since we read async 
        o_dataout(15 downto 0) <= dataMemory(to_integer(unsigned((i_address))));
        o_dataout(31 downto 16) <= dataMemory(to_integer(unsigned((i_address)))+1 );
        end if;
    end process ;

END dataMemory_a;
