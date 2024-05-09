library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity phase_modulation is
    generic(
        Tphase_mod:integer:=9;
        Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           phase : in STD_LOGIC;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end phase_modulation;

architecture Structural of phase_modulation is

component PM_timer is 
    generic(
        Tphase_mod:integer;
        Tone_replica:integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           phase : in STD_LOGIC;
           timer_out : out STD_LOGIC);
end component;

component PM_output_generation is 
    Port ( timer_in : in STD_LOGIC;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component timer_select is 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           timer1_trig : out STD_LOGIC;
           timer2_trig : out STD_LOGIC);
end component;

signal trigger:std_logic_vector(1 downto 0);
signal timer_out:std_logic_vector(1 downto 0);
signal timer_in:std_logic;

begin

inst_timer_select:timer_select
port map(
    clk => clk,
    reset => reset,
    sync_pulse => sync_pulse,
    timer1_trig => trigger(0),
    timer2_trig => trigger(1));

inst_PM_output_generation:PM_output_generation
port map(
    timer_in => timer_in,
    pm_out => pm_out);

generate_timers: for i in 0 to 1 generate 
    inst_PM_timer:PM_timer
        generic map( 
            Tphase_mod => Tphase_mod,
            Tone_replica => Tone_replica)
        port map(
            clk => clk,
            reset => reset,
            trigger => trigger(i),
            phase => phase,
            timer_out => timer_out(i));
end generate;

timer_in<= timer_out(0) or timer_out(1);

end Structural;
