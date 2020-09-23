----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2020 10:38:08
-- Design Name: 
-- Module Name: Division_cell - Structural
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

entity Division_cell is
    port (a: in std_logic;
          d: in std_logic;
          p_in: in std_logic;
          cin:  in std_logic;
          p_out: out std_logic;
          cout:  out std_logic;
          s:     out std_logic;
          d_out: out std_logic);
end Division_cell;

architecture Structural of Division_cell is

component FA is 
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Ci:	In	std_logic;
		S:	Out	std_logic;
		Co:	Out	std_logic);
end component; 
signal xor_s: std_logic;

begin
full_adder: FA port map (a, xor_s, cin, s, cout);

xor_s <= p_in xor d;    
d_out <= d;
p_out <= p_in;
end Structural;
