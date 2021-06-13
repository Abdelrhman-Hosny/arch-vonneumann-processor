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
                CCR_Enable   : IN STD_LOGIC := '0'; -- CCR ENABLE : Enable for neg , zero (initialized with zero)
                Carry_Enable : IN STD_LOGIC := '0'; -- enable for carry flag only (initialized with zero)

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
	process (CCR_Enable,Carry_Enable,carrySet,carryReset)
    -- Our design assumes CarrySet,Reset happens 
    -- without depending on W_enable
	begin
        IF (carrySet='1') then
            Q(0)<='1';   -- setting cf = 1;
        ELSIF (carryReset='1') then
            Q(0)<='0';   -- setting cf = 0 ;
        END IF;

        IF (CCR_Enable ='1') THEN
			Q(2 downto 1) <= D(2 downto 1); -- setting ZF,NF
		END IF;
        IF (Carry_Enable = '1') Then 
            Q(0) <= D(0); -- setting CF 
        END IF;
	end process;
end a_nMY_DFF;


