library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_PCselector IS
	Generic (n: integer :=2);
	PORT(
	  			CLK   : IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0):=(others=>'0')
		);
END My_nDFF_PCselector;

Architecture a_nMY_DFF OF My_nDFF_PCselector IS
BEGIN
	process (clk)
	begin
		IF ( falling_edge(clk)) THEN
			Q<=D;
		END IF;
	end process;
end a_nMY_DFF;


