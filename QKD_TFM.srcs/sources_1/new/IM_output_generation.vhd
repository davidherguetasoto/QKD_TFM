library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_output_generation is
    Port ( temp_in : in STD_LOGIC;
           ph_mod : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end IM_output_generation;

architecture Behavioral of IM_output_generation is

type state is (Idle, IntMod, PhaseMod);
signal present_state, next_state: state;

begin

state_transition:process(clk, reset)
begin
    if reset='0' then 
        present_state<= Idle;
    elsif rising_edge(clk) then 
        present_state<=next_state;
    end if;
end process;

state_update:process(present_state, temp_in, ph_mod)
begin
    case present_state is 
    when Idle => 
        case temp_in is        
        when '1' => 
            case ph_mod is 
            when '1' => next_state<=PhaseMod;
            when others => next_state<=IntMod;
            end case;
        when others => next_state<=Idle;
        end case;
    when IntMod => 
        case temp_in is        
        when '1' => 
            case ph_mod is 
            when '1' => next_state<=PhaseMod;
            when others => next_state<=IntMod;
            end case;
        when others => next_state<=Idle;
        end case;
    when PhaseMod => 
        case temp_in is        
        when '1' => 
            case ph_mod is 
            when '1' => next_state<=PhaseMod;
            when others => next_state<=IntMod;
            end case;
        when others => next_state<=Idle;
        end case;
    end case;
end process;

output_update:process(present_state)
begin 
    case present_state is 
    when Idle => im_out<="00";
    when IntMod => im_out<="11";
    when PhaseMod => im_out<="10";
    end case;
end process; 

end Behavioral;