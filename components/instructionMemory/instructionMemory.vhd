LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
PORT (  -- i removed clk since async read
        -- removed we and writing part since its read only (InstructionMemory)
		-- assuming 2^20 locations therefore 20 bits address
		-- will change later
		address : IN std_logic_vector(19 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0) 
	  );
END ENTITY ram;

ARCHITECTURE sync_ram_a OF ram IS 
-- in harvard the full memory containing instr and data is 1MB
-- since we switched to Von-Nueman --> we will make each of them 0.5MB	
--1/2 MB = 1/2 * 2^20 * 8 = 4194304 locations
-- 1000 as program crash
	TYPE ram_type IS ARRAY(0 TO 1000) of std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
BEGIN
	dataout <= ram(to_integer(unsigned((address))));
END sync_ram_a;
