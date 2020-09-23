library ieee;
use ieee.std_logic_1164.all;

package myTypes is

-- Control unit input sizes
    constant OP_CODE_SIZE : integer :=  6;                                              -- OPCODE field size
    constant FUNC_SIZE    : integer :=  11;                                             -- FUNC field size

-- R-Type instruction -> FUNC field
    constant RTYPE_INT_SLL : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000000100";    
    constant RTYPE_INT_SRL : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000000110"; 
    constant RTYPE_INT_SRA : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000000111"; 
    constant RTYPE_INT_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000100000"; 
    constant RTYPE_INT_ADDU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000100001"; 
    constant RTYPE_INT_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000100010"; 
    constant RTYPE_INT_SUBU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000100011"; 
    constant RTYPE_INT_AND : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000100100"; 
    constant RTYPE_INT_OR : std_logic_vector(FUNC_SIZE - 1 downto 0)     :=  "00000100101";    
    constant RTYPE_INT_XOR : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000100110"; 
    constant RTYPE_INT_SEQ : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101000"; 
    constant RTYPE_INT_SNE : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101001"; 
    constant RTYPE_INT_SLT : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101010"; 
    constant RTYPE_INT_SGT : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101011"; 
    constant RTYPE_INT_SLE : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101100"; 
    constant RTYPE_INT_SGE : std_logic_vector(FUNC_SIZE - 1 downto 0)    :=  "00000101101"; 
    constant RTYPE_INT_MOVI2S : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000110000";    
    constant RTYPE_INT_MOVS2I : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000110001"; 
    constant RTYPE_INT_MOVF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000110010"; 
    constant RTYPE_INT_MOVD : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000110011"; 
    constant RTYPE_INT_MOVFP2I : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000110100";
    constant RTYPE_INT_MOVI2FP : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000110101"; 
    constant RTYPE_INT_MOVI2T : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000110110"; 
    constant RTYPE_INT_MOVT2I : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000110111";
     
    constant RTYPE_INT_SLTU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000111010";    
    constant RTYPE_INT_SGTU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000111011"; 
    constant RTYPE_INT_SLEU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000111100"; 
    constant RTYPE_INT_SGEU : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000111101"; 
    
    constant RTYPE_INT_RSL  : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00001000000";
    constant RTYPE_INT_RSR  : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00001000001";
    constant RTYPE_INT_NAND  : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00001000010";
    constant RTYPE_INT_NOR  : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00001000011";
    constant RTYPE_INT_XNOR  : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00001000100";
        --Float FUNC.
    constant RTYPE_FLOAT_ADDF : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000000"; 
    constant RTYPE_FLOAT_SUBF : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000001"; 
    constant RTYPE_FLOAT_MULTF : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000010"; 
    constant RTYPE_FLOAT_DIVF : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000011"; 
    constant RTYPE_FLOAT_ADDD : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000100"; 
    constant RTYPE_FLOAT_SUBD : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000101"; 
    constant RTYPE_FLOAT_MULTD : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000110"; 
    constant RTYPE_FLOAT_DIVD : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000000111"; 
    constant RTYPE_FLOAT_CVTF2D : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001000"; 
    constant RTYPE_FLOAT_CVTF2I : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001001"; 
    constant RTYPE_FLOAT_CVTD2F : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001010"; 
    constant RTYPE_FLOAT_CVTD2I : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001011"; 
    constant RTYPE_FLOAT_CVTI2F : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001100"; 
    constant RTYPE_FLOAT_CVTI2D : std_logic_vector(FUNC_SIZE - 1 downto 0):=  "00000001101"; 
    constant RTYPE_FLOAT_MULT : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000001110"; 
    constant RTYPE_FLOAT_DIV : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000001111"; 
    constant RTYPE_FLOAT_EQF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010000"; 
    constant RTYPE_FLOAT_NEF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010001"; 
    constant RTYPE_FLOAT_LTF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010010"; 
    constant RTYPE_FLOAT_GTF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010011"; 
    constant RTYPE_FLOAT_LEF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010100"; 
    constant RTYPE_FLOAT_GEF : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000010101"; 
    constant RTYPE_FLOAT_MULTU : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000010110"; 
    constant RTYPE_FLOAT_DIVU : std_logic_vector(FUNC_SIZE - 1 downto 0)  :=  "00000010111"; 
    constant RTYPE_FLOAT_EQD : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011000"; 
    constant RTYPE_FLOAT_NED : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011001"; 
    constant RTYPE_FLOAT_LTD : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011010"; 
    constant RTYPE_FLOAT_GTD : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011011"; 
    constant RTYPE_FLOAT_LED : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011100"; 
    constant RTYPE_FLOAT_GED : std_logic_vector(FUNC_SIZE - 1 downto 0)   :=  "00000011101"; 
    
-- R-Type instruction -> OPCODE field
    constant R_INTEGER_TYPE :  std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000000";          --register-to-register integer operation
    constant R_FLOAT_TYPE   : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "000001";          --register-to-register float operation
    
-- J-Type instruction -> OPCODE field
    constant JTYPE_J : std_logic_vector(OP_CODE_SIZE - 1 downto 0)    :=  "000010";
    constant JTYPE_JAL : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "000011";
    
-- I-Type instruction -> OPCODE field
    constant ITYPE_BEQZ : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000100";
    constant ITYPE_BNEZ : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000101";
    constant ITYPE_BFPT : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000110";
    constant ITYPE_BFPF : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000111";
    constant ITYPE_ADDI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001000";
    constant ITYPE_ADDUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "001001";
    constant ITYPE_SUBI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001010";
    constant ITYPE_SUBUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "001011";
    constant ITYPE_ANDI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001100";
    constant ITYPE_ORI : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "001101";
    constant ITYPE_XORI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001110";
    constant ITYPE_LHI : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "001111";
    constant ITYPE_RFE : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "010000";
    constant ITYPE_TRAP : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010001";
    constant ITYPE_JR : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "010010";
    constant ITYPE_JALR : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010011";
    constant ITYPE_SLLI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010100";
    constant ITYPE_NOP : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "010101";
    constant ITYPE_SRLI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010110";
    constant ITYPE_SRAI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010111";
    constant ITYPE_SEQI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011000";
    constant ITYPE_SNEI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011001";
    constant ITYPE_SLTI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011010";
    constant ITYPE_SGTI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011011";
    constant ITYPE_SLEI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011100";
    constant ITYPE_SGEI : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011101";
    
    constant ITYPE_LB : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "100000";
    constant ITYPE_LH : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "100001";
    constant ITYPE_LW : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "100011";
    constant ITYPE_LBU : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "100100";
    constant ITYPE_LHU : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "100101";
    constant ITYPE_LF : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "100110";
    constant ITYPE_LD : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "100111";
    constant ITYPE_SB : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "101000";
    constant ITYPE_SH : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "101001";
    
    constant ITYPE_SW : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "101011";
    constant ITYPE_SF : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "101110";
    constant ITYPE_SD : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "101111";
    
    constant ITYPE_ITLB : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "111000";
    constant ITYPE_SLTUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "111010";
    constant ITYPE_SGTUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "111011";
    constant ITYPE_SLEUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "111100";
    constant ITYPE_SGEUI : std_logic_vector(OP_CODE_SIZE - 1 downto 0):=  "111101";

    constant ITYPE_RSLI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "110000";
    constant ITYPE_RSRI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "110001";
    constant ITYPE_NANDI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "110010";
    constant ITYPE_NORI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0)   :=  "110011";
    constant ITYPE_XNORI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0)  :=  "110100";
end myTypes;