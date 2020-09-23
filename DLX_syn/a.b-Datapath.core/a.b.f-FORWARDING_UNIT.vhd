----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.08.2020 15:05:05
-- Design Name: 
-- Module Name: FORWARDING_UNIT - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FORWARDING_UNIT is
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
end FORWARDING_UNIT;

architecture Behavioral of FORWARDING_UNIT is

component Register_Generic_rst is
    generic (N: integer:= 64);
    port (data_in: in std_logic_vector(N-1 downto 0);
          clk:     in std_logic;
          rst:     in std_logic;
          en:      in std_logic;
          data_out: out std_logic_vector(N-1 downto 0));
end component;

signal RS_RD_ID, RS_RD_EX_reg_out: std_logic_vector(11 downto 0);
signal WR_EX, WR_MEM: std_logic_vector(4 downto 0);
signal RS1_EX, RS2_EX: std_logic_vector(4 downto 0);
signal RD1_EX, RD2_EX: std_logic;
signal RM_WB, WM_WB: std_logic;
signal WR_INT_MEM, WR_FP_MEM, WR_DOUBLE_MEM: std_logic;
signal tmp_MUX_FRW_B_CTRL, tmp_MUX_FRW_A_CTRL, tmp_MUX_FRW_C_CTRL, tmp_MUX_FRW_D_CTRL:  std_logic_vector(2 downto 0); 
signal ALIGN_CTRL_MEM, ALIGN_CTRL_WB: std_logic_vector(2 downto 0);
signal JMP_FRW: std_logic;
begin
    
RS_RD_EX_STAGE: Register_Generic_rst generic map (12)
                                 port map (RS_RD_ID, CLK, RST ,'1', RS_RD_EX_reg_out);  
WR_MEM_STAGE:   Register_Generic_rst generic map (5)
                                 port map (WR_EX, CLK, RST ,'1', WR_MEM);
ALIGN_CTRL_MEM_STAGE: Register_Generic_rst generic map (3)
                                 port map (ALIGN_CTRL_EX, CLK, RST ,'1', ALIGN_CTRL_MEM);   
ALIGN_CTRL_WB_STAGE: Register_Generic_rst generic map (3)
                                 port map (ALIGN_CTRL_MEM, CLK, RST ,'1', ALIGN_CTRL_WB);    
                                                                                                                                
RS_RD_ID <= RS1_ID&RS2_ID&RD1_ID&RD2_ID;   
WR_EX <= WR_INT_EX&WR_FP_EX&WR_DOUBLE_EX&RM_MEM&WM_MEM;


RS1_EX <= RS_RD_EX_reg_out(11 downto 7);
RS2_EX <= RS_RD_EX_reg_out(6 downto 2);    
RD1_EX <= RS_RD_EX_reg_out(1);
RD2_EX <= RS_RD_EX_reg_out(0);       

WR_INT_MEM      <= WR_MEM(4);  
WR_FP_MEM       <= WR_MEM(3); 
WR_DOUBLE_MEM   <= WR_MEM(2);  
RM_WB           <= WR_MEM(1);      
WM_WB           <= WR_MEM(0); 

--CASE 011 or 100 => BEQZ or BNEZ.
JMP_FRW <=  ((not JMP_CTRL(2)) and JMP_CTRL(1) and JMP_CTRL(0)) OR ((JMP_CTRL(2)) and (not JMP_CTRL(1)) and (not JMP_CTRL(0)));
 
    process(RF_SEL_1, RF_SEL_2, RS1_EX, RS2_EX, RD_WB , RD1_EX, RD2_EX ,RD_MEM, WR_INT_MEM, WR_FP_MEM, WR_DOUBLE_MEM, WR_INT_WB, WR_FP_WB, WR_DOUBLE_WB, RM_MEM, WM_MEM, WM_EX ,RM_WB, WM_WB, JMP_FRW)
    begin
----------------------------------------------------------------OPA MUX CTRL-------------------------------------------------------------------------------------------
--INTEGERS.
        --INTEGER FROM ALU(MEM). 
        if ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_MEM = '0'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "010";
        --INTEGER FROM ALU (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_WB = '0'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "001";
        --INTEGER FROM MEMORY (MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_MEM = '1'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "011";
        --INTEGER FROM MEMORY (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_WB = '1'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "100";
--FLOAT SINGLE.
        --SINGLE FROM ALU(MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "01" AND RM_MEM = '0'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "010";
        --SINGLE FROM ALU (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "01" AND RM_WB = '0'  AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "001";
        --SINGLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "01" AND RM_MEM = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "011";
        --SINGLE FROM MEMORY (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "01" AND RM_WB = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "100";
--FLOAT DOUBLE.
        --DOUBLE FROM ALU(MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "10" AND RM_MEM = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "010";
        --DOUBLE FROM ALU (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "10" AND RM_WB = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "001";
        --DOUBLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "10" AND RM_MEM = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "011";
        --DOUBLE FROM MEMORY (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "10" AND RM_WB = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_A_CTRL <= "100";
        else
        --NO RAW.
            tmp_MUX_FRW_A_CTRL <= "000";    
        end if; 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------  
----------------------------------------------------------------OPB MUX CTRL-------------------------------------------------------------------------------------------
--INTEGERS.
        --INTEGER FROM ALU(MEM). 
        if ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_MEM = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "010";
        --INTEGER FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_WB = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "001";
        --INTEGER FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_MEM = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "011";
        --INTEGER FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_WB = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "100";
--FLOAT SINGLE.
        --SINGLE FROM ALU(MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_MEM = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "010";
        --SINGLE FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_WB = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "001";
        --SINGLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_MEM = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "011";
        --SINGLE FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_WB = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "100";
--FLOAT DOUBLE.
        --DOUBLE FROM ALU(MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_MEM = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "010";
        --DOUBLE FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_WB = '0' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "001";
        --DOUBLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_MEM = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "011";
        --DOUBLE FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_WB = '1' AND WM_EX = '0' AND JMP_FRW = '0') then
            tmp_MUX_FRW_B_CTRL <= "100";
        else
        --NO RAW.
            tmp_MUX_FRW_B_CTRL <= "000";    
        end if; 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------OPC MUX CTRL-------------------------------------------------------------------------------------------
--INTEGERS.
        --INTEGER FROM ALU(MEM). 
        if ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_MEM = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "010";
        --INTEGER FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_WB = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "001";
        --INTEGER FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_MEM = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "011";
        --INTEGER FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "00" AND RM_WB = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "100";
--FLOAT SINGLE.
        --SINGLE FROM ALU(MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_MEM = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "010";
        --SINGLE FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_WB = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "001";
        --SINGLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_FP_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_MEM = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "011";
        --SINGLE FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_FP_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "01" AND RM_WB = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "100";
--FLOAT DOUBLE.
        --DOUBLE FROM ALU(MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_MEM = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "010";
        --DOUBLE FROM ALU (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_WB = '0' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "001";
        --DOUBLE FROM MEMORY (MEM). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_MEM)) AND (WR_DOUBLE_MEM = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_MEM = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "011";
        --DOUBLE FROM MEMORY (WB). 
        elsif ((unsigned(RS2_EX) = unsigned(RD_WB)) AND (WR_DOUBLE_WB = '1') AND (RD2_EX = '1') AND RF_SEL_2 = "10" AND RM_WB = '1' AND WM_EX = '1' AND JMP_FRW = '0') then
            tmp_MUX_FRW_C_CTRL <= "100";
        else
        --NO RAW.
            tmp_MUX_FRW_C_CTRL <= "000";    
        end if; 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------OPD MUX CTRL-------------------------------------------------------------------------------------------
--INTEGERS.
        --INTEGER FROM ALU(MEM). 
        if ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_MEM = '0' AND WM_EX = '0' AND JMP_FRW = '1') then
            tmp_MUX_FRW_D_CTRL <= "010";
        --INTEGER FROM ALU (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_WB = '0' AND WM_EX = '0' AND JMP_FRW = '1') then
            tmp_MUX_FRW_D_CTRL <= "001";
        --INTEGER FROM MEMORY (MEM). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_MEM)) AND (WR_INT_MEM = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_MEM = '1' AND WM_EX = '0' AND JMP_FRW = '1') then
            tmp_MUX_FRW_D_CTRL <= "011";
        --INTEGER FROM MEMORY (WB). 
        elsif ((unsigned(RS1_EX) = unsigned(RD_WB)) AND (WR_INT_WB = '1') AND (RD1_EX = '1') AND RF_SEL_1 = "00" AND RM_WB = '1' AND WM_EX = '0' AND JMP_FRW = '1') then
            tmp_MUX_FRW_D_CTRL <= "100";
        else
        --NO RAW.
            tmp_MUX_FRW_D_CTRL <= "000";    
        end if; 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    
    end process;

MUX_FRW_A_CTRL <= tmp_MUX_FRW_A_CTRL when EN = '1' else
                  (others => '0');
MUX_FRW_B_CTRL <= tmp_MUX_FRW_B_CTRL when EN = '1' else
                  (others => '0');
MUX_FRW_C_CTRL <= tmp_MUX_FRW_C_CTRL when EN = '1' else
                  (others => '0'); 
MUX_FRW_D_CTRL <= tmp_MUX_FRW_D_CTRL when EN = '1' else
                  (others => '0');                  
FEED_ALIGN_CTRL_EX  <= ALIGN_CTRL_EX;
FEED_ALIGN_CTRL_MEM <= ALIGN_CTRL_MEM;
FEED_ALIGN_CTRL_WB  <= ALIGN_CTRL_WB;
end Behavioral;
