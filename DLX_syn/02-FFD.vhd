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

entity FFD is
    port (D: in std_logic;
          clk:     in std_logic;
          en_rd:      in std_logic;
          rst:     in std_logic;
          Q:       out std_logic);
end FFD;

architecture Behavioral of FFD is

signal R : std_logic:= '0';

begin
    process(clk, en_rd, D)
    begin 
        if (en_rd = '1') then
                R <= D;
            end if;
            
        if (clk = '1' and clk' event) then
            if(rst = '1') then
                R <= '0';
                Q <= '0';
            else    
                Q <= R;    
            end if;      
        end if;
    end process;
    
--    process(D, en)
--    begin
--        if (en = '1') then
--            R <= D;
--        end if; 
--    end process;

end Behavioral;
