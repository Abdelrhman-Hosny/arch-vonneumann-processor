library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is 
	Generic (n: integer :=16);
    port (
            i_0,i_1: in std_logic_vector(n-1 downto 0);
            i_s:in std_logic;
            o_selected :out std_logic_vector(n-1 downto 0)
        ); 
end entity mux2x1;

architecture arch of mux2x1 is 
begin 
    o_selected <=   i_0 when i_s = '0'
                    else i_1;
end architecture arch;