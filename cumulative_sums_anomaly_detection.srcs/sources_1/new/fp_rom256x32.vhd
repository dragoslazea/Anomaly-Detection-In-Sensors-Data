library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fp_rom256x32 is
    Port ( address : in STD_LOGIC_VECTOR (31 downto 0);
           data_out_previous : out STD_LOGIC_VECTOR (31 downto 0);
           data_out_current : out STD_LOGIC_VECTOR (31 downto 0));
end fp_rom256x32;

architecture Behavioral of fp_rom256x32 is

type rom_array is array (0 to 255) of std_logic_vector(31 downto 0);

signal rom : rom_array := (
    "01000010010001101100001010001111", -- 49.69, 0 offset timestamp 657 in original file
    "01000010010001011100001010001111", -- 49.44, 0
    "01000010010001010011110101110001", -- 49.31, 0
    "01000010010001000011110101110001", -- 49.06, 1
    "01000010001100101100001010001111", -- 44.69, 1
    "01000010010011000011110101110001", -- 51.06, 1
    "01000010011001101000010100011111", -- 57.63, 1
    "01000010010000110000000000000000", -- 48.75, 1
    "01000010010100110011110101110001", -- 52.81, 1
    "01000010011000010000000000000000", -- 56.25, 0
    "01000010011000011000010100011111", -- 56.38, 0
    "01000010011001100000000000000000", -- 57.50, 1
    "01000010011110001000010100011111", -- 62.13, 0
    "01000010011111011000010100011111", -- 63.38, 1
    "01000010011011011000010100011111", -- 59.38, 0
    "01000010011010101000010100011111", -- 58.63, 0
    "01000010011100101000010100011111", -- 60.63, 0
    "01000010011010101000010100011111", -- 58.63, 1
    "01000010100001001011110101110001", -- 66.37, 1
    "01000010100100110001111010111000", -- 73.56, 1
    "01000010101000010110000101001000", -- 80.69, 0
    "01000010101001011001111010111000", -- 82.81, 1
    "01000010101011001001111010111000", -- 86.31, 1
    "01000010101111010110000101001000", -- 94.69, 1
    "01000010101000110000000000000000", -- 81.50, 1
    "01000010101100000000000000000000", -- 88.00, 0
    "01000010101100111011110101110001", -- 89.87, 0
    "01000010101101011000000000000000", -- 90.75, 0
    "01000010101100111110000101001000", -- 89.94, 0
    "01000010101100110000000000000000", -- 89.50, 0
    "01000010101101000000000000000000", -- 90.00, 0
    "01000010101100101110000101001000", -- 89.44, 1
    "01000010100111011001111010111000", -- 78.81, 1
    "01000010101001010110000101001000", -- 82.69, 0
    "01000010101000101001111010111000", -- 81.31, 1
    "01000010101010111000000000000000", -- 85.75, 0
    "01000010101100000001111010111000", -- 88.06, 0
    "01000010101011101011110101110001", -- 87.37, 0
    "01000010101100100000000000000000", -- 89.00, 1
    "01000010101011001011110101110001", -- 86.37, 1
    "01000010101000100011110101110001", -- 81.12, 1
    "01000010100111000011110101110001", -- 78.12, 0
    "01000010101000000011110101110001", -- 80.12, 1
    "01000010101000101000000000000000", -- 81.25, 0 offset timestamp 700 in original file
    --others => "01000010101000101000000000000000"
    others => (others => '0')
);

signal next_address : STD_LOGIC_VECTOR (31 downto 0) := x"00000001";

begin

    next_address <= (others => '0') when address = x"FFFFFFFF" else address + 1;

    data_out_previous <= rom(conv_integer(address));
    data_out_current <= rom(conv_integer(next_address));

end Behavioral;