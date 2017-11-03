Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Clk_converter_100Hz is
	port(Clk_in : in std_logic;
	      reset : in std_logic;
	     Clk_out : out std_logic);
end Entity;

Architecture behavioral of Clk_converter_100Hz is
signal count : integer := 1;
signal tmp : std_logic := '0';
begin
process(Clk_in,reset)
begin
if(reset='1') then
count<='1';
tmp<='0';
elsif(rising_edge(Clk_in)) then
	count <= count+1;
	if (count = 250000) then --100Hz frequency
		tmp <= NOT tmp;
		count <= 1;
	end if;
end if;
Clk_out<=tmp;
end process;
end architecture;
