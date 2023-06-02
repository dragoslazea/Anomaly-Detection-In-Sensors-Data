library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fp_max is
    Port ( aclk : in STD_LOGIC;
           a_valid : in STD_LOGIC;
           a_ready : out STD_LOGIC;
           a_data : in STD_LOGIC_VECTOR (31 downto 0);
           b_valid : in STD_LOGIC;
           b_ready : out STD_LOGIC;
           b_data : in STD_LOGIC_VECTOR (31 downto 0);
           max_valid : out STD_LOGIC;
           max_ready : in STD_LOGIC;
           max_data : out STD_LOGIC_VECTOR (31 downto 0));
end fp_max;

architecture Behavioral of fp_max is

COMPONENT fp_greater_than
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tready : IN STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

signal comp_res : std_logic_vector(7 downto 0);

begin

    comp : fp_greater_than
      PORT MAP (
        aclk => aclk,
        s_axis_a_tvalid => a_valid,
        s_axis_a_tready => a_ready,
        s_axis_a_tdata => a_data,
        s_axis_b_tvalid => b_valid,
        s_axis_b_tready => b_ready,
        s_axis_b_tdata => b_data,
        m_axis_result_tvalid => max_valid,
        m_axis_result_tready => max_ready,
        m_axis_result_tdata => comp_res
      );
      
      max_data <= a_data when comp_res(0) = '1' else b_data;


end Behavioral;
