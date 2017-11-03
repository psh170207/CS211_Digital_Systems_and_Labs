Library IEEE;
use IEEE.std_logic_1164.all;

Entity complement is
	port (input : in std_logic_vector(8 downto 0);
		compl : out std_logic_vector(8 downto 0));
end entity;

architecture behavior of complement is
begin
compl <= not input + 1;
end architecture;
