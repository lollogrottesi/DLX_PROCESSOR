----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2020 17:10:48
-- Design Name: 
-- Module Name: Pentium_IV_Adder - Structural
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

entity Pentium_IV_Adder is
generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          cout: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end Pentium_IV_Adder;

architecture Structural of Pentium_IV_Adder is

component Carry_Select_Sum_Generator is
    generic (n : integer := 8);
    port(Carry: IN std_logic_vector((n/4)-1 downto 0);
         cin: in std_logic;
         A: IN std_logic_vector(n-1 downto 0);
         B : IN std_logic_vector(n-1 downto 0);
         S: OUT std_logic_vector(n-1 downto 0));
end component;

component CLA_Sparse_Tree_Generator is
    generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          carry_out: OUT std_logic_vector((2**(N-2))- 1 downto 0));
end component;

signal carry: std_logic_vector((2**(N-2))- 1 downto 0);
begin
    Adder_select_like: Carry_Select_Sum_Generator generic map (2**N) port map(carry, cin ,A, B, S);
    CLA_sparse_tree: CLA_Sparse_Tree_Generator generic map (N) port map (A, B, cin, carry); 
    cout <= carry((2**(N-2))- 1); 
end Structural;
