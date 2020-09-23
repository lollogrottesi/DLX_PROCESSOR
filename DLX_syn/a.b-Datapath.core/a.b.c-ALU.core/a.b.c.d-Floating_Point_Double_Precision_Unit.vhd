----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2020 11:09:17
-- Design Name: 
-- Module Name: Floating_Point_Double_Precision_Unit - Structural
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

entity Floating_Point_Double_Precision_Unit is
    port(FP_a: in std_logic_vector(63 downto 0);
         FP_b: in std_logic_vector(63 downto 0);
         EN:   in std_logic;
         ADD_SUB: in std_logic;
         CMP_CTRL: in std_logic_vector(2 downto 0);
         OP_CTRL:  in std_logic_vector(1 downto 0);
         CMP_OUT:  out std_logic;
         FP_out:   out std_logic_vector(63 downto 0)); 
end Floating_Point_Double_Precision_Unit;

architecture Structural of Floating_Point_Double_Precision_Unit is

component Double_cmp_add_sub is
    port (FP_a: in std_logic_vector(63 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(63 downto 0);
          add_subAndCmp: in std_logic;
          cmp_ctrl:      in std_logic_vector(2 downto 0);   --Select one compare operation.
          cmp_out:       out std_logic;                     --Result of the selected comparison.
          FP_z: out std_logic_vector(63 downto 0));
end component;

component Double_Floating_Point_Multiplier is
    port (FP_a: in std_logic_vector(63 downto 0);--Normalized  biased values.
          FP_b: in std_logic_vector(63 downto 0);
          overflow: out std_logic;
          FP_z: out std_logic_vector(63 downto 0));
end component;

component Double_Floating_Point_Divider is
     port (   FP_a: in std_logic_vector(63 downto 0);
              FP_b: in std_logic_vector(63 downto 0);
              FP_z: out std_logic_vector(63 downto 0));
end component;

signal op_a, op_b: std_logic_vector(63 downto 0);
signal add_sub_out, mul_out, div_out: std_logic_vector(63 downto 0);
signal overflow: std_logic;
begin
FP_double_add_sub_cmp : Double_cmp_add_sub      port map (op_a, op_b, ADD_SUB, CMP_CTRL, CMP_OUT, add_sub_out);
FP_double_mul: Double_Floating_Point_Multiplier port map (op_a, op_b, overflow, mul_out);
--FP_double_div: Double_Floating_Point_Divider    port map (op_a, op_b, div_out);
op_a <= FP_a when EN = '1' else
        (others => '0');
op_b <= FP_b when EN = '1' else
        (others => '0');
        
        
FP_out <= add_sub_out     when OP_CTRL = "01" else
          mul_out         when OP_CTRL = "10" else
          (others => '0');
end Structural;
