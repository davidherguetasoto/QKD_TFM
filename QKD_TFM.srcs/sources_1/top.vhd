library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC; 
           auto : in STD_LOGIC;    -- If active, base and bit will be selected randomly  
           early_ext : in STD_LOGIC;   --For leaving the early replica alone in IM
           late_ext : in STD_LOGIC;    --For leaving the late replica alone in IM
           phase_ext : in STD_LOGIC;   --Active for phase modulation
           pi_rad_ext : in std_logic;  --If active, pi rad phase difference between replicas
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);  --Output for the first IM that generates the light pulses
           im_out : out STD_LOGIC_VECTOR (1 downto 0);     --Output for the second IM that modules the intensity of the replicas
           pm_out : out STD_LOGIC_VECTOR (1 downto 0);  --Output for the phase modulator        
           phase_base: out std_logic;  --If active, phase codification was chosen
           time_base: out std_logic);  --If active, time codification was chosen
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
        Tone_replica:integer;
        Ttwo_replicas:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component phase_modulation is 
    generic(
        Tphase_mod:integer:=9;
        Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           phase : in STD_LOGIC;
           pi_rad: in std_logic;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component mux_8_a_4 is
    Port ( inputs : in STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC;
           outputs : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component pseudo_rng is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in std_logic;
           late : out std_logic;
           early : out std_logic;
           phase : out std_logic;
           pi_rad : out std_logic);
      
end component;

signal sync_pulse_out:std_logic_vector(1 downto 0);
signal sync_pulse_in:std_logic;
signal late, early, phase, pi_rad: std_logic;
signal late_rand, early_rand, phase_rand, pi_rad_rand: std_logic;

constant Tpulse:integer:=9; --Clock cycles until next light pulse
constant Tearly:integer:=8; --Delay in clock cycles - 1 bewteen the signal that generates the pulse and the late replica at the second IM.  
constant Tlate:integer:=6;  --Delay in clock cycles - 1 bewteen the signal that generates the pulse and the early replica at the second IM.
constant Ttwo_replicas:integer:=4; --Clock cycles that the signal for the second intensity mod. must keep active in order to phase mod. 
constant Tone_replica:integer:=2;   --Clock cycles that the signal for the second intensity mod. must keep active in order to int mod.
constant Tphase_mod:integer:=8; --Delay in clock cycles - 2 between the signal that generates the pulse and the early replica at the PM

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
    Tone_replica => Tone_replica,
    Ttwo_replicas => Ttwo_replicas)
port map( 
    clk => clk,
    reset => reset,
    sync_pulse => sync_pulse_in,
    early => early,
    late => late,
    phase => phase,
    im_out => im_out);

inst_phase_modulation:phase_modulation
generic map(
    Tphase_mod => Tphase_mod,
    Tone_replica => Tone_replica)
port map(
    clk => clk,
    reset => reset,
    sync_pulse => sync_pulse_in,
    phase => phase,
    pi_rad => pi_rad,
    pm_out => pm_out);
    
inst_mux: mux_8_a_4 
port map(
    inputs(7) => late_ext,
    inputs(6) => early_ext,
    inputs(5) => phase_ext,
    inputs(4) => pi_rad_ext,
    inputs(3) => late_rand,
    inputs(2) => early_rand,
    inputs(1) => phase_rand,
    inputs(0) => pi_rad_rand,
    outputs(3) => late,
    outputs(2) => early,
    outputs(1) => phase,
    outputs(0) => pi_rad,
    selector => auto); 
    
inst_pseudo_rng: pseudo_rng 
port map(
    reset => reset,
    clk => sync_pulse_in,
    enable => auto,
    late => late_rand,
    early => early_rand,
    phase => phase_rand,
    pi_rad => pi_rad_rand);

pulse_out<=sync_pulse_out;
sync_pulse_in<=sync_pulse_out(0);

phase_base <= phase;
time_base <= early or late;

end Structural;
