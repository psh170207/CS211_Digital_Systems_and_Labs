library IEEE;
use IEEE.std_logic_1164.all;

Entity cs211_lab2 is
port(
sw: in std_logic_vector(3 downto 0);
ledr: out std_logic_vector(0 downto 0)); -- out

end cs211_lab2;
architecture structure of cs211_lab2 is

	component RB port(input: in std_logic_vector(2 downto 0);
							output : out std_logic_vector(0 downto 0));
	end component;
	signal C : std_logic;
Begin
	U1 : RB port map(input(0)=>sw(0),input(1)=>sw(1),input(2)=>sw(2),output(0)=>C);
	ledr(0) <= C xor sw(3);
end structure;

library IEEE;
use IEEE.std_logic_1164.all;

Entity RB is
port( 
input: in std_logic_vector(2 downto 0);
output: out std_logic_vector(0 downto 0)); -- output of redbox
end RB;
architecture Redbox of RB is 
	signal A,B : std_logic;
Begin
	A <= input(0) or input(1);
	B <= (not input(0)) and input(2);
	output(0) <= A and B;
end Redbox;