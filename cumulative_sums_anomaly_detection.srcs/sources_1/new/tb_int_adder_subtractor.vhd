library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_int_adder_subtractor is
end tb_int_adder_subtractor;

architecture Behavioral of tb_int_adder_subtractor is

component int_adder_subtractor is
  Port ( 
    aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_operation_tvalid : IN STD_LOGIC;
    s_axis_operation_tready : OUT STD_LOGIC;
    s_axis_operation_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tready : IN STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end component;

constant T : time := 20 ns;

signal clk : STD_LOGIC := '0';

-- data signals
signal a, b, res : STD_LOGIC_VECTOR (31 downto 0);
signal op : STD_LOGIC_VECTOR (7 downto 0);

-- ready signals
signal a_ready, b_ready, op_ready, res_ready : STD_LOGIC := '0';

-- valid signals
signal a_valid, b_valid, op_valid, res_valid : STD_LOGIC := '0';

begin

    clk <= not clk after T / 2;

    DUT : int_adder_subtractor port map (
        aclk => clk,
        s_axis_a_tvalid => a_valid,
        s_axis_a_tready => a_ready,
        s_axis_a_tdata => a,
        s_axis_b_tvalid => b_valid,
        s_axis_b_tready => b_ready,
        s_axis_b_tdata => b,
        s_axis_operation_tvalid => op_valid,
        s_axis_operation_tready => op_ready,
        s_axis_operation_tdata => op,
        m_axis_result_tvalid => res_valid,
        m_axis_result_tready => res_ready,
        m_axis_result_tdata => res
    );
    
    a <= x"0000001E"; -- 30
    b <= x"00000015"; -- 21
    op <= "00000000", "00000001" after 16 * T; -- add / sub
    
    a_valid <= not a_valid after T;
    b_valid <= not b_valid after 2 * T;
    op_valid <= not op_valid after 4 * T;
    res_ready <= not res_ready after 8 * T;
    

end Behavioral;
