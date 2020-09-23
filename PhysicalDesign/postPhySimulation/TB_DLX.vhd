----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.08.2020 12:10:38
-- Design Name: 
-- Module Name: TB_DLX - Behavioral
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

entity TB_DLX is
--  Port ( );
end TB_DLX;

architecture Behavioral of TB_DLX is
component DLX is
    port (clk:     IN std_logic;
          rst:     IN std_logic;
          DLX_OUT: OUT std_logic_vector(63 downto 0);
          --IRAM SIGNALS
          Dout_IRAM : IN   std_logic_vector(31 downto 0);
          Addr_IRAM : OUT  std_logic_vector(31 downto 0);
          --RAM SIGNALS
          RM:               OUT std_logic;
          WM:               OUT std_logic;
          RM_DOUBLE:        OUT std_logic;
          WM_DOUBLE:        OUT std_logic;
          ALIGN_CTRL:       OUT std_logic_vector(2 downto 0);
          EN3:              OUT std_logic;
          ADDR_RAM: 	    OUT std_logic_vector(31 downto 0);
          DATAIN_RAM: 	    OUT std_logic_vector(63 downto 0);
          DATAOUT_RAM:      IN  std_logic_vector(63 downto 0));
end component;

component DLX_RAM is
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
end component;

component IRAM is
  generic (RAM_DEPTH : integer := 192);
  port (
    Rst  : in  std_logic;
    Addr : in  std_logic_vector(31 downto 0);
    Dout : out std_logic_vector(31 downto 0));

end component;

signal clk, rst: std_logic;
signal DLX_OUT: std_logic_vector(63 downto 0);

signal ADDR_IRAM, DOUT_IRAM: std_logic_vector(31 downto 0);

signal RM, WM, RM_DOUBLE, WM_DOUBLE, EN3: std_logic;
signal ALIGN_CTRL: std_logic_vector(2 downto 0);
signal DATAIN_RAM, DATAOUT_RAM: std_logic_vector(63 downto 0);
signal ADDR_RAM: std_logic_vector(31 downto 0);
begin

IRAM_DLX: IRAM port map (RST => RST,
                         ADDR => ADDR_IRAM,
                         DOUT => DOUT_IRAM); 

RAM: DLX_RAM generic map(5)
             port map (CLK => CLK,
                       RST => RST,
                       RD_M => RM,
                       WR_M => WM,
                       RD_DOUBLE => RM_DOUBLE,
                       WR_DOUBLE => WM_DOUBLE,
                       ALIGN_CTRL => ALIGN_CTRL,
                       EN => EN3,
                       ADDR => ADDR_RAM(4 downto 0),
                       DATAIN => DATAIN_RAM,
                       DATAOUT => DATAOUT_RAM);

DLX_DUT: DLX port map (CLK => CLK,
                       RST => RST,
                       DLX_OUT=> DLX_OUT,
                       --IRAM SIGNALS
                       Dout_IRAM => DOUT_IRAM,
                       Addr_IRAM => ADDR_IRAM,
                      --RAM SIGNALS
                       RM => RM,
                       WM => WM, 
                       RM_DOUBLE => RM_DOUBLE,
                       WM_DOUBLE => WM_DOUBLE,
                       ALIGN_CTRL => ALIGN_CTRL,
                       EN3 => EN3,
                       ADDR_RAM => ADDR_RAM,
                       DATAIN_RAM => DATAIN_RAM,
                       DATAOUT_RAM => DATAOUT_RAM);

    process
    begin
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
    end process;
    
    process
    begin
        wait until clk='1'and clk'event;
        rst <= '1';
        wait until clk='1'and clk'event;
        rst <= '0';
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait until clk='1'and clk'event;
        wait;
    end process;
    
end Behavioral;
