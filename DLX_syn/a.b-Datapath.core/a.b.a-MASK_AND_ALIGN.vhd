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

entity MASK_AND_ALIGN is
    port (INPUT:  IN std_logic_vector(63 downto 0);
          CTRL:   IN std_logic_vector(2 downto 0);
          OUTPUT: OUT std_logic_vector(63 downto 0));
end MASK_AND_ALIGN;

architecture Behavioral of MASK_AND_ALIGN is

begin

    process(INPUT, CTRL)
    begin 
        case CTRL is
            when "000" =>
                OUTPUT <= INPUT;
            when "110" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 24) <= INPUT(7 downto 0); 
                OUTPUT(23 downto 0) <= (others => '0');
            when "111" =>
                OUTPUT(63 downto 32) <= (others => '0');
                OUTPUT(31 downto 16) <= INPUT(15 downto 0); 
                OUTPUT(15 downto 0) <= (others => '0');
            when others =>
               OUTPUT <= INPUT;
        end case;
    end process;

--------------------------------------ENCODING------------------------------
--  000 => no changes.
--  110 => 8 to 32, BYTE ALIGNED.
--  111 => 16 to 32 HALF WORD ALIGNED.
end Behavioral;
