library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity RCA is 
	Port (	A:	In	std_logic_vector(5 downto 0);
		B:	In	std_logic_vector(5 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(5 downto 0);
		Co:	Out	std_logic);
end RCA; 

architecture STRUCTURAL of RCA is

  signal STMP : std_logic_vector(5 downto 0);
  signal CTMP : std_logic_vector(6 downto 0);

  component FA 
  Port ( A:	In	std_logic;
	 B:	In	std_logic;
	 Ci:	In	std_logic;
	 S:	Out	std_logic;
	 Co:	Out	std_logic);
  end component; 

begin

  CTMP(0) <= Ci;
  S <= STMP;
  Co <= CTMP(6);
  
  ADDER1: for I in 1 to 6 generate
    FAI : FA 
	  Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
  end generate;

end STRUCTURAL;

