----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2020 14:16:20
-- Design Name: 
-- Module Name: Carry_Select_Sum_Generator - Structural
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

entity Carry_Select_Sum_Generator is
    generic (n : integer := 8);
    port(Carry: IN std_logic_vector((n/4)-1 downto 0);
         cin: in std_logic;
         A: IN std_logic_vector(n-1 downto 0);
         B : IN std_logic_vector(n-1 downto 0);
         S: OUT std_logic_vector(n-1 downto 0));
end Carry_Select_Sum_Generator;

architecture Structural of Carry_Select_Sum_Generator is
component Carry_Select_Block is
    port(cin: IN std_logic;
         A: IN std_logic_vector(3 downto 0);
         B: IN std_logic_vector(3 downto 0);
         s: OUT std_logic_vector(3 downto 0));
end component;

begin

    CSB_0: Carry_Select_Block port map (cin ,A(3 downto 0), B(3 downto 0), S(3 downto 0));
gen_blocks:
    for i in 1 to (n/4)-1 generate
        CSB_i: Carry_Select_Block port map (Carry(i-1) ,A(4*i+3 downto 4*i), B(4*i+3 downto 4*i), S(4*i+3 downto 4*i));
    end generate gen_blocks;

end Structural;
