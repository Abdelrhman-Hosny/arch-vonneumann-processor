library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_INPORT IS
	Generic (n: integer :=16);
	PORT(
	                RST : IN STD_LOGIC ;
					D   : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q   : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END My_nDFF_INPORT;

Architecture a_nMY_DFF OF My_nDFF_INPORT IS
BEGIN
	process (rst,D)
	begin
		IF( RST='1') THEN
			Q<=(others=>'0');
		else
			Q <= D;
		END IF;
	end process;
    

end a_nMY_DFF;


