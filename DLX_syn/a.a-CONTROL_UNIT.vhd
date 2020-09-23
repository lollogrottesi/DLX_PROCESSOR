----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2020 20:03:14
-- Design Name: 
-- Module Name: CONTROL_UNIT - Behavioral
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
use WORK.myTypes.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL_UNIT is
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
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

signal pipe_1_out: std_logic_vector(58 downto 0);
signal pipe_2_out: std_logic_vector(11 downto 0);

signal stage_1_ctrl_word: std_logic_vector(4 downto 0);
signal stage_2_ctrl_word: std_logic_vector(46 downto 0);
signal stage_3_ctrl_word: std_logic_vector(7 downto 0);
signal stage_4_ctrl_word: std_logic_vector(3 downto 0);

signal CONTROL_WORD, FLUSH_CONTROL_WORD: std_logic_vector(63 downto 0); --TMP_CTRL_WORD.

constant RD1        : integer:= 63;
constant RF_SEL_1_B0: integer:= 58;
constant RF_SEL_1_B1: integer:= 57;
constant RM         : integer:= 11;
constant WB_INT     : integer:= 2;
constant WB_FP      : integer:= 1;
constant WB_DOUBLE  : integer:= 0;

component Register_Generic_rst is
    generic (N: integer:= 64);
    port (data_in: in std_logic_vector(N-1 downto 0);
          clk:     in std_logic;
          rst:     in std_logic;
          en:      in std_logic;
          data_out: out std_logic_vector(N-1 downto 0));
end component;
--component register_generic_async_wr is
--    generic (N: integer:= 64);
--    port (data_in: in std_logic_vector(N-1 downto 0);
--          clk:     in std_logic;
--          rst:     in std_logic;
--          en:      in std_logic;
--          data_out: out std_logic_vector(N-1 downto 0));
--end component;
begin
    process(OPCODE, FUNC)
    begin 
        case OPCODE is
            when JTYPE_J =>
                CONTROL_WORD <= "0011100000110100000100000000000100000000000000000001000000010000";
            when JTYPE_JAL =>
                CONTROL_WORD <= "0011100000110100000100000000000100000000000000001011000000011100";
            when ITYPE_BEQZ =>
                CONTROL_WORD <= "1001100000101100000100000000000100000000000000000001000000010000";
            when ITYPE_BNEZ =>
                CONTROL_WORD <= "1001100000110000000100000000000100000000000000000001000000010000";
            when ITYPE_BFPT =>  
                CONTROL_WORD <= "0001100000101000000100000000000100000000000000000001000000010000";
            when ITYPE_BFPF =>
                CONTROL_WORD <= "0001100000100100000100000000000100000000000000000001000000010000";
            when ITYPE_ADDI =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001000000011100";
            when ITYPE_ADDUI =>
                CONTROL_WORD <= "1000100001100000000100000000000100000000000000000001000000011100";
            when ITYPE_SUBI =>
                CONTROL_WORD <= "1001100001100000000110000000000100000000000000000001000000011100";
            when ITYPE_SUBUI =>
                CONTROL_WORD <= "1000100001100000000110000000000100000000000000000001000000011100";
            when ITYPE_ANDI =>
                CONTROL_WORD <= "1000100001100000000100000000000011000000000000000001000000011100";
            when ITYPE_ORI =>
                CONTROL_WORD <= "1000100001100000000100001000000011000000000000000001000000011100";
            when ITYPE_XORI =>
                CONTROL_WORD <= "1000100001100000000100010000000011000000000000000001000000011100";
            when ITYPE_LHI =>
                CONTROL_WORD <= "0001100001100000000000000000000000000000000000001111000001111100";
            when ITYPE_JR =>
                CONTROL_WORD <= "1100100001110100000100000000000100000000000000000000000000000000";
            when ITYPE_JALR =>
                CONTROL_WORD <= "1100100000110100000100000000000000000000000000001011000000011100";
            when ITYPE_SLLI =>
                CONTROL_WORD <= "1000100001100000000100000000000010000000000000000001000000011100";   
            when ITYPE_NOP =>
                CONTROL_WORD <= "0000000000000000000000000000000000000000000000000000000000000000";     
            when ITYPE_SRLI =>
                CONTROL_WORD <= "1000100001100000000100000001000010000000000000000001000000011100";
            when ITYPE_SRAI =>
                CONTROL_WORD <= "1000100001100000000100000010000010000000000000000001000000011100";
            when ITYPE_SEQI =>
                CONTROL_WORD <= "1001100001100000000100000000001000000000000000001101000000011100"; 
            when ITYPE_SNEI =>
                CONTROL_WORD <= "1001100001100000000100000000010000000000000000001101000000011100";
            when ITYPE_SLTI =>
                CONTROL_WORD <= "1001100001100000000100000000101000000000000000001101000000011100";
            when ITYPE_SGTI =>
                CONTROL_WORD <= "1001100001100000000100000000011000000000000000001101000000011100";
            when ITYPE_SLEI =>
                CONTROL_WORD <= "1001100001100000000100000000110000000000000000001101000000011100";
            when ITYPE_SGEI =>
                CONTROL_WORD <= "1001100001100000000100000000100000000000000000001101000000011100";    
            when ITYPE_LB =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100010010100";
            when ITYPE_LH =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100000110100";    
            when ITYPE_LW =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100000010100"; 
            when ITYPE_LBU =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100010110100";    
            when ITYPE_LHU =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100001010100";
            when ITYPE_LF =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001100000010010";
            when ITYPE_LD =>
                CONTROL_WORD <= "1001100001100000000100000000000100000000000000000001101000010001";         
            when ITYPE_SB =>
                CONTROL_WORD <= "1101100001100000000100000000000100000000000000000001010011010000";
            when ITYPE_SH =>
                CONTROL_WORD <= "1101100001100000000100000000000100000000000000000001010011110000";
            when ITYPE_SW =>
                CONTROL_WORD <= "1101100001100000000100000000000100000000000000000001010000010000"; 
            when ITYPE_SF =>
                CONTROL_WORD <= "1101100011100000000100000000000100000000000000000001010000010000";
            when ITYPE_SD =>
                CONTROL_WORD <= "1101100101100000000100000000000100000000000000000001010100010000";
            when ITYPE_SLTUI =>
                CONTROL_WORD <= "1000100001100000000100000000101000000000000000001101000000011100";     
            when ITYPE_SGTUI =>
                CONTROL_WORD <= "1000100001100000000100000000011000000000000000001101000000011100";    
            when ITYPE_SLEUI =>
                CONTROL_WORD <= "1000100001100000000100000000110000000000000000001101000000011100";    
            when ITYPE_SGEUI =>
                CONTROL_WORD <= "1000100001100000000100000000100000000000000000001101000000011100";  
            when ITYPE_RSLI =>
                CONTROL_WORD <= "1000100001100000000100000011000010000000000000000001000000011100";
            when ITYPE_RSRI =>
                CONTROL_WORD <= "1000100001100000000100000100000010000000000000000001000000011100";
            when ITYPE_NANDI =>
                CONTROL_WORD <= "1000100001100000000100100000000011000000000000000001000000011100";
            when ITYPE_NORI =>
                CONTROL_WORD <= "1000100001100000000100011000000011000000000000000001000000011100";
            when ITYPE_XNORI =>
                CONTROL_WORD <= "1000100001100000000100101000000011000000000000000001000000011100";
                
            when R_INTEGER_TYPE =>
                case FUNC is
                    when RTYPE_INT_SLL =>
                        CONTROL_WORD <= "1100100001000000000100000000000010000000000000000001000000011100";
                    when RTYPE_INT_SRL =>
                        CONTROL_WORD <= "1100100001000000000100000001000010000000000000000001000000011100";
                    when RTYPE_INT_SRA =>
                        CONTROL_WORD <= "1100100001000000000100000010000010000000000000000001000000011100";
                    when RTYPE_INT_ADD =>
                        CONTROL_WORD <= "1100100001000000000100000000000100000000000000000001000000011100";
                    when RTYPE_INT_ADDU =>
                        CONTROL_WORD <= "1100100001000000000100000000000100000000000000000001000000011100";
                    when RTYPE_INT_SUB =>
                        CONTROL_WORD <= "1100100001000000000110000000000100000000000000000001000000011100";
                    when RTYPE_INT_SUBU =>
                        CONTROL_WORD <= "1100100001000000000110000000000100000000000000000001000000011100";
                    when RTYPE_INT_AND =>
                        CONTROL_WORD <= "1100100001000000000100000000000011000000000000000001000000011100";
                    when RTYPE_INT_OR =>
                        CONTROL_WORD <= "1100100001000000000100001000000011000000000000000001000000011100";
                    when RTYPE_INT_XOR =>
                        CONTROL_WORD <= "1100100001000000000100010000000011000000000000000001000000011100";
                    when RTYPE_INT_SEQ =>
                        CONTROL_WORD <= "1100100001000000000100000000001000000000000000001101000000011100";
                    when RTYPE_INT_SNE =>
                        CONTROL_WORD <= "1100100001000000000100000000010000000000000000001101000000011100";
                    when RTYPE_INT_SLT =>
                        CONTROL_WORD <= "1100100001000000000100000000101000000000000000001101000000011100";
                    when RTYPE_INT_SGT =>
                        CONTROL_WORD <= "1100100001000000000100000000011000000000000000001101000000011100";
                    when RTYPE_INT_SLE =>
                        CONTROL_WORD <= "1100100001000000000100000000110000000000000000001101000000011100";
                    when RTYPE_INT_SGE =>
                        CONTROL_WORD <= "1100100001000000000100000000100000000000000000001101000000011100";
                    when RTYPE_INT_MOVF =>
                        CONTROL_WORD <= "1000101001000000000000000000000000000000000000001001000000011010";
                    when RTYPE_INT_MOVD =>
                        CONTROL_WORD <= "1000110001000000000000000000000000000000000000001001001000011001";
                    when RTYPE_INT_MOVFP2I =>
                        CONTROL_WORD <= "1000101001000000000000000000000000000000000000001001000000011100";
                    when RTYPE_INT_MOVI2FP =>
                        CONTROL_WORD <= "1000100001000000000000000000000000000000000000001001000000011010";
                    when RTYPE_INT_SLTU =>
                        CONTROL_WORD <= "1100100001000000000100000000101000000000000000001101000000011100";
                    when RTYPE_INT_SGTU =>
                        CONTROL_WORD <= "1100100001000000000100000000011000000000000000001101000000011100";
                    when RTYPE_INT_SLEU =>
                        CONTROL_WORD <= "1100100001000000000100000000110000000000000000001101000000011100";
                    when RTYPE_INT_SGEU =>
                        CONTROL_WORD <= "1100100001000000000100000000100000000000000000001101000000011100";
                    when RTYPE_INT_RSL =>
                        CONTROL_WORD <="1100100001000000000100000011000010000000000000000001000000011100";
                    when RTYPE_INT_RSR =>
                        CONTROL_WORD <= "1100100001000000000100000100000010000000000000000001000000011100";
                    when RTYPE_INT_NAND =>
                        CONTROL_WORD <= "1100100001000000000100100000000011000000000000000001000000011100";
                    when RTYPE_INT_NOR =>
                        CONTROL_WORD <= "1100100001000000000100011000000011000000000000000001000000011100";
                    when RTYPE_INT_XNOR =>
                        CONTROL_WORD <= "1100100001000000000100101000000011000000000000000001000000011100";
                    when others =>
                        CONTROL_WORD <= (others => '0');
                end case;
                
                --FLOATING POINT 
            when R_FLOAT_TYPE =>
                case FUNC is
                    when RTYPE_FLOAT_ADDF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000100001100000000101000000011010";
                    when RTYPE_FLOAT_SUBF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000110001100000000101000000011010";
                    when RTYPE_FLOAT_MULTF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000100000100000000101000000011010";
                    when RTYPE_FLOAT_DIVF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000100001000000000101000000011010";
                    when RTYPE_FLOAT_ADDD =>
                        CONTROL_WORD <= "1100110101000000000000000000000000000000010000010111000000011001";
                    when RTYPE_FLOAT_SUBD =>
                        CONTROL_WORD <= "1100110101000000000000000000000000000000011000010111000000011001";
                    when RTYPE_FLOAT_MULTD =>
                        CONTROL_WORD <= "1100110101000000000000000000000000000000010000100111000000011001";
                    when RTYPE_FLOAT_DIVD =>
                        CONTROL_WORD <= "1100110101000000000000000000000000000000010000110111000000011001";
                    when RTYPE_FLOAT_CVTF2D =>
                        CONTROL_WORD <= "1000101001000000101000000000000000000000000000001001000000011001";
                    when RTYPE_FLOAT_CVTF2I =>
                        CONTROL_WORD <= "1000101001000001011000000000000000000000000000001001000000011100";
                    when RTYPE_FLOAT_CVTD2F =>
                        CONTROL_WORD <= "1000110001000000110000000000000000000000000000001001000000011010";
                    when RTYPE_FLOAT_CVTD2I =>
                        CONTROL_WORD <= "1000110001000001100000000000000000000000000000001001000000011100";
                    when RTYPE_FLOAT_CVTI2F =>
                        CONTROL_WORD <= "1000100001000001001000000000000000000000000000001001000000011010";
                    when RTYPE_FLOAT_CVTI2D =>
                        CONTROL_WORD <= "1000100001000001010000000000000000000000000000001001000000011001";    
                    when RTYPE_FLOAT_MULT =>
                        CONTROL_WORD <= "1100100001000000000101000000000001000000000000000001000000011100";
                    when RTYPE_FLOAT_DIV =>
                        CONTROL_WORD <= "1100100001000011001000000000000000100001000000000011000000011100";
                    when RTYPE_FLOAT_EQF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000110010000000000001000000000000";
                    when RTYPE_FLOAT_NEF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000110100000000000001000000000000";
                    when RTYPE_FLOAT_LTF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000111010000000000001000000000000";
                    when RTYPE_FLOAT_GTF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000110110000000000001000000000000";
                    when RTYPE_FLOAT_LEF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000111100000000000001000000000000";
                    when RTYPE_FLOAT_GEF =>
                        CONTROL_WORD <= "1100101011000000000000000000000000111000000000000001000000000000";   
                    when RTYPE_FLOAT_MULTU =>
                        CONTROL_WORD <= "1100100001000000000100000000000001000000000000000001000000011100";
                    when RTYPE_FLOAT_DIVU =>
                        CONTROL_WORD <= "1100100001000001001000000000000000100001000000000011000000011100";
                    
                    when others =>
                        CONTROL_WORD <= (others => '0');
                end case;
                    
            when others =>
                CONTROL_WORD <= (others => '0');
        end case;
    end process;

FLUSH_CONTROL_WORD <= CONTROL_WORD when FLUSH = '0' else
                      (others => '0');



PIPE_1: Register_Generic_rst generic map(59)
                             port map(FLUSH_CONTROL_WORD(58 downto 0), clk, rst, '1', pipe_1_out);
PIPE_2: Register_Generic_rst generic map(12)
                             port map(pipe_1_out(11 downto 0), clk, rst, '1', pipe_2_out);
PIPE_3: Register_Generic_rst generic map(4)
                             port map(pipe_2_out(3 downto 0), clk, rst, '1', stage_4_ctrl_word);
                             
stage_1_ctrl_word <= FLUSH_CONTROL_WORD(63 downto 59);     --ID STAGE.                        
stage_2_ctrl_word <= pipe_1_out(58 downto 12);             --EX STAGE.
stage_3_ctrl_word <= pipe_2_out(11 downto 4);              --MEM STAGE.

CTRL_WORD <= stage_1_ctrl_word&stage_2_ctrl_word&stage_3_ctrl_word&stage_4_ctrl_word;

--CLOCK ENABLE FOR RF.
CLK_EN_RF(0) <= ((FLUSH_CONTROL_WORD(RF_SEL_1_B0) nor FLUSH_CONTROL_WORD(RF_SEL_1_B1)) and FLUSH_CONTROL_WORD(RD1)) or RST;
CLK_EN_RF(1) <= (((not FLUSH_CONTROL_WORD(RF_SEL_1_B0)) and FLUSH_CONTROL_WORD(RF_SEL_1_B1)) and FLUSH_CONTROL_WORD(RD1)) or RST;
CLK_EN_RF(2) <= ((FLUSH_CONTROL_WORD(RF_SEL_1_B0) and (not FLUSH_CONTROL_WORD(RF_SEL_1_B1))) and FLUSH_CONTROL_WORD(RD1)) or RST;

--OUT WR SIGNALS.
ALIGN_CTRL_EX    <= pipe_1_out(7 downto 5);
WM_EX            <= pipe_1_out(10); 
WR_EX(WB_INT)    <= pipe_1_out(WB_INT); 
WR_EX(WB_FP)     <= pipe_1_out(WB_FP);
WR_EX(WB_DOUBLE) <= pipe_1_out(WB_DOUBLE);
end Behavioral;
