----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.08.2020 20:26:03
-- Design Name: 
-- Module Name: Floating_point_single_precision_to_double - Behavioral
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

entity Floating_point_single_precision_to_double is
    port (fp_single: in std_logic_vector(31 downto 0);
          fp_double: out std_logic_vector(63 downto 0));
end Floating_point_single_precision_to_double;

architecture Behavioral of Floating_point_single_precision_to_double is
signal extended_E: std_logic_vector(10 downto 0);
signal extended_M: std_logic_vector(51 downto 0);
begin
--Attch sign bit.
fp_double(63) <= fp_single(31);
--Extend MSB mantissa.
extended_M(51 downto 29) <= fp_single (22 downto 0);
extended_M(28 downto 0) <= (others =>'0');
fp_double (51 downto 0) <= extended_M;
--Extend Exponent and convert in double biased.
extended_E(7 downto 0) <= fp_single(30 downto 23);
extended_E(10 downto 8) <= (others =>'0');

fp_double (62 downto 52) <= (others =>'0') when fp_single(30 downto 0) = "0000000000000000000000000000000" else
                            std_logic_vector(unsigned(extended_E) + 896);
                             -- Ebiased(double) =  E(biased(single) - 127 + 1023;
end Behavioral;
