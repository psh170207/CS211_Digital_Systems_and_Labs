Library IEEE;
use IEEE.std_logic_hex1164.all;

Entity BCD_adder is
	port(arg1,arg2 : in std_logic_vector(7 downto 0);
		S,O : in std_logic;
		hex : out std_logic_vector(6 downto 0);
		output : out std_logic_vector(11 downto 0));
end entity;

architecture behavior of BCD_adder is

component full_adder
	Port(x,y,c : in std_logic;
		s,cn : out std_logic);
end component;

component 10s_complement
	port(input : in std_logic_vector(7 downto 0);
	     output : out std_logic_vector(7 downto 0));
end component;

signal c1,c2,c3 : std_logic_vector(7 downto 0);
signal hexout,hexoutab,hexoutba : std_logic_vector(6 downto 0);
signal A,S1,S2,temp1,temp2,temp3 : std_logic_vector(9 downto 0);
signal O1,O2,O2p,O3,O3p : std_logic_vector(11 downto 0);
signal O2n,O3n : std_logic_vector(7 downto 0);
begin

U0 : 10s_complement port map(arg1,neg1); -- neg1 = A'
U1 : 10s_complement port map(arg2,neg2); -- neg2 = B'

--1st, compute A+B
U2 : full_adder port map(arg1(0),arg2(0),'0',A(0),c1(0));
U3 : full_adder port map(arg1(1),arg2(1),c1(0),A(1),c1(1));
U4 : full_adder port map(arg1(2),arg2(2),c1(1),A(2),c1(2));
U5 : full_adder port map(arg1(3),arg2(3),c1(2),A(3),c1(3));
A(4) <= c1(3);
temp1(4 downto 0) <= "10000" when A(4 downto 0) = "01010" else
	"10001" when A(4 downto 0) = "01011" else
	"10010" when A(4 downto 0) = "01100" else
	"10011" when A(4 downto 0) = "01101" else
	"10100" when A(4 downto 0) = "01110" else
	"10101" when A(4 downto 0) = "01111" else
	"10110" when A(4 downto 0) = "10000" else
	"10111" when A(4 downto 0) = "10001" else
	"11000" when A(4 downto 0) = "10010" else
	A(4 downto 0) when others; -- A<=1001

U6 : full_adder port map(arg1(4),arg2(4),temp1(4),A(5),c1(4));
U7 : full_adder port map(arg1(5),arg2(5),c1(4),A(6),c1(5));
U8 : full_adder port map(arg1(6),arg2(6),c1(5),A(7),c1(6));
U9 : full_adder port map(arg1(7),arg2(7),c1(6),A(8),c1(7));
A(9) <= c1(7);
temp1(9 downto 5) <= "10000" when A(9 downto 5) = "01010" else
	"10001" when A(9 downto 5) = "01011" else
	"10010" when A(9 downto 5) = "01100" else
	"10011" when A(9 downto 5) = "01101" else
	"10100" when A(9 downto 5) = "01110" else
	"10101" when A(9 downto 5) = "01111" else
	"10110" when A(9 downto 5) = "10000" else
	"10111" when A(9 downto 5) = "10001" else
	"11000" when A(9 downto 5) = "10010" else
	A(9 downto 5) when others;

O1(3 downto 0) <= temp1(3 downto 0);
O1(7 downto 4) <= temp1(8 downto 5);
O1(11 downto 8) <= "000"&temp1(9);

hexout <= "1000000" when O1(11 downto 8)="0000" else
	"1111001" when O1(11 downto 8)="0001";

--2nd, compute A-B
U10 : full_adder port map(arg1(0),neg2(0),'0',S1(0),c2(0));
U11 : full_adder port map(arg1(1),neg2(1),c2(0),S1(1),c2(1));
U12 : full_adder port map(arg1(2),neg2(2),c2(1),S1(2),c2(2));
U13 : full_adder port map(arg1(3),neg2(3),c2(2),S1(3),c2(3));
S1(4) <= c2(3);
temp2(4 downto 0) <= "10000" when S1(4 downto 0) = "01010" else
	"10001" when S1(4 downto 0) = "01011" else
	"10010" when S1(4 downto 0) = "01100" else
	"10011" when S1(4 downto 0) = "01101" else
	"10100" when S1(4 downto 0) = "01110" else
	"10101" when S1(4 downto 0) = "01111" else
	"10110" when S1(4 downto 0) = "10000" else
	"10111" when S1(4 downto 0) = "10001" else
	"11000" when S1(4 downto 0) = "10010" else
	S1(4 downto 0) when others; -- S1<=1001

U14 : full_adder port map(arg1(4),neg2(4),temp2(4),S1(5),c2(4));
U15 : full_adder port map(arg1(5),neg2(5),c2(4),S1(6),c2(5));
U16 : full_adder port map(arg1(6),neg2(6),c2(5),S1(7),c2(6));
U17 : full_adder port map(arg1(7),neg2(7),c2(6),S1(8),c2(7));
S1(9) <= c2(7);
temp2(9 downto 5) <= "10000" when S1(9 downto 5) = "01010" else
	"10001" when S1(9 downto 5) = "01011" else
	"10010" when S1(9 downto 5) = "01100" else
	"10011" when S1(9 downto 5) = "01101" else
	"10100" when S1(9 downto 5) = "01110" else
	"10101" when S1(9 downto 5) = "01111" else
	"10110" when S1(9 downto 5) = "10000" else
	"10111" when S1(9 downto 5) = "10001" else
	"11000" when S1(9 downto 5) = "10010" else
	S1(9 downto 5) when others;

O2p(3 downto 0) <= temp2(3 downto 0);
O2p(7 downto 4) <= temp2(8 downto 5);
O2p(11 downto 8) <= "000"&temp2(9);

U18 : 10s_complement port map(O2p(7 downto 0),O2n);

O2 <= "0000"&O2n when arg1<arg2 else -- A<B
	O2p when arg1>arg2 else
	"000000000000" when arg1=arg2;

hexoutab <= "0111111" when arg1<arg2 else -- '-' sign.
	"1000000" when arg1>=arg2 and O2(11 downto 8)="0000"else
	"1111001" when arg1>=arg2 and O2(11 downto 8)="0001";

--3rd, compute B-A
U19 : full_adder port map(arg2(0),neg1(0),'0',S2(0),c3(0));
U20 : full_adder port map(arg2(1),neg1(1),c3(0),S2(1),c3(1));
U21 : full_adder port map(arg2(2),neg1(2),c3(1),S2(2),c3(2));
U22 : full_adder port map(arg2(3),neg1(3),c3(2),S2(3),c3(3));
S2(4) <= c3(3);
temp3(4 downto 0) <= "10000" when S2(4 downto 0) = "01010" else
	"10001" when S2(4 downto 0) = "01011" else
	"10010" when S2(4 downto 0) = "01100" else
	"10011" when S2(4 downto 0) = "01101" else
	"10100" when S2(4 downto 0) = "01110" else
	"10101" when S2(4 downto 0) = "01111" else
	"10110" when S2(4 downto 0) = "10000" else
	"10111" when S2(4 downto 0) = "10001" else
	"11000" when S2(4 downto 0) = "10010" else
	S2(4 downto 0) when others; -- S2<=1001

U23 : full_adder port map(arg2(4),neg1(4),temp3(4),S2(5),c3(4));
U24 : full_adder port map(arg2(5),neg1(5),c3(4),S2(6),c3(5));
U25 : full_adder port map(arg2(6),neg1(6),c3(5),S2(7),c3(6));
U26 : full_adder port map(arg2(7),neg1(7),c3(6),S2(8),c3(7));
S2(9) <= c3(7);
temp3(9 downto 5) <= "10000" when S2(9 downto 5) = "01010" else
	"10001" when S2(9 downto 5) = "01011" else
	"10010" when S2(9 downto 5) = "01100" else
	"10011" when S2(9 downto 5) = "01101" else
	"10100" when S2(9 downto 5) = "01110" else
	"10101" when S2(9 downto 5) = "01111" else
	"10110" when S2(9 downto 5) = "10000" else
	"10111" when S2(9 downto 5) = "10001" else
	"11000" when S2(9 downto 5) = "10010" else
	S2(9 downto 5) when others;

O3p(3 downto 0) <= temp3(3 downto 0);
O3p(7 downto 4) <= temp3(8 downto 5);
O3p(11 downto 8) <= "000"&temp3(9);

U27 : 10s_complement port map(O3p(7 downto 0),O3n);

O3 <= "0000"&O3n when arg1>arg2 else --B<A
	O3p when others;

hexoutba <= "0111111" when arg1>arg2 else -- '-' sign.
	"1000000" when arg1<=arg2 and O3(11 downto 8)="0000"else
	"1111001" when arg1<=arg2 and O3(11 downto 8)="0001";

process(S,O,O1,O2,O3,hexout,hexoutab,hexoutba)
begin
	if(S='0') then output<=O1 and hex<=hexout;
	elsif(O='0') then output<=O2 and hex<=hexoutab;
	elsif(O='1') then output<=O3 and hex<=hexoutba;
	end if;
end process;

end architecture;
