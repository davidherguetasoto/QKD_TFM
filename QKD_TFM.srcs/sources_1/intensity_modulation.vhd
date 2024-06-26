library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intensity_modulation is
    generic(
        Tearly:integer:=8;
        Tlate:integer:=6;
        Ttwo_replicas:integer:=4;
        Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end intensity_modulation;

architecture Structural of intensity_modulation is

component IM_timer is 
    generic(Tearly:integer;
            Tlate:integer;
            Ttwo_replicas:integer;
            Tone_replica:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           timer_out : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end component;

component IM_output_generation is
    Port ( timer_in : in STD_LOGIC;
           ph_mod : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component timer_select is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           timer1_trig : out STD_LOGIC;
           timer2_trig : out STD_LOGIC);
end component;

signal timer_trig:std_logic_vector(1 downto 0);
signal timer_out:std_logic_vector(1 downto 0);
signal ph_mod_timer: std_logic_vector(1 downto 0);
signal timer_in:std_logic;
signal ph_mod: std_logic;

begin

inst_timer_select:timer_select
port map(
    clk => clk,
    reset => reset,
    sync_pulse => sync_pulse,
    timer1_trig => timer_trig(0),
    timer2_trig => timer_trig(1));

inst_IM_output_generation: IM_output_generation
port map(
    timer_in => timer_in,
    ph_mod => ph_mod,
    im_out => im_out);
    
timer_generator: for i in 0 to 1 generate 
    inst_IM_temporization:IM_timer
    generic map(
        Tearly => Tearly,
        Tlate => Tlate,
        Ttwo_replicas => Ttwo_replicas,
        Tone_replica => Tone_replica)
    port map(
        clk => clk,
        reset => reset,
        trigger => timer_trig(i),
        late => late,
        early => early,
        phase => phase,
        timer_out => timer_out(i),
        ph_mod => ph_mod_timer(i));
end generate;         
    
timer_in<=timer_out(0) or timer_out(1);
ph_mod<=ph_mod_timer(0) xor ph_mod_timer(1);

end Structural;
