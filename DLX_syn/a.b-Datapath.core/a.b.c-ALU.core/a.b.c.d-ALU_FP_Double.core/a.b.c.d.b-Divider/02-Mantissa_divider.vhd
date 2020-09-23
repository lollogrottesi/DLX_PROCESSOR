----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2020 12:13:57
-- Design Name: 
-- Module Name: Mantissa_divider - Structural
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

entity Mantissa_double_divider is
    --Format: 0.1mantissa => '0' in MSB + hidden bit + 52 bit mantissa = 54 bit.
    port (M_a: in std_logic_vector(107 downto 0);
          M_b: in std_logic_vector(53 downto 0);
          M_q: out std_logic_vector(53 downto 0));
end Mantissa_double_divider;

architecture Structural of Mantissa_double_divider is

component Cellular_array_divider is
    generic (N: integer := 5);
    port (a: in std_logic_vector(0 to 2*N-1);
          d: in std_logic_vector(0 to N-1);
          q: out std_logic_vector(0 to N-1));
end component;
begin
cellular_divider: Cellular_array_divider generic map(54)
                                         port map(M_a, M_b, M_q);

end Structural;
