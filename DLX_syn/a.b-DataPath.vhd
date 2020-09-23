----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.08.2020 14:25:35
-- Design Name: 
-- Module Name: DataPath - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataPath is
    port (CLK:          IN std_logic;
          RST:          IN std_logic;
          CLK_EN_RF:    IN std_logic_vector(2 downto 0);
          WR_EX_STAGE:  IN std_logic_vector(2 downto 0);
          WM_EX:        IN std_logic;
          ALIGN_CTRL_EX:IN std_logic_vector(2 downto 0);
          --IR INPUTS.
          INP1:         IN std_logic_vector(31 downto 0);
          RS1:          IN std_logic_vector(4 downto 0);
          RS2:          IN std_logic_vector(4 downto 0);
          INP2:         IN std_logic_vector(31 downto 0);
          RD:           IN std_logic_vector(4 downto 0);
          --STAGE 1 CONTROL SIGNALS.
          RD1:          IN std_logic;
          RD2:          IN std_logic;
          S_U_EXT:      IN std_logic_vector(1 downto 0);
          EN1:          IN std_logic;
          --STAGE 2 CONTROL SIGNALS.
          RF_SEL_1:     IN std_logic_vector(1 downto 0);
          RF_SEL_2:     IN std_logic_vector(1 downto 0);
          S1:           IN std_logic;
          S2:           IN std_logic;
          JMP_CTRL:     IN std_logic_vector(2 downto 0);
          CONV_CTRL:        IN std_logic_vector(4 downto 0);
          INT_CTRL:         IN std_logic_vector(14 downto 0);
          SINGLE_FP_CTRL:   IN std_logic_vector(6 downto 0);
          DOUBLE_FP_CTRL:   IN std_logic_vector(6 downto 0);
          OUT_CTRL:         IN std_logic_vector(2 downto 0);
          EN2:              IN std_logic;
          --STAGE 3 CONTROL SIGNALS.
          RM:               IN std_logic;
          WM:               IN std_logic;
          RM_DOUBLE:        IN std_logic;
          WM_DOUBLE:        IN std_logic;
          ALIGN_CTRL:       IN std_logic_vector(2 downto 0);
          EN3:              IN std_logic;
          --STAGE 4 CONTROL SIGNALS.
          S3:               IN std_logic;
          WR_INT:           IN std_logic;
          WR_FLOAT:         IN std_logic;
          WR_DOUBLE:        IN std_logic;
          --OUTPUTS.
          B_T_NT:           OUT std_logic;
          NPC:              OUT std_logic_vector(31 downto 0);
          DLX_OUT:          OUT std_logic_vector(63 downto 0);
          --RAM SIGNALS
          ADDR_RAM: 	  OUT std_logic_vector(31 downto 0);
          DATAIN_RAM: 	  OUT std_logic_vector(63 downto 0);
          DATAOUT_RAM:    IN  std_logic_vector(63 downto 0));
end DataPath;

architecture Structural of DataPath is

component ALU is
    Port (
        OPA, OPB     : in std_logic_vector(63 downto 0);  -- 2 inputs N-bit
        integer_ctrl : in std_logic_vector(14 downto 0);
        single_precision_fp_ctrl : in std_logic_vector(6 downto 0);
        double_precision_fp_ctrl : in std_logic_vector(6 downto 0);
        conversion_ctrl : in std_logic_vector(4 downto 0);
        out_ctrl : in std_logic_vector(2 downto 0);
        ALU_Out   : out std_logic_vector(63 downto 0);
        PC_ALU: out std_logic_vector(63 downto 0);
        FPS : out std_logic);
end component;

component DLX_RF is
    port ( CLK: 	  IN std_logic;
           RST:       IN std_logic;
           ENABLE: 	  IN std_logic;
           RD1: 	  IN std_logic;
           RD2: 	  IN std_logic;
           RD_DOUBLE: IN std_logic;
           WR_DOUBLE: IN std_logic;
           WR: 		  IN std_logic;
           ADD_WR: 	  IN std_logic_vector(4 downto 0);
           ADD_RD1:   IN std_logic_vector(4 downto 0);
           ADD_RD2:   IN std_logic_vector(4 downto 0);
           DATAIN: 	  IN std_logic_vector(63 downto 0);
           OUT1: 	  OUT std_logic_vector(63 downto 0);
           OUT2: 	  OUT std_logic_vector(63 downto 0));
end component;

component Register_Generic is
    generic (N: integer:= 64);
    port (data_in: in std_logic_vector(N-1 downto 0);
          clk:     in std_logic;
          en:      in std_logic;
          data_out: out std_logic_vector(N-1 downto 0));
end component;

component Zero_detector is
    Generic (N: integer:= 32);
    Port (A: in std_logic_vector (N-1 downto 0);
          A_eq_zero: out std_logic); 
end component;

component FFD is
    port (D: in std_logic;
          clk:     in std_logic;
          en_rd:      in std_logic;
          rst:     in std_logic;
          Q:       out std_logic);
end component;

component LOGIC_JMP is
    port (zero_det: in std_logic;
          FPS:      in std_logic;
          JMP_CTRL: in std_logic_vector(2 downto 0);
          B_T_NT:   OUT std_logic);
end component;

component EXT_IMM is
    port (S_U_EXT: in std_logic_vector(1 downto 0);
          IMM:     in std_logic_vector(31 downto 0);
          EXT_IMM: out std_logic_vector(63 downto 0));
end component;

component SHIFT_AND_ALIGN is
    port (INPUT:  IN std_logic_vector(63 downto 0);
          CTRL:   IN std_logic_vector(2 downto 0);
          OUTPUT: OUT std_logic_vector(63 downto 0));
end component;

component MASK_AND_ALIGN is
    port (INPUT:  IN std_logic_vector(63 downto 0);
          CTRL:   IN std_logic_vector(2 downto 0);
          OUTPUT: OUT std_logic_vector(63 downto 0));
end component;

component FORWARDING_UNIT is
    port (CLK:              IN std_logic;
          EN:               IN std_logic;
          RST:              IN std_logic;
          RF_SEL_1:         IN std_logic_vector(1 downto 0);
          RF_SEL_2:         IN std_logic_vector(1 downto 0);
          RS1_ID:           IN std_logic_vector(4 downto 0);
          RS2_ID:           IN std_logic_vector(4 downto 0);
          RD_MEM:           IN std_logic_vector(4 downto 0);
          RD_WB:            IN std_logic_vector(4 downto 0);
          RD1_ID:           IN std_logic;
          RD2_ID:           IN std_logic;
          JMP_CTRL:         IN std_logic_vector(2 downto 0);
          RM_MEM:           IN std_logic;
          WM_EX:            IN std_logic;
          WM_MEM:           IN std_logic;
          WR_INT_EX:        IN std_logic;
          WR_FP_EX:         IN std_logic;
          WR_DOUBLE_EX:     IN std_logic;
          ALIGN_CTRL_EX:    IN std_logic_vector(2 downto 0);
          WR_INT_WB:        IN std_logic;
          WR_FP_WB:         IN std_logic;
          WR_DOUBLE_WB:     IN std_logic;
          FEED_ALIGN_CTRL_EX: OUT std_logic_vector(2 downto 0);
          FEED_ALIGN_CTRL_MEM:OUT std_logic_vector(2 downto 0);
          FEED_ALIGN_CTRL_WB: OUT std_logic_vector(2 downto 0);
          MUX_FRW_A_CTRL:   OUT std_logic_vector(2 downto 0);
          MUX_FRW_B_CTRL:   OUT std_logic_vector(2 downto 0);
          MUX_FRW_C_CTRL:   OUT std_logic_vector(2 downto 0);
          MUX_FRW_D_CTRL:   OUT std_logic_vector(2 downto 0));
end component;
----------------------STAGE 1 SIGNALS--------------------------------------
signal RD_stage_1_reg_out, RD_stage_2_reg_out, RF_addr_wr: std_logic_vector(4 downto 0);
signal write_back, aligned_write_back: std_logic_vector(63 downto 0);
signal A_reg_out_int, B_reg_out_int, A_reg_out_float, B_reg_out_float, A_reg_out_double, B_reg_out_double: std_logic_vector(63 downto 0);
signal A_SEL_RF, B_SEL_RF: std_logic_vector(63 downto 0); 
signal IMM_1, IMM_2, IMM_1_reg_out, IMM_2_reg_out: std_logic_vector(63 downto 0);
signal OP_A, OP_B, RF_OP_A, RF_OP_B: std_logic_vector(63 downto 0);
signal zero_det_out: std_logic;
signal CLK_EN_INT, CLK_EN_FP, CLK_EN_DOUBLE: std_logic;
---------------------------------------------------------------------------
----------------------STAGE 2 SIGNALS--------------------------------------
signal alu_out: std_logic_vector(63 downto 0);
signal alu_reg_out, PC_ALU: std_logic_vector(63 downto 0);
signal data_memory, aligned_data_memory, B_SEL_FRW: std_logic_vector(63 downto 0);
signal FPS, FPS_reg_out : std_logic:='0';
signal FPS_EN: std_logic;
signal MUX_A_FRW_CTRL, MUX_B_FRW_CTRL, MUX_C_FRW_CTRL, MUX_D_FRW_CTRL: std_logic_vector(2 downto 0); 
signal ZERO_DET_IN_FRW: std_logic_vector(63 downto 0);
---------------------------------------------------------------------------
----------------------STAGE 3 SIGNALS--------------------------------------
signal ram_out: std_logic_vector (63 downto 0);
signal alu_write_back_reg_out: std_logic_vector(63 downto 0);
signal ALIGN_AND_ENABLE: std_logic_vector(3 downto 0);
signal CLK_EN_MEM: std_logic;
---------------------------------------------------------------------------
----------------------STAGE 4 SIGNALS--------------------------------------
signal  ALIGN_AND_ENABLE_reg_out: std_logic_vector(3 downto 0);
---------------------------------------------------------------------------
----------------------FEEDBACK FORWARDING SIGNALS--------------------------
signal FEEDBACK_ALIGNED_MEM_OUT, FEEDBACK_ALIGNED_ALU_MEM: std_logic_vector(63 downto 0);
signal FEEDBACK_ALIGNED_ALU_OUT, FEEDBACK_ALIGNED_MEM_OUT_REG_OUT: std_logic_vector(63 downto 0);
signal FEED_ALIGN_CTRL_EX, FEED_ALIGN_CTRL_MEM, FEED_ALIGN_CTRL_WB: std_logic_vector(2 downto 0);
---------------------------------------------------------------------------

begin
--------------------------------------STAGE 1 (ID)---------------------------------------------------------------------------------------

INTEGER_REGISTER_FILE: DLX_RF port map (CLK => CLK,
                                        RST => RST,
                                        ENABLE => EN1,
                                        RD1 => RD1,
                                        RD2 => RD2,
                                        RD_DOUBLE => '0',
                                        WR_DOUBLE => '0',
                                        WR => WR_INT,
                                        ADD_WR => RF_addr_wr,
                                        ADD_RD1 => RS1,
                                        ADD_RD2 => RS2,
                                        DATAIN => aligned_write_back,
                                        OUT1 => A_reg_out_int,
                                        OUT2 => B_reg_out_int);
                                        
FLOATING_REGISTER_FILE: DLX_RF port map (CLK => CLK,
                                         RST => RST,
                                         ENABLE => EN1,
                                         RD1 => RD1,
                                         RD2 => RD2,
                                         RD_DOUBLE => '0',
                                         WR_DOUBLE => '0',
                                         WR => WR_FLOAT,
                                         ADD_WR => RF_addr_wr,
                                         ADD_RD1 => RS1,
                                         ADD_RD2 => RS2,
                                         DATAIN => aligned_write_back,
                                         OUT1 => A_reg_out_float,
                                         OUT2 => B_reg_out_float);

DOUBLE_REGISTER_FILE:   DLX_RF port map (CLK => CLK,
                                         RST => RST,
                                         ENABLE => EN1,
                                         RD1 => RD1,
                                         RD2 => RD2,
                                         RD_DOUBLE => '1',
                                         WR_DOUBLE => '1',
                                         WR => WR_DOUBLE,
                                         ADD_WR => RF_addr_wr,
                                         ADD_RD1 => RS1,
                                         ADD_RD2 => RS2,
                                         DATAIN => aligned_write_back,
                                         OUT1 => A_reg_out_double,
                                         OUT2 => B_reg_out_double); 
--CLOCK GATING ENABLES.
CLK_EN_INT    <= CLK  and CLK_EN_RF(0); 
CLK_EN_FP     <= CLK  and CLK_EN_RF(1); 
CLK_EN_DOUBLE <= CLK  and CLK_EN_RF(2);
                                
IN_1: Register_Generic generic map (64)
                       port map (IMM_1 ,CLK, EN1, IMM_1_reg_out);     
IN_2: Register_Generic generic map (64)
                       port map (IMM_2 ,CLK, EN1, IMM_2_reg_out);    
ZERO_DET: Zero_detector generic map (64)
                        port map (ZERO_DET_IN_FRW, zero_det_out); 
                                                              
IMM_1(31 downto 0) <= INP1;                                
IMM_1(63 downto 32)<= (others => '0');

--S_U_EXT flags the immediate sign, in case of J-TYPE instructions left S_U_EXT to '0'.
EXT_IMMEDIATE: EXT_IMM port map (S_U_EXT, INP2, IMM_2);

-----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------STAGE 2 (EX)---------------------------------------------------------------------------------------
EX_ALU: ALU port map (OPA => OP_A,
                      OPB => OP_B,
                      integer_ctrl => INT_CTRL,
                      single_precision_fp_ctrl => SINGLE_FP_CTRL,
                      double_precision_fp_ctrl => DOUBLE_FP_CTRL, 
                      conversion_ctrl => CONV_CTRL,
                      out_ctrl => OUT_CTRL,
                      ALU_Out => alu_out,
                      PC_ALU => PC_ALU,
                      FPS => FPS);
                      
DATA_FORWORDING_UNIT: FORWARDING_UNIT port map (CLK => CLK,
                                                EN  => EN2,
                                                RST => RST,
                                                RF_SEL_1 => RF_SEL_1,
                                                RF_SEL_2 => RF_SEL_2,
                                                RS1_ID   => RS1,
                                                RS2_ID   => RS2,
                                                JMP_CTRL => JMP_CTRL,
                                                RD_MEM   => RD_stage_2_reg_out,
                                                RD_WB    => RF_addr_wr,
                                                RD1_ID   => RD1,
                                                RD2_ID   => RD2,
                                                RM_MEM   => RM,
                                                WM_EX    => WM_EX,
                                                WM_MEM   => WM,
                                                WR_INT_EX => WR_EX_STAGE(2),
                                                WR_FP_EX  => WR_EX_STAGE(1),
                                                WR_DOUBLE_EX => WR_EX_STAGE(0),
                                                ALIGN_CTRL_EX => ALIGN_CTRL_EX,
                                                WR_INT_WB      => WR_INT,
                                                WR_FP_WB       => WR_FLOAT,
                                                WR_DOUBLE_WB   => WR_DOUBLE,
                                                FEED_ALIGN_CTRL_EX  => FEED_ALIGN_CTRL_EX,
                                                FEED_ALIGN_CTRL_MEM => FEED_ALIGN_CTRL_MEM,
                                                FEED_ALIGN_CTRL_WB  => FEED_ALIGN_CTRL_WB,
                                                MUX_FRW_A_CTRL => MUX_A_FRW_CTRL,
                                                MUX_FRW_B_CTRL => MUX_B_FRW_CTRL,
                                                MUX_FRW_C_CTRL => MUX_C_FRW_CTRL,
                                                MUX_FRW_D_CTRL => MUX_D_FRW_CTRL);   
                                                     
ALU_REG: Register_Generic generic map (64)
                          port map (alu_out ,CLK, EN2, alu_reg_out); 
MEM_REG: Register_Generic generic map (64)
                          port map (B_SEL_FRW ,CLK, EN2, data_memory); 
                             
FPS_REG: FFD              port map (FPS ,CLK, FPS_EN, RST ,FPS_reg_out);    

FPS_EN <= SINGLE_FP_CTRL(4) or SINGLE_FP_CTRL(3) or SINGLE_FP_CTRL(2) or DOUBLE_FP_CTRL(4) or DOUBLE_FP_CTRL(3) or DOUBLE_FP_CTRL(2); --IF CMP FP IS USED.

JMP_LOGIC: LOGIC_JMP port map (zero_det_out, FPS_reg_out, JMP_CTRL, B_T_NT);

NPC <= PC_ALU(31 downto 0);     

--A_SEL_RF MUX
A_SEL_RF <=  A_reg_out_int    when RF_SEL_1 = "00" else
             A_reg_out_float  when RF_SEL_1 = "01" else
             A_reg_out_double when RF_SEL_1 = "10" else
             A_reg_out_int;
--B_SEL_RF MUX             
B_SEL_RF <=  B_reg_out_int    when RF_SEL_2 = "00" else
             B_reg_out_float  when RF_SEL_2 = "01" else
             B_reg_out_double when RF_SEL_2 = "10" else
             B_reg_out_int;
             

--MUX A
RF_OP_A <= IMM_1_reg_out when S1 = '0' else
           A_SEL_RF;
        
--MUX B
RF_OP_B <= B_SEL_RF when S2 = '0' else
           IMM_2_reg_out; 
        
--FORWARD MUX A
OP_A <= RF_OP_A                             when MUX_A_FRW_CTRL = "000" else
        FEEDBACK_ALIGNED_ALU_MEM            when MUX_A_FRW_CTRL = "001" else 
        FEEDBACK_ALIGNED_ALU_OUT            when MUX_A_FRW_CTRL = "010" else  
        FEEDBACK_ALIGNED_MEM_OUT            when MUX_A_FRW_CTRL = "011" else
        FEEDBACK_ALIGNED_MEM_OUT_REG_OUT    when MUX_A_FRW_CTRL = "100" else
        RF_OP_A;
        
--FORWARD MUX B
OP_B <= RF_OP_B                             when MUX_B_FRW_CTRL = "000" else
        FEEDBACK_ALIGNED_ALU_MEM            when MUX_B_FRW_CTRL = "001" else 
        FEEDBACK_ALIGNED_ALU_OUT            when MUX_B_FRW_CTRL = "010" else  
        FEEDBACK_ALIGNED_MEM_OUT            when MUX_B_FRW_CTRL = "011" else
        FEEDBACK_ALIGNED_MEM_OUT_REG_OUT    when MUX_B_FRW_CTRL = "100" else 
        RF_OP_B;   
          
--FORWARD MUX B FOR DATA MEMORY.        
B_SEL_FRW <= B_SEL_RF                            when MUX_C_FRW_CTRL = "000" else
             FEEDBACK_ALIGNED_ALU_MEM            when MUX_C_FRW_CTRL = "001" else 
             FEEDBACK_ALIGNED_ALU_OUT            when MUX_C_FRW_CTRL = "010" else  
             FEEDBACK_ALIGNED_MEM_OUT            when MUX_C_FRW_CTRL = "011" else
             FEEDBACK_ALIGNED_MEM_OUT_REG_OUT    when MUX_C_FRW_CTRL = "100" else 
             B_SEL_RF;  

--FORWARD MUX D FOR DATA MEMORY.        
ZERO_DET_IN_FRW <= A_reg_out_int                       when MUX_D_FRW_CTRL = "000" else
                   FEEDBACK_ALIGNED_ALU_MEM            when MUX_D_FRW_CTRL = "001" else 
                   FEEDBACK_ALIGNED_ALU_OUT            when MUX_D_FRW_CTRL = "010" else  
                   FEEDBACK_ALIGNED_MEM_OUT            when MUX_D_FRW_CTRL = "011" else
                   FEEDBACK_ALIGNED_MEM_OUT_REG_OUT    when MUX_D_FRW_CTRL = "100" else 
                   A_reg_out_int;                                              
-----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------STAGE 3 (MEM)--------------------------------------------------------------------------------------
--RAM: DLX_RAM generic map(5) --1024 byte = 1kB.
--             port map (CLK => CLK,
--                       RST => RST,
--                       RD_M => RM,
--                       WR_M => WM,
--                       RD_DOUBLE => RM_DOUBLE,
--                       WR_DOUBLE => WM_DOUBLE,
--                       ALIGN_CTRL => ALIGN_CTRL,
--                       EN => EN3,
--                       ADDR => alu_reg_out(4 DOWNTO 0),
--                       DATAIN => data_memory,--CAMBIATO
--                       DATAOUT => ram_out);
--RAM SIGNALS.
ram_out    <= DATAOUT_RAM;                     
DATAIN_RAM <= data_memory;
ADDR_RAM   <= alu_reg_out(31 downto 0);     

M_A_A: MASK_AND_ALIGN  port map (data_memory, ALIGN_CTRL, aligned_data_memory);
MEM_REG_ALU: Register_Generic generic map(64)
                              port map(alu_reg_out, CLK, EN3, alu_write_back_reg_out);    
ALIGN_AND_ENABLE <= ALIGN_CTRL&EN3; 
-----------------------------------------------------------------------------------------------------------------------------------------
ALIGN_EN_STAGE3_TO_4: Register_Generic generic map(4)
                                       port map (ALIGN_AND_ENABLE, CLK, '1', ALIGN_AND_ENABLE_reg_out);

--------------------------------------STAGE 4 (WB)---------------------------------------------------------------------------------------
--MUX C 
write_back <= ram_out when S3 = '0' else
              alu_write_back_reg_out; 
              
            
S_A_A: SHIFT_AND_ALIGN port map (write_back, ALIGN_AND_ENABLE_reg_out(3 downto 1), aligned_write_back);
-----------------------------------------------------------------------------------------------------------------------------------------

REGISTER_OUT: Register_Generic generic map (64)
                       port map (aligned_write_back ,CLK, ALIGN_AND_ENABLE_reg_out(0), DLX_OUT);  

------------------------------------DELAY RD 2 CC-----------------------------------------------------------------------------------
STAGE_1_RD: Register_Generic generic map (5)
                       port map (RD ,CLK, EN1, RD_stage_1_reg_out); 
STAGE_2_RD: Register_Generic generic map (5)
                       port map (RD_stage_1_reg_out ,CLK, EN2, RD_stage_2_reg_out);   
STAGE_3_RD: Register_Generic generic map (5)
                       port map (RD_stage_2_reg_out ,CLK, EN3, RF_addr_wr); 
------------------------------------------------------------------------------------------------------------------------------------                       

------------------------------------DATA FORWARDING FEEDBACKS-----------------------------------------------------------------------------------
S_A_A_FEEDBACK_ALU_EX:  SHIFT_AND_ALIGN port map (alu_reg_out, FEED_ALIGN_CTRL_MEM, FEEDBACK_ALIGNED_ALU_OUT);
S_A_A_FEEDBACK_ALU_MEM: SHIFT_AND_ALIGN port map (alu_write_back_reg_out, FEED_ALIGN_CTRL_WB, FEEDBACK_ALIGNED_ALU_MEM);
S_A_A_FEEDBACK_MEM:     SHIFT_AND_ALIGN port map (ram_out, FEED_ALIGN_CTRL_MEM, FEEDBACK_ALIGNED_MEM_OUT);

FEEDBACK_MEM_WB_REG: Register_Generic generic map(64)
                                      port map(FEEDBACK_ALIGNED_MEM_OUT, CLK, '1', FEEDBACK_ALIGNED_MEM_OUT_REG_OUT);  
------------------------------------------------------------------------------------------------------------------------------------------------

end Structural;
