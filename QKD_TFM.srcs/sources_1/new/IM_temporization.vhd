library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_temporization is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           out_temp : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end IM_temporization;

architecture Behavioral of IM_temporization is

begin


end Behavioral;
