----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2020 11:28:46
-- Design Name: 
-- Module Name: Exponent_Adder - Structural
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

entity Exponent_Double_Adder is
    port (E_a: in std_logic_vector(10 downto 0);
          E_b: in std_logic_vector(10 downto 0);
          E_out: out std_logic_vector(10 downto 0);
          overflow: out std_logic);
end Exponent_Double_Adder;

architecture Structural of Exponent_Double_Adder is

Component c_l_addr IS
    generic (N: integer:= 25);
    PORT
        (
         x_in      :  IN   STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         carry_in  :  IN   STD_LOGIC;
         sum       :  OUT  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         carry_out :  OUT  STD_LOGIC
        );
END Component;

signal tmp_E_out, tmp_E_bias_out: std_logic_vector(10 downto 0);
signal add_E_cout, add_B_cout: std_logic;
signal one_compl_bias : std_logic_vector(10 downto 0);
begin
--E1 + E2 + 2*Bias.
adder_E: c_l_addr generic map(11)
                port map (E_a, E_b, '0', tmp_E_out, add_E_cout); 
--Subctract Bias.
one_compl_bias <= "10000000000";   --One's complement of 127.
Add_Bias: c_l_addr generic map(11)
                port map (tmp_E_out, one_compl_bias, '1', tmp_E_bias_out, add_B_cout); 
E_out <= tmp_E_bias_out;        
      
overflow <= add_B_cout and add_E_cout;
end Structural;
