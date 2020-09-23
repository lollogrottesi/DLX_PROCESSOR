----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2020 15:19:55
-- Design Name: 
-- Module Name: PG_Network - Behavioral
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

entity PG_Network is
    generic (N : integer := 32);
    port (A: IN std_logic_vector(N-1 downto 0);
          B: IN std_logic_vector(N-1 downto 0); 
          cin: IN std_logic;
          p_out: OUT std_logic_vector(N-1 downto 0);
          g_out: OUT std_logic_vector(N-1 downto 0));
end PG_Network;

architecture Behavioral of PG_Network is

begin 

--g_out(0) <= (A(0) and B(0)); --or cin;
--p_out(0) <= (A(0) xor B(0)) and cin;
p_out<= A xor B;
g_out(0) <= (A(0) and B(0)) or ((A(0) xor B(0)) and cin);
g_out(N-1 downto 1) <= A(N-1 downto 1) and B(N-1 downto 1);
--g_out(N-1 downto 1) <= A(N-1 downto 1) and B(N-1 downto 1);

end Behavioral;
