----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2020 15:02:34
-- Design Name: 
-- Module Name: Register_Generic - Behavioral
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

entity Register_Generic_rst is
    generic (N: integer:= 64);
    port (data_in: in std_logic_vector(N-1 downto 0);
          clk:     in std_logic;
          rst:     in std_logic;
          en:      in std_logic;
          data_out: out std_logic_vector(N-1 downto 0));
end Register_Generic_rst;

architecture Behavioral of Register_Generic_rst is

signal R : std_logic_vector(N-1 downto 0);
signal rst_syn: std_logic;
begin
    process(clk)
    begin 
        if (clk = '1' and clk' event) then
            if (rst = '1') then 
--                R <= (others => '0');
                rst_syn <= '1';
                data_out <= (others => '0');
            else 
                rst_syn <= '0';
                if (en = '1') then
                    data_out <= R;
                else
                    data_out <= (others => '0');
                end if;
            end if;
--        else
--            R <= data_in;    
        end if;
    end process;
    
    process(data_in, rst_syn)
    begin
        if (rst_syn = '1') then
            R <= (others => '0');
        else
            R <= data_in;
        end if;
    end process;

end Behavioral;
