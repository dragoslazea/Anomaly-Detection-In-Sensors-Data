library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.STD_lOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_int_cumulative_sums_detector is
end tb_int_cumulative_sums_detector;

architecture Behavioral of tb_int_cumulative_sums_detector is

component int_cumulative_sums_detector is
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


signal rd_count, wr_count : integer := 0;

type measurements_type is array (0 to 5000) of std_logic_vector (31 downto 0);
signal measurements : measurements_type := (others => (others => '0'));

begin

    clk <= not clk after T / 2;
    init <= '0', '1' after 6 * T, '0' after 15 * T, '1' after 17 * T, '0' after 19 * T;
    nrst <= '0', '1' after 5 * T;
    
    DUT : int_cumulative_sums_detector port map (
        clk => clk,
        rst => nrst,
        current_sensor_in_data => Tt,
        current_sensor_in_ready => Tt_ready,
        current_sensor_in_valid => Tt_valid,
        previous_sensor_in_data => Tt_1,
        previous_sensor_in_ready => Tt_1_ready,
        previous_sensor_in_valid => Tt_1_valid,
        drift_data => "00000000000000000000000000110010", -- 50
        drift_ready => drift_ready,
        drift_valid => '1',
        threshold_data => "00000000000000000000000011001000", -- 200
        threshold_ready => th_ready,
        threshold_valid => '1',
        abnormal_data => abnormal,
        abnormal_ready => abnormal_ready,
        abnormal_valid => abnormal_valid,
        timestamp_data => timestamp,
        timestamp_ready => timestamp_ready,
        timestamp_valid => timestamp_valid
    );
    
    --Tt_valid <= '0', '1' after 20 * T;
    --Tt_1_valid <= '0', '1' after 20 * T;
    --th_valid <= '0', '1' after 20 * T;
    --drift_valid <= '0', '1' after 20 * T;
    abnormal_ready <= '1';
    timestamp_ready <= '1';
    
    process
        file sensors_data : text open read_mode is "04-12-22_measurements_int_bin.csv";
        variable in_line : line;
        
        
        variable current_timestamp : string(1 to 16);
        variable t_ds18b20 : std_logic_vector(31 downto 0);
        variable t_dht11 : std_logic_vector(31 downto 0);
        variable t_lm35dz : std_logic_vector(31 downto 0);
        variable t_bmp180 : std_logic_vector(31 downto 0);
        variable t_thermistor : std_logic_vector(31 downto 0);
        variable t_dht22 : std_logic_vector(31 downto 0);
        variable space : character;
        variable comma : character;
        
        function to_string(lvec: in std_logic_vector) return string is
            variable text: string(lvec'length-1 downto 0) := (others => '9');
        begin
            for k in lvec'range loop
                case lvec(k) is
                    when '0' => text(k) := '0';
                    when '1' => text(k) := '1';
                    when 'U' => text(k) := 'U';
                    when 'X' => text(k) := 'X';
                    when 'Z' => text(k) := 'Z';
                    when '-' => text(k) := '-';
                    when others => text(k) := '?';
                end case;
            end loop;
            
            return text;
        end function;
    
    begin
        wait until rising_edge(clk);
        
        if nrst = '0' then
            wait until rising_edge(nrst);
        end if;
        
        -- while not endfile(sensors_data) loop
        if not endfile(sensors_data) then     
            
            if Tt_ready = '1' and Tt_1_ready = '1' then
                readline(sensors_data, in_line);
                read(in_line, current_timestamp);
            
                Tt_1 <= Tt;
                
                Tt_valid <= '1';
                Tt_1_valid <= '1';
                th_valid <= '1';
                drift_valid <= '1';
                
                read(in_line, comma);
                read(in_line, t_ds18b20);
                
                Tt <= t_ds18b20;
                
                measurements(rd_count) <= Tt;
                rd_count <= rd_count + 1;
                
                report "t = " & current_timestamp;
                report "T(t - 1) = " & to_string(Tt_1);
                report "T(t) = " & to_string(Tt);
                -- wait for T;
            else
                Tt_valid <= '0';
                Tt_1_valid <= '0';
            
            end if;
                
            -- read(in_line, comma);
            -- read(in_line, t_dht11);
            -- report "t (DS18B20): " & to_string(t_dht11);
                
                
            -- read(in_line, comma);
            -- read(in_line, t_lm35dz);
            -- report "t (DS18B20): " & to_string(t_lm35dz);
                
            -- read(in_line, comma);
            -- read(in_line, t_bmp180);
            -- report "t (DS18B20): " & to_string(t_bmp180);
                
            -- read(in_line, comma);
            -- read(in_line, t_thermistor);
            -- report "t (DS18B20): " & to_string(t_thermistor);
                
            -- read(in_line, comma);
            -- read(in_line, t_dht22);
            -- report "t (DS18B20): " & to_string(t_dht22);
            
            -- wait for 4 * T;
            
        -- end loop;
        else
            file_close(sensors_data);
            wait;
        end if;
    
    end process;
    
    process 
        file results : text open write_mode is "C:\CTI\Licenta\cumulative_sums_anomaly_detection\04-12-22_results_int_bin.csv";
        variable out_line : line;
    begin
        wait until rising_edge(clk);
            
        if nrst = '0' then
            wait until rising_edge(nrst);
        end if;
    
        if wr_count <= rd_count then
            if abnormal_valid = '1' then
                write(out_line, to_integer(signed(timestamp)));
                write(out_line, string'(", "));
                write(out_line, to_integer(signed(measurements(wr_count))));
                write(out_line, string'(", "));
                write(out_line, abnormal);
                writeline(results, out_line);
                
                wr_count <= wr_count + 1;
            end if;
        else
            file_close(results);
            report "execution finished";
            wait;
        end if;
    end process;


end Behavioral;
