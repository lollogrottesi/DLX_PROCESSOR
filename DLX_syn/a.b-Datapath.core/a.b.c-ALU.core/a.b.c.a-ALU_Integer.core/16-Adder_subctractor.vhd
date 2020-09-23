----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.07.2020 11:18:11
-- Design Name: 
-- Module Name: Adder_subctractor - Structural
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

entity Adder_subctractor is
generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          add_sub: IN std_logic;
          cout: out std_logic;
          overflow: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end Adder_subctractor;

architecture Structural of Adder_subctractor is

component Pentium_IV_Adder is
generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          cout: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end component;

signal tmp_b, ctrl_add_sub, tmp_s : std_logic_vector((2**N)-1 downto 0);
constant MSB : integer := ((2**N)-1);
begin
--The subctraction is performed using the carry in bit and an exor networ(two's complement of B).
ctrl_add_sub <= (others => add_sub);
tmp_b <= B xor ctrl_add_sub;

Pentium_adder: Pentium_IV_Adder generic map (N)
                                port map (A, tmp_b, add_sub, cout, tmp_s);
--Overflow condition.
--overflow <= (tmp_s(MSB) and (not A(MSB)) and (not B(MSB))) or ((not tmp_s(MSB)) and A(MSB) and B(MSB));
overflow <= '0';
S <= tmp_s;
end Structural;
