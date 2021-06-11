library ieee;
use ieee.std_logic_1164.all;

entity mux8x1RegisterFile is port (
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7 : in std_logic_vector(31 downto 0);
                        i_s:in std_logic_vector(2 downto 0);
			o_selected :out std_logic_vector(31 downto 0)
                        ); 
end entity mux8x1RegisterFile;

architecture arch of mux8x1RegisterFile is 
begin 
with i_s select 
o_selected <=   i_0 when "000",
                i_1 when "001",
                i_2 when "010",
                i_3 when "011",
                i_4 when "100",
                i_5 when "101",
                i_6 when "110",
                i_7 when "111",
                x"00000000" when others;
 end architecture arch;