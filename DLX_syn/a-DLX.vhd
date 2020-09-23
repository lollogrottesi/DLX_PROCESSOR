----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.08.2020 11:21:18
-- Design Name: 
-- Module Name: DLX - Structural
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

entity DLX is
    port (clk:     IN std_logic;
          rst:     IN std_logic;
          DLX_OUT: OUT std_logic_vector(63 downto 0);
          --IRAM SIGNALS
          Dout_IRAM : IN   std_logic_vector(31 downto 0);
          Addr_IRAM : OUT  std_logic_vector(31 downto 0);
          --RAM SIGNALS
          RM:               OUT std_logic;
          WM:               OUT std_logic;
          RM_DOUBLE:        OUT std_logic;
          WM_DOUBLE:        OUT std_logic;
          ALIGN_CTRL:       OUT std_logic_vector(2 downto 0);
          EN3:              OUT std_logic;
          ADDR_RAM: 	    OUT std_logic_vector(31 downto 0);
          DATAIN_RAM: 	    OUT std_logic_vector(63 downto 0);
          DATAOUT_RAM:      IN  std_logic_vector(63 downto 0));
end DLX;

architecture Structural of DLX is
component DataPath is
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
end component;

component DLX_Fetch_Stage is
    port (clk:      IN std_logic;
          rst:      IN std_logic;
          MUX_sel:  IN std_logic;
          NPC_in:   IN std_logic_vector(31 downto 0);
          NPC_out:  OUT std_logic_vector(31 downto 0);
          IR:       OUT std_logic_vector(31 downto 0);
          --IRAM SIGNALS
          Dout_IRAM : IN   std_logic_vector(31 downto 0);
          Addr_IRAM : OUT  std_logic_vector(31 downto 0));
end component;

component CONTROL_UNIT is
    port(CLK:           IN std_logic;
         RST:           IN std_logic;
         OPCODE:        IN std_logic_vector(5 downto 0);
         FUNC:          IN std_logic_vector(10 downto 0);
         FLUSH:         IN std_logic;    
         CTRL_WORD:     OUT std_logic_vector(63 downto 0);
         CLK_EN_RF:     OUT std_logic_vector(2 downto 0);
         WR_EX:         OUT std_logic_vector(2 downto 0);
         WM_EX:         OUT std_logic;
         ALIGN_CTRL_EX: OUT std_logic_vector(2 downto 0));
end component;

signal PC_DP, PC_rst, NPC_s: std_logic_vector(31 downto 0);
signal IR: std_logic_vector(31 downto 0);
signal RS1, RS2, RD: std_logic_vector(4 downto 0);
signal INP2: std_logic_vector(31 downto 0);
signal ext_IMM, ext_offset: std_logic_vector(31 downto 0);
signal OPCODE: std_logic_vector(5 downto 0);
signal FUNC: std_logic_vector(10 downto 0);
signal B_T_NT: std_logic;
type INSTRUCTION_TYPE is (I_TYPE, R_TYPE, J_TYPE);
signal TYPE_CASE: INSTRUCTION_TYPE;
signal CTRL_WORD: std_logic_vector(63 downto 0);
signal CLK_EN_RF: std_logic_vector(2 downto 0);
signal WR_EX_STAGE, ALIGN_CTRL_EX: std_logic_vector(2 downto 0);
signal RM_EX_STAGE, WM_EX: std_logic;
begin
CU:     CONTROL_UNIT port map (CLK       => CLK,
                               RST       => RST,
                               OPCODE    => OPCODE,
                               FUNC      => FUNC,
                               FLUSH     =>  B_T_NT,
                               CTRL_WORD => CTRL_WORD,
                               CLK_EN_RF => CLK_EN_RF,
                               WR_EX     => WR_EX_STAGE,
                               WM_EX     => WM_EX,
                               ALIGN_CTRL_EX => ALIGN_CTRL_EX);
                               
IF_stage: DLX_Fetch_Stage port map (CLK, RST, B_T_NT, PC_DP, NPC_s, IR, Dout_IRAM, Addr_IRAM);
ID_EX_MEM_WB_stages: DataPath port map (CLK  => CLK,
                                        RST  => RST,
                                        CLK_EN_RF   => CLK_EN_RF,
                                        WR_EX_STAGE => WR_EX_STAGE,
                                        WM_EX       => WM_EX,
                                        ALIGN_CTRL_EX => ALIGN_CTRL_EX,
                                        --IR INPUTS.
                                        INP1 => NPC_s,
                                        RS1  => RS1,
                                        RS2  => RS2,
                                        INP2 => INP2,
                                        RD   => Rd,
                                        --STAGE 1 CONTROL SIGNALS.
                                        RD1         => CTRL_WORD(63),
                                        RD2         => CTRL_WORD(62),
                                        S_U_EXT     => CTRL_WORD(61 downto 60),
                                        EN1         => CTRL_WORD(59),
                                        --STAGE 2 CONTROL SIGNALS.
                                        RF_SEL_1        => CTRL_WORD(58 downto 57),
                                        RF_SEL_2        => CTRL_WORD(56 downto 55),
                                        S1              => CTRL_WORD(54),
                                        S2              => CTRL_WORD(53),
                                        JMP_CTRL        => CTRL_WORD(52 downto 50),
                                        CONV_CTRL       => CTRL_WORD(49 downto 45),
                                        INT_CTRL        => CTRL_WORD(44 downto 30),
                                        SINGLE_FP_CTRL  => CTRL_WORD(29 downto 23),
                                        DOUBLE_FP_CTRL  => CTRL_WORD(22 downto 16),
                                        OUT_CTRL        => CTRL_WORD(15 downto 13),
                                        EN2             => CTRL_WORD(12),
                                        --STAGE 3 CONTROL SIGNALS.
                                        RM              => CTRL_WORD(11),
                                        WM              => CTRL_WORD(10),
                                        RM_DOUBLE       => CTRL_WORD(9),
                                        WM_DOUBLE       => CTRL_WORD(8),
                                        ALIGN_CTRL      => CTRL_WORD(7 downto 5),
                                        EN3             => CTRL_WORD(4),
                                        --STAGE 4 CONTROL SIGNALS.
                                        S3              => CTRL_WORD(3),
                                        WR_INT          => CTRL_WORD(2),
                                        WR_FLOAT        => CTRL_WORD(1),
                                        WR_DOUBLE       => CTRL_WORD(0),
                                        --OUTPUTS.
                                        B_T_NT          => B_T_NT,
                                        DLX_OUT         => DLX_OUT,
                                        NPC             => PC_DP,
                                        --RAM SIGNALS.
                                        ADDR_RAM    => ADDR_RAM,
                                        DATAIN_RAM  => DATAIN_RAM,
                                        DATAOUT_RAM => DATAOUT_RAM);

RM              <= CTRL_WORD(11);
WM              <= CTRL_WORD(10);
RM_DOUBLE       <= CTRL_WORD(9);
WM_DOUBLE       <= CTRL_WORD(8);
ALIGN_CTRL      <= CTRL_WORD(7 downto 5);
EN3             <= CTRL_WORD(4);

OPCODE <= IR (31 downto 26);
FUNC   <= IR (10 downto 0); 

TYPE_CASE <= I_TYPE when (OPCODE(5) or OPCODE(4) or OPCODE(3) or OPCODE(2)) = '1'                      else --I-TYPE.
             R_TYPE when (OPCODE(5) or OPCODE(4) or OPCODE(3) or OPCODE(2) or OPCODE(1)) = '0'         else --R-TYPE.
             J_TYPE ;                                                                                       --J-TYPE.
                                                                                                   
                                                                                                  
RS1 <= IR(25 downto 21);
            
RS2 <= IR(20 downto 16);

RD <= "11111"          when  (TYPE_CASE = J_TYPE) or (OPCODE = "010011") else --JUMP AND LINK CASE.
      IR(20 downto 16) when  TYPE_CASE = I_TYPE else
      IR(15 downto 11); 
      
INP2 <= ext_IMM     when TYPE_CASE = I_TYPE else
        ext_offset;
              
ext_IMM (15 downto 0) <= IR (15 downto 0);
ext_IMM (31 downto 16)<= (others => '0');    

ext_offset(25 downto 0) <= IR(25 downto 0);
ext_offset(31 downto 26)<= (others => '0');


end Structural;
