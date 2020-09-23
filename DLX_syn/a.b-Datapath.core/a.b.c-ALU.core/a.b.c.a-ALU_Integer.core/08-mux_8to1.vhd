----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.08.2020 18:57:34
-- Design Name: 
-- Module Name: mux_8to1 - architectural
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

entity mux_8to1 is
    Port (A: in std_logic;
          B: in std_logic;
          C: in std_logic;
          D: in std_logic;
          E: in std_logic;
          F: in std_logic;
          G: in std_logic;
          H: in std_logic;
          SEL: in std_logic_vector(2 downto 0);
          output: out std_logic);
end mux_8to1;

architecture architectural of mux_8to1 is

component mux2to1 is
 Port (A: in std_logic;
       B: in std_logic;
       SEL: in std_logic;
       output: out std_logic);
end component;
 signal O1,O2,O3,O4,O5,O6: std_logic;
begin

    m2to1_1: mux2to1
        port map(A,B,sel(0),O1);

    m2to1_2: mux2to1
        port map(C,D,sel(0),O2);

    m2to1_3: mux2to1
        port map(E,F,sel(0),O3);

    m2to1_4: mux2to1
        port map(G,H,sel(0),O4);

    m2to1_5: mux2to1
        port map(O1,O2,sel(1),O5);

    m2to1_6: mux2to1
        port map(O3,O4,sel(1),O6);

    m2to1_7: mux2to1
        port map(O5,O6,sel(2),output);

end architectural;
