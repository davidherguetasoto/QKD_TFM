library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intensity_modulation is
    generic(
        Tearly:integer:=8;
        Tlate:integer:=6;
        Tphase:integer:=4;
        Tint:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end intensity_modulation;

architecture Structural of intensity_modulation is

component IM_temporization is 
    generic(Tearly:integer;
            Tlate:integer;
            Tphase:integer;
            Tint:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           out_temp : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end component;

component IM_output_generation is
    Port ( temp_in : in STD_LOGIC;
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
signal out_timer:std_logic_vector(1 downto 0);
signal ph_mod_timer: std_logic_vector(1 downto 0);
signal temp_in:std_logic;
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
    temp_in => temp_in,
    ph_mod => ph_mod,
    im_out => im_out);
    
timer_generator: for i in 0 to 1 generate 
    inst_IM_temporization:IM_temporization
    generic map(
        Tearly => Tearly,
        Tlate => Tlate,
        Tphase => Tphase,
        Tint => Tint)
    port map(
        clk => clk,
        reset => reset,
        trigger => timer_trig(i),
        late => late,
        early => early,
        phase => phase,
        out_temp => out_timer(i),
        ph_mod => ph_mod_timer(i));
end generate;         
    
temp_in<=out_timer(0) or out_timer(1);
ph_mod<=ph_mod_timer(0) xor ph_mod_timer(1);

end Structural;
