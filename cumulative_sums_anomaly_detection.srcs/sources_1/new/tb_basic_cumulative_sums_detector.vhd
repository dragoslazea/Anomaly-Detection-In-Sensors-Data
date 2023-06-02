library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity tb_basic_cumulative_sums_detector is
end tb_basic_cumulative_sums_detector;

architecture Behavioral of tb_basic_cumulative_sums_detector is

component cumulative_sums_detector is
    Port ( 
           -- control inputs
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           -- data inputs
           current_sensor_in_data : in STD_LOGIC_VECTOR (31 downto 0);
           current_sensor_in_ready : out STD_LOGIC;
           current_sensor_in_valid : in STD_LOGIC;
           
           previous_sensor_in_data : in STD_LOGIC_VECTOR (31 downto 0);
           previous_sensor_in_ready : out STD_LOGIC;
           previous_sensor_in_valid : in STD_LOGIC;
           
           threshold_data : in STD_LOGIC_VECTOR (31 downto 0);
           threshold_ready : out STD_LOGIC;
           threshold_valid : in STD_LOGIC;
           
           drift_data : in STD_LOGIC_VECTOR (31 downto 0);
           drift_ready : out STD_LOGIC;
           drift_valid : in STD_LOGIC;
           
           -- outputs
           abnormal_data : out STD_LOGIC;
           abnormal_ready : in STD_LOGIC;
           abnormal_valid : out STD_LOGIC;
           
           timestamp_data : out STD_LOGIC_VECTOR (31 downto 0);
           timestamp_ready : in STD_LOGIC;
           timestamp_valid : out STD_LOGIC);
end component;

constant T : time := 20 ns;

signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC := '0';
signal nrst : STD_LOGIC := '1';
signal init : STD_LOGIC := '0';

-- data signals
signal Tt, Tt_1, th, drift, timestamp : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal abnormal : STD_LOGIC := '0';

-- ready signals
signal Tt_ready, Tt_1_ready, th_ready, drift_ready, timestamp_ready, abnormal_ready : STD_LOGIC;

-- valid signals
signal Tt_valid, Tt_1_valid, th_valid, drift_valid, timestamp_valid, abnormal_valid : STD_LOGIC;


begin

    clk <= not clk after T / 2;
    init <= '0', '1' after 6 * T, '0' after 15 * T, '1' after 17 * T, '0' after 19 * T;
    --nrst <= '1', '0' after T, '1' after 5 * T;
    nrst <= '0', '1' after 5 * T;
    
    DUT : cumulative_sums_detector port map (
        clk => clk,
        rst => nrst,
        current_sensor_in_data => Tt,
        current_sensor_in_ready => Tt_ready,
        current_sensor_in_valid => Tt_valid,
        previous_sensor_in_data => Tt_1,
        previous_sensor_in_ready => Tt_1_ready,
        previous_sensor_in_valid => Tt_1_valid,
        drift_data => "00111111000000000000000000000000", -- 0.5
        drift_ready => drift_ready,
        drift_valid => drift_valid,
        threshold_data => "01000000000000000000000000000000", -- 2.0
        threshold_ready => th_ready,
        threshold_valid => th_valid,
        abnormal_data => abnormal,
        abnormal_ready => abnormal_ready,
        abnormal_valid => abnormal_valid,
        timestamp_data => timestamp,
        timestamp_ready => timestamp_ready,
        timestamp_valid => timestamp_valid
    );
    
    Tt_valid <= '0', '1' after 20 * T;
    Tt_1_valid <= '0', '1' after 20 * T;
    th_valid <= '0', '1' after 20 * T;
    drift_valid <= '0', '1' after 20 * T;
    abnormal_ready <= '1';
    timestamp_ready <= '1';
    
    --Tt <= "01000001101100000000000000000000"; -- 22.0
    --Tt_1 <= "01000001101011000000000000000000"; -- 21.5
    
    --Tt <= "01000001101111011000010100011111"; -- 23.69
    --Tt_1 <= "01000001101111001111010111000011"; -- 23.62
    
    Tt <= "01000010001100101100001010001111"; -- 44.69
    Tt_1 <= "01000010010001000011110101110001"; -- 49.06


end Behavioral;
