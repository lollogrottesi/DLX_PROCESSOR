----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.08.2020 18:19:42
-- Design Name: 
-- Module Name: comparator - mixed
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

entity integer_comparator is
Generic (N: integer:= 32);
    Port (A: in std_logic_vector (N-1 downto 0);
          B: in std_logic_vector (N-1 downto 0);
          signed_unsigned_n: in std_logic;--1-> signed comparator, 0-> unsigned.
          SEL  : in std_logic_vector (2 downto 0);
          logic_output: out std_logic);
end integer_comparator;

architecture mixed of integer_comparator is

component Carry_out_network is
 Generic(N: integer:= 32); 
 Port (A: in std_logic_vector(N-1 downto 0);
       B: in std_logic_vector(N-1 downto 0);
       cin: in std_logic;
       cout: out std_logic);
end component;

component mux_8to1 is
 Port (A: in std_logic;
       B: in std_logic;
       C: in std_logic;
       D: in std_logic;
       E: in std_logic;
       F: in std_logic;
       G: in std_logiC;
       H: in std_logic;
       SEL: in std_logic_vector (2 downto 0);
       output: out std_logic);
end component;

signal b_compl: std_logic_vector (N-1 downto 0);
signal carry_out: std_logic;
signal A_xor_B: std_logic_vector(N-1 downto 0);
signal nor_network: std_logic_vector(N-3 downto 0);
signal tmp_a_eq_b: std_logic;
signal sign_a_b: std_logic_vector(1 downto 0);
signal A_eq_B, A_not_equal_B, A_gr_B, A_gr_eq_B, A_low_B,A_low_equal_B:  std_logic;
begin
sign_a_b <= A(N-1)&B(N-1) when signed_unsigned_n = '1' else
            "00";
b_compl <= not B;
A_xor_B <= A xor B;
nor_network(0) <= A_xor_B (0) or A_xor_B(1);
--Perform A-B (using two's complements of B).
Carry_out_net: Carry_out_network generic map (N)
                                 port map (A, b_compl, '1', carry_out);      
                                 
--To perform the equality without perform the difference, use a XORtoNOR network.
A_equal_B:
    for i in 1 to N-3 generate
        nor_network(i) <= nor_network(i-1) or A_xor_B(i+1);
    end generate A_equal_B;
--tmp_a_eq_b = 1 if A=B , 0 otherwise.
tmp_a_eq_b <= nor_network(N-3) nor A_xor_B(N-1);     
 

    process(sign_a_b, A, B, tmp_a_eq_b, carry_out)
    begin
        case sign_a_b is 
            when "00" =>
                --If both positive check as unsigned numbers.
                A_gr_eq_B <= carry_out;
                A_gr_B <= carry_out and (not tmp_a_eq_b);
                A_low_B <= not carry_out;   
                A_low_equal_B <= (not carry_out) or tmp_a_eq_b;
            when "01" =>
                --A > B.
                A_gr_eq_B <= '1';
                A_gr_B <= '1';
                A_low_B <= '0';
                A_low_equal_B <= '0';
            when "10" =>
                --A < B.
                A_gr_eq_B <= '0';
                A_gr_B <= '0';
                A_low_B <= '1';
                A_low_equal_B <= '1';
            when "11" =>
                --If both negative.
                A_gr_eq_B <= carry_out;
                A_gr_B <= carry_out and (not tmp_a_eq_b);
                A_low_B <= not carry_out;   
                A_low_equal_B <= (not carry_out) or tmp_a_eq_b;  
                
            when others =>
                 A_gr_eq_B <= carry_out;
                A_gr_B <= carry_out and (not tmp_a_eq_b);
                A_low_B <= not carry_out;   
                A_low_equal_B <= (not carry_out) or tmp_a_eq_b; 
        end case;
    end process;
    
    A_eq_B <= tmp_a_eq_b;
    A_not_equal_B <= not tmp_a_eq_b;

    m8to1_1: mux_8to1
        port map('0', A_eq_B, A_not_equal_B, A_gr_B, A_gr_eq_B ,A_low_B, A_low_equal_B, '0', SEL, logic_output);

end mixed;

---------------------------------mapping of the operation---------------------------
--000,111 default ('0')
--001 A=B
--010 A!=B
--011 A>B
--100 A>=B
--101 A<B
--110 A<=B
