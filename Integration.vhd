library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity processor is
  port (
    CLK: IN std_logic

  );
end processor ;

architecture arch of processor is

-------------------------------------------------------------------
-- STAGE 1 COMPONENTS & SIGNALS

-- INSTRUCTION MEMORY
Component ram IS
PORT (  -- i removed clk since async read
		-- will change later (acc to PC )
		i_address : IN std_logic_vector(15 DOWNTO 0);
		o_dataout : OUT std_logic_vector(15 DOWNTO 0);
		o_immediate : OUT std_logic_vector(15 DOWNTO 0)
	  );
END Component;

-- PC MULTIPLEXER
Component mux4x1 is 
	Generic (n: integer :=16);
    port (
            i_0,i_1,i_2,i_3: in std_logic_vector(n-1 downto 0);
            i_s:in std_logic_vector(1 downto 0);
            o_selected :out std_logic_vector(n-1 downto 0)
        ); 
end Component;

-- PC Register 
Component My_nDFF_PC IS
	Generic (n: integer :=16);
	PORT(
	  CLK,RST,W_Enable: IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
		);
END Component;

-- Adder by 1,2 of the pc
Component adder is
    Generic (n: integer := 16); 
    port (
      D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
      val : integer ;
      Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
    );
end Component ;


--SIGNALS :

-- Adder signals
    -- PC will be I/P to Adders
    -- val will be 1 or 2 (will be adjusted before portmapping)
    -- PC+1 will be O/P from Adders
    Signal val         : integer := 1; 
    Signal PC_plus_one : std_logic_vector(15 DOWNTO 0) := (others =>'0');


-- mux 4x1 -- PC SELECTOR  (signals) 
    -- 4 I/PS : PC+1 // MEMORY // COND JUMP // UNCOND JUMP 
    -- MUX OUTPUT -> into pc register signals 
    
    -- SELECTOR 
    Signal pcSelector : std_logic_vector(1 DOWNTO 0) := "00";
    -- default is 00 to add 1 since we dont have the remaining operands
    
    -- input pc_plus_one
    Signal memory : std_logic_vector(15 DOWNTO 0);
    Signal condJump : std_logic_vector(15 DOWNTO 0);
    Signal uncondJump : std_logic_vector(15 DOWNTO 0);
    
-- PC REGISTER signals 
    -- MUX OUTPUT : I/P from mux 4x1 signals 
    -- PC : O/P from My_nDFF_PC 
Signal PC : std_logic_vector(15 DOWNTO 0) := (others =>'0');


-- Output will be instruction that will be decoded next stage
Signal Instruction : std_logic_vector(15 DOWNTO 0); -- o_dataout

-- we will need to extract data from PC+1 also (immediate)
Signal Immediate : std_logic_vector(15 DOWNTO 0); -- o_immediate

-------------------------------------------------------------------

-- STAGE 2 COMPONENTS & SIGNALS

-- REGISTER FILE 
Component registerfile is
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
end Component ;

--signals :

-- Write enable will come from (control signal)

-- Rdst = write_address (wb in regfile)
Signal Rdst  : std_logic_vector(2 DOWNTO 0) := Instruction(10 downto 8);

-- Rscr1,Rscr2 
-- VERY IMPORTANT NOTE : When there's only 1 SRC USE Rscr2 
Signal Rsrc1 : std_logic_vector(2 DOWNTO 0) := Instruction(10 downto 8);
Signal Rsrc2 : std_logic_vector(2 DOWNTO 0) := Instruction(7 downto 5);

-- Outputs from register file (data read)
Signal readData1 : std_logic_vector(31 DOWNTO 0);
Signal readData2 : std_logic_vector(31 DOWNTO 0);

-- Write_address will come from (WB)
-- Write_register will come from (WB) as well 
-------------------------------------------------------------------

-- STAGE 3 COMPONENTS & SIGNALS

-- ALU
Component ALU is
    port (
      i_operand1    : IN STD_LOGIC_VECTOR (31 downto 0);
      i_operand2    : IN STD_LOGIC_VECTOR (31 downto 0);
      o_output      : OUT STD_LOGIC_VECTOR (31 downto 0);
      i_opCode      : IN STD_LOGIC_VECTOR(3 downto 0);
      o_Cout          : OUT STD_LOGIC;
      i_shiftAmount : IN STD_LOGIC_VECTOR (4 downto 0)
    );
end Component ;
-------------------------------------------------------------------

-- STAGE 4 COMPONENTS & SIGNALS


-------------------------------------------------------------------

-- STAGE 5 COMPONENTS & SIGNALS


-------------------------------------------------------------------


begin

--Assigning values
Rdst  <= Instruction(10 downto 8);
Rsrc1 <= Instruction(10 downto 8);
Rsrc2 <= Instruction(7 downto 5);



-------------------------------------------------------------------
-- PORT MAPPING

--STAGE 1 
instructionMemory : ram port map (PC,Instruction,Immediate);


--STAGE 2

-- decide whether to add 1 or 2 based on instruction
valueDecider : process(Instruction)
begin 
    IF (Instruction(15 downto 11) = "01000" or Instruction(15 downto 11)= "00111" or Instruction(15 downto 13)= "110") THEN
			val <= 2;
	ELSE
            val <= 1;
    END IF;
end process ; -- valueDecider

-- regFile : registerfile port map(CLK,write_enable.Rscr1,Rscr2,readData1,readData2)

adderPC : adder generic map(16) port map(PC,val,PC_plus_one);

muxPC : mux4x1 generic map(16) port map(PC_plus_one,memory, condJump, uncondJump, pcSelector ,PC) ;

-------------------------------------------------------------------


end architecture ; -- arch