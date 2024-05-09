library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PM_timer is
    generic(
        Tphase_mod:integer:=9;
        Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           phase : in STD_LOGIC;
           timer_out : out STD_LOGIC);
end PM_timer;

architecture Behavioral of PM_timer is

type state is (Idle, Timing, OutPulse);
signal present_state, next_state: state;
signal timer: integer range 0 to 255;
signal phase_reg:std_logic; --Register for synchronizing phase input

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

state_update:process(present_state, phase_reg,trigger)
begin
    case present_state is 
    when Idle => 
        timer<=1;
        case trigger and phase_reg is 
        when '1' => next_state<=Timing;
        when others => next_state<=Idle;
        end case;
    when Timing => 
        timer<=Tphase_mod;
        next_state<=OutPulse;
    when OutPulse => 
        timer<=Tone_replica;
        case trigger and phase_reg is 
        when '1' => next_state<=Timing;
        when others => next_state<=Idle;
        end case;
    end case;
end process;

output_updates:process(present_state)
begin 
    case present_state is 
    when Idle => 
        timer_out<='0';
    when Timing => 
        timer_out<='0';
    when OutPulse => 
        timer_out<='1';
    end case;
end process;

synchronize_inputs:process(clk,reset)
begin 
    if reset='0' then 
        phase_reg<='0';
    elsif rising_edge(clk) then 
        phase_reg<=phase;
    end if;
end process;

end Behavioral;