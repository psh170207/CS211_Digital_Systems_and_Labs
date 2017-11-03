Library IEEE;
use IEEE.std_logic_1164.all;

Entity cs211_lab7 is
	port(sw : in std_logic_vector(17 downto 0);
		ledr : out std_logic_vector(11 downto 0);
		hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7 : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of cs211_lab7 is

component BCD_adder
	port(arg1,arg2 : in std_logic_vector(7 downto 0);
		S,O : in std_logic;
		hex : out std_logic_vector(6 downto 0);
		output : out std_logic_vector(11 downto 0));
end component;

component BCD_to_7seg
	port(BCDnum : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end component;

signal ANS : std_logic_vector(11 downto 0);

begin
U0 : BCD_adder port map(sw(15 downto 8),sw(7 downto 0),sw(17),sw(16),hex2,ANS);
U1 : BCD_to_7seg port map(sw(3 downto 0),hex4);
U2 : BCD_to_7seg port map(sw(7 downto 4),hex5);
U3 : BCD_to_7seg port map(sw(11 downto 8),hex6);
U4 : BCD_to_7seg port map(sw(15 downto 12),hex7);
U5 : BCD_to_7seg port map(ANS(3 downto 0),hex0);
U6 : BCD_to_7seg port map(ANS(7 downto 4),hex1);
hex3 <= "1110000" when sw(15 downto 8) > sw(7 downto 0) else
				"1000110" when sw(15 downto 8) < sw(7 downto 0) else
				"1110110" when sw(15 downto 8) = sw(7 downto 0);
ledr <= ANS;
end architecture;
------------------------------------------BCD_adder------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

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

component tens_complement
	port(input : in std_logic_vector(7 downto 0);
	     output : out std_logic_vector(7 downto 0));
end component;

signal c1,c2,c3 : std_logic_vector(7 downto 0);
signal hexout,hexoutab,hexoutba : std_logic_vector(6 downto 0);
signal A,S1,S2,temp1,temp2,temp3 : std_logic_vector(9 downto 0);
signal O1,O2,O2p,O3,O3p : std_logic_vector(11 downto 0);
signal O2n,O3n : std_logic_vector(7 downto 0);
signal neg1,neg2 : std_logic_vector(7 downto 0);
begin

U0 : tens_complement port map(arg1,neg1); -- neg1 = A'
U1 : tens_complement port map(arg2,neg2); -- neg2 = B'

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
	"00000" when A(4 downto 0) = "00000" else
	"00001" when A(4 downto 0) = "00001" else
	"00010" when A(4 downto 0) = "00010" else
	"00011" when A(4 downto 0) = "00011" else
	"00100" when A(4 downto 0) = "00100" else
	"00101" when A(4 downto 0) = "00101" else
	"00110" when A(4 downto 0) = "00110" else
	"00111" when A(4 downto 0) = "00111" else
	"01000" when A(4 downto 0) = "01000" else
	"01001" when A(4 downto 0) = "01001";

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
	"00000" when A(9 downto 5) = "00000" else
	"00001" when A(9 downto 5) = "00001" else
	"00010" when A(9 downto 5) = "00010" else
	"00011" when A(9 downto 5) = "00011" else
	"00100" when A(9 downto 5) = "00100" else
	"00101" when A(9 downto 5) = "00101" else
	"00110" when A(9 downto 5) = "00110" else
	"00111" when A(9 downto 5) = "00111" else
	"01000" when A(9 downto 5) = "01000" else
	"01001" when A(9 downto 5) = "01001";

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
	"00000" when S1(4 downto 0) = "00000" else
	"00001" when S1(4 downto 0) = "00001" else
	"00010" when S1(4 downto 0) = "00010" else
	"00011" when S1(4 downto 0) = "00011" else
	"00100" when S1(4 downto 0) = "00100" else
	"00101" when S1(4 downto 0) = "00101" else
	"00110" when S1(4 downto 0) = "00110" else
	"00111" when S1(4 downto 0) = "00111" else
	"01000" when S1(4 downto 0) = "01000" else
	"01001" when S1(4 downto 0) = "01001";

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
	"00000" when S1(9 downto 5) = "00000" else
	"00001" when S1(9 downto 5) = "00001" else
	"00010" when S1(9 downto 5) = "00010" else
	"00011" when S1(9 downto 5) = "00011" else
	"00100" when S1(9 downto 5) = "00100" else
	"00101" when S1(9 downto 5) = "00101" else
	"00110" when S1(9 downto 5) = "00110" else
	"00111" when S1(9 downto 5) = "00111" else
	"01000" when S1(9 downto 5) = "01000" else
	"01001" when S1(9 downto 5) = "01001";

O2p(3 downto 0) <= temp2(3 downto 0);
O2p(7 downto 4) <= temp2(8 downto 5);
O2p(11 downto 8) <= "000"&temp2(9);

U18 : tens_complement port map(O2p(7 downto 0),O2n);

O2 <= "0000"&O2n when arg1<arg2 else -- A<B
	O2p when arg1>arg2 else
	"000000000000" when arg1=arg2;

hexoutab <= "0111111" when arg1<arg2 else -- '-' sign.
	"1000000" when arg1>arg2 else
	"1000000" when arg1=arg2;

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
		"00000" when S2(4 downto 0) = "00000" else
	"00001" when S2(4 downto 0) = "00001" else
	"00010" when S2(4 downto 0) = "00010" else
	"00011" when S2(4 downto 0) = "00011" else
	"00100" when S2(4 downto 0) = "00100" else
	"00101" when S2(4 downto 0) = "00101" else
	"00110" when S2(4 downto 0) = "00110" else
	"00111" when S2(4 downto 0) = "00111" else
	"01000" when S2(4 downto 0) = "01000" else
	"01001" when S2(4 downto 0) = "01001";

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
		"00000" when S2(9 downto 5) = "00000" else
	"00001" when S2(9 downto 5) = "00001" else
	"00010" when S2(9 downto 5) = "00010" else
	"00011" when S2(9 downto 5) = "00011" else
	"00100" when S2(9 downto 5) = "00100" else
	"00101" when S2(9 downto 5) = "00101" else
	"00110" when S2(9 downto 5) = "00110" else
	"00111" when S2(9 downto 5) = "00111" else
	"01000" when S2(9 downto 5) = "01000" else
	"01001" when S2(9 downto 5) = "01001";

O3p(3 downto 0) <= temp3(3 downto 0);
O3p(7 downto 4) <= temp3(8 downto 5);
O3p(11 downto 8) <= "000"&temp3(9);

U27 : tens_complement port map(O3p(7 downto 0),O3n);

O3 <= "0000"&O3n when arg1>arg2 else --B<A
	O3p when arg1<arg2 else
	"000000000000" when arg1=arg2;

hexoutba <= "0111111" when arg1>arg2 else -- '-' sign.
	"1000000" when arg1<arg2 else
	"1000000" when arg1=arg2;

output <= O1 when S='0' else
	O2 when S='1' and O='0' else
	O3 when S='1' and O='1';
hex <= hexout when S='0' else
	hexoutab when S='1' and O='0'else
	hexoutba when S='1' and O='1';

end architecture;
--------------------------------------------------tens_complement---------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity tens_complement is
	port(input : in std_logic_vector(7 downto 0);
	     output : out std_logic_vector(7 downto 0));
end entity;

architecture behavior of tens_complement is
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
		'0' when N(3 downto 0)="0001" else
		'0' when N(3 downto 0)="0010" else
		'0' when N(3 downto 0)="0011" else
		'0' when N(3 downto 0)="0100" else
		'0' when N(3 downto 0)="0101" else
		'0' when N(3 downto 0)="0110" else
		'0' when N(3 downto 0)="0111" else
		'0' when N(3 downto 0)="1000";

	T(7 downto 4) <= N(7 downto 4) when c='0' else
		"0001" when c='1' and N(7 downto 4)="0000" else
		"0010" when c='1' and N(7 downto 4)="0001" else
		"0011" when c='1' and N(7 downto 4)="0010" else
		"0100" when c='1' and N(7 downto 4)="0011" else
		"0101" when c='1' and N(7 downto 4)="0100" else
		"0110" when c='1' and N(7 downto 4)="0101" else
		"0111" when c='1' and N(7 downto 4)="0110" else
		"1000" when c='1' and N(7 downto 4)="0111" else
		"1001" when c='1' and N(7 downto 4)="1000" else
		"0000" when c='1' and N(7 downto 4)="1001";

output <= T;
end architecture;

-------------------------------------------------------------BCD_to_7seg---------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity BCD_to_7seg is
	port(BCDnum : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end entity;

architecture behavior of BCD_to_7seg is
begin
hex <= "1000000" when BCDnum = "0000"--0
else "1111001" when BCDnum = "0001" --1
else "0100100" when BCDnum = "0010" --2
else "0110000" when BCDnum = "0011" --3
else "0011001" when BCDnum = "0100" --4
else "0010010" when BCDnum = "0101" --5
else "0000010" when BCDnum = "0110" --6
else "1011000" when BCDnum = "0111" --7
else "0000000" when BCDnum = "1000" --8
else "0010000" when BCDnum = "1001"; --9
end architecture;

--------------------------------------full_adder-------------------------------------------------------------------
--<full-adder>
Library IEEE;
use IEEE.std_logic_1164.all;
 
Entity full_adder is
Port(x,y,c : in std_logic;
s,cn : out std_logic); -- cn means carry-next.
end Entity;
 
Architecture behavior of full_adder is
component half_adder
port(x,y : in std_logic;
s,c : out std_logic);
end component;
signal A,B,C1,D : std_logic;
begin
U0 : half_adder port map (x,y,A,B);
U1 : half_adder port map (c,A,D,C1);
s <= D;
cn <= C1 or B;
end architecture;
 
--<Half-adder>
Library IEEE;
use IEEE.std_logic_1164.all;
 
Entity half_adder is
Port(x,y : in std_logic;
s,c : out std_logic);
end Entity;
 
Architecture behavior of half_adder is
begin
c <= x and y;
s <= x xor y;
end architecture;
