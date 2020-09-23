----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2020 14:26:27
-- Design Name: 
-- Module Name: REG_FILE_MONO - Behavioral
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

entity DLX_RF is
    port ( CLK: 	  IN std_logic;
           RST:       IN std_logic;
           ENABLE: 	  IN std_logic;
           RD1: 	  IN std_logic;
           RD2: 	  IN std_logic;
           RD_DOUBLE: IN std_logic;
           WR_DOUBLE: IN std_logic;
           WR: 		  IN std_logic;
           ADD_WR: 	  IN std_logic_vector(4 downto 0);
           ADD_RD1:   IN std_logic_vector(4 downto 0);
           ADD_RD2:   IN std_logic_vector(4 downto 0);
           DATAIN: 	  IN std_logic_vector(63 downto 0);
           OUT1: 	  OUT std_logic_vector(63 downto 0);
           OUT2: 	  OUT std_logic_vector(63 downto 0));
end DLX_RF;

architecture Behavioral of DLX_RF is
    -- suggested structure
    subtype REG_ADDR is integer range 0 to 31;      -- using integer type, define address.
    subtype WORD is std_logic_vector(31 downto 0);  -- define word length.
    type REG_ARRAY is array(REG_ADDR) of WORD;      -- define type ragister.
    --Current register and Next register signal instantiation. 
    signal regFile: REG_ARRAY;

    signal write_op, syn_rst: std_logic;
begin
--Case wr=1 and rst=1 must be handled to we defined write_op signal to avoid conflicts.
write_op <= (not RST) and WR; 

   sync_process:
    process(CLK)
    begin
        
        if (CLK='1' and CLK'event) then
            if (RST = '1') then
                regFile <= (others => (others => '0'));
            else
                --Read signals.
                if (ENABLE = '0') then
                    OUT1 <= (others => '0');
                    OUT2 <= (others => '0');
                else  
                    if (RD1 = '1') then
                        if (ADD_RD1 = "00000") then
                            OUT1 <= (others => '0');
                        else
                            if(RD_DOUBLE = '1') then
                                OUT1(63 downto 32) <= regFile(to_integer(unsigned(ADD_RD1)));
                                OUT1(31 downto 0)  <= regFile(to_integer(unsigned(ADD_RD1))+1);
                            else
                                OUT1(63 downto 32) <= (others=>'0');
                                OUT1(31 downto 0) <= regFile(to_integer(unsigned(ADD_RD1)));
                            end if; 
                        end if; 
                    else
                        OUT1 <= (others => '0');
                    end if;
                    
                    if (RD2 = '1') then
                        if (ADD_RD2 = "00000") then
                            OUT2 <= (others => '0');
                        else
                            if(RD_DOUBLE = '1') then
                                OUT2(63 downto 32) <= regFile(to_integer(unsigned(ADD_RD2)));
                                OUT2(31 downto 0)  <= regFile(to_integer(unsigned(ADD_RD2))+1);
                            else
                                OUT2(63 downto 32) <= (others=>'0');
                                OUT2(31 downto 0) <= regFile(to_integer(unsigned(ADD_RD2)));
                            end if; 
                        end if;
                    else
                        OUT2 <= (others => '0');
                    end if;
                end if; 
            end if;
       end if;      
       if (clk = '0') then
        
            if (write_op = '1' and unsigned(ADD_WR) > 0) then        --IF write enable.
                if (WR_DOUBLE = '1') then
                --Write double value.   
                    regFile(to_integer(unsigned(ADD_WR)))   <= DATAIN(63 downto 32);
                    regFile(to_integer(unsigned(ADD_WR)+1)) <= DATAIN(31 downto 0);
                else
                --Write single value.  
                    regFile(to_integer(unsigned(ADD_WR))) <= DATAIN(31 downto 0);
                end if;
            end if;
            
         end if;      
    end process sync_process;

end Behavioral;
