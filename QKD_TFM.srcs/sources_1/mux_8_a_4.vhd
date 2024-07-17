library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8_a_4 is
    Port ( inputs : in STD_LOGIC_VECTOR (7 downto 0);
           selector : in STD_LOGIC;
           outputs : out STD_LOGIC_VECTOR (3 downto 0));
end mux_8_a_4;

architecture RTL of mux_8_a_4 is

begin

outputs <= inputs(7 downto 4) when selector = '0' else 
           inputs(3 downto 0);
           
end RTL;
