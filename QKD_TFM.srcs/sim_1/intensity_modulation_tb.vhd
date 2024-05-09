library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intensity_modulation_tb is
--  Port ( );
end intensity_modulation_tb;

architecture testbench of intensity_modulation_tb is

component intensity_modulation is 
    generic(
        Tearly:integer;
        Tlate:integer;
        Ttwo_replicas:integer;
        Tone_replica:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;
           
signal clk, reset, sync_pulse, early, late, phase:std_logic;
signal im_out: std_logic_vector(1 downto 0);

constant Tclk:time:=10ns;

begin

inst_int_mod: intensity_modulation
    generic map(
        Tlate => 6,
        Tearly => 8,
        Ttwo_replicas => 4, 
        Tone_replica => 2)
    port map(
        clk => clk,
        reset => reset,
        sync_pulse => sync_pulse,
        im_out => im_out,
        early => early,
        late => late,
        phase => phase);
process 
begin
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

process 
begin
    sync_pulse<='1';
    wait for Tclk;
    sync_pulse<='0';
    wait for 9*Tclk;
end process;

reset<='0', '1' after 3*Tclk;

late<='0';
early<='1';
phase<='0';



end testbench;
