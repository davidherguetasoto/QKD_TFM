library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           pi_rad : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);
           im_out : out STD_LOGIC_VECTOR (1 downto 0);
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end top;

architecture Structural of top is

component pulse_generation is 
    generic(Tpulse: integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component intensity_modulation is 
    generic(
        Tearly:integer;
        Tlate:integer;
        Tphase:integer;
        Tint:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal sync_pulse_out:std_logic_vector(1 downto 0);
signal sync_pulse_in:std_logic;

constant Tpulse:integer:=9; --Clock cycles until next pulse
constant Tearly:integer:=8; --Clock cycles until signal activation for early intensity modulation
constant Tlate:integer:=6;  --Clock cycles until signal activation for early intensity modulation
constant Tphase:integer:=4; --Clock cycles along the signal of the intensity mod. must keep active for phase mod. 
constant Tint:integer:=2;   --Clock cycles along the signal of the intensity mod. must keep active for int mod.

begin

inst_pulse_generation:pulse_generation
generic map(Tpulse => Tpulse)
port map(
    clk => clk,
    reset => reset,
    pulse_out => sync_pulse_out);

inst_intensity_modulation:intensity_modulation
generic map(
    Tearly => Tearly,
    Tlate => Tlate,
    Tphase => Tphase,
    Tint => Tint)
port map( 
    clk => clk,
    reset => reset,
    sync_pulse => sync_pulse_in,
    early => early,
    late => late,
    phase => phase,
    im_out => im_out);

pulse_out<=sync_pulse_out;
sync_pulse_in<=sync_pulse_out(0) or sync_pulse_out(1);
pm_out<="00";

end Structural;
