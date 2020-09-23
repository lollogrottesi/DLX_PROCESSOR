----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.08.2020 13:24:43
-- Design Name: 
-- Module Name: Integer_to_floating_point_double - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Integer_to_floating_point_double_precision is
    port (int_in: in std_logic_vector(31 downto 0);
          s_u: in std_logic; --Specify if integer input have to be treated as unsigned or signed.
          fp_out: out std_logic_vector(63 downto 0));
end Integer_to_floating_point_double_precision;

architecture Behavioral of Integer_to_floating_point_double_precision is
component Generic_normalization_LSB_unit is
    generic (N: integer:= 8);
    port (M: in std_logic_vector(N-1 downto 0);
          norma_M: out std_logic_vector(N-1 downto 0);
          shift_amt: out std_logic_vector(N-1 downto 0));
end component;

signal sign_module_int: std_logic_vector(32 downto 0);
signal long_exponent_unbiased, long_mantissa : std_logic_vector(31 downto 0);
signal exponent_unbiased, exponent_biased: std_logic_vector(10 downto 0);
begin
normalizator: Generic_normalization_LSB_unit generic map (32)
                                             port map(sign_module_int(31 downto 0), long_mantissa, long_exponent_unbiased);
process(int_in, s_u)
    begin
        if (s_u = '1') then
            --Signed case.
            if (int_in(31) = '1') then
                --Signed negative
                sign_module_int(30 downto 0) <= std_logic_vector(unsigned(not int_in(30 downto 0)) + 1);
                sign_module_int(31) <= '0'; --In this case bit 31 is not used.
                sign_module_int(32) <= int_in(31);
            else
                --Signed positive.
                sign_module_int(30 downto 0) <= int_in(30 downto 0);
                sign_module_int(31) <= '0';
                sign_module_int(32) <= int_in(31);
            end if;
        else
            --Unsigned case.
            sign_module_int(31 downto 0) <= int_in;
            sign_module_int(32) <= '0';
        end if;
    end process;
    
exponent_unbiased <= long_exponent_unbiased(10 downto 0);
exponent_biased <= std_logic_vector(unsigned(exponent_unbiased) + 1023);
fp_out (63) <= sign_module_int(32);
fp_out (62 downto 52) <= (others =>'0') when int_in = "00000000000000000000000000000000" else
                         exponent_biased;
fp_out (51 downto 20) <= long_mantissa;
fp_out (19 downto 0) <= (others=>'0');

end Behavioral;
