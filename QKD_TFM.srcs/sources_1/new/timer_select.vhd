library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer_select is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           timer1_trig : out STD_LOGIC;
           timer2_trig : out STD_LOGIC);
end timer_select;

architecture Behavioral of timer_select is

type state is (Timer1, Timer2);
signal present_state, next_state:state;
signal sync_pulse_reg:std_logic;

begin

state_transition:process(clk, reset)
begin
    if reset='0' then 
        present_state<= Timer1;
    elsif rising_edge(clk) then  
        present_state<=next_state;
    end if;
end process;

state_update: process(present_state,sync_pulse)
begin 
    case present_state is 
    when Timer1 => 
        case sync_pulse is 
        when '1' => next_state<= Timer2;
        when others => next_state <= Timer1;
        end case;
    when Timer2 => 
        case sync_pulse is 
        when '1' => next_state<=Timer1;
        when others => next_state<=Timer2;
        end case;
    end case;
end process;

output_update:process(present_state,sync_pulse_reg)
begin 
    case present_state is 
    when Timer1 => 
        case sync_pulse_reg is 
        when '1' => timer1_trig<='1'; timer2_trig<='0';
        when others => timer1_trig<='0'; timer2_trig<='0';
        end case;
    when Timer2 => 
        case sync_pulse_reg is 
        when '1' => timer1_trig<='0'; timer2_trig<='1';
        when others => timer1_trig<='0'; timer2_trig<='0';
        end case;
    end case;
end process;

input_register:process(clk,reset)
begin 
    if reset='0' then 
        sync_pulse_reg<='0';
    elsif rising_edge(clk) then 
        sync_pulse_reg<=sync_pulse;
    end if;
end process;

end Behavioral;
