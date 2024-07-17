library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pseudo_rng is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in std_logic;
           late : out std_logic;
           early : out std_logic;
           phase : out std_logic;
           pi_rad : out std_logic);
end pseudo_rng;

architecture RTL of pseudo_rng is

signal registers_rng : std_logic_vector(63 downto 0);
signal feedback : std_logic;
signal flag_bloq : std_logic;
signal xor_out : std_logic;
 
constant seed : std_logic_vector(63 downto 0):= "0110011101101010010110010110001011001011110101001101100111100101";
constant zero : std_logic_vector(63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";

begin

process(clk, reset)
begin
    if reset='0' then 
        registers_rng<=zero;
    elsif rising_edge(clk) then
        if enable = '1' then 
            if flag_bloq = '1' then
                registers_rng <= seed;
            else
                registers_rng<= feedback & registers_rng(63 downto 1);
            end if;
        else 
            registers_rng <= zero;
        end if;
    end if;
end process;

flag_bloq <= '1' when registers_rng = zero 
             else '0';
feedback <= registers_rng(1) xor registers_rng(4) xor registers_rng(3) xor registers_rng(0);

xor_out <= registers_rng(14) xor registers_rng(33);
late <= xor_out and registers_rng(14);
early <= xor_out and registers_rng(33);
phase <= not xor_out;
pi_rad <= registers_rng(14) and registers_rng(33);

end RTL;
