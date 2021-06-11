library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
  port (
    i_instruction : IN std_logic_vector(4 downto 0);
    o_outputControl : OUT std_logic_vector(11 downto 0)
  ) ;
end controlUnit ;

architecture arch of controlUnit is

-- writeback signals
signal s_wbEnable : std_logic;
signal s_wbSelector : std_logic_vector(1 downto 0);
------
-- Memory signals
signal s_SPEnable, s_addSubSP, s_memRead, s_memWrite : std_logic;
--------
-- ALU Signals
-- ALU OP code is passed in instruction
signal s_ccrEnable, s_immRegSelector : std_logic;

--------
-- Branching
signal s_condJumpEnable : std_logic;
-- determines which flag to use in the conditional jump
-- zero flag / neg flag / carry flag
signal s_flagJumpSelector : std_logic_vector(1 downto 0);

begin
    process(i_instruction)
    begin

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
        s_condJumpEnable <= '0';
        s_flagJumpSelector <= "11";
        s_ccrEnable <= '1';
        --
        -- IN
    elsif i_instruction = "10110" then
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_condJumpEnable <= '0';
        s_flagJumpSelector <= "11";
        s_ccrEnable <= '0';
        s_wbEnable <= '1';
        s_wbSelector <= "10";
        -- OUT
    elsif i_instruction = "10101" then
        s_SPEnable <= '0';
        s_memRead <= '0';
        s_memWrite <= '0';
        s_addSubSP <= '0';
        s_condJumpEnable <= '0';
        s_flagJumpSelector <= "11";
        s_ccrEnable <= '0';
        s_wbEnable <= '0';
        s_wbSelector <= "11";
    end if ;



    end process;

    o_outputControl <=  s_immRegSelector &
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