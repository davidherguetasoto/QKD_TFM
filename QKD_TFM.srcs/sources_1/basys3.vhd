library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basys3 is
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        sw: in std_logic_vector(3 downto 0);
        led: out std_logic_vector(3 downto 0);
        JA: out std_logic_vector(5 downto 0));   
end basys3;

architecture Structural of basys3 is

component top is
     Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;   
           early : in STD_LOGIC;   --For leaving the early replica alone in IM
           late : in STD_LOGIC;    --For leaving the late replica alone in IM
           phase : in STD_LOGIC;   --Active for phase modulation
           pi_rad : in std_logic;  --If active, pi rad phase difference between replicas
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);  --Output for the first IM that generates the light pulses
           im_out : out STD_LOGIC_VECTOR (1 downto 0);     --Output for the second IM that modules the intensity of the replicas
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));    --Output for the phase modulator
end component;

signal reset_aux:std_logic;

begin

inst_top: top
port map(
    clk => clk,
    reset => reset_aux,
    early => sw(0),
    late => sw(1),
    phase => sw(2),
    pi_rad => sw(3),
    pulse_out(0) => JA(0),
    pulse_out(1) => JA(1),
    im_out(0) => JA(2),
    im_out(1) => JA(3),
    pm_out(0) => JA(4),
    pm_out(1) => JA(5));
    
led <= sw;

reset_aux<= not reset;  

end Structural;
