library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_timer_tb is
--  Port ( );
end IM_timer_tb;

architecture testbench of IM_timer_tb is

component IM_timer is 
    generic(Tearly:integer:=8;
            Tlate:integer:=6;
            Ttwo_replicas:integer:=4;
            Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           timer_out : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end component;

signal clk, reset, late, early,phase,timer_out,ph_mod, trigger:std_logic;

constant Tclk:time:=10ns;

begin

inst_IM_timer: IM_timer
generic map(
    Tearly => 8,
    Tlate => 6,
    Ttwo_replicas => 4,
    Tone_replica => 2)
port map(
    clk => clk,
    reset => reset,
    late => late,
    early => early,
    phase => phase,
    timer_out => timer_out,
    ph_mod => ph_mod,
    trigger => trigger);

process 
begin 
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

reset<= '0','1' after 3*Tclk;

process
begin 
    trigger<='1';
    wait for Tclk;
    trigger<='0';
    wait for 12*Tclk;
end process;

early<='0';
late<='1';
phase<='0';

end testbench;
