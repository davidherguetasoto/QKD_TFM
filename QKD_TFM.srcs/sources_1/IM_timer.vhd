library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IM_timer is
    generic(Tearly:integer:=8;
            Tlate:integer:=6;
            Ttwo_replicas:integer:=4;
            Tone_replica:integer:=2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           trigger : in STD_LOGIC;
           late : in STD_LOGIC;
           early : in STD_LOGIC;
           phase : in STD_LOGIC;
           timer_out : out STD_LOGIC;
           ph_mod : out STD_LOGIC);
end IM_timer;

architecture Behavioral of IM_timer is

type state is (Idle, TempLate, TempEarly, TempPhase, IntMod, PhaseMod);
signal present_state, next_state: state;
signal timer: integer range 0 to 255;
signal late_reg, early_reg, phase_reg : std_logic; --Registers for inputs synchronization

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

state_update:process(present_state, phase_reg, late_reg, early_reg,trigger)
begin 
    case present_state is 
        when Idle => 
            timer<=1;
            case trigger is 
            when '1' =>
                if late_reg='1' and early_reg='0' and phase_reg='0' then 
                    next_state<=TempLate;
                elsif early_reg='1' and late_reg='0' and phase_reg='0' then 
                    next_state<=TempEarly;
                elsif phase_reg='1' and early_reg='0' and late_reg='0' then
                    next_state<=TempPhase;
                else 
                    next_state<=Idle;
                end if;
            when others => next_state<=Idle;
            end case;        
        when TempLate=> 
            timer<=Tlate;   
            next_state<=IntMod;        
        when TempEarly=> 
            timer<=Tearly;
            next_state<=IntMod;
        when TempPhase=> 
            timer<=Tlate;
            next_state<=PhaseMod;
        when IntMod => 
            timer<=Tone_replica;
            case trigger is 
            when '1' =>
                if late_reg='1' and early_reg='0' and phase_reg='0' then 
                    next_state<=TempLate;
                elsif early_reg='1' and late_reg='0' and phase_reg='0' then 
                    next_state<=TempEarly;
                elsif phase_reg='1' and early_reg='0' and late_reg='0' then
                    next_state<=TempPhase;
                else 
                    next_state<=Idle;
                end if;
            when others => next_state<=Idle;
            end case;
        when PhaseMod => 
            timer<=Ttwo_replicas; 
            case trigger is 
            when '1' =>
                if late_reg='1' and early_reg='0' and phase_reg='0' then 
                    next_state<=TempLate;
                elsif early_reg='1' and late_reg='0' and phase_reg='0' then 
                    next_state<=TempEarly;
                elsif phase_reg='1' and early_reg='0' and late_reg='0' then
                    next_state<=TempPhase;
                else 
                    next_state<=Idle;
                end if;
            when others => next_state<=Idle;
            end case;
   end case;
end process;            

output_updates: process(present_state)
begin 
    case present_state is 
    when Idle=> 
        timer_out<='0';
        ph_mod<='0';
    when TempLate=> 
        timer_out<='0';
        ph_mod<='0';
    when TempEarly=> 
        timer_out<='0';
        ph_mod<='0';
    when TempPhase=> 
        timer_out<='0';
        ph_mod<='0';
    when IntMod=> 
        timer_out<='1';
        ph_mod<='0';
    when PhaseMod=> 
        timer_out<='1';
        ph_mod<='1';
    end case;
end process;

input_synchronization:process(clk, reset)
begin 
    if reset='0' then 
        early_reg<='0';
        phase_reg<='0';
        late_reg<='0';
       -- trigger_reg<='0';
    elsif rising_edge(clk) then 
        early_reg<=early;
        phase_reg<=phase;
        late_reg<=late;
      --  trigger_reg<=trigger;
    end if;
end process;

end Behavioral;
