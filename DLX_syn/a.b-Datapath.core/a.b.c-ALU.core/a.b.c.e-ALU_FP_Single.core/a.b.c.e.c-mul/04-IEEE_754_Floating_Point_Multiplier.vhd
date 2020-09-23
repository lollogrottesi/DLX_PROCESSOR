----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2020 12:07:35
-- Design Name: 
-- Module Name: IEEE_754_Floating_Point_Multiplier - Behavioral
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

entity IEEE_754_Floating_Point_Multiplier is
    port (FP_a: in std_logic_vector(31 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(31 downto 0);
          overflow: out std_logic;
          FP_z: out std_logic_vector(31 downto 0));
end IEEE_754_Floating_Point_Multiplier;

architecture Behavioral of IEEE_754_Floating_Point_Multiplier is

component Mantissa_multiplier_single is
    --Mantissa = 1 bit sign + 1 hidden bit + 23 bit module = 25.
    port ( M_a : in std_logic_vector (24 downto 0);
           M_b : in std_logic_vector (24 downto 0);
           M_out: out std_logic_vector (48 downto 0));
end component;

component Exponent_Adder_single is
    port (E_a: in std_logic_vector(7 downto 0);
          E_b: in std_logic_vector(7 downto 0);
          E_out: out std_logic_vector(7 downto 0);
          overflow: out std_logic);
end component;

component postnormalization_multiplier_unit_single is
   port ( E: in std_logic_vector(7 downto 0); 
          --2*23 bit mantissa + 2*1 hidden bit  = 48 bit.
          M: in std_logic_vector(47 downto 0);--Sign bit is apart.
          norma_M: out std_logic_vector(22 downto 0);
          norma_E: out std_logic_vector(7 downto 0));
end component;

signal post_addition_E: std_logic_vector (7 downto 0);
signal pre_mul_M_a, pre_mul_M_b: std_logic_vector (24 downto 0);
signal post_mul_M: std_logic_vector (48 downto 0);
signal prenormalization_M : std_logic_vector(47 downto 0);
signal tmp_FP_z: std_logic_vector(30 downto 0); --Do not consider the sign.
signal tmp_overflow: std_logic;
begin
--------------------------------Mantissa multiplication and exponent addition stage------------------------------------------------------------
pre_mul_M_a(24) <= FP_a(31);                                    --Append sign.
pre_mul_M_a(22 downto 0) <= FP_a(22 downto 0);                  --Append module.
pre_mul_M_a(23) <= '0' when FP_a(30 downto 23)= "00000000" else --Append hidden bit.
                   '1';
pre_mul_M_b(24) <= FP_b(31);
pre_mul_M_b(22 downto 0) <= FP_b(22 downto 0);
pre_mul_M_b(23) <= '0' when FP_b(30 downto 23)= "00000000" else
                   '1';
Exponent_addition_stage: Exponent_Adder_single port map (FP_a(30 downto 23), FP_b(30 downto 23), post_addition_E, tmp_overflow);
Mantissa_multiplication_stage: Mantissa_multiplier_single port map (pre_mul_M_a, pre_mul_M_b, post_mul_M);
-----------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------PostNormalization stage---------------------------------------------------------------------------
prenormalization_M <= post_mul_M(47 downto 0); --Drop sign.
normalization_stage: postnormalization_multiplier_unit_single port map (post_addition_E, prenormalization_M, tmp_FP_z(22 downto 0), tmp_FP_z(30 downto 23));
-----------------------------------------------------------------------------------------------------------------------------------------------
--If all zero prenormalization_M out is all zero.
FP_z  <= (others=>'0') when prenormalization_M = "000000000000000000000000000000000000000000000000" else
         post_mul_M(48)&tmp_FP_z;       --Sign&Exp&Mantissa.
overflow <= tmp_overflow;               --Overflow when summing exponent.
end Behavioral;
