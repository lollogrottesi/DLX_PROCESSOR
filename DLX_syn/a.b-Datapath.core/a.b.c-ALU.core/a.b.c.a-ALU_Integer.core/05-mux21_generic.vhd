library IEEE;
use ieee.numeric_std;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
--use WORK.constants.all; -- libreria WORK user-defined

entity MUX21_GENERIC is
	Generic (NBIT: integer:= 4);
	Port (	A:	In	std_logic_vector(NBIT-1 downto 0) ;
		B:	In	std_logic_vector(NBIT-1 downto 0);
		SEL:	In	std_logic;
		Y:	Out	std_logic_vector(NBIT-1 downto 0));
end MUX21_GENERIC;



architecture MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is

begin
  process(A, B, SEL)
    begin
      if (SEL ='1')then
        Y <= A ;
      else
        Y <= B;
      end if;
  end process;


end MUX21_GEN_BEHAVIORAL;



