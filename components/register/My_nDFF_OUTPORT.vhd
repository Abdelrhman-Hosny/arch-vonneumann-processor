library ieee;
use ieee.std_logic_1164.all;



entity My_nDFF_OUTPORT IS
        Generic (n: integer :=16);
        PORT(
                  W_Enable: IN STD_LOGIC ;
                        D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
                        Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
            );
END My_nDFF_OUTPORT;

Architecture a_nMY_DFF OF My_nDFF_OUTPORT IS
BEGIN
      with W_Enable select 
      Q <= D when '1';

end a_nMY_DFF;


