----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2020 14:05:22
-- Design Name: 
-- Module Name: Booth_Multiplier - Structural
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

entity Booth_Multiplier is
    generic (n_level: integer:= 3);-- N_level is used to create the height of the adders (log base 2 nbit).
    port (A: in std_logic_vector((2**n_level)-1 downto 0);
          B: in std_logic_vector((2**n_level)-1 downto 0);
          y: out std_logic_vector(2*(2**n_level)-1 downto 0));
end Booth_Multiplier;

architecture Structural of Booth_Multiplier is

component Pentium_IV_Adder is
generic (N : integer := 5);--N is the log base 2 of numbit(ex 32bit => N=5).
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          cout: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end component;

component Shifter_gen is
    generic (n: integer := 8;
             shift_amt: integer:= 2);
    port(A : in std_logic_vector(n-1 downto 0);
         sel: in std_logic_vector(2 downto 0);
         y : out std_logic_vector(2*n-1 downto 0));
         
end component;

constant n : integer := 2**n_level;
constant n_enc :integer:= n/2;--Number of encoders.

--New type variable used for the signals outing from shifter to adders and signal outing form adders.
--Output of the shifters is 2*n bits, so all signal range 2*n-1 downoto 0.
type shifter_to_sum_type is array (n_enc-1 downto 0) of std_logic_vector(2*n-1 downto 0);
type sum_out_type is array (n_enc-2 downto 0) of std_logic_vector(2*n-1 downto 0);

signal b_tmp: std_logic_vector(n downto 0);
signal shift_to_sum: shifter_to_sum_type;
signal sum_out: sum_out_type;
signal carry_prop: std_logic_vector(n_enc-1 downto 0);
begin
b_tmp <= B&'0';--Create a new multiplicand vector.


--Create first two shifter and first multiplier, first level generation.
first_shifter: shifter_gen generic map(n, 1)
                           port map(A, b_tmp(2 downto 0), shift_to_sum(0));
second_shifter: shifter_gen generic map(n, 3)
                           port map(A, b_tmp(4 downto 2), shift_to_sum(1)); 
first_adder: Pentium_IV_Adder generic map(n_level+1)--n_level + 1 mean that the adder inputs are 2*n bits resolutions.
                              port map(shift_to_sum(0), shift_to_sum(1), '0', carry_prop(0), sum_out(0));

--If more than one level are required generate the ramaining n_enc - 2 shifters.                                                  
gen_shifters:for i in 2 to n_enc-1 generate
    shifter_i: shifter_gen generic map(n, 2*i+1)
                           port map(A, b_tmp(2*i+2 downto 2*i), shift_to_sum(i));
end generate gen_shifters;

--If more than one level are required generate the ramaining adders. 
gen_sum: for i in 1 to n_enc-2 generate
    adder_i: Pentium_IV_Adder generic map(n_level+1)--n_level + 1 mean that the adder inputs are 2*n bits resolutions.
                              port map(shift_to_sum(i+1), sum_out(i-1), '0', carry_prop(i) ,sum_out(i));
end generate gen_sum;

--Connect the output signal.
y <= sum_out(n_enc-2);
end Structural;
