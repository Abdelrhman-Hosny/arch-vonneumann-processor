library ieee;
use ieee.std_logic_1164.all;

entity forwardingUnit is
  port (
    i_de_readData1Address, i_de_readData2Address : IN std_logic_vector(2 downto 0 );
    i_em_writeBackSignal : IN std_logic;
    i_em_writeAddress :  IN std_logic_vector(2 downto 0 );
    i_mw_writeBackSignal : IN std_logic;
    i_mw_writeAddress :  IN std_logic_vector(2 downto 0 );
    o_aluOperand1Selector, o_aluOperand2Selector  : OUT std_logic_vector(1 downto 0)  := (others =>'0')
  ) ;
end forwardingUnit ;

architecture arch of forwardingUnit is

begin

    
    o_aluOperand1Selector <=    "01" when i_em_writeBackSignal = '1' and i_de_readData1Address = i_em_writeAddress else  
                                "10"  when i_mw_writeBackSignal = '1' and i_de_readData1Address = i_mw_writeAddress else
                                "00";

    o_aluOperand2Selector <=    "01" when i_em_writeBackSignal = '1' and i_de_readData2Address = i_em_writeAddress else
                                "10"  when i_mw_writeBackSignal = '1' and i_de_readData2Address = i_mw_writeAddress else
                                "00";


end architecture ; -- arch