----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2020 15:17:53
-- Design Name: 
-- Module Name: Generic_normlization_unit - Behavioral
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

entity Generic_normalization_LSB_unit is
    generic (N: integer:= 8);
    port (M: in std_logic_vector(N-1 downto 0);
          norma_M: out std_logic_vector(N-1 downto 0);
          shift_amt: out std_logic_vector(N-1 downto 0));
end Generic_normalization_LSB_unit;

architecture Behavioral of Generic_normalization_LSB_unit is

--constant norma_bit :integer := N-1; --The bit with respect the normalization is done, this bit must be set to one to normalize the value.

type shift_matrix_type is array (0 to 2*N-1) of std_logic_vector(2*N-1 downto 0);
type check_mask_type is array   (0 to N-1) of std_logic_vector(N-1 downto 0);

signal shift_M : shift_matrix_type;
signal flag_mask: std_logic_vector(N-1 downto 0);
signal mask_index: std_logic_vector (N-1 downto 0);
signal check_mask: check_mask_type;
signal unit_mask: std_logic_vector(N-1 downto 0);
signal extended_m: std_logic_vector(2*N-1 downto 0);
signal shifted_m: std_logic_vector(2*N-1 downto 0);
begin

extended_m(2*N-1 downto N) <= M;
extended_m(N-1 downto 0) <= (others =>'0');

unit_mask(N-1 downto 1) <= (others=>'0'); 
unit_mask(0) <= '1';

--Generate all possible shift right from M.
--Generate all possible shift right from unit_mask.
mask_shift:
    for i in 0 to 2*N-1 generate
        shift_M(i) <= std_logic_vector(shift_right(unsigned(extended_m), i));
        --check_mask(i) <= std_logic_vector(shift_right(unsigned(unit_mask), i));
    end generate mask_shift;
    
checkmask:
    for h in 0 to N-1 generate
        check_mask(h) <= std_logic_vector(shift_left(unsigned(unit_mask), h));
    end generate checkmask;
--Check for mask that has '1' in N-1 position.
--Generate an array of signal containing the flag on the N-1 bit.
flagmask: 
    for j in 0 to N-1 generate
        flag_mask(N-1-j) <=  shift_M(j)(N) and '1';
    end generate flagmask;
    
--flag_mask(N-1 downto 0) <= (others=>'0');

--Having the flag mask array, the elemente with the less index having word with one 1 and all zeros.    
--Decode the flag_mask using the check mask and update the mask_index value accordingly.
Decoder_process:    
    process(flag_mask)
    begin
        for k in 0 to N-1 loop
            if (flag_mask (k downto 0) = check_mask(k)(k downto 0)) then
                mask_index <= std_logic_vector(to_unsigned(N-1-k, N));
            end if;
        end loop;
    end process;

shifted_m <= std_logic_vector(shift_right(unsigned(extended_m), to_integer(unsigned(mask_index))));
shift_amt <= mask_index;
norma_m <= shifted_m(N-1 downto 0);
end Behavioral;
