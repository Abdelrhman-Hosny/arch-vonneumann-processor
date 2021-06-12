library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_Port IS
	Generic (n: integer :=16);
	PORT(
	  RST,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0):=(others=>'0')
		);
END My_nDFF_Port;

Architecture a_nMY_DFF OF My_nDFF_Port IS
BEGIN
	process (rst,W_Enable)
	begin
		IF( RST='1') THEN
			Q<=(others=>'0');
		ELSIF (W_Enable ='1') THEN
			Q<=D;
		END IF;
	end process;
end a_nMY_DFF;


