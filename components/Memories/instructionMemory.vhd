LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
PORT (  -- i removed clk since async read
        -- removed we and writing part since its read only (InstructionMemory)
		-- assuming pc is 16 bit 
		-- maybe will be changed later
		i_address : IN std_logic_vector(15 DOWNTO 0); -- same size as PC
		o_dataout : OUT std_logic_vector(15 DOWNTO 0);
		o_immediate : OUT std_logic_vector(15 DOWNTO 0)
	  );
END ENTITY ram;

ARCHITECTURE sync_ram_a OF ram IS 
-- SIZE WILL BE RELATIVE TO PC (NOW 16 BITS)
-- 1/2 * 2^16 = 32768
-- 1000 as program crash
	TYPE ram_type IS ARRAY(0 TO 1048575) of std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
BEGIN
	o_dataout <= ram(to_integer(unsigned((i_address))));
	o_immediate <= ram(to_integer(unsigned((i_address)))+1);
END sync_ram_a;
