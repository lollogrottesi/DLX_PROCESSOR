----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.07.2020 15:35:29
-- Design Name: 
-- Module Name: Comparator - Mixed
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

entity Zero_detector is
    Generic (N: integer:= 32);
    Port (A: in std_logic_vector (N-1 downto 0);
          A_eq_zero: out std_logic); 
end Zero_detector;

architecture Mixed of Zero_detector is
signal A_xor_B: std_logic_vector(N-1 downto 0);
signal nor_network: std_logic_vector(N-3 downto 0);
signal tmp_a_eq_b: std_logic;
signal B: std_logic_vector(N-1 downto 0);
begin

B <= (others => '0');
A_xor_B <= A xor B;
nor_network(0) <= A_xor_B (0) or A_xor_B(1);
     
A_equal_zero:
    for i in 1 to N-3 generate
        nor_network(i) <= nor_network(i-1) or A_xor_B(i+1);
    end generate A_equal_zero;

tmp_a_eq_b <= nor_network(N-3) nor A_xor_B(N-1);     
 
A_eq_zero <= tmp_a_eq_b;  

end Mixed;
