library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basys3_tb is
--  Port ( );
end basys3_tb;

architecture testbench of basys3_tb is

component basys3 is 
    Port ( 
        clk: in std_logic;
        reset: in std_logic;
        sw: in std_logic_vector(15 downto 0);
        led: out std_logic_vector(15 downto 0);
        JA: out std_logic_vector(7 downto 0);
        JB: out std_logic_vector(7 downto 0));   
end component;

signal clk,reset:std_logic;
signal sw,led:std_logic_vector(15 downto 0);
signal JA:std_logic_vector(7 downto 0);
signal JB:std_logic_vector(7 downto 0);

constant Tclk:time:=10ns;

begin

inst_basys3: basys3
port map(
    clk => clk,
    reset => reset,
    sw => sw,
    led => led,
    JA => JA,
    JB => JB);
    
process
begin 
    clk<='1';
    wait for Tclk/2;    
    clk<='0';
    wait for Tclk/2;
end process;

reset<= '1', '0' after 3*Tclk;

sw(3 downto 0)<="0001"; --Base and bit manually selected
sw(15)<='1'; --Manual or automatic mode
sw(14 downto 6)<= (others => '0');
sw(5 downto 4) <= "11";

end testbench;
