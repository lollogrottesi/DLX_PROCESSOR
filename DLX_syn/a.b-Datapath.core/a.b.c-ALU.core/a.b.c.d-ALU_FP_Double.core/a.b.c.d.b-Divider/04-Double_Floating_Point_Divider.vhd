----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.08.2020 17:25:39
-- Design Name: 
-- Module Name: Double_Floating_Point_Divider - Structural
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

entity Double_Floating_Point_Divider is
 port (   FP_a: in std_logic_vector(63 downto 0);
          FP_b: in std_logic_vector(63 downto 0);
          FP_z: out std_logic_vector(63 downto 0));
end Double_Floating_Point_Divider;

architecture Structural of Double_Floating_Point_Divider is

component Exponent_subctrator_fp_double is
    port(E_a: in std_logic_vector(10 downto 0);
         E_b: in std_logic_vector(10 downto 0);
         E_out: out std_logic_vector(10 downto 0));
end component;

component Mantissa_double_divider is
    --Format: 0.1mantissa => '0' in MSB + hidden bit + 52 bit mantissa = 54 bit.
    port (M_a: in std_logic_vector(107 downto 0);
          M_b: in std_logic_vector(53 downto 0);
          M_q: out std_logic_vector(53 downto 0));
end component;

component Generic_normalization_double_DIV_unit is
    generic (N: integer:= 8);
    port (M: in std_logic_vector(N-1 downto 0);
          E: in std_logic_vector (10 downto 0);
          norma_M: out std_logic_vector(51 downto 0);
          norma_E: out std_logic_vector(10 downto 0));
end component;

signal pre_division_M_b , post_division_M, pre_normalization_M : std_logic_vector (53 downto 0);
signal pre_division_M_a : std_logic_vector (107 downto 0);
signal post_sub_E, post_norma_E: std_logic_vector(10 downto 0);
signal post_norma_M: std_logic_vector (51 downto 0);
signal sign_bit_z : std_logic;
begin
pre_division_M_a(107) <= '0'; 
pre_division_M_a(106) <= '0' when FP_a(62 downto 52) = "00000000000" else 
                         '1';
pre_division_M_a(105 downto 54) <= FP_a(51 downto 0);
pre_division_M_a(53 downto 0) <= (others =>'0');

pre_division_M_b(51 downto 0) <= FP_b(51 downto 0);
pre_division_M_b(53) <= '0';
pre_division_M_b(52) <= '0' when FP_b(62 downto 52) = "00000000000" else 
                        '1';
Mantissa_divider_unit: Mantissa_double_divider port map (pre_division_M_a, pre_division_M_b, post_division_M);                        
exponent_subctractor_unit: Exponent_subctrator_fp_double port map (FP_a(62 downto 52), FP_b(62 downto 52), post_sub_E);

pre_normalization_M <= post_division_M;

postnormalization: Generic_normalization_double_DIV_unit generic map(54)
                                                         port map (pre_normalization_M, post_sub_E, post_norma_M, post_norma_E);
                                                         
sign_bit_z <= FP_a(63) xor FP_b(63);

FP_z(63 downto 52) <=  FP_a(31)&"11111111111" when FP_b(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000" else
                       sign_bit_z&post_norma_E;
FP_z(51 downto 0)  <=  (others=>'0')          when FP_b(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000" else 
                       post_norma_M(51 downto 0);                                                             
                                                                                                               
end Structural;
