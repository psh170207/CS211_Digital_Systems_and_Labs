Library IEEE;
use IEEE.std_logic_1164.all;

Entity BCD_to_7seg is
	port(input : in std_logic_vector(3 downto 0);
		7seg : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of BCD_to_7seg is
begin
7seg <= "1000000" when input = "0000"--0
else "1111001" when input = "0001" --1
else "0100100" when input = "0010" --2
else "0110000" when input = "0011" --3
else "0011001" when input = "0100" --4
else "0010010" when input = "0101" --5
else "0000010" when input = "0110" --6
else "1011000" when input = "0111" --7
else "0000000" when input = "1000" --8
else "0010000" when input = "1001"; --9
end architecture;
