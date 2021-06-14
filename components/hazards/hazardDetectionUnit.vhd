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

entity hazardDetectionUnit is
  port (
    IDEX_MemRead        : IN std_logic;
    IDEX_Rdst           : IN std_logic_vector(2 downto 0 );
    IFID_Rsrc           : IN std_logic_vector(2 downto 0 );
    IDEX_Rdst           : IN std_logic_vector(2 downto 0 );
    IFID_Rdst           : IN std_logic_vector(2 downto 0 );
    Stall_IF            : IN std_logic;
    Stall_ID            : IN std_logic
) ;
end hazardDetectionUnit ;

architecture arch of hazardDetectionUnit is

begin
    Stall_IF <= '1' when ( IDEX_MemRead='1' and ( (IDEX_Rdst == IFID_Rsrc) or ( IDEX_Rdst== IFID_Rdst) ) ) else
                '0' ;


    Stall_ID <= '1' when ( IDEX_MemRead='1' and ( (IDEX_Rdst == IFID_Rsrc) or ( IDEX_Rdst== IFID_Rdst) ) ) else
                '0' ;

end architecture ; -- arch
