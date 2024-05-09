library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
--  Port ( );
end top_tb;

architecture testbench of top_tb is

component top is 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           pi_rad : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);
           im_out : out STD_LOGIC_VECTOR (1 downto 0);
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal clk,reset,early,late,phase,pi_rad:std_logic;
signal im_out,pm_out,pulse_out: std_logic_vector(1 downto 0);

constant Tclk:time:=10ns;

begin

inst_top:top 
port map(
    clk => clk,
    reset => reset,
    early => early,
    late => late,
    phase => phase,
    pi_rad => pi_rad,
    pulse_out => pulse_out,
    im_out => im_out,
    pm_out => pm_out);
    
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
pi_rad<='0';

end testbench;
