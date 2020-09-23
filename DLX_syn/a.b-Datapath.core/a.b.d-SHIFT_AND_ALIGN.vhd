----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.08.2020 11:23:45
-- Design Name: 
-- Module Name: MASK_AND_ALIGN - Behavioral
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

entity SHIFT_AND_ALIGN is
    port (INPUT:  IN std_logic_vector(63 downto 0);
          CTRL:   IN std_logic_vector(2 downto 0);
          OUTPUT: OUT std_logic_vector(63 downto 0));
end SHIFT_AND_ALIGN;

architecture Behavioral of SHIFT_AND_ALIGN is

begin
    process(INPUT, CTRL)
    begin 
        case CTRL is
            when "000" =>
                OUTPUT <= INPUT;
            when "001" => 
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 16) <= (others => INPUT(31));
                OUTPUT(15 downto 0)  <=  INPUT (31 downto 16);
            when "010" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 16) <= (others => '0');
                OUTPUT(15 downto 0)  <= INPUT (31 downto 16);
            when "011" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 16) <= INPUT (15 downto 0);
                OUTPUT(15 downto 0)  <= (others => '0');
            when "100" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 8)  <= (others => INPUT(31));
                OUTPUT(7 downto 0)   <= INPUT (31 downto 24);
            when "101" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 8)  <= (others => '0');
                OUTPUT(7 downto 0)   <= INPUT (31 downto 24);
            when others =>
                OUTPUT <= INPUT; 
        end case;
    end process;

--------------------------------------ENCODING------------------------------
--  000 => no changes.
--  001 => 16 to 32 ,signed.
--  010 => 16 to 32 ,unsigned.
--  011 => 16 to 32 ,shift left(16 bit).
--  100 => 8 to 32 , signed.
--  101 => 8 to 32 , unisgned.
--  110 => no changes.
--  111 => no changes.
end Behavioral;