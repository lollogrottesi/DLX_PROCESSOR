----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2020 15:04:44
-- Design Name: 
-- Module Name: Shifter_gen - Behavioral
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

entity Shifter_gen is
    generic (n: integer := 8;
             shift_amt: integer:= 2);
    port(A : in std_logic_vector(n-1 downto 0);
         sel: in std_logic_vector(2 downto 0);
         y : out std_logic_vector(2*n-1 downto 0));
         
end Shifter_gen;

architecture Behavioral of Shifter_gen is
signal a_tmp : std_logic_vector(2*n-1 downto 0);
begin
--MSB sign.
a_tmp (2*n-1 downto n) <= (others => A(n-1));
a_tmp (n-1 downto 0) <= std_logic_vector(signed(A));
--If we want to use just on MSB as sign use the complement only on that bit, and leave the signed() operator.
    process(a_tmp, sel)
    begin
    
        case sel is
            when "000"=>
                y <= (others => '0');
            when "001"=>
                y <=  std_logic_vector(shift_left(signed(a_tmp), shift_amt-1));
            when "010"=>
                y <=  std_logic_vector(shift_left(signed(a_tmp), shift_amt-1));
            when "011"=>
                y <= std_logic_vector(shift_left(signed(a_tmp), shift_amt));
            when "100"=>
                y <= std_logic_vector( - shift_left(signed(a_tmp), shift_amt));     
            when "101"=>
                y <= std_logic_vector( - shift_left(signed(a_tmp), shift_amt-1));  
            when "110"=>
                y <= std_logic_vector( - shift_left(signed(a_tmp), shift_amt-1));
            when others =>  
                y <= (others => '0');   
        end case;
    end process;

end Behavioral;
