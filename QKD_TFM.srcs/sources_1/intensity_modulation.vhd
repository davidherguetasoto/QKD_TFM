library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intensity_modulation is
    generic(
        Tearly:integer:=8;
        Tlate:integer:=6);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end intensity_modulation;

architecture Behavioral of intensity_modulation is

type state is (Idle, Counting, IntMod, PhaseMod);
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

state_udate:process(present_state, sync_pulse, early, late, phase)
begin
    case present_state is 
        when Idle => 
            timer<=1;
            if sync_pulse='1' then 
                next_state<=Counting;
            else 
                next_state<=Idle;
            end if;
        when Counting =>
            if early='1' and late='0' and phase='0' then  
                timer<=Tearly;
                next_state<=IntMod;
            elsif early='0' and late='1' and phase='0' then 
                timer<=Tlate;
                next_state<=IntMod;
            elsif early='0' and late='0' and phase='1' then 
                timer<=Tlate;
                next_state<=PhaseMod;
            elsif sync_pulse='1' then 
                timer<=1;
                next_state<= Counting;
            else 
                timer<=1;
                next_state<=Idle;
            end if;
        
        when IntMod => 
            timer<=2;
            if sync_pulse='1' then 
                next_state<=Counting;
            else
                next_state<=Idle;
            end if;
        when PhaseMod =>
            timer<=4;
            if sync_pulse='1' then 
                next_state<=Counting;
            else 
                next_state<=Idle;
            end if;
     end case;
end process;

output_updates:process(present_state)
begin
    case present_state is 
        when Idle => 
            im_out<="00";
        when Counting => 
            im_out<="00";
        when IntMod => 
            im_out<="11";
        when PhaseMod => 
            im_out<="10";
    end case;
end process;
            
end Behavioral;
