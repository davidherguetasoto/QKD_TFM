library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basys3 is
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        sw: in std_logic_vector(15 downto 0);
        led: out std_logic_vector(15 downto 0);
        JA: out std_logic_vector(7 downto 0);
        JB: out std_logic_vector(7 downto 0)); 
end basys3;

architecture Structural of basys3 is

component top is
     Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC; 
           auto : in std_logic;    -- If active, base and bit will be selected randomly
           early_ext : in STD_LOGIC;   --For leaving the early replica alone in IM
           late_ext : in STD_LOGIC;    --For leaving the late replica alone in IM
           phase_ext : in STD_LOGIC;   --Active for phase modulation
           pi_rad_ext : in std_logic;  --If active, pi rad phase difference between replicas
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);  --Output for the first IM that generates the light pulses
           im_out : out STD_LOGIC_VECTOR (1 downto 0);     --Output for the second IM that modules the intensity of the replicas
           pm_out : out STD_LOGIC_VECTOR (1 downto 0);    --Output for the phase modulator
           phase_base: out std_logic;
           time_base: out std_logic);
end component;

signal reset_aux:std_logic;

begin

inst_top: top
port map(
    clk => clk,
    reset => reset_aux,
    auto => sw(15),
    early_ext => sw(0),
    late_ext => sw(1),
    phase_ext => sw(2),
    pi_rad_ext => sw(3),
    pulse_out(0) => JA(0),
    pulse_out(1) => JA(1),
    im_out(0) => JA(2),
    im_out(1) => JA(3),
    pm_out(0) => JA(4),
    pm_out(1) => JA(5),
    time_base => JB(0),
    phase_base => JB(1));
    
led(3 downto 0) <= sw(3 downto 0);
led(15) <= sw(15);
led(14 downto 4)<= (others => '0');

JB(7 downto 2) <= "000000";
JA(7 downto 6) <= "00";

reset_aux<= not reset;  

end Structural;
