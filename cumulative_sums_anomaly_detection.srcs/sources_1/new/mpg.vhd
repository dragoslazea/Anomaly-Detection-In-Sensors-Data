library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- monopulse generator (generates a pulse on clock)
entity mpg is
  Port ( clk : in STD_LOGIC;
        btn : in STD_LOGIC;
        en : out STD_LOGIC );
end mpg;

architecture Behavioral of mpg is

signal count : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal q1 : STD_LOGIC := '0';
signal q2 : STD_LOGIC := '0';
signal q3 : STD_LOGIC := '0';

begin

    process (clk)
    begin
        if rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;

    process (clk)
    begin
        if rising_edge(clk) then
            if count(15 downto 0) = x"1111" then
                q1 <= btn;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            q2 <= q1;
            q3 <= q2;
        end if;
    end process;

    en <= q2 and (not q3);

end Behavioral;