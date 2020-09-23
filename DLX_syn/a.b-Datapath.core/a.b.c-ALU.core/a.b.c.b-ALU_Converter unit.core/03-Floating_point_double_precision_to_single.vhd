----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.08.2020 20:48:50
-- Design Name: 
-- Module Name: Floating_point_double_precision_to_single - Behavioral
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

entity Floating_point_double_precision_to_single is
    port (fp_double: in std_logic_vector(63 downto 0);
          fp_single: out std_logic_vector(31 downto 0));
end Floating_point_double_precision_to_single;

architecture Behavioral of Floating_point_double_precision_to_single is
signal exponent: std_logic_vector(10 downto 0);
begin
--Attch sign bit.
fp_single (31) <= fp_double (63);
--Convert Exponent.
exponent <= std_logic_vector(unsigned(fp_double(62 downto 52)) - 896);-- Ebiased(single) =  E(biased(double) + 127 - 1023;
fp_single(30 downto 23) <= (others =>'0') when fp_double(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000" else
                           exponent (7 downto 0);
--Attach mantissa.
fp_single (22 downto 0) <= fp_double(51 downto 29);

end Behavioral;
