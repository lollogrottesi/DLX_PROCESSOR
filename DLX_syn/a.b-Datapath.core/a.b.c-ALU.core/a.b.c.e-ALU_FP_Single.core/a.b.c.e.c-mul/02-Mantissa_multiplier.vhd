----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2020 11:14:03
-- Design Name: 
-- Module Name: Mantissa_multiplier - Structural
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

entity Mantissa_multiplier_single is
    --Mantissa = 1 bit sign + 1 hidden bit + 23 bit module = 25.
    port ( M_a : in std_logic_vector (24 downto 0);
           M_b : in std_logic_vector (24 downto 0);
           M_out: out std_logic_vector (48 downto 0));
end Mantissa_multiplier_single;

architecture Structural of Mantissa_multiplier_single is

Component arraymult is
    Generic (N: integer:=4);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0);     -- factor 1
           Y : in  STD_LOGIC_VECTOR (N-1 downto 0);     -- factor 2
           P : out  STD_LOGIC_VECTOR (2*N-1 downto 0)); -- product
end Component;

constant sign    : integer := 24;
constant num_bit : integer := 25;


begin
multiplier : arraymult generic map(24) --Perfomed unsigned multiplication between modules of mantissa (considering the hidden bit).
                       port map(M_a (23 downto 0), M_b(23 downto 0), M_out(47 downto 0));
--Output sign.
M_out (48) <=  M_a(sign) XOR M_b(sign);

end Structural;
