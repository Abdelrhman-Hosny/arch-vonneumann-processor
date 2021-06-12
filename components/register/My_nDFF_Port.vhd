library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_Port IS
	Generic (n: integer :=16);
	PORT(
	                RST : IN STD_LOGIC ;
					D   : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q   : OUT STD_LOGIC_VECTOR(n-1 downto 0):=(others=>'0')
		);
END My_nDFF_Port;

Architecture a_nMY_DFF OF My_nDFF_Port IS
BEGIN
	process (rst)
	begin
		IF( RST='1') THEN
			Q<=(others=>'0');
		END IF;
	end process;
    Q<=D;
end a_nMY_DFF;


