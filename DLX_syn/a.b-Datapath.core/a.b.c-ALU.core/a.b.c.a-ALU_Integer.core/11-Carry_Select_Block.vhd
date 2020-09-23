----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2020 11:51:21
-- Design Name: 
-- Module Name: Carry_Select_Block - Structural
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
use WORK.constants.all; -- libreria WORK user-defined

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Carry_Select_Block is
    port(cin: IN std_logic;
         A: IN std_logic_vector(3 downto 0);
         B: IN std_logic_vector(3 downto 0);
         s: OUT std_logic_vector(3 downto 0));
end Carry_Select_Block;

architecture Structural of Carry_Select_Block is
    component RCA_Gen is 
        generic (Nbit: integer:= 6);
        Port (	A:	In	std_logic_vector(Nbit-1 downto 0);
            B:	In	std_logic_vector(Nbit-1 downto 0);
            Ci:	In	std_logic;
            S:	Out	std_logic_vector(Nbit-1 downto 0);
            Co:	Out	std_logic);
    end component;
    
    component MUX21_GENERIC is
        Generic (NBIT: integer:= numBit);
        Port (	A:	In	std_logic_vector(NBIT-1 downto 0) ;
            B:	In	std_logic_vector(NBIT-1 downto 0);
            SEL:	In	std_logic;
            Y:	Out	std_logic_vector(NBIT-1 downto 0));
    end component;
signal cout: std_logic_vector(1 downto 0);
signal rca_0_to_mux, rca_1_to_mux: std_logic_vector(3 downto 0);
begin

 RCA_0 : RCA_Gen generic map (4) 
                 port map (A, B, '0', rca_0_to_mux, cout(0)); 
 RCA_1 : RCA_Gen generic map (4) 
                 port map (A, B, '1', rca_1_to_mux, cout(1));      
 MUX : MUX21_GENERIC generic map(4)
                     port map (rca_1_to_mux, rca_0_to_mux, cin, s);                  
           
end Structural;
