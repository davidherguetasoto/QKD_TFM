library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_output_generation_tb is
--  Port ( );
end IM_output_generation_tb;

architecture testbench of IM_output_generation_tb is

component IM_output_generation is 
    Port ( timer_in : in STD_LOGIC;
           ph_mod : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal timer_in,ph_mod: std_logic;
signal im_out: std_logic_vector(1 downto 0);

constant Tclk:time:=10ns;

begin

inst_IM_output_generation: IM_output_generation
port map( 
    timer_in => timer_in, 
    ph_mod => ph_mod,
    im_out => im_out);    

ph_mod<='0','1' after 6*Tclk, '0' after 10*Tclk;
timer_in<='0', '1' after 5*Tclk, '0' after 15*Tclk;

end testbench;
