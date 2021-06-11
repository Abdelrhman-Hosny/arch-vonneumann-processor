library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF IS
	Generic (n: integer :=32);
	PORT(
	  CLK,RST,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END My_nDFF;

Architecture a_nMY_DFF OF My_nDFF IS
BEGIN
	process (clk,rst)
	begin
		IF( RST='1') THEN
			Q<=(others=>'0');
		ELSIF ( rising_edge(clk) and (W_Enable ='1')) THEN
			Q<=D;
		END IF;
	end process;
end a_nMY_DFF;


