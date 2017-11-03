Library IEEE;
use IEEE.std_logic_1164.all;
 
Entity cs211_lab5 is
Port(sw : in std_logic_vector(17 downto 0);
ledr : out std_logic_vector(7 downto 0);
hex7,hex6,hex5,hex4,hex3,hex1,hex0 : out std_logic_vector(6 downto 0));
end Entity;
 
Architecture behavior of cs211_lab5 is

function To_7seg (digit : in std_logic_vector(3 downto 0))
return std_logic_vector is
variable ret : std_logic_vector(6 downto 0);
begin
case digit is
when "0000" => ret := "1000000"; --0
when "0001" => ret := "1111001"; --1
when "0010" => ret := "0100100"; --2
when "0011" => ret := "0110000"; --3
when "0100" => ret := "0011001"; --4
when "0101" => ret := "0010010"; --5
when "0110" => ret := "0000010"; --6
when "0111" => ret := "1011000"; --7
when "1000" => ret := "0000000"; --8
when "1001" => ret := "0010000"; --9
when "1010" => ret := "0001000"; --A
when "1011" => ret := "0000011"; --B
when "1100" => ret := "1000110"; --C
when "1101" => ret := "0100001"; --D
when "1110" => ret := "0000110"; --E
when others => ret := "0001110"; --F
end case;
return ret;
end To_7seg;
 
component Cmp
	port(input : in std_logic_vector(15 downto 0);
			output : out std_logic_vector(6 downto 0));
end component;

component RCA
	port(arg1,arg2 : in std_logic_vector(7 downto 0);
			c : in std_logic;
	output : out std_logic_vector(7 downto 0));
end component;

component complement
	port( x : in std_logic_vector(7 downto 0);
	nx : out std_logic_vector(7 downto 0));
end component;

signal CP : std_logic_vector(6 downto 0);
signal C1,C2,C3,SELHEX : std_logic_vector(7 downto 0);

begin
hex7 <= To_7seg(sw(15 downto 12)); -- A's 2nd byte
hex6 <= To_7seg(sw(11 downto 8)); -- A's 1st byte
hex5 <= To_7seg(sw(7 downto 4)); -- B's 2nd byte
hex4 <= To_7seg(sw(3 downto 0)); -- B's 1st byte

U0: Cmp port map(sw(15 downto 0),CP);
hex3 <= CP;

U1: RCA port map(sw(15 downto 8),not sw(7 downto 0),'1',C1); --C1 <= A-B
U2: RCA port map(not sw(15 downto 8),sw(7 downto 0),'1',C2); --C2 <= B-A
U3: RCA port map(sw(15 downto 8),sw(7 downto 0),'0',C3); -- C3 <= A+B

SELHEX <= C3 when sw(17) = '0' else C1 when sw(16) = '0' else C2;

hex1 <= To_7seg(SELHEX(7 downto 4)); -- 2nd byte of Selhex

hex0 <= To_7seg(SELHEX(3 downto 0)); -- 1st byte of Selhex

ledr <= SELHEX; -- ledr is same as Selhex
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;

Entity Cmp is
	port(input : in std_logic_vector(15 downto 0);
			output : out std_logic_vector(6 downto 0));
end entity;

Architecture behavior of Cmp is
component RCA
	port(arg1,arg2 : in std_logic_vector(7 downto 0);
			c : in std_logic;
		  output : out std_logic_vector(7 downto 0));
end component;

component complement
	port(  x : in std_logic_vector(7 downto 0);
			 nx : out std_logic_vector(7 downto 0));
end component;


signal X : std_logic_vector(7 downto 0);
begin
U0: RCA port map
	(input(15 downto 8), input(7 downto 0),'1',X);
	output <= "1110110" when input(15 downto 8) = input(7 downto 0) 
					else "1110000" when input(15) = '0' and input = '1' else  "1000110" when input(15) = '1' and input(7) = '0'
					else "1110000" when X(7) = '0' else "1000110" when X(7) = '1';

end architecture;


--<2’s complement>
Library IEEE;
use IEEE.std_logic_1164.all;

Entity complement is
Port( x : in std_logic_vector(7 downto 0);
	nx : out std_logic_vector(7 downto 0));
end Entity;

Architecture behavior of complement is

component RCA
	port(	arg1,arg2 : in std_logic_vector(7 downto 0);
			c : in std_logic;
		   output : out std_logic_vector(7 downto 0));
end component;

signal N : std_logic_vector(7 downto 0);

begin
N <= not x;

U1 : RCA port map(N,"00000001",'0',nx);

end architecture;

--/////////////////// 8-bit-ripple-carry adder ////////////////////
Library IEEE;
use IEEE.std_logic_1164.all;

Entity RCA is -- 8-bit-ripple-carry adder.
Port( arg1,arg2 : in std_logic_vector(7 downto 0);
		c : in std_logic;
	output : out std_logic_vector(7 downto 0));
end Entity;

Architecture behavior of RCA is
	component full_adder
		port(x,y,c : in std_logic;
			     s,cn : out std_logic);
	end component;
	signal c1,c2,c3,c4,c5,c6,c7,c8 : std_logic;
begin
		U0 : full_adder port map (arg1(0),arg2(0),c,output(0),c1);
		U1 : full_adder port map (arg1(1),arg2(1),c1,output(1),c2);
		U2 : full_adder port map (arg1(2),arg2(2),c2,output(2),c3);
		U3 : full_adder port map (arg1(3),arg2(3),c3,output(3),c4);
		U4 : full_adder port map (arg1(4),arg2(4),c4,output(4),c5);
		U5 : full_adder port map (arg1(5),arg2(5),c5,output(5),c6);
		U6 : full_adder port map (arg1(6),arg2(6),c6,output(6),c7);
		U7 : full_adder port map (arg1(7),arg2(7),c7,output(7),c8);
end architecture;

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
