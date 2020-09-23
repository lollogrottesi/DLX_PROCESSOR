----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.08.2020 15:45:17
-- Design Name: 
-- Module Name: shifter - Behavioral
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
use ieee.numeric_std.all;  

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shifter is
    Generic (N: integer:= 32);
    port(dataIN : in std_logic_vector(N-1 downto 0);  
        positions: in std_logic_vector(N-1 downto 0);
        SEL : in std_logic_vector(2 downto 0);  
        dataOUT : out std_logic_vector(N-1 downto 0));  
 end shifter;

architecture Behavioral of shifter is
signal data_in_ext_vector,shift_right_ext_vector: std_logic_vector(3*N-1 downto 0);
signal roatate_right_data_in: std_logic_vector(N-1 downto 0);

signal shift_left_ext_vector: std_logic_vector(3*N-1 downto 0);
signal roatate_left_data_in: std_logic_vector(N-1 downto 0);
begin
--Extend data on left and right.
data_in_ext_vector(2*N-1 downto N) <= dataIN;
data_in_ext_vector(3*N-1 downto 2*N) <= (others => '0');
data_in_ext_vector(N-1 downto 0) <= (others => '0');
--Perform the rotation through shift.

shift_right_ext_vector <= std_logic_vector(shift_right(unsigned(data_in_ext_vector), to_integer(unsigned(positions))));
roatate_right_data_in <= shift_right_ext_vector(2*N-1 downto N) or shift_right_ext_vector(N-1 downto 0);

shift_left_ext_vector <= std_logic_vector(shift_left(unsigned(data_in_ext_vector), to_integer(unsigned(positions))));
roatate_left_data_in <= shift_left_ext_vector(2*N-1 downto N) or shift_left_ext_vector(3*N-1 downto 2*N);

    process(SEL,dataIN, roatate_left_data_in, roatate_right_data_in)
    begin
        case SEL is 
            when "000" =>
                --SHIFT LEFT
                dataOUT <= std_logic_vector(shift_left(unsigned(dataIN), to_integer(unsigned(positions))));
            when "001" =>
                --LOGICAL SHIFT RIGHT
                dataOUT <= std_logic_vector(shift_right(unsigned(dataIN), to_integer(unsigned(positions))));
            when "010" =>
                --ARITMETIC SHIFT RIGHT
                dataOUT <= std_logic_vector(shift_right(signed(dataIN), to_integer(unsigned(positions))));
            when "011" =>
             --ROTATE SHIFT LEFT
                dataOUT <= roatate_left_data_in;
            when "100" =>
             --ROTATE SHIFT RIGHT
                dataOUT <= roatate_right_data_in;
            when others =>
                dataOUT <= dataIN;
        end case;
    end process;
end Behavioral;
