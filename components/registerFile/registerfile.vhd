LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

--Register File
--There are eight 4-byte general purpose registers
-- since 8 -> address 3 bits 
entity registerfile is
  port (
    CLK               : IN std_logic;
    write_enable      : IN std_logic;

    -- read addresses
    read_register1_address : IN std_logic_vector(2 DOWNTO 0);
    read_register2_address : IN std_logic_vector(2 DOWNTO 0);

    -- Outputs from register file (data read)
    register1_data    : OUT std_logic_vector(31 DOWNTO 0);
    register2_data    : OUT std_logic_vector(31 DOWNTO 0);
    
    --  write in register ( address / data )
    write_address     : IN std_logic_vector(2 DOWNTO 0);
    write_register    : IN std_logic_vector(31 DOWNTO 0)
  );
end registerfile ;

architecture arch of registerfile is

-- my n bit D flip Flop Component
Component My_nDFF_RegFile IS
	Generic (n: integer );
	PORT(
	  CLK,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END Component;


-- 3x8 decoder 
Component My_3x8Decoder IS
	PORT( i_address : IN STD_LOGIC_VECTOR(2 downto 0 ) ;
		  o_decoded: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
END Component;

-- 8x1 multiplexer 
Component mux8x1RegisterFile is port (
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7 : in std_logic_vector(31 downto 0);
                        i_s:in std_logic_vector(2 downto 0);
			                  o_selected :out std_logic_vector(31 downto 0)
                        ); 
end Component;



-- contain write address of register 
signal write_address_decoded : STD_LOGIC_VECTOR(7 downto 0);

-- Output of the registers
signal R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT :std_logic_vector(31 downto 0);

-- Output of register file (readdata 1, readdata 2 )
-- made them since vhdl doesnt allow reading outputs directly from entity
signal read_output1 :std_logic_vector(31 downto 0);
signal read_output2 :std_logic_vector(31 downto 0);

begin


--WRITE!!
decoder0: My_3x8Decoder port map (write_address,write_address_decoded);



-- PORT MAPPING THE 8 Registers
R0:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(0),write_register,R0_OUT);
R1:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(1),write_register,R1_OUT);
R2:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(2),write_register,R2_OUT);
R3:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(3),write_register,R3_OUT);
R4:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(4),write_register,R4_OUT);
R5:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(5),write_register,R5_OUT);
R6:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(6),write_register,R6_OUT);
R7:My_nDFF_RegFile generic map(32) port map(CLK,write_address_decoded(7),write_register,R7_OUT);



-- output of register file (read data)
mux0: mux8x1RegisterFile port map(
  R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,read_register1_address,read_output1);

mux1: mux8x1RegisterFile port map(
  R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,read_register2_address,read_output2);

-- assigning signals to realOutput 
register1_data <=   (others=>'X') when read_register1_address = "UUU" else
                    read_output1;
                   
register2_data <=   (others=>'X') when read_register2_address = "UUU" else
                    read_output2;
-- register1_data <= read_output1;
-- register2_data <= read_output2;

end architecture ; -- arch