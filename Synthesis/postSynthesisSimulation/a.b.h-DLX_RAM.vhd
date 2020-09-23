----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.08.2020 11:01:44
-- Design Name: 
-- Module Name: DLX_RAM - Behavioral
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

entity DLX_RAM is
    generic (Addr_l: integer := 10);    
    port ( CLK: 	  IN std_logic;
           RST:       IN std_logic;
           RD_M:      IN std_logic;
           WR_M:      IN std_logic;
           RD_DOUBLE: IN std_logic;
           WR_DOUBLE: IN std_logic;
           ALIGN_CTRL:IN std_logic_vector(2 downto 0);
           EN:   	  IN std_logic;
           ADDR: 	  IN std_logic_vector(Addr_l-1 downto 0);
           DATAIN: 	  IN std_logic_vector(63 downto 0);
           DATAOUT:   OUT std_logic_vector(63 downto 0));
end DLX_RAM;

architecture Behavioral of DLX_RAM is

type RAM_TYPE is array (0 to 2**Addr_l-1) of std_logic_vector(7 downto 0);
signal ram : RAM_TYPE;
begin
    
    process(CLK)
    begin
        if (CLK='0' and CLK'event) then 
            if (RST = '1') then
                ram <= (others => (others => '0'));
            else          
                if (EN = '0') then
                    DATAOUT <= (others => '0');
                else    --EN = '0'. 
                    --READ.
                    if (RD_M = '1') then
                        if (RD_DOUBLE = '1') then
                            DATAOUT(7 downto 0)   <= ram  (to_integer(unsigned(ADDR)) +7);
                            DATAOUT(15 downto 8)  <= ram  (to_integer(unsigned(ADDR)) +6);
                            DATAOUT(23 downto 16) <= ram  (to_integer(unsigned(ADDR)) +5);
                            DATAOUT(31 downto 24) <= ram  (to_integer(unsigned(ADDR)) +4);
                            DATAOUT(39 downto 32) <= ram  (to_integer(unsigned(ADDR)) +3);
                            DATAOUT(47 downto 40) <= ram  (to_integer(unsigned(ADDR)) +2);
                            DATAOUT(55 downto 48) <= ram  (to_integer(unsigned(ADDR)) +1);
                            DATAOUT(63 downto 56) <= ram  (to_integer(unsigned(ADDR)) ); 
                        else
                            DATAOUT(7 downto 0)   <= ram  (to_integer(unsigned(ADDR)) +3);
                            DATAOUT(15 downto 8)  <= ram  (to_integer(unsigned(ADDR)) +2);
                            DATAOUT(23 downto 16) <= ram  (to_integer(unsigned(ADDR)) +1);
                            DATAOUT(31 downto 24) <= ram  (to_integer(unsigned(ADDR)) );
                            DATAOUT(63 downto 32) <= (others => '0');
                        end if;
                    end if;   
                
                end if;
            end if;
--		else             
            if (WR_M = '1') then 
                if (WR_DOUBLE = '1') then     --DOUBLE
                    ram  (to_integer(unsigned(ADDR))+7) <= DATAIN(7 downto 0);
                    ram  (to_integer(unsigned(ADDR))+6) <= DATAIN(15 downto 8);
                    ram  (to_integer(unsigned(ADDR))+5) <= DATAIN(23 downto 16);
                    ram  (to_integer(unsigned(ADDR))+4) <= DATAIN(31 downto 24);
                    ram  (to_integer(unsigned(ADDR))+3) <= DATAIN(39 downto 32);
                    ram  (to_integer(unsigned(ADDR))+2) <= DATAIN(47 downto 40);
                    ram  (to_integer(unsigned(ADDR))+1) <= DATAIN(55 downto 48);
                    ram  (to_integer(unsigned(ADDR)))   <= DATAIN(63 downto 56);
                elsif (ALIGN_CTRL = "110") then --BYTE
                    ram  (to_integer(unsigned(ADDR)))   <= DATAIN(7 downto 0);
                elsif (ALIGN_CTRL = "111") then --HALFWORD
                    ram  (to_integer(unsigned(ADDR))+1) <= DATAIN(7 downto 0);
                    ram  (to_integer(unsigned(ADDR)))   <= DATAIN(15 downto 8);
                else                           --WORD
                    ram  (to_integer(unsigned(ADDR))+3) <= DATAIN(7 downto 0);
                    ram  (to_integer(unsigned(ADDR))+2) <= DATAIN(15 downto 8);
                    ram  (to_integer(unsigned(ADDR))+1) <= DATAIN(23 downto 16);
                    ram  (to_integer(unsigned(ADDR)))   <= DATAIN(31 downto 24);
                end if;  
            end if;
        end if;
    end process;
    
end Behavioral;