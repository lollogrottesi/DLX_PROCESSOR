----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2020 17:58:57
-- Design Name: 
-- Module Name: integer_ALU - Architectural
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

entity integer_ALU is
    generic (constant N: natural := 64);
    Port (
        OPA, OPB     : in std_logic_vector(N-1 downto 0);  -- 2 inputs N-bit
        ADD_SUB, sign_usign_n, ENABLE : in std_logic; -- operation selectors
        logic_control, shifter_control, comparator_control, out_control : in std_logic_vector(2 downto 0); -- operation and otput selectors
        ALU_Out   : out std_logic_vector(N-1 downto 0);
        cmp_out : out std_logic); -- 1 output N-bit
end integer_ALU;

architecture structural of integer_ALU is
    signal OPA_32bit, OPB_32bit, ALU_out_32bit, A, B : std_logic_vector(N/2-1 downto 0);
    signal ADD_SUB_res, logic_res, shifter_res, mul_res : std_logic_vector(N/2-1 downto 0);
    signal cout_tmp, ov_tmp : std_logic;
    component shifter is
        Generic (N: integer:= 32);
        port(dataIN : in std_logic_vector(N-1 downto 0);  
            positions: in std_logic_vector(N-1 downto 0);
            SEL : in std_logic_vector(2 downto 0);  
            dataOUT : out std_logic_vector(N-1 downto 0));  
    end component;   
    
    component integer_comparator is
        Generic (N: integer:= 32);
        Port (A: in std_logic_vector (N-1 downto 0);
              B: in std_logic_vector (N-1 downto 0);
              signed_unsigned_n: in std_logic;--1-> signed comparator, 0-> unsigned.
              SEL  : in std_logic_vector (2 downto 0);
              logic_output: out std_logic);
    end component;

    component Multiplier_unit is
        port (A: in std_logic_vector(31 downto 0);
              B: in std_logic_vector (31 downto 0);
              sign_unisgn: in std_logic;
              y: out std_logic_vector(31 downto 0));
    end component;
    
    component  Adder_subctractor is
    generic (N : integer := 5);--N is number of level in the tree.
        port (A: IN std_logic_vector((2**N)-1 downto 0);
              B: IN std_logic_vector((2**N)-1 downto 0); 
              add_sub: IN std_logic;
              cout: out std_logic;
              overflow: out std_logic;
              S: OUT std_logic_vector((2**N)-1 downto 0));
    end component;
    
    component logic_unit is
        generic (N: integer := 32);
        Port (
        A, B     : in  STD_LOGIC_VECTOR(N-1 downto 0);  
        logic_sel  : in  STD_LOGIC_VECTOR(2 downto 0);
        logic_out   : out  STD_LOGIC_VECTOR(N-1 downto 0));
    end component;
    
begin

shifter_hw: shifter generic map (N/2)
                 port map (A, B, shifter_control, shifter_res);     
                 
logic_hw: logic_unit generic map (N/2)
                 port map (A, B, logic_control, logic_res);
                 
comparator_hw: integer_comparator generic map (N/2)
                 port map (A, B, sign_usign_n, comparator_control, cmp_out);

MUL_hw: multiplier_unit 
                 port map (A, B, sign_usign_n, mul_res);
                 
A_S_hw: Adder_subctractor generic map (5)
                 port map (A, B, add_sub, cout_tmp, ov_tmp, add_sub_res);

OPA_32bit <= OPA(31 downto 0);

OPB_32bit <= OPB(31 downto 0);

ALU_out <= x"00000000"&ALU_out_32bit;

A <= OPA_32bit when ENABLE = '1' else
    (others => '0'); --to avoid switchin activity
B <= OPB_32bit when ENABLE = '1' else
    (others => '0'); --to avoid switchin activity
    
process(ADD_SUB_res, logic_res, shifter_res, mul_res, out_control)
    begin
        case out_control is 
             when "001" =>
                           ALU_out_32bit <= mul_res;
             when "010" =>
                           ALU_out_32bit <= shifter_res;
             when "011" =>
                           ALU_out_32bit <= logic_res; 
             when "100" =>
                           ALU_out_32bit <= ADD_SUB_res; 
            when others =>
                           ALU_out_32bit <= (others => '0');
    end case;
 end process;
 
end structural;
