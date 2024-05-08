library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intensity_modulation is
    generic(
        Tearly:integer:=8;
        Tlate:integer:=6;
        Tphase:integer:=6);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sync_pulse : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end intensity_modulation;

architecture Structural of intensity_modulation is
begin

            
end Structural;
