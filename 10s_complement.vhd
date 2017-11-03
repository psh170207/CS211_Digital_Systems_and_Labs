Library IEEE;
use IEEE.std_logic_1164.all;

entity 10s_complement is
	port(input : in std_logic_vector(7 downto 0);
	     output : out std_logic_vector(7 downto 0));
end entity;

architecture behavior of 10s_complement is
--9's complement + 1
signal N : std_logic_vector(7 downto 0); -- Nine's complement
signal T : std_logic_vector(7 downto 0); -- Ten's complement
signal C : std_logic; -- Carry bit
begin
	N(7 downto 4)<="0000" when input(7 downto 4)="1001"else
	"0001" when input(7 downto 4)="1000"else
	"0010" when input(7 downto 4)="0111"else
	"0011" when input(7 downto 4)="0110"else
	"0100" when input(7 downto 4)="0101"else
	"0101" when input(7 downto 4)="0100"else
	"0110" when input(7 downto 4)="0011"else
	"0111" when input(7 downto 4)="0010"else
	"1000" when input(7 downto 4)="0001"else
	"1001" when input(7 downto 4)="0000";
	
	N(3 downto 0)<="0000" when input(3 downto 0)="1001"else
	"0001" when input(3 downto 0)="1000"else
	"0010" when input(3 downto 0)="0111"else
	"0011" when input(3 downto 0)="0110"else
	"0100" when input(3 downto 0)="0101"else
	"0101" when input(3 downto 0)="0100"else
	"0110" when input(3 downto 0)="0011"else
	"0111" when input(3 downto 0)="0010"else
	"1000" when input(3 downto 0)="0001"else
	"1001" when input(3 downto 0)="0000";
	--9's complement

	T(3 downto 0)<="0001" when N(3 downto 0)="0000" else
	"0010" when N(3 downto 0)="0001" else
	"0011" when N(3 downto 0)="0010" else
	"0100" when N(3 downto 0)="0011" else
	"0101" when N(3 downto 0)="0100" else
	"0110" when N(3 downto 0)="0101" else
	"0111" when N(3 downto 0)="0110" else
	"1000" when N(3 downto 0)="0111" else
	"1001" when N(3 downto 0)="1000" else
	"0000" when N(3 downto 0)="1001";

	C <= '1' when N(3 downto 0)="1001" else
		'0' when others;
process(N,C)
begin
	if(C='1') then
		case N(7 downto 4) is
			when "0000" => T(7 downto 4) <= "0001";
			when "0001" => T(7 downto 4) <= "0010";
			when "0010" => T(7 downto 4) <= "0011";
			when "0011" => T(7 downto 4) <= "0100";
			when "0100" => T(7 downto 4) <= "0101";
			when "0101" => T(7 downto 4) <= "0110";
			when "0110" => T(7 downto 4) <= "0111";
			when "0111" => T(7 downto 4) <= "1000";
			when "1000" => T(7 downto 4) <= "1001";
			when "1001" => T(7 downto 4) <= "0000";
		end case;
	else then
		T(7 downto 4)<=N(7 downto 4);
	--9's complement + 1
end process;

output <= T;
end architecture;
