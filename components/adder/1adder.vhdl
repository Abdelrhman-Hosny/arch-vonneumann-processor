entity adder1 is
  Generic (n: integer := 16); 
  port (
    D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
    Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
  );
end adder1 ;

architecture arch of adder1 is

begin
	Q <= std_logic_vector(
        to_signed(
          to_integer( unsigned(D)) + 1
          , n))
    
end architecture ; -- arch