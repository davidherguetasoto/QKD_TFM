library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_output_generation is
    Port ( timer_in : in STD_LOGIC;
           ph_mod : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end IM_output_generation;

architecture Dataflow of IM_output_generation is

begin

im_out<= "11" when timer_in='1' and ph_mod='0' else 
         "10" when timer_in='1' and ph_mod='1' else 
         "00"; 

end Dataflow;