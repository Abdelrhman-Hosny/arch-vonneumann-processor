library ieee;
use ieee.std_logic_1164.all;

-- Hazard Detection
-- If (ID/EX.MemRead == 1)
-- and
-- ((
-- ID/EX.Rdst == IF/ID.Rsrc)
-- or
-- ( ID/EX.Rdst== IF/ID.Rdst)
-- ){
-- Stall IF # PC Enable will be equal zero so we stop
-- #fetching next instruction and IF/ID_BUFFER.
-- Stall ID # will pass zeros to the cu signals at decode stage
-- }
-- in hazard detection, we only stall first and second stages
entity hazardDetectionUnit is
  port (
    i_de_MemRead        : IN std_logic;
    i_de_Rdst           : IN std_logic_vector(2 downto 0 );
    i_fd_Rsrc           : IN std_logic_vector(2 downto 0 );
    i_fd_Rdst           : IN std_logic_vector(2 downto 0 );
    o_stall : OUT std_logic
);
end hazardDetectionUnit ;

architecture arch of hazardDetectionUnit is

begin
  o_stall <= '1' when ( i_de_MemRead='1' and ( (i_de_Rdst == i_fd_Rsrc) or ( i_de_Rdst== i_fd_Rdst) ) ) else
                '0' ;

end architecture ; -- arch
