Library IEEE;
use IEEE.std_logic_1164.all;

Entity state_to_watch is
	port(input : in std_logic_vector(1 downto 0);
	     clk_in : in std_logic;
	     clk_enable : out std_logic);
end entity;

Architecture behavioral of state_to_watch is

begin
process(clk_in,input)
begin
if(rising_edge(clk)) then
	if(input = "00") then
		clk_enable <='0';
	elsif(input = "01") then
		clk_enable <= clk_in;
	elsif(input = "10") then
		clk_enable <= '0';
	end if;
end if;
end process;
end architecture;
