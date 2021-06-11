library ieee;
use ieee.std_logic_1164.all;


entity My_N_TRISTATE IS
	Generic (n: integer );
	PORT(
		i_data	: IN STD_LOGIC_VECTOR(n-1 downto 0);
	    o_data: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		i_enable  : IN STD_LOGIC
	);
END My_N_TRISTATE;

Architecture a_My_N_TRISTATE OF My_N_TRISTATE IS
BEGIN

o_data <= i_data when i_enable='1' ELSE
			(others=>'Z');

end a_My_N_TRISTATE;

