----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.08.2020 09:56:26
-- Design Name: 
-- Module Name: Double_Floating_Point_Multiplier - Structural
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

entity Double_Floating_Point_Multiplier is
    port (FP_a: in std_logic_vector(63 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(63 downto 0);
          overflow: out std_logic;
          FP_z: out std_logic_vector(63 downto 0));
end Double_Floating_Point_Multiplier;

architecture Structural of Double_Floating_Point_Multiplier is

component Generic_normalization_double_MUL_unit is
    generic (N: integer:= 8);
    port (M: in std_logic_vector(N-1 downto 0);
          E: in std_logic_vector (10 downto 0);
          norma_M: out std_logic_vector(51 downto 0);
          norma_E: out std_logic_vector(10 downto 0));
end component;

component Mantissa_Double_multiplier is
    --Mantissa = 1 bit sign + 1 hidden bit + 52 bit module = 54.
    port ( M_a : in std_logic_vector (53 downto 0);
           M_b : in std_logic_vector (53 downto 0);
           M_out: out std_logic_vector (106 downto 0));
end component;

component Exponent_Double_Adder is
    port (E_a: in std_logic_vector(10 downto 0);
          E_b: in std_logic_vector(10 downto 0);
          E_out: out std_logic_vector(10 downto 0);
          overflow: out std_logic);
end component;

signal post_addition_E: std_logic_vector (10 downto 0);
signal pre_mul_M_a, pre_mul_M_b: std_logic_vector (53 downto 0);
signal post_mul_M: std_logic_vector (106 downto 0);
signal prenormalization_M : std_logic_vector(105 downto 0);
signal tmp_FP_z: std_logic_vector(62 downto 0); --Do not consider the sign.
signal tmp_overflow: std_logic;
begin
--------------------------------Mantissa multiplication and exponent addition stage------------------------------------------------------------
pre_mul_M_a(53) <= FP_a(63);                                        --Append sign.
pre_mul_M_a(51 downto 0) <= FP_a(51 downto 0);                      --Append module.
pre_mul_M_a(52) <= '0' when FP_a(62 downto 52)= "00000000000" else  --Append hidden bit.
                   '1';
pre_mul_M_b(53) <= FP_b(63);
pre_mul_M_b(51 downto 0) <= FP_b(51 downto 0);
pre_mul_M_b(52) <= '0' when FP_b(62 downto 52)= "00000000000" else
                   '1';
Exponent_addition_stage: Exponent_Double_Adder port map (FP_a(62 downto 52), FP_b(62 downto 52), post_addition_E, tmp_overflow);
Mantissa_multiplication_stage: Mantissa_Double_multiplier port map (pre_mul_M_a, pre_mul_M_b, post_mul_M);
-----------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------PostNormalization stage---------------------------------------------------------------------------
prenormalization_M <= post_mul_M(105 downto 0); --Drop sign.
normalization_stage: Generic_normalization_double_MUL_unit generic map (106)
                                                           port map (prenormalization_M, post_addition_E ,tmp_FP_z(51 downto 0), tmp_FP_z(62 downto 52));
-----------------------------------------------------------------------------------------------------------------------------------------------
--If all zero prenormalization_M out is all zero.
FP_z  <= (others=>'0') when prenormalization_M = "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" else
         post_mul_M(106)&tmp_FP_z;       --Sign&Exp&Mantissa.
         
overflow <= tmp_overflow;               --Overflow when summing exponent.
end Structural;
