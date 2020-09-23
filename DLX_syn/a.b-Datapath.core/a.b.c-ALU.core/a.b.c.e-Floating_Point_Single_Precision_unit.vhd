----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2020 10:11:52
-- Design Name: 
-- Module Name: Floating_Point_Single_Precision_unit - Structural
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

entity Floating_Point_Single_Precision_unit is
    port(FP_a: in std_logic_vector(63 downto 0);
         FP_b: in std_logic_vector(63 downto 0);
         EN:   in std_logic;
         ADD_SUB: in std_logic;
         CMP_CTRL: in std_logic_vector(2 downto 0);
         OP_CTRL:  in std_logic_vector(1 downto 0);
         CMP_OUT:  out std_logic;
         FP_out:   out std_logic_vector(63 downto 0)); 
end Floating_Point_Single_Precision_unit;

architecture Structural of Floating_Point_Single_Precision_unit is

component IEEE_754_Floating_Point_Multiplier is
    port (FP_a: in std_logic_vector(31 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(31 downto 0);
          overflow: out std_logic;
          FP_z: out std_logic_vector(31 downto 0));
end component;

component IEEE_754_Fast_Divider is
 port (   FP_a: in std_logic_vector(31 downto 0);
          FP_b: in std_logic_vector(31 downto 0);
          FP_z: out std_logic_vector(31 downto 0));
end component;

component IEEE_754_Add_Cmp_unit is
    port (FP_a: in std_logic_vector(31 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(31 downto 0);
          add_subAndCmp: in std_logic;
          cmp_ctrl:      in std_logic_vector(2 downto 0);   --Select one compare operation.
          cmp_out:       out std_logic;                     --Result of the selected comparison.
          FP_z: out std_logic_vector(31 downto 0));
end component;

signal fp_a_op, fp_b_op : std_logic_vector(31 downto 0);
signal fp_add_sub_out, fp_mul_out, fp_div_out: std_logic_vector(63 downto 0);
signal overflow: std_logic;

begin
add_sub_cmp_FP_unit: IEEE_754_Add_Cmp_unit port map (fp_a_op, fp_b_op, ADD_SUB, CMP_CTRL, CMP_OUT, fp_add_sub_out(31 downto 0));
mul_FP_unit: IEEE_754_Floating_Point_Multiplier port map (fp_a_op, fp_b_op, overflow, fp_mul_out(31 downto 0));
div_FP_unit: IEEE_754_Fast_Divider port map(fp_a_op, fp_b_op,fp_div_out(31 downto 0));

fp_a_op <= FP_a (31 downto 0) when EN = '1' else
           (others => '0');
fp_b_op <= FP_b (31 downto 0) when EN = '1' else
           (others => '0');
            
fp_add_sub_out (63 downto 32) <= (others => '0');
fp_mul_out     (63 downto 32) <= (others => '0');
fp_div_out     (63 downto 32) <= (others => '0');

FP_out <= (others => '0') when OP_CTRL = "00" else
          fp_mul_out      when OP_CTRL = "01" else
          fp_div_out      when OP_CTRL = "10" else
          fp_add_sub_out  when OP_CTRL = "11";
end Structural;
