library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity phase_modulation is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           pi_rad : in STD_LOGIC;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end phase_modulation;

architecture Behavioral of phase_modulation is

begin


end Behavioral;
