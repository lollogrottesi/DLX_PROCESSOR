----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.08.2020 10:08:56
-- Design Name: 
-- Module Name: DLX_Fetch_Stage - STructural
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

entity DLX_Fetch_Stage is
    port (clk:      IN std_logic;
          rst:      IN std_logic;
          MUX_sel:  IN std_logic;
          NPC_in:   IN std_logic_vector(31 downto 0);
          NPC_out:  OUT std_logic_vector(31 downto 0);
          IR:       OUT std_logic_vector(31 downto 0);
          --IRAM SIGNALS
          Dout_IRAM : IN   std_logic_vector(31 downto 0);
          Addr_IRAM : OUT  std_logic_vector(31 downto 0));
end DLX_Fetch_Stage;

architecture Structural of DLX_Fetch_Stage is
component Register_Generic_rst is
    generic (N: integer:= 64);
    port (data_in: in std_logic_vector(N-1 downto 0);
          clk:     in std_logic;
          rst:     in std_logic;
          en:      in std_logic;
          data_out: out std_logic_vector(N-1 downto 0));
end component;

signal PC: std_logic_vector(31 downto 0):= (others => '0');
signal NPC, NPC_out_reg: std_logic_vector(31 downto 0):= (others => '0');
signal NIR: std_logic_vector(31 downto 0):= (others => '0');
signal rst_sync : std_logic;
signal sel: std_logic_vector(1 downto 0);
begin
--CONNECT IRAM.
Addr_IRAM <= PC;
NIR       <= Dout_IRAM;

sel <= MUX_sel & rst_sync;

PC <= (others => '0')   when sel="01" else
      (others => '0')   when sel="11" else  
      NPC_in            when sel="10" else  
      NPC_out_reg       when sel="00" ;
                     
NEXT_PC: Register_Generic_rst generic map (32)
                     port map (NPC, clk, rst, '1', NPC_out_reg);--WHEN FLUSH RESET THE NPC.
                    
             
IR_REG: Register_Generic_rst generic map (32)
                     port map (NIR, clk, rst,'1', IR);     
                                    
NPC <= std_logic_vector(unsigned(PC) + 4);

NPC_out <= NPC_out_reg;

    process(clk)
    begin
        if (clk='1'and clk'event) then
            if (rst = '1') then
                rst_sync <= '1';
            else
                rst_sync <= '0';
            end if;
        end if;
    end process;
end Structural;
