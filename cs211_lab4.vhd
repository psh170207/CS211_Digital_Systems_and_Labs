Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity cs211_lab4 is 
	Port(sw : in std_logic_vector(17 downto 0);
			ledr : out std_logic_vector(7 downto 0);
			hex7,hex6,hex5,hex4,hex3,hex1,hex0 : out std_logic_vector(6 downto 0));
end Entity;

Architecture behavior of cs211_lab4 is

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

function Cmp (input : in std_logic_vector(15 downto 0))
			return std_logic_vector is
		begin
			if ((input(15) xor input(7)) = '0') then -- sign bit xor = 0 : same bit => compare value
				if input(15 downto 8) < input(7 downto 0) then return "1000110";  -- input(15 downto 8) means A, input(7 downto 0) means B.
				elsif input(15 downto 8) > input(7 downto 0) then return "1110000";
				else return "1110110";
				end if;
			else -- diff sign bit => always pos>neg 
				if (input(15) = '1') then return "1000110";
				else return "1110000";
				end if;
			end if;
		end Cmp;

function Selhex (selbits : in std_logic_vector(1 downto 0);input : in std_logic_vector(15 downto 0))
			return std_logic_vector is
		variable ret : std_logic_vector(7 downto 0);
		begin
			case selbits is
				when "00" => ret := input(15 downto 8) - input(7 downto 0); -- A - B
				when "01" => ret := input(7 downto 0) - input(15 downto 8); -- B - A
				when others => ret := input(15 downto 8) + input(7 downto 0); -- A + B
			end case;
			return ret;
		end Selhex;
begin
hex7 <= To_7seg(sw(15 downto 12)); -- A's 2nd byte
hex6 <= To_7seg(sw(11 downto 8)); -- A's 1st byte
hex5 <= To_7seg(sw(7 downto 4)); -- B's 2nd byte
hex4 <= To_7seg(sw(3 downto 0)); -- B's 1st byte
hex3 <= Cmp(sw(15 downto 0)); -- compare A and B
hex1 <= To_7seg(Selhex(sw(17 downto 16),sw(15 downto 0))(7 downto 4)); -- 2nd byte of Selhex
hex0 <= To_7seg(Selhex(sw(17 downto 16),sw(15 downto 0))(3 downto 0)); -- 1st byte of Selhex
ledr <= Selhex(sw(17 downto 16),sw(15 downto 0)); -- ledr is same as Selhex
end architecture;