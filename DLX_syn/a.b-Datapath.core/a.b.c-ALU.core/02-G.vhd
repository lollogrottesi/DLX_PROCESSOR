----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2020 15:05:11
-- Design Name: 
-- Module Name: G - Behavioral
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

entity G is
    port ( g_ik : IN std_logic;
           p_ik : IN std_logic;
           g_k_1_j: IN std_logic;
           g_ij: OUT std_logic);
end G;

architecture Behavioral of G is

begin
g_ij <= g_ik or (p_ik and g_k_1_j);

end Behavioral;
