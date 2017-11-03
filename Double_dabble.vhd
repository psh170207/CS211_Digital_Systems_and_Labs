Library IEEE;
use IEEE.std_logic_1164.all;

Entity Double_dabble is
	port(input : in std_logic_vector(8 downto 0);
		hex3,hex2,hex1,hex0 : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of Double_dabble is

component complement
	port (input : in std_logic_vector(8 downto 0);
		compl : out std_logic_vector(8 downto 0));
end component;

component BCD_to_7seg
	port(input : in std_logic_vector(3 downto 0);
		7seg : out std_logic_vector(6 downto 0));
end component;

signal A : std_logic_vector(19 downto 0);
signal C : std_logic_vector(8 downto 0);
signal H,T,U : std_logic_vector(3 downto 0);
signal h0,h1,h2 : std_logic_vector(6 downto 0);

begin
U0 : complement port map(input,C);
hex3 <= "1111111"; -- initial : turn off all segments.
process(input)
begin
	if(input="100000000") then
		hex3 <= "0111111";
	elsif(input(8)='1') then
		input <= C;
		hex3 <= "0111111"; -- express '-' sign.
	end if;
end process;

A<="000000000000"&input(7 downto 0);--initialization

process(A)
begin
	for i in 0 to 7 loop
		if(A(19 downto 16)>"0100") then
			if(A(19 downto 16)="0101") then H<="1000";
			elsif(A(19 downto 16)="0110") then H<="1001";
			elsif(A(19 downto 16)="0111") then H<="1010";
			elsif(A(19 downto 16)="1000") then H<="1011";
			elsif(A(19 downto 16)="1001") then H<="1100";
			end if;
			A(19 downto 16) <= H;
		end if;

		if(A(15 downto 12)>"0100") then
			if(A(15 downto 12)="0101") then T<="1000";
			elsif(A(15 downto 12)="0110") then T<="1001";
			elsif(A(15 downto 12)="0111") then T<="1010";
			elsif(A(15 downto 12)="1000") then T<="1011";
			elsif(A(15 downto 12)="1001") then T<="1100";
			end if;
			A(15 downto 12) <= T;
		end if;

		if(A(11 downto 8)>"0100") then
			if(A(11 downto 8)="0101") then U<="1000";
			elsif(A(11 downto 8)="0110") then U<="1001";
			elsif(A(11 downto 8)="0111") then U<="1010";
			elsif(A(11 downto 8)="1000") then U<="1011";
			elsif(A(11 downto 8)="1001") then U<="1100";
			end if;
			A(11 downto 8) <= U;
		end if;
		A <= A sll 1; -- logical left shift by 1 bit.
	end loop;
end process;

U1 : BCD_to_7seg port map(A(19 downto 16),h2);
U2 : BCD_to_7seg port map(A(15 downto 12),h1);
U3 : BCD_to_7seg port map(A(11 downto 8),h0);

process(input)
if(input = "100000000") then
	hex2 <= "0100100";
	hex1 <= "0010010";
	hex0 <= "0000010";
else then
	hex2 <= h2;
	hex1 <= h1;
	hex0 <= h0;
end if;
end process;
end architecture;

--z1 := z1(18 downto 8) & x(i) & x(7 downto 0);
