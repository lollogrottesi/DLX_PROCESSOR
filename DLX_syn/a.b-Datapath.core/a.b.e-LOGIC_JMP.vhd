----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2020 10:56:25
-- Design Name: 
-- Module Name: LOGIC_JMP - Dataflow
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

entity LOGIC_JMP is
    port (zero_det: in std_logic;
          FPS:      in std_logic;
          JMP_CTRL: in std_logic_vector(2 downto 0);
          B_T_NT:   OUT std_logic);
end LOGIC_JMP;

architecture Behevioral of LOGIC_JMP is
signal MUX_CTRL: std_logic;
begin

B_T_NT  <=  '0'             when JMP_CTRL = "000" else --DEFAULT NPC = PC+1.
            FPS             when JMP_CTRL = "010" else --CHECK FPS = '1'.
            not FPS         when JMP_CTRL = "001" else --CHECK FPS = '0'.
            zero_det        when JMP_CTRL = "011" else --CHECK EQZERO.
            not zero_det    when JMP_CTRL = "100" else --CHECK NEQZ.
            '1'             when JMP_CTRL = "101" else --JUMP UNCONDITION.
            '0';
 
--B_T_NT  <=  '0'             when JMP_CTRL = "000" else --DEFAULT NPC = PC+1.
--            FPS             when JMP_CTRL = "001" else --CHECK FPS = '1'.
--            not FPS         when JMP_CTRL = "010" else --CHECK FPS = '0'.
--            zero_det        when JMP_CTRL = "011" else --CHECK EQZERO.
--            not zero_det    when JMP_CTRL = "100" else --CHECK NEQZ.
--            '1'             when JMP_CTRL = "101" else --JUMP UNCONDITION.
--            '0';
--'0' BRANCH NOT TAKEN.
--'1' BRANCH TAKEN.
end Behevioral;
