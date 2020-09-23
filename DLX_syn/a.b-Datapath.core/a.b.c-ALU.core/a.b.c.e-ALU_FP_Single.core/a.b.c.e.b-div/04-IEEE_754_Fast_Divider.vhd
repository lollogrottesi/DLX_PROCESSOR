----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2020 12:19:29
-- Design Name: 
-- Module Name: IEEE_754_Fast_Divider - Structural
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

entity IEEE_754_Fast_Divider is
 port (   FP_a: in std_logic_vector(31 downto 0);
          FP_b: in std_logic_vector(31 downto 0);
          FP_z: out std_logic_vector(31 downto 0));
end IEEE_754_Fast_Divider;

architecture Structural of IEEE_754_Fast_Divider is

component Exponent_subctrator_fp_single is
    port(E_a: in std_logic_vector(7 downto 0);
         E_b: in std_logic_vector(7 downto 0);
         E_out: out std_logic_vector(7 downto 0));
end component;

component Mantissa_divider is
    port (M_a: in std_logic_vector(49 downto 0);
          M_b: in std_logic_vector(24 downto 0);
          M_q: out std_logic_vector(24 downto 0));
end component;

component postnormalization_DIV_unit is
    port (E: in std_logic_vector(7 downto 0); --E is unbiased.
          --23 bit mantissa + 1 hidden bit + 1 guardian bit = 25 bit.
          M: in std_logic_vector(24 downto 0);--Sign bit is apart.
          norma_M: out std_logic_vector(24 downto 0);
          norma_E: out std_logic_vector(7 downto 0));
end component;

signal pre_division_M_b , post_division_M, pre_normalization_M : std_logic_vector (24 downto 0);
signal pre_division_M_a : std_logic_vector (49 downto 0);
signal post_sub_E, post_norma_E: std_logic_vector(7 downto 0);
signal post_norma_M: std_logic_vector (24 downto 0);
signal sign_bit_z : std_logic;
begin


pre_division_M_a(49) <= '0'; 
pre_division_M_a(48) <= '0' when FP_a(30 downto 23) = "00000000" else 
                        '1';
pre_division_M_a(47 downto 25) <= FP_a(22 downto 0);
pre_division_M_a(24 downto 0) <= (others =>'0');

pre_division_M_b(22 downto 0) <= FP_b(22 downto 0);
pre_division_M_b(24) <= '0';
pre_division_M_b(23) <= '0' when FP_b(30 downto 23) = "00000000" else 
                        '1';
                        
Mantissa_divider_unit: Mantissa_divider port map (pre_division_M_a, pre_division_M_b, post_division_M);                        
exponent_subctractor_unit: Exponent_subctrator_fp_single port map (FP_a(30 downto 23), FP_b(30 downto 23), post_sub_E);

pre_normalization_M <= post_division_M;

postnormalization: postnormalization_DIV_unit port map (post_sub_E, pre_normalization_M, post_norma_M, post_norma_E);

sign_bit_z <= FP_a(31) xor FP_b(31);
--FP_z(31 downto 23) <= sign_bit_z&post_norma_E;
--FP_z(22 downto 0) <= post_norma_M(23 downto 1);

FP_z(31 downto 23) <=  FP_a(31)&"11111111" when FP_b(30 downto 0) = "0000000000000000000000000000000" else
                       sign_bit_z&post_norma_E;
FP_z(22 downto 0)  <=  (others=>'0')       when FP_b(30 downto 0) = "0000000000000000000000000000000" else 
                       post_norma_M(23 downto 1);               
end Structural;
