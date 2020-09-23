----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2020 12:11:04
-- Design Name: 
-- Module Name: Multiplier_unit - Structural
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

entity Multiplier_unit is
    port (A: in std_logic_vector(31 downto 0);
          B: in std_logic_vector (31 downto 0);
          sign_unisgn: in std_logic;
          y: out std_logic_vector(31 downto 0));
end Multiplier_unit;

architecture Structural of Multiplier_unit is

signal tmp_a, tmp_b: std_logic_vector(15 downto 0);

component Booth_Multiplier is
    generic (n_level: integer:= 3);-- N_level is used to create the height of the adders (log base 2 nbit).
    port (A: in std_logic_vector((2**n_level)-1 downto 0);
          B: in std_logic_vector((2**n_level)-1 downto 0);
          y: out std_logic_vector(2*(2**n_level)-1 downto 0));
end component;

component arraymult is
    Generic (N: integer:=4);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0); -- factor 1
           Y : in  STD_LOGIC_VECTOR (N-1 downto 0); -- factor 2
           P : out  STD_LOGIC_VECTOR (2*N-1 downto 0)); -- product
end component;

signal unsigned_y, signed_y: std_logic_vector(31 downto 0);
begin
tmp_a <= A(15 downto 0);
tmp_b <= B(15 downto 0);
signed_mul: Booth_Multiplier generic map (4)
                             port map(tmp_a, tmp_b, signed_y);
unsigned_mul: arraymult      generic map (16)
                             port map (tmp_a, tmp_b, unsigned_y);
                             
y <= signed_y when sign_unisgn = '1' else
     unsigned_y;
end Structural;
