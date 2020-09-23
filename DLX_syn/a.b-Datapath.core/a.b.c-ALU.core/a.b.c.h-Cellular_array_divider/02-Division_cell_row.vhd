----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2020 10:52:56
-- Design Name: 
-- Module Name: Division_cell_row - structural
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

entity Division_cell_row is
    generic (N: integer:= 5);
    port (a: in std_logic_vector(0 to N-1);
          d: in std_logic_vector(0 to N-1);
          p: in std_logic;
          q: out std_logic;
          s_out: out std_logic_vector(0 to N-2);
          d_out: out std_logic_vector(0 to N-1));
end Division_cell_row;

architecture structural of Division_cell_row is

component Division_cell is
    port (a: in std_logic;
          d: in std_logic;
          p_in: in std_logic;
          cin:  in std_logic;
          p_out: out std_logic;
          cout:  out std_logic;
          s:     out std_logic;
          d_out: out std_logic);
end component;
signal c_network: std_logic_vector(0 to N-1);
signal p_network: std_logic_vector(0 to N-1);
signal first_s: std_logic;
begin

cell_0: Division_cell port map (a(0), d(0), p, c_network (0), p_network(0), q, first_s, d_out(0));
cell_last: Division_cell port map (a(N-1), d(N-1), p_network(N-2), p_network (N-1), p_network(N-1), c_network(N-2), s_out (N-2), d_out (N-1));

gen_row:
    for i in 1 to N-2 generate
        cell_i: Division_cell port map (a(i), d(i), p_network(i-1), c_network (i), p_network(i), c_network(i-1), s_out (i-1), d_out (i));
    end generate gen_row;

end structural;
