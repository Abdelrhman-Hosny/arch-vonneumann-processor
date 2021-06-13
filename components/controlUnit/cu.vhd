library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
  port (
    i_instruction : IN std_logic_vector(4 downto 0);
    o_outputControl : OUT std_logic_vector(16 downto 0)  := (others =>'0')
  ) ;
end controlUnit ;

architecture arch of controlUnit is

-- writeback signals
signal s_wbEnable : std_logic;
signal s_wbSelector : std_logic_vector(1 downto 0);
------
-- Memory signals
signal s_SPEnable, s_addSubSP, s_memRead, s_memWrite, s_memWriteDataSelector: std_logic;
--------
-- ALU Signals
-- ALU OP code is passed in instruction
signal s_ccrEnable, s_immRegSelector : std_logic;
signal s_resetCarryFlag, s_setCarryFlag : std_logic;
--------
-- Branching
signal s_unCondJumpEnable, s_condJumpEnable : std_logic;
-- determines which flag to use in the conditional jump
-- zero flag / neg flag / carry flag
signal s_flagJumpSelector : std_logic_vector(1 downto 0);
-------
-- OUT
signal s_outPortEnable : std_logic;
----

begin
    process(i_instruction)
    begin
    
    -- stuff that is set automatically in
    -- else condition

    --  s_condJumpEnable , s_flagJumpSelector , s_memWriteDataSelector, s_outPortEnable
    --  s_unCondJumpEnable, s_setCarryFlag, s_resetCarryFlag, s_immRegSelector
    
    -- total : 9
    -- stuff that you have to write manually 
    
    -- s_SPEnable, s_addSubSP, s_memRead, s_memWrite
    -- s_ccrEnable,  s_wbEnable, s_wbSelector

    -- total : 8
    -- control unit signals that happen in only one op

    -- Conditional JUMPS
    if i_instruction = "10000" then -- Zero
        s_condJumpEnable <= '1';
        s_flagJumpSelector <= "10";
        -- mem 
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        -- wb
        s_wbEnable <= '0';
        s_wbSelector <= "11";
        -- ccr Enable
        s_ccrEnable <= '0';

    elsif  i_instruction = "10001" then -- Negative
        s_condJumpEnable <= '1';
        s_flagJumpSelector <= "01";
        -- mem 
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        -- wb
        s_wbEnable <= '0';
        s_wbSelector <= "11";
        -- ccr Enable
        s_ccrEnable <= '0';

    elsif  i_instruction = "10010" then -- Carry
        s_condJumpEnable <= '1';
        s_flagJumpSelector <= "00";
        -- mem 
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        -- wb
        s_wbEnable <= '0';
        s_wbSelector <= "11";
        -- ccr Enable
        s_ccrEnable <= '0';
    else
        s_condJumpEnable <= '0';
        s_flagJumpSelector <= "11";
    end if ;

    if  i_instruction = "10101" then -- OUT
        s_outPortEnable <= '1';
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '0';
        s_wbSelector <= "11";
    else
        s_outPortEnable <= '0';
    end if ;

    if  i_instruction = "01111" then -- CALL
        s_memWriteDataSelector <= '0';
        s_SPEnable <= '1';
        s_memRead <= '0';
        s_memWrite <= '1';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '0';
        s_wbSelector <= "00";

    else
        s_memWriteDataSelector <= '1';
    end if ;
        
    if  i_instruction = "10011" then -- JMP
        s_unCondJumpEnable <= '1';
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '0';
        s_wbSelector <= "11";
    else
        s_unCondJumpEnable <= '0';
    end if ;
        
        -- SETC
    if  i_instruction = "01001" then
        s_setCarryFlag <= '1';
        -- mem
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        -- wb
        s_wbEnable <= '0';
        s_wbSelector <= "00";
        -- ccr Enable
        s_ccrEnable <= '0';


    else
        s_setCarryFlag <= '0';
    end if ;
    
        -- CLRC
    if i_instruction = "01010" then
        s_resetCarryFlag <= '1';
        -- mem
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        -- wb
        s_wbEnable <= '0';
        s_wbSelector <= "00";
        -- ccr Enable
        s_ccrEnable <= '0';
    else
        s_resetCarryFlag <= '0';
    end if ;
    
    -- whether immediate will be used or not
    if  i_instruction(4 downto 2) = "110" or i_instruction = "01000" or  i_instruction = "00111"  then
        s_immRegSelector <= '1';
    else 
        s_immRegSelector <= '0';
    end if ;
    
    -- non memory ALU operations
    if i_instruction(4 downto 3) = "00" or i_instruction = "01000" then
        s_wbEnable <= '1';
        s_wbSelector <= "01";
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '1';
        
        --
        -- IN
    elsif i_instruction = "10110" then
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '1';
        s_wbSelector <= "10";   
        --
        -- NOP
    elsif i_instruction = "01011" then
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '0';
        s_wbSelector <= "10";
        --
        -- MOV
    elsif i_instruction = "10100" then
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_ccrEnable <= '0';
        s_wbEnable <= '1';
        s_wbSelector <= "01";
    end if ;
    -- stuff that you have to write manually 
    
    -- s_SPEnable, s_addSubSP, s_memRead, s_memWrite
    -- s_ccrEnable,  s_wbEnable, s_wbSelector

    -- total : 8


    end process;

    o_outputControl <=  s_resetCarryFlag &
    s_setCarryFlag &
    s_unCondJumpEnable &
    s_memWriteDataSelector &
    s_outPortEnable &
    s_immRegSelector &
    s_condJumpEnable &
    s_ccrEnable &
    s_flagJumpSelector &
    s_addSubSP &
    s_SPEnable &
    s_memRead &
    s_memWrite &
    s_wbSelector &
    s_wbEnable;



end architecture ; -- arch