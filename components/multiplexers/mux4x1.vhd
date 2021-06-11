library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is 
	Generic (n: integer :=16);
    port (
            i_0,i_1,i_2,i_3: in std_logic_vector(n-1 downto 0);
            i_s:in std_logic_vector(1 downto 0);
            o_selected :out std_logic_vector(n-1 downto 0)
        ); 
end entity mux4x1;

architecture arch of mux4x1 is 
begin 
with i_s select 
o_selected <=   i_0 when "00",
                i_1 when "01",
                i_2 when "10",
                i_3 when "11";                
 end architecture arch;