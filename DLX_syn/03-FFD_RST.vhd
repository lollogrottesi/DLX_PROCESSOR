----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2020 10:47:58
-- Design Name: 
-- Module Name: FF - Behavioral
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

entity FFD_RST is
    port (D: in std_logic;
          clk:     in std_logic;
          rst:      in std_logic;
          Q:       out std_logic);
end FFD_RST;

architecture Behavioral of FFD_RST is

signal R : std_logic;
begin
    process(clk)
    begin 
        if (clk = '1' and clk' event) then
            if (rst = '1') then
                R <= '0';
                Q <= '0';
            else
                Q <= R;
            end if;
        else
            R <= D;        
        end if;
    end process;
    

end Behavioral;
