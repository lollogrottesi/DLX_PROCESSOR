----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2020 10:47:51
-- Design Name: 
-- Module Name: Cellular_array_divider - Structural
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

entity Cellular_array_divider is
    generic (N: integer := 5);
    port (a: in std_logic_vector(0 to 2*N-1);
          d: in std_logic_vector(0 to N-1);
          q: out std_logic_vector(0 to N-1));
end Cellular_array_divider;

architecture Structural of Cellular_array_divider is

component Division_cell_row is
    generic (N: integer:= 5);
    port (a: in std_logic_vector(0 to N-1);
          d: in std_logic_vector(0 to N-1);
          p: in std_logic;
          q: out std_logic;
          s_out: out std_logic_vector(0 to N-2);
          d_out: out std_logic_vector(0 to N-1));
end component;

--type s_network_type is array (0 to N-1) of std_logic_vector(0 to N-2); 
type network_type is array (0 to N-1) of std_logic_vector(0 to N-1); 
signal s_network: network_type;
signal d_network: network_type;
signal q_network: std_logic_vector(0 to N-1);

begin
first_row: Division_cell_row generic map (N)
                             port map(a(0 to N-1), d, '1', q_network(0), s_network(0)(0 to N-2), d_network(0));
                             
gen_network:
    for j in 0 to N-1 generate
        s_network (j)(N-1) <= a(N+j); 
    end generate gen_network;
    
gen_array_divider:
    for i in 1 to N-1 generate
        row_i: Division_cell_row generic map (N)
                             port map(s_network(i-1), d_network(i-1), q_network(i-1), q_network(i), s_network(i)(0 to N-2), d_network(i));
    end generate gen_array_divider;
    
    q <= q_network;
end Structural;
