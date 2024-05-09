library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PM_output_generation is
    Port ( timer_in : in STD_LOGIC;
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end PM_output_generation;

architecture Dataflow of PM_output_generation is
    
begin

pm_out<="11" when timer_in='1' else
        "00";

end Dataflow;
