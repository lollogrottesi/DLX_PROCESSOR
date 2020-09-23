----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2020 14:14:42
-- Design Name: 
-- Module Name: EXT_IMM - Behavioral
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

entity EXT_IMM is
    port (S_U_EXT: in std_logic_vector(1 downto 0);
          IMM:     in std_logic_vector(31 downto 0);
          EXT_IMM: out std_logic_vector(63 downto 0));
end EXT_IMM;

architecture Behavioral of EXT_IMM is

begin
    process(S_U_EXT, IMM)
    begin
        case S_U_EXT is
            when "00" => --UNSIGNED 16
                EXT_IMM(15 downto 0)  <= IMM(15 downto 0);
                EXT_IMM(63 downto 16) <= (others => '0');
            when "01" => --SIGNED 16
                EXT_IMM(15 downto 0)  <= IMM(15 downto 0);
                EXT_IMM(63 downto 16) <= (others => IMM(15));
            when "10" => --UNSIGNED 26
                EXT_IMM(25 downto 0)  <= IMM(25 downto 0);
                EXT_IMM(63 downto 26) <= (others => '0');
            when "11" => --SIGNED 26
                EXT_IMM(25 downto 0)  <= IMM(25 downto 0);
                EXT_IMM(63 downto 26) <= (others => IMM(25));
            when others => 
                EXT_IMM(15 downto 0)  <= IMM(15 downto 0);
                EXT_IMM(63 downto 16) <= (others => '0');
        end case;
    end process;

end Behavioral;
