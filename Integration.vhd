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
-- Buffers
-- IF/ID
component fetchDecode
port(
        clk           : IN STD_LOGIC ; 
		-- inputs to buffer
        i_Instruction : IN STD_LOGIC_VECTOR(15 downto 0) ;
		    i_immediate   : IN STD_LOGIC_VECTOR(15 downto 0);
        i_PC_plus_one : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
        i_enable      : IN STD_LOGIC ;
        i_F_Flush     : IN STD_LOGIC ;
        
        -- outputs 
        o_Instruction : OUT STD_LOGIC_VECTOR(15 downto 0) ;
	    	o_immediate   : OUT STD_LOGIC_VECTOR(15 downto 0);
        o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 downto 0 ) 

);
end component;
-- IF/ID Signals
signal bo_fd_instruction, bo_fd_immediate: STD_LOGIC_VECTOR(15 downto 0) ;
signal bo_fd_PC_plus_one :STD_LOGIC_VECTOR(31 downto 0) ;
----------------------------
-- ID / EX 
component decodeExecBuffer
port(
  clk                 : IN STD_LOGIC ; 
-- inputs to buffer
    i_Flush             : IN STD_LOGIC ; 
    i_isRET             : IN std_logic ;
    i_readData1, i_readData2 : IN std_logic_vector( 31 downto 0);
    i_readData1Address, i_readData2Address : IN std_logic_vector(2 downto 0);
    i_writeAddress1 : IN std_logic_vector( 2 downto 0);
    i_PCNext : IN std_logic_vector(31 downto 0 );
    i_aluOPCode : IN std_logic_vector(3 downto 0);
    i_cuSignals : IN std_logic_vector(16 downto 0);
    i_immediate : IN std_logic_vector(31 downto 0);
    i_isLoadStore : IN std_logic;
    -- output to buffer
    o_isRET             : OUT std_logic ;
    o_readData1         , o_readData2 : OUT std_logic_vector( 31 downto 0);
    o_readData1Address, o_readData2Address : OUT std_logic_vector(2 downto 0);
    o_writeAddress1          : OUT std_logic_vector( 2 downto 0);
    o_PCNext                 : OUT std_logic_vector(31 downto 0 );
    o_aluOPCode               : OUT std_logic_vector(3 downto 0);
    o_cuSignals              : OUT std_logic_vector(16 downto 0);
    o_immediate              : OUT std_logic_vector(31 downto 0);
    o_isLoadStore : OUT std_logic
);

end component;
-- reset signal 
signal de_isFlush : std_logic ; 
-- ID EX Signals
signal bo_de_readData1, bo_de_readData2 : std_logic_vector( 31 downto 0);
signal bo_de_writeAddress1, bo_de_readData1Address , bo_de_readData2Address : std_logic_vector( 2 downto 0 );
signal bo_de_PCNext : std_logic_vector( 31 downto 0 );
signal bo_de_cuSignals : std_logic_vector (16 downto 0)  := (others =>'0');
signal bo_de_aluOPCode : std_logic_vector (3 downto 0);
signal bo_de_immediate : std_logic_vector( 31 downto 0);
signal bo_de_isLoadStore, bi_de_isLoadStore : std_logic;
------------------------------------
-- EX MEM Buffer
component execMemory
port(

  clk                 : IN STD_LOGIC ; 
  i_isFlush           : IN STD_LOGIC ; 
  i_isJump              :IN  STD_LOGIC ; 
      -- inputs to buffer
      i_isRET             : IN std_logic;
      i_aluData           : IN STD_LOGIC_VECTOR(31 downto 0) ;
          i_PC_plus_one       : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
      i_readData1         : IN STD_LOGIC_VECTOR(31 downto 0);
      i_controlSignals    : IN STD_LOGIC_VECTOR(7 downto 0);
      i_writeAddress      : IN STD_LOGIC_VECTOR(2 downto 0) ;
      
      -- outputs 
      o_isRET             :out std_logic;
      o_aluData           : OUT STD_LOGIC_VECTOR(31 downto 0) ;
          o_PC_plus_one       : OUT STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
      o_readData1         : OUT STD_LOGIC_VECTOR(31 downto 0);
      o_controlSignals    : OUT STD_LOGIC_VECTOR(7 downto 0);
      o_writeAddress      : OUT STD_LOGIC_VECTOR(2 downto 0);
      o_isJump            : OUT  STD_LOGIC 
);
end component;
-- signal isFlush 
signal em_isFlush : std_logic ;
-- temp sp signal
signal tempSPsignal : std_logic_vector(31 downto 0);
-- EX MEM Signals


signal bi_em_controlSignals, bo_em_controlSignals : std_logic_vector(7 downto 0)  := (others =>'0') ;

signal bo_em_aluOutput, bo_em_readData1, bi_em_alu_iport : std_logic_vector(31 downto 0);
signal bo_em_PCNext : std_logic_vector(31 downto 0);
signal bo_em_writeAddress1 : std_logic_vector(2 downto 0);
---------------------------
-- MEM WB Buffer
component memoryWB
port(
  clk                 : IN STD_LOGIC ; 
  i_isFlush           : IN STD_LOGIC ;
  -- inputs to buffer
      i_aluData           : IN STD_LOGIC_VECTOR(31 downto 0) ;
      i_memoryData        : IN STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
      i_controlSignals    : IN STD_LOGIC_VECTOR(2 downto 0);
      i_writeAddress      : IN STD_LOGIC_VECTOR(2 downto 0) ;
      -- outputs 
      o_aluData           : OUT STD_LOGIC_VECTOR(31 downto 0) ;
      o_memoryData        : OUT STD_LOGIC_VECTOR(31 downto 0 ); -- maybe can be changed
      o_controlSignals    : OUT STD_LOGIC_VECTOR(2 downto 0);
      o_writeAddress      : OUT STD_LOGIC_VECTOR(2 downto 0) 
  );
end component;

-- is flush
signal mw_isFlush : STD_LOGIC ;
-- MEM WB Buffer
signal bo_mw_aluData, bo_mw_memoryData : STD_LOGIC_VECTOR(31 downto 0);
signal bo_mw_controlSignals, bo_mw_writeAddress : STD_LOGIC_VECTOR(2 downto 0)  := (others =>'0') ;

-------------------------------------------------------------------
-- STAGE 1 COMPONENTS & SIGNALS

-- INSTRUCTION MEMORY
Component ram IS
PORT (  -- i removed clk since async read
		-- will change later (acc to PC )
		i_address : IN std_logic_vector(31 DOWNTO 0);
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
	Generic (n: integer :=32);
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


Component My_nDFF_PCselector IS
	Generic (n: integer :=2);
	PORT(
	  			CLK   : IN STD_LOGIC ;
					D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q : OUT STD_LOGIC_VECTOR(n-1 downto 0):=(others=>'0')
		);
END Component;

--SIGNALS :
signal stallOrFlush :  STD_LOGIC ;
-- Adder signals
    -- PC will be I/P to Adders
    -- valPC will be 1 or 2 (will be adjusted before portmapping)
    -- PC+1 will be O/P from Adders (pc+1 here mean next instruction not just +1)
    Signal valPC         : integer := 1; 
    -- initial value of PC_plus_one = 1 ->
    Signal PC_plus_one : std_logic_vector(31 DOWNTO 0) := (others =>'0');

-- mux 2x1
  component mux2x1
    Generic (n: integer :=16);
    port (
            i_0,i_1: in std_logic_vector(n-1 downto 0);
            i_s:in std_logic;
            o_selected :out std_logic_vector(n-1 downto 0)
    ); 
  end component;

-- mux 4x1 -- PC SELECTOR  (signals) 
    -- 4 I/PS : PC+1 // MEMORY // COND JUMP // UNCOND JUMP 
    -- MUX OUTPUT -> into pc register signals 
    
    -- SELECTOR 
    Signal pcSelector : std_logic_vector(1 DOWNTO 0) := "00";
    SIGNAL bo_PCselector : std_logic_vector(1 DOWNTO 0) := "00";
    
    -- input pc_plus_one
    Signal memory : std_logic_vector(31 DOWNTO 0);
    Signal condJumpAddress : std_logic_vector(31 DOWNTO 0);
    Signal uncondJumpAddress : std_logic_vector(31 DOWNTO 0);
    
-- PC REGISTER signals 
    -- MUX OUTPUT : I/P to My_nDFF_PC
    -- PC : O/P from My_nDFF_PC 
Signal MuxPCOutput : std_logic_vector(31 DOWNTO 0) := (others =>'0');
Signal PC : std_logic_vector(31 DOWNTO 0) := (others =>'0');


-- Output will be instruction that will be decoded next stage
Signal Instruction : std_logic_vector(15 DOWNTO 0); -- o_dataout

-- we will need to extract data from PC+1 also (immediate)
Signal Immediate : std_logic_vector(15 DOWNTO 0); -- o_immediate
signal bi_de_extendedImmediate : std_logic_vector(31 downto 0 );


--- Reset Intsruction
signal isReset : std_logic := '0'; 

signal fd_isFlush : std_logic := '0'; -- willbe or of isreset and flush from cu  

-------------------------------------------------------------------

-- STAGE 2 COMPONENTS & SIGNALS

-- Control Unit 
Component controlUnit is
  port (
    i_instruction : IN std_logic_vector(4 downto 0);
    o_outputControl : OUT std_logic_vector(16 downto 0)
  ) ;
end Component ;

signal zeroControlSignal : std_logic_vector(16 downto 0) := "00010000000000000";
signal outputMuxControlSignal : std_logic_vector(16 downto 0);
signal selectorControlSignal : std_logic;


-- REGISTER FILE 
Component registerfile is
    port (
      CLK               : IN std_logic;
      RST               : IN std_logic;
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


-- VERY IMPORTANT NOTE : When there's only 1 SRC USE Rscr2
-- Rdst = Rsrc1 (replace it later if you need ,, i made it just for illustration for now) 
Signal readData1 : std_logic_vector(31 DOWNTO 0);
Signal readData2 : std_logic_vector(31 DOWNTO 0);
signal bi_de_isRET, bo_de_isRET, bo_em_isRET : std_logic;
-- Write_address will come from (WB)
-- Write_register will come from (WB) as well 

-- CU Signals ::
-- I/P :  Instruction(15 downto 11);
Signal s_outputControl : std_logic_vector(16 downto 0) ; 

-------------------------------------------------------------------

-- STAGE 3 COMPONENTS & SIGNALS

-- ALU
Component ALU is
      port (
        i_operand1    : IN STD_LOGIC_VECTOR (31 downto 0);
        i_operand2    : IN STD_LOGIC_VECTOR (31 downto 0);
        o_output      : OUT STD_LOGIC_VECTOR (31 downto 0);
        i_opCode      : IN STD_LOGIC_VECTOR(3 downto 0);
        o_Cout        : OUT STD_LOGIC;
        o_CarryEnable : OUT STD_LOGIC;
        o_ZeroFlag    : OUT STD_LOGIC;
        o_NegFlag    : OUT STD_LOGIC
      );
end Component ;

-- Signals 
Signal s_aluOutput : STD_LOGIC_VECTOR (31 downto 0);
Signal s_aluCout   : STD_LOGIC;
signal aluOperand1, aluOperand2, aluOperand2TempHolder, aluOperand1Real :  STD_LOGIC_VECTOR (31 downto 0);
signal s_aluCarryEnable : STD_LOGIC;
signal s_aluZeroFlag    : STD_LOGIC;
signal s_aluNegFlag     : STD_LOGIC;

signal bo_em_isJump_register : STD_LOGIC:='0';
signal bi_em_isJump_register : STD_LOGIC:='0';


-- FLAG REGISTER
component My_nDFF_CCR IS
            PORT(
              CLK          : IN STD_LOGIC;
              CCR_Enable   : IN STD_LOGIC := '0'; -- CCR ENABLE : Enable for neg , zero (initialized with zero)
              Carry_Enable : IN STD_LOGIC := '0'; -- enable for carry flag only (initialized with zero)
              jump_Enable  :IN STD_LOGIC;
              Selector     : IN STD_LOGIC_VECTOR(1 downto 0);
              -- in ALU operations 
                  -- CCR_enable is opened directly each alu operation as they are changed in all alu operations
                  -- while carry_enable is opened only if operation change it 
              D         : IN STD_LOGIC_VECTOR(2 downto 0) := (others =>'0') ; -- initialized with zeros
                          -- bit 0 : CF
                          -- bit 1 : NF
                          -- bit 2 : ZF

              Q         : OUT STD_LOGIC_VECTOR(2 downto 0):= (others =>'0') ; -- initialized with zeros
              carrySet  : IN STD_LOGIC := '0';
              carryReset: IN STD_LOGIC := '0'
            );
END component;

-- FLAG REGISTER Signals: 
signal FlagRegisterOut :STD_LOGIC_VECTOR(2 downto 0) ; 
signal FlagRegisterIn :STD_LOGIC_VECTOR(2 downto 0) ; 



-- OUT PORT 
Component My_nDFF_OUTPORT IS
        Generic (n: integer :=16);
        PORT(
                  W_Enable: IN STD_LOGIC ;
                        D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
                        Q : OUT STD_LOGIC_VECTOR(n-1 downto 0)
            );
END Component;

-- Signals 
Signal OUTPORT_output : STD_LOGIC_VECTOR(31 downto 0);

Signal jumpCondFlagOutput : STD_LOGIC ; -- output of mux of flag register
-------------------------------------------------------------------

-- STAGE 4 COMPONENTS & SIGNALS

-- 2 * 2x1 muxes before Memory 
-- 1 * 2x1 mux before AdderSP to choose 2,-2


-- Adder by 2 , - 2 of the SP
-- signals
    -- SP will be I/P to Adder
    -- val will be -2 or 2 (will be adjusted before portmapping)
    --SP_plus_one will be O/P from Adders will be next sp and will update sp
    Signal valSP         : integer := 2; 
    Signal SP_plus_one : std_logic_vector(31 DOWNTO 0);

-- SP Register will be same (My_nDFF_PC)
-- SP REGISTER signals 
    -- operands : O/P from adderSP 
    -- SP : O/P from My_nDFF_PC 
component My_nDFF_SP IS
  Generic (n: integer :=32);
  PORT(
        CLK,RST,W_Enable: IN STD_LOGIC ;
              D : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
              Q : OUT STD_LOGIC_VECTOR(n-1 downto 0):= x"000003FE"
        );
END component;

Signal SP : std_logic_vector(31 DOWNTO 0) := x"000003FE";


-- we have 2 mux2x1 before Memory 
  -- first one
    -- operands : SP / ALU output
    -- Output : its o/p will enter memory as Address I/P
  -- second one 
    -- operands : PC+1 / ReadData1
    -- Output : its o/p will enter memory as Data I/P
Signal Address_IP : std_logic_vector(31 DOWNTO 0) := (others =>'0');
Signal Data_IP : std_logic_vector(31 DOWNTO 0) := (others =>'0');

-- Data Memory 
-- LITTLE_ENDIAN dataMemory
Component dataMemory IS
PORT (
		    CLK             : IN std_logic;
        i_writeEnable   : IN std_logic;
        i_readEnable    : IN std_logic;
        i_address       : IN std_logic_vector(31 DOWNTO 0); -- depends onsize of memory 
        i_writeData     : IN std_logic_vector(31 DOWNTO 0); -- same size as Register
		    o_dataout       : OUT std_logic_vector(31 DOWNTO 0) -- same size as Register
	  );
END Component;

Signal memoryData_OUT : std_logic_vector(31 DOWNTO 0) := (others =>'0');


-------------------------------------------------------------------

-- STAGE 5 COMPONENTS & SIGNALS

-- we have 1 *  mux4x1 
    -- operands : ReadData / IP port / ALU
    -- Output wbData : its o/p Will be written back in register file

-- I/P Port
Component My_nDFF_INPort IS
	Generic (n: integer :=32);
	PORT(
	        RST : IN STD_LOGIC ;
					D   : IN STD_LOGIC_VECTOR(n-1 downto 0) ;
					Q   : OUT STD_LOGIC_VECTOR(n-1 downto 0):=(others=>'0')
		);
END Component;

-- I/P PORT Signals
  --RST -> '0' 
  Signal IPPort_Input : STD_LOGIC_VECTOR(31 downto 0);
  Signal IPPort_Output : STD_LOGIC_VECTOR(31 downto 0);

--o/p from 4x1 multiplexer
Signal wbData : std_logic_vector(31 downto 0);

-------------------------------------------------------------------
-- Hazards

-- Forwarding unit
component forwardingUnit
port(
  i_de_readData1Address, i_de_readData2Address : IN std_logic_vector(2 downto 0 );
  i_em_writeBackSignal : IN std_logic;
  i_em_writeAddress :  IN std_logic_vector(2 downto 0 );
  i_mw_writeBackSignal : IN std_logic;
  i_mw_writeAddress :  IN std_logic_vector(2 downto 0 );
  o_aluOperand1Selector, o_aluOperand2Selector  : OUT std_logic_vector(1 downto 0)
);
end component;

signal fwdUnit_alu1Selector, fwdUnit_alu2Selector : std_logic_vector( 1 downto 0);


-- Hazard Detection Unit 


component hazardDetectionUnit is
  port (
    i_de_MemRead        : IN std_logic;
    i_de_Rdst           : IN std_logic_vector(2 downto 0 );
    i_fd_Rsrc           : IN std_logic_vector(2 downto 0 );
    i_fd_Rdst           : IN std_logic_vector(2 downto 0 );
    o_stall             : OUT std_logic
);
end component ;

-- signals  
signal o_HDU_stall :  std_logic ; 

begin


-- STAGE 1

-- Reseting pc
isReset <= '1' when Instruction(15 downto 11)="10111" else
            '0';



-- decide whether to add 1 or 2 based on instruction
valueDeciderPC : process(Instruction)
begin 
IF (Instruction(15 downto 11) = "01000" or Instruction(15 downto 11)= "00111" or Instruction(15 downto 13)= "110") THEN
valPC <= 2;
ELSE
valPC <= 1;
END IF;
end process ; -- valueDeciderPC

adderPC : adder generic map(32) port map(PC,valPC,PC_plus_one);

uncondJumpAddress <= aluOperand1 ;
condJumpAddress <= aluOperand1 ; 

PCSelectorBuffer : My_nDFF_PCselector port map (clk,pcSelector,bo_PCselector);
muxPC : mux4x1 generic map(32) port map(PC_plus_one, memoryData_OUT, condJumpAddress, uncondJumpAddress, bo_PCselector ,MuxPCOutput);

registerPC : My_nDFF_PC generic map(32) port map (CLK,isReset,"not"(o_HDU_stall),MuxPCOutput,PC); -- '0','1' FOR NOW ONLY

instructionMemory : ram port map (PC,Instruction,Immediate);

fd_isFlush <= '1' when 
        isReset='1' or bo_de_cuSignals(14)='1' or (bo_de_cuSignals(10)='1' and jumpCondFlagOutput='1') or bo_de_cuSignals(13) = '0' or bo_em_isRET = '1' else
          '0'; 


buffer_fetchDecode : fetchDecode port map(clk, 
                                          Instruction, Immediate,PC_plus_one,
                                          "not"(o_HDU_stall), fd_isFlush,  
                                          bo_fd_instruction,bo_fd_immediate,bo_fd_PC_plus_one );
-------------------------------------------------------------------

--STAGE 2


registerFileLabel : registerfile port map(
  CLK,isReset,bo_mw_controlSignals(0),bo_fd_instruction(10 downto 8),bo_fd_instruction(7 downto 5),readData1,readData2,bo_mw_writeAddress,wbData
);


bi_de_extendedImmediate <= std_logic_vector(resize( unsigned(bo_fd_immediate), 32) ) ; 
-- Rdst  <= Instruction(10 downto 8);
-- Rsrc1 <= Instruction(10 downto 8);
-- Rsrc2 <= Instruction(7 downto 5);


controlUnitLabel : controlUnit port map(bo_fd_instruction(15 downto 11),s_outputControl);
bi_de_isLoadStore <= '1' when bo_fd_instruction(15 downto 11) = "11010" or bo_fd_instruction(15 downto 11) = "11011" else
                      '0'; 


selectorControlSignal <= o_HDU_stall  ; --or will be replacing it soon  

outputMuxControlSignal <= zeroControlSignal when selectorControlSignal='1' or bo_em_isJump_register='1' else
                          s_outputControl; 

de_isFlush <='1' when  isReset='1' or 
                        (bo_de_cuSignals(14)='1') or 
                        (bo_de_cuSignals(10)='1' and jumpCondFlagOutput='1') or 
                        bo_de_cuSignals(13)='0' or bo_em_isRET = '1' else
              '0' ;

bi_de_isRET <= '1' when bo_fd_instruction(15 downto 11) = "01110"
              else '0';

buffer_decodeExec: decodeExecBuffer port map(
  clk,
  de_isFlush,
  bi_de_isRET,
  readData1,readData2,
  bo_fd_instruction(10 downto 8),bo_fd_instruction(7 downto 5), -- readAddress 1 and 2
  bo_fd_instruction(10 downto 8), -- writeAddress1
  bo_fd_PC_plus_one,
  bo_fd_instruction(4 downto 1),
  outputMuxControlSignal,
  bi_de_extendedImmediate,
  bi_de_isLoadStore,
  -- outputs
  bo_de_isRET,
  bo_de_readData1, bo_de_readData2,
  bo_de_readData1Address, bo_de_readData2Address,
  bo_de_writeAddress1,
  bo_de_PCNext,
  bo_de_aluOPCode,
  bo_de_cuSignals,
  bo_de_immediate,
  bo_de_isLoadStore
);


-------------------------------------------------------------------

-- STAGE 3 
                                            -- op 2 and 3 are forwarded data from mem and previous alu
                                            -- op4 is never accessed
                                            -- selector comes from forwarding unit not control unit
aluMux1 : mux4x1  generic map(32) port map(bo_de_readData1, bo_em_aluOutput, wbData, x"00000000", fwdUnit_alu1Selector, aluOperand1);
aluMux2 : mux4x1  generic map(32) port map(bo_de_readData2, bo_em_aluOutput, wbData, x"00000000", fwdUnit_alu2Selector, aluOperand2TempHolder);
                                                                          -- selector should be replaced
                                                                          -- with immediate or reg decider from cu

aluMux3 : mux2x1  generic map(32) port map(aluOperand2TempHolder, bo_de_immediate, bo_de_cuSignals(11), aluOperand2);
aluMux4: mux2x1  generic map(32) port map(aluOperand1, aluOperand2TempHolder, bo_de_isLoadStore, aluOperand1Real);
aluLabel : ALU port map (
                  aluOperand1Real, aluOperand2, s_aluOutput , bo_de_aluOPCode , s_aluCout,s_aluCarryEnable
                  ,s_aluZeroFlag, s_aluNegFlag);


FlagRegisterIn <= s_aluZeroFlag & s_aluNegFlag & s_aluCout ; 
FlagRegister : My_nDFF_CCR port map (CLK,bo_de_cuSignals(9),s_aluCarryEnable,
                                      bo_de_cuSignals(10),bo_de_cuSignals(8 downto 7)
                                      ,FlagRegisterIn
                                      ,FlagRegisterOut
                                      ,bo_de_cuSignals(15),bo_de_cuSignals(16));

-- flag register mux  
jumpCondFlagOutput <= FlagRegisterOut(0) when bo_de_cuSignals(8 downto 7) = "00" else
                      FlagRegisterOut(1) when bo_de_cuSignals(8 downto 7) = "01" else
                      FlagRegisterOut(2) when bo_de_cuSignals(8 downto 7) = "10" else
                      '0';
                      -- 0 : CF / 1 :NF / 2 :ZF / 3 :00
-- I/P PORT
IP_PORT : My_nDFF_INPORT generic map(32) port map('0',IPPort_Input,IPPort_Output);


muxALU_IPport:  mux2x1 generic map(32) port map(s_aluOutput, IPPort_Output, bo_de_cuSignals(2), bi_em_alu_iport );

bi_em_controlSignals <=  bo_de_cuSignals(13) & bo_de_cuSignals(6 downto 0);
-- readData1, readData2 must be changed to be output from muxes 
-- we just made it now for testing

-- recognizing unconditional jump in stage 3 
pcSelector <= "11" when bo_de_cuSignals(14)='1' or bo_de_cuSignals(13)='0' else
              "10" when bo_de_cuSignals(10)='1' and jumpCondFlagOutput='1' else
              "01" when bo_em_isRET = '1' else
              "00"; 

bi_em_isJump_register <= '1' when  bo_de_cuSignals(14)='1' or (bo_de_cuSignals(10)='1' and jumpCondFlagOutput='1') or bo_de_cuSignals(13)='0' or bo_em_isRET='1' else
                         '0'; 
em_isFlush <= isReset ; -- maybe ored later
buffer_execMemory: execMemory port map( clk,
                                        em_isFlush,
                                        bi_em_isJump_register,
                                        -- inputs
                                        bo_de_isRET,
                                        bi_em_alu_iport,
                                        bo_de_PCNext,
                                        aluOperand1,
                                        bi_em_controlSignals,-- control signals
                                        bo_de_writeAddress1,
                                        -- outputs
                                        bo_em_isRET,
                                        bo_em_aluOutput,
                                        bo_em_PCNext,
                                        bo_em_readData1,
                                        bo_em_controlSignals,
                                        bo_em_writeAddress1,
                                        bo_em_isJump_register
                                        );


-- OUTPORT 
OUT_PORT : My_nDFF_OUTPORT generic map(32) port map (bo_de_cuSignals(12), aluOperand1, OUTPORT_output);


-------------------------------------------------------------------

-- STAGE 4

-- SP REGION 
-- -- decide whether to add 2 or -2 based on instruction
-- valueDeciderForSP : process(CLK)
-- begin 
--     IF ( bo_em_controlSignals(5) = '1' ) THEN                 -- Will be removed CU and be from buffer
-- 			  valSP <= 2;
-- 	  ELSE
--         valSP <= -2;
--     END IF;
-- end process ; -- valueDeciderForSP

-- SP Adder
valSP <= 2 when bo_em_controlSignals(6) = '1' else
        -2 ;

adderSP : adder generic map(32) port map(SP,valSP,SP_plus_one);

SP_register : My_nDFF_SP generic map (32) port map (clk,'0',bo_em_controlSignals(5),SP_plus_one ,SP );

-- Updating SP
-- process(clk)
-- begin 
--   if(rising_edge(clk) and bo_em_controlSignals(5) = '1') THEN -- Will be removed CU and be from buffer
--     SP <= SP_plus_one;
--   end if; 
-- end process ; -- SPAssign

-- tempSPsignal <= SP_plus_one when bo_em_controlSignals(6) = '1' else
--                 SP;

-- check control signals
-- SP is made at selector 1 not 0 as report 
memorymux1 : mux2x1  generic map(32) port map(bo_em_aluOutput , SP, bo_em_controlSignals(5),Address_IP);
memorymux2 : mux2x1  generic map(32) port map(bo_em_PCNext, bo_em_readData1, bo_em_controlSignals(7),Data_IP);
-- ZEROS WILL BE bo_em_PCNext

-- check control signals
datamemory0 : dataMemory port map(CLK , bo_em_controlSignals(3), bo_em_controlSignals(4),
                                                Address_IP, Data_IP, memoryData_OUT);


mw_isFlush <= isReset ; -- maybe ored later
buffer_memWB : memoryWB port map( clk,
                                  mw_isFlush,
                                  -- inputs
                                  bo_em_aluOutput,
                                  memoryData_OUT, -- memoryData
                                  bo_em_controlSignals(2 downto 0),
                                  bo_em_writeAddress1,
                                  -- outputs
                                  bo_mw_aluData,
                                  bo_mw_memoryData,
                                  bo_mw_controlSignals,
                                  bo_mw_writeAddress
                                  );
-------------------------------------------------------------------

-- STAGE 5 


--WBmux
muxWB : mux4x1 generic map (32) port map (
  bo_mw_memoryData, bo_mw_aluData, bo_mw_aluData,(others=>'0'),bo_mw_controlSignals(2 downto 1), wbData
);

-------------------------------------------------------------------
-- Hazards

-- Forwarding unit

fwdUnit : forwardingUnit port map(
                  bo_de_readData1Address , bo_de_readData2Address,
                  bo_em_controlSignals(0), bo_em_writeAddress1,
                  bo_mw_controlSignals(0), bo_mw_writeAddress,
                  fwdUnit_alu1Selector, fwdUnit_alu2Selector
                  );

-- HazardDetectionUnit

HDU0 : hazardDetectionUnit port map (
                                  bo_de_cuSignals(4),bo_de_readData1Address,
                                  bo_fd_instruction(10 downto 8),bo_fd_instruction(7 downto 5),
                                  o_HDU_stall);


end architecture ; -- arch

