library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity phase_modulation_tb is
--  Port ( );
end phase_modulation_tb;

architecture testbench of phase_modulation_tb is

component phase_modulation is 
    generic(
        Tphase_mod:integer;
        Tone_replica:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           phase : in STD_LOGIC;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal clk,reset,sync_pulse,phase:std_logic;
signal pm_out:std_logic_vector(1 downto 0);

constant Tclk:time:=10ns;

begin

inst_phase_modulation: phase_modulation
    generic map(
        Tphase_mod => 9,
        Tone_replica => 2)
    port map(
        clk => clk,
        reset => reset,
        sync_pulse => sync_pulse,
        phase => phase,
        pm_out => pm_out);
        
process
begin 
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

reset<='0','1' after 3*Tclk;

process
begin
    sync_pulse<='1';
    wait for Tclk;
    sync_pulse<='0';
    wait for 9*Tclk;
end process;

phase<='0','1' after 5*tclk,'0' after 40*tclk;

end testbench;
