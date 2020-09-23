----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.08.2020 17:31:38
-- Design Name: 
-- Module Name: Converter_unit - Structural
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

entity Converter_unit is
    port (x: in std_logic_vector(63 downto 0);
          conversion_ctrl: in std_logic_vector (3 downto 0);
          y: out std_logic_vector(63 downto 0));
end Converter_unit;

architecture Structural of Converter_unit is

component Integer_to_floating_point_single_precision is
    port (int_in: in std_logic_vector(31 downto 0);
          s_u: in std_logic; --Specify if integer input have to be treated as unsigned or signed.
          fp_out: out std_logic_vector(31 downto 0));
end component;

component Floating_point_single_precision_to_double is
    port (fp_single: in std_logic_vector(31 downto 0);
          fp_double: out std_logic_vector(63 downto 0));
end component;

component Floating_point_double_precision_to_single is
    port (fp_double: in std_logic_vector(63 downto 0);
          fp_single: out std_logic_vector(31 downto 0));
end component;

component Floating_point_double_precision_to_integer is
    Port (FP_in : in std_logic_vector (63 downto 0);
          s_u: in std_logic;    --Specify if output format is signed or unsigned. 
          integer_out: out std_logic_vector (31 downto 0));
end component;

component Integer_to_floating_point_double_precision is
    port (int_in: in std_logic_vector(31 downto 0);
          s_u: in std_logic; --Specify if integer input have to be treated as unsigned or signed.
          fp_out: out std_logic_vector(63 downto 0));
end component;

component Floating_point_single_precision_to_integer is
    Port (FP_in : in std_logic_vector (31 downto 0);
          s_u: in std_logic;    --Specify if output format is signed or unsigned. 
          integer_out: out std_logic_vector (31 downto 0));
end component;
signal int_to_single, int_to_double, single_to_int, single_to_double, double_to_int, double_to_single : std_logic_vector(63 downto 0);
begin
int_to_fp_single: Integer_to_floating_point_single_precision port map (x(31 downto 0), conversion_ctrl(3), int_to_single(31 downto 0));
fp_single_to_double: Floating_point_single_precision_to_double port map (x(31 downto 0), single_to_double);
fp_double_to_single: Floating_point_double_precision_to_single port map (x, double_to_single (31 downto 0));
fp_double_to_int: Floating_point_double_precision_to_integer port map (x, conversion_ctrl(3) ,double_to_int(31 downto 0));
int_to_fp_double: Integer_to_floating_point_double_precision port map (x(31 downto 0), conversion_ctrl(3), int_to_double);
fp_single_to_int: Floating_point_single_precision_to_integer port map (x(31 downto 0), conversion_ctrl(3), single_to_int(31 downto 0));

--Append zeros to MSB half-word.
int_to_single (63 downto 32) <= (others => '0');
double_to_single (63 downto 32) <= (others => '0');
double_to_int (63 downto 32) <= (others => '0');
single_to_int (63 downto 32) <= (others => '0');

    process(x, conversion_ctrl, int_to_single, int_to_double, single_to_int, single_to_double, double_to_int, double_to_single)
    begin
        case conversion_ctrl is
            when "0000" =>
                y <= x;
            when "0001" =>
                y <= int_to_single;
            when "0010"=>
                y <= int_to_double;
            when "0011" =>
                y <= single_to_int;
            when "0100"=>
                y <= double_to_int;
            when "0101" =>
                y <= single_to_double;
            when "0110"=>
                y <= double_to_single;
            --signed.
            when "1001" =>
                y <= int_to_single;
            when "1010"=>
                y <= int_to_double;
            when "1011" =>
                y <= single_to_int;
            when "1100"=>
                y <= double_to_int;
            when others => 
                y <= x;
        end case;
    end process;
-----------------------------------------------------ENCODING-----------------------------------------------------------------------------
--0000 => NO CONVERSION
--0001 => UNSIGNED INTEGER TO SINGLE PRECISION 
--0010 => UNSIGNED INTEGER TO DOUBLE PRECISION 
--0011 => SINGLE PRECISION TO INTEGER UNSIGNED
--0100 => DOUBLE PRECISION TO INTEGER UNSIGNED
--0101 => SINGLE TO DOUBLE
--0110 => DOUBLE TO SINGLE
--0111 => NO CONVERSION
--1000 => NO CONVERSION
--1001 => SIGNED INTEGER TO SINGLE PRECISION 
--1010 => SIGNED INTEGER TO DOUBLE PRECISION 
--1011 => SINGLE PRECISION TO INTEGER SIGNED
--1100 => DOUBLE PRECISION TO INTEGER SIGNED
--1101 => NO CONVERSION
--1110 => NO CONVERSION
--1111 => NO CONVERSION
------------------------------------------------------------------------------------------------------------------------------------------
end Structural;
