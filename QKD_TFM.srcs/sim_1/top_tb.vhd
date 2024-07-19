library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
--  Port ( );
end top_tb;

architecture testbench of top_tb is

component top is 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           auto : in std_logic;
           early_ext : in STD_LOGIC;
           late_ext : in STD_LOGIC;
           phase_ext : in STD_LOGIC;
           pi_rad_ext: in std_logic;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);
           im_out : out STD_LOGIC_VECTOR (1 downto 0);
           pm_out : out STD_LOGIC_VECTOR (1 downto 0);
           phase_base: out std_logic;
           time_base: out std_logic);
end component;

signal clk,reset,auto,early,late,phase, pi_rad:std_logic;
signal im_out,pm_out,pulse_out: std_logic_vector(1 downto 0);
signal time_base, phase_base:std_logic;

constant Tclk:time:=10ns;

begin

inst_top:top 
port map(
    clk => clk,
    reset => reset,
    auto => auto,
    early_ext => early,
    late_ext => late,
    phase_ext => phase,
    pi_rad_ext => pi_rad,
    pulse_out => pulse_out,
    im_out => im_out,
    pm_out => pm_out,
    time_base => time_base,
    phase_base => phase_base);
    
process 
begin
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

reset<='0', '1' after 3*Tclk;

early<='1';
late<='0';
phase<='0';
auto<='1';

process
begin
    pi_rad<='1';
    wait for 15*Tclk;
    pi_rad<='0';
    wait for 15*Tclk;
end process;

end testbench;
