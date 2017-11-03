Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity cs211_lab6 is
	port(sw : in std_logic_vector(8 downto 0);
			hex3,hex2,hex1,hex0 : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of cs211_lab6 is
component Double_dabble
	port(input : in std_logic_vector(8 downto 0);
		out3,out2,out1,out0 : out std_logic_vector(6 downto 0));
end component;

begin
U0 : Double_dabble port map(sw(8 downto 0),hex3,hex2,hex1,hex0);
end architecture;


----------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity Double_dabble is
	port(input : in std_logic_vector(8 downto 0);
		out3,out2,out1,out0 : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of Double_dabble is

component complement
	port (input : in std_logic_vector(8 downto 0);
		compl : out std_logic_vector(8 downto 0));
end component;

component BCD_to_7seg
	port(input : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end component;

signal Ans : std_logic_vector(19 downto 0);
signal C : std_logic_vector(8 downto 0); -- complement of input
--signal H,T,U : std_logic_vector(3 downto 0); -- hundreds, tens, units.
signal h0,h1,h2 : std_logic_vector(6 downto 0);
signal X : std_logic_vector(8 downto 0); -- signal for input data

begin
U1 : complement port map(input,C);
process(input)
begin
	if(input="100000000") then
		X<= input;
		out3 <= "0111111";
	elsif(input(8)='1') then
		X <= C;
		out3 <= "0111111"; -- express '-' sign.
	else
		X <= input;
		out3 <= "1111111";
	end if;
end process;

process(X)
variable A : std_logic_vector(19 downto 0);
begin
	A:="000000000000"&X(7 downto 0);--initialization
	for i in 0 to 7 loop
			if(A(19 downto 16)="0101") then A(19 downto 16):="1000";
			elsif(A(19 downto 16)="0110") then A(19 downto 16):="1001";
			elsif(A(19 downto 16)="0111") then A(19 downto 16):="1010";
			elsif(A(19 downto 16)="1000") then A(19 downto 16):="1011";
			elsif(A(19 downto 16)="1001") then A(19 downto 16):="1100";
			end if;
			
			if(A(15 downto 12)="0101") then A(15 downto 12):="1000";
			elsif(A(15 downto 12)="0110") then A(15 downto 12):="1001";
			elsif(A(15 downto 12)="0111") then A(15 downto 12):="1010";
			elsif(A(15 downto 12)="1000") then A(15 downto 12):="1011";
			elsif(A(15 downto 12)="1001") then A(15 downto 12):="1100";
			end if;

			if(A(11 downto 8)="0101") then A(11 downto 8):="1000";
			elsif(A(11 downto 8)="0110") then A(11 downto 8):="1001";
			elsif(A(11 downto 8)="0111") then A(11 downto 8):="1010";
			elsif(A(11 downto 8)="1000") then A(11 downto 8):="1011";
			elsif(A(11 downto 8)="1001") then A(11 downto 8):="1100";
			end if;
			
		A := A(18 downto 0)&'0'; -- logical left shift by 1 bit.
	end loop;
	Ans <= A;
end process;

U2 : BCD_to_7seg port map(Ans(19 downto 16),h2);
U3 : BCD_to_7seg port map(Ans(15 downto 12),h1);
U4 : BCD_to_7seg port map(Ans(11 downto 8),h0);

process(input)
begin
if(input = "100000000") then
	out2 <= "0100100";
	out1 <= "0010010";
	out0 <= "0000010";
else
	out2 <= h2;
	out1 <= h1;
	out0 <= h0;
end if;
end process;
end architecture;




----------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity BCD_to_7seg is
	port(input : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of BCD_to_7seg is
begin
hex <= "1000000" when input = "0000"--0
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




----------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity complement is
	port (input : in std_logic_vector(8 downto 0);
		compl : out std_logic_vector(8 downto 0));
end entity;

architecture behavior of complement is
begin
compl <= not input + 1;
end architecture;
