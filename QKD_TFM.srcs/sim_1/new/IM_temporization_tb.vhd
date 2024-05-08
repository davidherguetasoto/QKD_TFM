library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_temporization_tb is
--  Port ( );
end IM_temporization_tb;

architecture testbench of IM_temporization_tb is

component IM_temporization is 
    generic(Tearly:integer:=8;
            Tlate:integer:=6;
            Tphase:integer:=4;
            Tint:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           out_temp : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end component;

signal clk, reset, late, early,phase,out_temp,ph_mod, trigger:std_logic;

constant Tclk:time:=10ns;

begin

inst_IM_temporization: IM_temporization
generic map(
    Tearly => 8,
    Tlate => 6,
    Tphase => 4,
    Tint => 2)
port map(
    clk => clk,
    reset => reset,
    late => late,
    early => early,
    phase => phase,
    out_temp => out_temp,
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
