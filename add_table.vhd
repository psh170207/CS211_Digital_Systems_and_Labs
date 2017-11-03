Library IEEE;
use IEEE.std_logic_1164.all;

Entity add_table is
	port(input : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(3 downto 0));
end entity;

architecture behavior of add_table is
begin
	output <= "1000" when input = "0101" --5
	else "1001" when input = "0110" --6
	else "1010" when input = "0111" --7
	else "1011" when input = "1000" --8
	else "1100" when input = "1001"; --9 and upper cases never occurs in this algorithm.
end architecture;
