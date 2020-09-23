----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2020 19:23:43
-- Design Name: 
-- Module Name: logic_unit - Behavioral
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

entity logic_unit is
    generic (N: integer := 32);
    Port (
    A, B     : in  STD_LOGIC_VECTOR(N-1 downto 0);  
    logic_sel  : in  STD_LOGIC_VECTOR(2 downto 0);
    logic_out   : out  STD_LOGIC_VECTOR(N-1 downto 0));
end logic_unit;

architecture Behavioral of logic_unit is

begin

 process(A,B,logic_sel)
 begin
  case(logic_sel) is
  when "000" => -- Logical and 
   logic_out <= A and B;
  when "001" => -- Logical or
   logic_out <= A or B;
  when "010" => -- Logical xor 
   logic_out <= A xor B;
  when "011" => -- Logical nor
   logic_out <= A nor B;
  when "100" => -- Logical nand 
   logic_out <= A nand B;
  when "101" => -- Logical xnor
   logic_out <= A xnor B;
  when others => 
   logic_out <= (others => '0');
  end case;
 end process;
 
end Behavioral;
