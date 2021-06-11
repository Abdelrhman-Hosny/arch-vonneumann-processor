LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

--Register File
--There are eight 4-byte general purpose registers
-- since 8 -> address 3 bits 
-- NO CLK SINCE ITS ASYNC 
entity registerfile is
  port (
    CLK               : IN std_logic;
    RST               : IN std_logic;
    write_enable      : IN std_logic;
    -- read addresses
    read_register1_address : IN std_logic_vector(2 DOWNTO 0);
    read_register2_address : IN std_logic_vector(2 DOWNTO 0);
    -- Outputs from register file (data read)
    register1_data    : OUT std_logic_vector(31 DOWNTO 0);
    register2_data    : OUT std_logic_vector(31 DOWNTO 0)
    
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
	  CLK,RST,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END Component;

-- my Tristate buffer Component
Component My_N_TRISTATE IS
	Generic (n: integer );
	PORT(
		data_in	: IN STD_LOGIC_VECTOR(n-1 downto 0);
	    data_out: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Enable  : IN STD_LOGIC
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
                        i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8 : in std_logic_vector(31 downto 0);
                        i_s:in std_logic_vector(2 downto 0);
			o_selected :out std_logic_vector(31 downto 0)); 
end Component;


-- READ ADDRESSES SIGNALS USED IN DECODER
signal read_address1_decoded : STD_LOGIC_VECTOR(7 downto 0);
signal read_address2_decoded : STD_LOGIC_VECTOR(7 downto 0);


-- contain write address of register 
signal write_address_decoded : STD_LOGIC_VECTOR(7 downto 0);

-- Output of the registers
signal R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT ::std_logic_vector(31 downto 0);


begin


--READ!!
decoder0: My_3x8Decoder port map (read_register1_address,read_address1_decoded);
decoder1: My_3x8Decoder port map (read_register2_address,read_address2_decoded);

--WRITE!!
decoder2: My_3x8Decoder port map (write_address,write_address_decoded);



-- PORT MAPPING THE 8 Registers
R0:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(0),write_register,R0_OUT);
R1:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(1),write_register,R1_OUT);
R2:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(2),write_register,R2_OUT);
R3:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(3),write_register,R3_OUT);
R4:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(4),write_register,R4_OUT);
R5:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(5),write_register,R5_OUT);
R6:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(6),write_register,R6_OUT);
R7:My_nDFF_RegFile generic map(32) port map(CLK,RST,write_address_decoded(7),write_register,R7_OUT);



-- output of register file (read data)
mux0: mux8x1RegisterFile port map(R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,register1_data)
mux1: mux8x1RegisterFile port map(R0_OUT,R1_OUT,R2_OUT,R3_OUT,R4_OUT,R5_OUT,R6_OUT,R7_OUT,register2_data)


end architecture ; -- arch