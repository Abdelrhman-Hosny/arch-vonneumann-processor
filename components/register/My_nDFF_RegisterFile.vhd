library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_RegFile IS
	Generic (n: integer :=32);
	PORT(
	  CLK,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END My_nDFF_RegFile;

Architecture a_nMY_DFF OF My_nDFF_RegFile IS
BEGIN
	process (clk)
	begin
		IF ( falling_edge(clk) and (W_Enable ='1')) THEN
			Q<=D;
		END IF;
	end process;
end a_nMY_DFF;


