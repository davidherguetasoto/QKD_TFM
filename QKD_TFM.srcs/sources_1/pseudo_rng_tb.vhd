library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pseudo_rng is
end tb_pseudo_rng;

architecture testbench of tb_pseudo_rng is

    -- Component Declaration for the Unit Under Test (UUT)
    component pseudo_rng
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in std_logic;
           late : out std_logic;
           early : out std_logic;
           phase : out std_logic;
           pi_rad : out std_logic);
    end component;

    -- Signals for connecting to UUT
    signal reset : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal late : STD_LOGIC;
    signal early : STD_LOGIC;
    signal phase : STD_LOGIC;
    signal pi_rad : STD_LOGIC;

    -- Clock period definition (100 MHz)
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: pseudo_rng Port map (
          reset => reset,
          clk => clk,
          enable => enable,
          late => late,
          early => early,
          phase => phase,
          pi_rad => pi_rad
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 20 ns.
        reset <= '0';
        wait for 20 ns;
        
        reset <= '1';
        wait for 20 ns;

        -- Enable the PRNG
        enable <= '1';
        wait for 200 ns;
        
        -- Disable the PRNG
        enable <= '0';
        wait for 40 ns;

        -- Re-enable the PRNG
        enable <= '1';
        wait for 200 ns;
        
        -- Add more stimulus as needed
        wait;
    end process;

end testbench;