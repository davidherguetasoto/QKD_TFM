library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulse_generation is
    generic(Tpulse: integer:=9);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0));
end pulse_generation;

architecture Behavioral of pulse_generation is

type state is (Idle, Pulse);
signal present_state, next_state: state;
signal timer: integer range 0 to 255;

begin

state_transition:process(clk, reset)
variable count: integer range 0 to 255;
begin
    if reset='0' then 
        present_state<= Idle;
        count:=0;
    elsif rising_edge(clk) then 
        count:=count+1;
        if count >=timer then 
            present_state<=next_state;
            count:=0;
        end if;
    end if;
end process;

state_update:process(present_state)
begin
    case present_state is 
        when Idle => 
            timer<=Tpulse;
            next_state<=Pulse;
        when Pulse => 
            timer<=1;
            next_state<=Idle;
     end case;
end process;

output_updates:process(present_state)
begin
    case present_state is 
        when Idle => 
            pulse_out<="00";
        when Pulse => 
            pulse_out<="11";
    end case;
end process;
            
end Behavioral;
