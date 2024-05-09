library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer_select_tb is
--  Port ( );
end timer_select_tb;

architecture testbench of timer_select_tb is

component timer_select is 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           timer1_trig : out STD_LOGIC;
           timer2_trig : out STD_LOGIC);
end component;

signal clk, reset, sync_pulse, timer1_trig, timer2_trig:std_logic;

constant Tclk:time:=10ns;

begin

inst_timer_select: timer_select
port map(
    clk => clk,
    reset => reset, 
    sync_pulse => sync_pulse,
    timer1_trig => timer1_trig,
    timer2_trig => timer2_trig);
    
process 
begin
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

reset<='0', '1' after 3*Tclk;

process 
begin 
    sync_pulse<='1';
    wait for Tclk;
    sync_pulse<='0';
    wait for 9*Tclk;
end process;

end testbench;
