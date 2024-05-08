----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2024 17:08:46
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           early : in STD_LOGIC;
           late : in STD_LOGIC;
           phase : in STD_LOGIC;
           pi_rad : in STD_LOGIC;
           pulse_out : out STD_LOGIC_VECTOR (1 downto 0);
           im_out : out STD_LOGIC_VECTOR (1 downto 0);
           pm_out : out STD_LOGIC_VECTOR (1 downto 0));
end top;

architecture Behavioral of top is

begin


end Behavioral;
