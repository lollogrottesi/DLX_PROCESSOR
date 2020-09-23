----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2020 10:36:58
-- Design Name: 
-- Module Name: ALU - Structural
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

entity ALU is
    Port (
        OPA, OPB     : in std_logic_vector(63 downto 0);  -- 2 inputs N-bit
        integer_ctrl : in std_logic_vector(14 downto 0);
        single_precision_fp_ctrl : in std_logic_vector(6 downto 0);
        double_precision_fp_ctrl : in std_logic_vector(6 downto 0);
        conversion_ctrl : in std_logic_vector(4 downto 0);
        out_ctrl : in std_logic_vector(2 downto 0);
        ALU_Out   : out std_logic_vector(63 downto 0);
        PC_ALU: out std_logic_vector(63 downto 0);
        FPS : out std_logic);
end ALU;

architecture Structural of ALU is


component integer_ALU is
    generic (constant N: natural := 64);
    Port (
        OPA, OPB     : in std_logic_vector(N-1 downto 0);  -- 2 inputs N-bit
        ADD_SUB, sign_usign_n, ENABLE : in std_logic; -- operation selectors
        logic_control, shifter_control, comparator_control, out_control : in std_logic_vector(2 downto 0); -- operation and otput selectors
        ALU_Out   : out std_logic_vector(N-1 downto 0);
        cmp_out : out std_logic); -- 1 output N-bit
end component;

component Floating_Point_Single_Precision_unit is
    port(FP_a: in std_logic_vector(63 downto 0);
         FP_b: in std_logic_vector(63 downto 0);
         EN:   in std_logic;
         ADD_SUB: in std_logic;
         CMP_CTRL: in std_logic_vector(2 downto 0);
         OP_CTRL:  in std_logic_vector(1 downto 0);
         CMP_OUT:  out std_logic;
         FP_out:   out std_logic_vector(63 downto 0));
end component;

component Floating_Point_Double_Precision_Unit is
    port(FP_a: in std_logic_vector(63 downto 0);
         FP_b: in std_logic_vector(63 downto 0);
         EN:   in std_logic;
         ADD_SUB: in std_logic;
         CMP_CTRL: in std_logic_vector(2 downto 0);
         OP_CTRL:  in std_logic_vector(1 downto 0);
         CMP_OUT:  out std_logic;
         FP_out:   out std_logic_vector(63 downto 0));
end component;
  
component Converter_unit is
    port (x: in std_logic_vector(63 downto 0);
          conversion_ctrl: in std_logic_vector (3 downto 0);
          y: out std_logic_vector(63 downto 0));
end component;

component Floating_point_single_precision_to_integer is
    Port (FP_in : in std_logic_vector (31 downto 0);
          s_u: in std_logic;    --Specify if output format is signed or unsigned. 
          integer_out: out std_logic_vector (31 downto 0));
end component;


signal converted_OPA, converted_OPB, out_integer, out_float, out_double, float_to_int_out, integer_cmp_out: std_logic_vector(63 downto 0);
signal int_cmp, float_cmp, double_cmp: std_logic;
begin

conv_A: Converter_unit port map(OPA, conversion_ctrl(3 downto 0), converted_OPA);

conv_B: Converter_unit port map(OPB, conversion_ctrl(3 downto 0), converted_OPB);

int: integer_ALU port map (OPA => converted_OPA,
                           OPB => converted_OPB,
                           ENABLE => integer_ctrl(14),
                           ADD_SUB => integer_ctrl(13),
                           sign_usign_n => integer_ctrl(12),
                           logic_control => integer_ctrl(11 downto 9),
                           shifter_control => integer_ctrl(8 downto 6),
                           comparator_control => integer_ctrl(5 downto 3),
                           out_control => integer_ctrl(2 downto 0),
                           ALU_Out => out_integer,
                           cmp_out => int_cmp);

float_single: Floating_Point_Single_Precision_unit port map (FP_a => converted_OPA,
                                                      FP_b => converted_OPB,
                                                      EN => single_precision_fp_ctrl(6),
                                                      ADD_SUB => single_precision_fp_ctrl(5),
                                                      CMP_CTRL => single_precision_fp_ctrl(4 downto 2),
                                                      OP_CTRL => single_precision_fp_ctrl(1 downto 0),
                                                      CMP_OUT => float_cmp,
                                                      FP_out => out_float);
                                                      
float_double: Floating_Point_Double_Precision_unit port map (FP_a => converted_OPA,
                                                             FP_b => converted_OPB,
                                                             EN => double_precision_fp_ctrl(6),
                                                             ADD_SUB => double_precision_fp_ctrl(5),
                                                             CMP_CTRL => double_precision_fp_ctrl(4 downto 2),
                                                             OP_CTRL => double_precision_fp_ctrl(1 downto 0),
                                                             CMP_OUT => double_cmp,
                                                             FP_out => out_double);
                                                             
fp_to_int: Floating_point_single_precision_to_integer port map (out_float(31 downto 0), conversion_ctrl(4), float_to_int_out(31 downto 0));

float_to_int_out(63 downto 32) <= (others => '0');

integer_cmp_out (0) <= int_cmp;
integer_cmp_out(63 downto 1) <= (others => '0');

ALU_out <= out_integer                                  when out_ctrl="000" else
           float_to_int_out                             when out_ctrl="001" else
           out_float                                    when out_ctrl="010" else
           out_double                                   when out_ctrl="011" else
           converted_OPA                                when out_ctrl="100" else
           std_logic_vector(unsigned(converted_OPA)+4)  when out_ctrl="101" else
           integer_cmp_out                              when out_ctrl="110" else
           converted_OPB                                when out_ctrl="111";
           
FPS <= float_cmp or double_cmp;     

PC_ALU <=  out_integer;
--FPS <= int_cmp when out_ctrl="101" else
--           float_cmp when out_ctrl="110" else
--           double_cmp when out_ctrl="111" else
--           '0';
           
end Structural;
