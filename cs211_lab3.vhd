library IEEE;
use IEEE.std_logic_1164.all;
entity cs211_lab3 is
port(sw : in std_logic_vector(17 downto 0);
		ledr : out std_logic_vector(17 downto 0);
		ledg : out std_logic_vector(7 downto 0);
		hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7 : out std_logic_vector(6 downto 0));
end cs211_lab3;
architecture behavioral of cs211_lab3 is
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

	function MUX81 (sel : in std_logic_vector(2 downto 0); input : in std_logic_vector(7 downto 0))
		return std_logic_vector is
		variable output:std_logic_vector(3 downto 0);
		begin
			case sel is
				when "000" => output := "000"&input(0);  -- padding 0 to use output for input of function To_7seg.
				when "001" => output := "000"&input(1);
				when "010" => output := "000"&input(2);
				when "011" => output := "000"&input(3);
				when "100" => output := "000"&input(4);
				when "101" => output := "000"&input(5);
				when "110" => output := "000"&input(6);
				when others => output := "000"&input(7);
			end case;
			return output;
		end MUX81;

	function greenled(input : in std_logic_vector(2 downto 0))
		return std_logic_vector is
		variable output:std_logic_vector(7 downto 0);
		begin
			case input is
				when "000" => output := "00000001";
				when "001" => output := "00000010";
				when "010" => output := "00000100";
				when "011" => output := "00001000";
				when "100" => output := "00010000";
				when "101" => output := "00100000";
				when "110" => output := "01000000";
				when "111" => output := "10000000";
			end case;
			return output;
		end greenled;
		
begin
ledg <= greenled(sw(17 downto 15));
ledr <= sw(17 downto 15)&"0000000"&sw(7 downto 0);
hex3 <= "1000000";
hex2 <= "0100100";
hex1 <= "1000000";
hex0 <= "0000000"; -- birthday 0208
hex4 <= To_7seg(sw(3 downto 0));
hex5 <= To_7seg(sw(7 downto 4));
hex6 <= to_7seg("0"&sw(17 downto 15));
hex7 <= To_7seg(MUX81(sw(17 downto 15),sw(7 downto 0)));
end behavioral;