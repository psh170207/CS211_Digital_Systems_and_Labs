Library IEEE;
use IEEE.std_logic_1164.all; 

Entity counter is 
  port(clk, clear : in  std_logic; 
       output : inout std_logic_vector(3 downto 0)); 
end entity;
 
Architecture behavioral of counter is 
signal tmp: std_logic_vector(3 downto 0); 
begin 
process(clk,clear)
begin
    if (clear='1') then
	tmp <= "0000";
    elsif (rising_edge(clk)) then
       if tmp = "1001" then
		tmp <= (others => '0');
	else
		tmp <= tmp+1;
       end if;
	output <= tmp;
    end if;
end process;
end architecture;
