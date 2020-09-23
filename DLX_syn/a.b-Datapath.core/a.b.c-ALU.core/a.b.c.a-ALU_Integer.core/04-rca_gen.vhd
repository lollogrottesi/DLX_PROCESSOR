library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;

entity RCA_Gen is 
	generic (Nbit: integer:= 6);
	Port (	A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(Nbit-1 downto 0);
		Co:	Out	std_logic);
end RCA_Gen; 

architecture STRUCTURAL of RCA_Gen is

  signal STMP : std_logic_vector(Nbit-1 downto 0);
  signal CTMP : std_logic_vector(Nbit downto 0);

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
  Co <= CTMP(Nbit);
  
  ADDER1: for I in 1 to Nbit generate  --generic rca is composed by n full adder 
    FAI : FA 
	  --generic map (DFAS => DRCAS, DFAC => DRCAC) 
	  Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
  end generate;

end STRUCTURAL;

