library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;


entity adder is
  Generic (n: integer := 16); 
  port (
    D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
    val : integer ;
    Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
  );
end adder ;

architecture arch of adder is

begin
	Q <= std_logic_vector(
        to_signed(
          to_integer( unsigned(D)) + val
          , n));
    
end architecture ; -- arch