library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

-- i removed read enable since in our refisterfile we dont have read enable
entity My_3x8Decoder IS
	PORT( i_address : IN STD_LOGIC_VECTOR(2 downto 0 ) ;
		  o_decoded: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
END My_3x8Decoder;

Architecture a_My_3x8Decoder OF My_3x8Decoder IS

BEGIN
	process (i_address)
        variable output_temp : STD_LOGIC_VECTOR(7 downto 0) ;
        begin
        -- must put all at first = 0 
        -- if we dont make it it will overwrite the old value without changing it
        -- so if first decode 1 and second decode 2 --> both will be 1 (000000110)
        output_temp:= (others=>'0');
        -- we change the address to integer to be used as index
        output_temp(to_integer(unsigned(i_address))):= '1';
        o_decoded <= output_temp ;
	end process;
    
    
end a_My_3x8Decoder;
