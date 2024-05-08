library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulse_generator_tb is
--  Port ( );
end pulse_generator_tb;

architecture testbench of pulse_generator_tb is

component pulse_generation is 
    generic(Tpulse: integer);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal clk,reset:std_logic;
signal pulse_out:std_logic_vector(1 downto 0);
constant Tclk:time:=10ns;

begin

inst_puse_generation:pulse_generation
generic map (Tpulse => 9)
port map(
    clk => clk,
    reset => reset,
    pulse_out => pulse_out);

process 
begin
    clk<='1';
    wait for Tclk/2;
    clk<='0';
    wait for Tclk/2;
end process;

reset<='0', '1' after 3*Tclk;


end testbench;
