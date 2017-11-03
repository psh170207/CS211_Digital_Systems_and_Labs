Library IEEE;
use IEEE.std_logic_1164.all;

Entity cs211_lab7 is
	port(sw(17 downto 0) : in std_logic_vector(17 downto 0);
		ledr(11 downto 0) : out std_logic_vector(11 downto 0);
		hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7 : out std_logic_vector(6 downto 0));
end entity

architecture behavior of cs211_lab7 is
component BCD_adder
	port(arg1,arg2 : in std_logic_vector(7 downto 0);
		S,O : in std_logic;
		hex : out std_logic_vector(6 downto 0);
		output : out std_logic_vector(11 downto 0));
end component;

component BCD_to_7seg
	port(input : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end component;

signal ANS : std_logic_vector(11 downto 0);

begin
U0 : BCD_adder port map(arg1=>sw(15 downto 8),arg2=>sw(7 downto 0),S=>sw(17),O=>sw(16),hex=>hex2,output=>ANS);
U1 : BCD_to_7seg(sw(3 downto 0),hex4);
U2 : BCD_to_7seg(sw(7 downto 4),hex5);
U3 : BCD_to_7seg(sw(11 downto 8),hex6);
U4 : BCD_to_7seg(sw(15 downto 12),hex7);
U5 : BCD_to_7seg(ANS(3 downto 0),hex0);
U6 : BCD_to_7seg(ANS(7 downto 4),hex1);
hex3 <= "1110000" when sw(15 downto 8) > sw(7 downto 0) else
				"1000110" when sw(15 downto 8) < sw(7 downto 0) else
				"1110110" when others;
ledr <= ANS;
end architecture;

