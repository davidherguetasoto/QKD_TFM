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

signal reg_rng : std_logic_vector(63 downto 0);
signal feedback : std_logic;
signal flag_bloq : std_logic;
signal xor_out : std_logic;
 
constant seed : std_logic_vector(63 downto 0):= "0110011101101010010110010110001011001011110101001101100111100101";
constant zero : std_logic_vector(63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";

begin

process(clk, reset)
begin
    if reset='0' then 
        reg_rng<=seed;
    elsif rising_edge(clk) then
        if enable = '1' then 
            if flag_bloq = '1' then
                reg_rng <= seed;
            else
                reg_rng<= feedback & reg_rng(63 downto 1);
            end if;
        end if;
    end if;
end process;

flag_bloq <= '1' when reg_rng = zero 
             else '0';
feedback <= reg_rng(1) xor reg_rng(4) xor reg_rng(3) xor reg_rng(0);

xor_out <= reg_rng(14) xor reg_rng(33);
late <= xor_out and reg_rng(14) and enable;
early <= xor_out and reg_rng(33) and enable;
phase <= enable and (not xor_out);
pi_rad <= reg_rng(14) and reg_rng(33) and enable;

end RTL;
