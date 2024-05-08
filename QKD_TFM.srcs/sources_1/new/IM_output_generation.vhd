----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2024 12:33:32
-- Design Name: 
-- Module Name: IM_output_generation - Behavioral
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

entity IM_output_generation is
    Port ( temp_in : in STD_LOGIC;
           ph_mod : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           im_out : out STD_LOGIC_VECTOR (1 downto 0));
end IM_output_generation;

architecture Behavioral of IM_output_generation is

begin


end Behavioral;
