library ieee;
use ieee.std_logic_1164.all;


-- this is flag register
-- consists of Carry , Neg , Zero Flags 
                        -- 00 C
                        -- 01 N
                        -- 10 Z
                        -- 11 Always 0

entity My_nDFF_CCR IS
        PORT(
                CLK          : IN STD_LOGIC ;
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
END My_nDFF_CCR;

Architecture a_nMY_DFF OF My_nDFF_CCR IS
BEGIN

    -- Carry set and reset async
   
        Q(0)<='1' when  carrySet='1' else
              '0' when  carryReset='1';

    -- writing sync
        process(clk)
        begin
            if(rising_edge(clk) and (jump_Enable ='1')) then
                if (Selector="00") then
                    Q(0) <= '0';
                elsif (Selector="01") then
                    Q(1) <= '0';
                elsif (Selector="10") then
                    Q(2) <= '0';
                end if;
            else 
                if(rising_edge(clk) and (CCR_Enable ='1') ) then
                    Q(2 downto 1) <= D(2 downto 1); --write both in same time 
                end if;
                if (rising_edge(clk) and (Carry_Enable = '1') )then
                    Q(0) <= D(0);
                end if;
            end if ;
        end process;


end a_nMY_DFF;


