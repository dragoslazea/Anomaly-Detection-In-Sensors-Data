library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_rom256x32 is
end tb_rom256x32;

architecture Behavioral of tb_rom256x32 is

component rom256x32 is
    Port ( address : in STD_LOGIC_VECTOR (31 downto 0);
           data_out_previous : out STD_LOGIC_VECTOR (31 downto 0);
           data_out_current : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal T : time :=  20 ns;

signal a, pr, cr : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal clk : STD_LOGIC := '0';

begin

    clk <= not clk after T / 2;
    
    process (clk)
    begin
        if rising_edge(clk) then
            a <= a + 1;
        end if;
    end process;

    UUT : rom256x32 port map (address => a, data_out_previous => pr, data_out_current => cr);

end Behavioral;
