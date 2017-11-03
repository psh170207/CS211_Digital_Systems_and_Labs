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
