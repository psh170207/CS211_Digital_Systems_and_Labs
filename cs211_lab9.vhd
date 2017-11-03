Library IEEE;
use IEEE.std_logic_1164.all;

Entity main is
	port(sw : in std_logic_vector(2 downto 0);
		key : in std_logic_vector(0 downto 0);
		clk_50 : in std_logic;
		hex3,hex2,hex1,hex0 : out std_logic_vector(6 downto 0));
end entity;

Architecture behavioral of main is
component FSM
	port(sw2,sw1,sw0,key0,clk : in std_logic;
	     output : out std_logic);
end component;

component counter
  port(clk, clear : in  std_logic; 
       output : inout std_logic_vector(3 downto 0)); 
end component;

component Clk_converter_100Hz
	port(Clk_in : in std_logic;
	      reset : in std_logic;
	     Clk_out : out std_logic);
end component;

component Clk_converter_10Hz
	port(Clk_in : in std_logic;
	      reset : in std_logic;
	     Clk_out : out std_logic);
end component;

component Clk_converter_1Hz
	port(Clk_in : in std_logic;
	      reset : in std_logic;
	     Clk_out : out std_logic);
end component;

component Clk_converter_01Hz
	port(Clk_in : in std_logic;
	      reset : in std_logic;
	     Clk_out : out std_logic);
end component;

component BCD_to_7seg
	port(input : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0));
end component;

signal clk_enable : std_logic;
signal q0,q1,q2,q3 : std_logic_vector(3 downto 0);
signal clk_100,clk_10,clk_1,clk_01 : std_logic;
begin
U0 : Clk_converter_100Hz port map(clk_50,sw(0),clk_100);
U1 : Clk_converter_10Hz port map(clk_50,sw(0),clk_10);
U2 : Clk_converter_1Hz port map(clk_50,sw(0),clk_1);
U3 : Clk_converter_01Hz port map(clk_50,sw(0),clk_01);

U4 : FSM port map(sw(2),sw(1),sw(0),key(0),clk_50,clk_enable);

U6 : counter port map(clk_enable AND clk_100,sw(0),q0);
U7 : counter port map(clk_enable AND clk_10,sw(0),q1);
U8 : counter port map(clk_enable AND clk_1,sw(0),q2);
U9 : counter port map(clk_enable AND clk_01,sw(0),q3);

U10 : BCD_to_7seg port map(q0,hex0);
U11 : BCD_to_7seg port map(q1,hex1);
U12 : BCD_to_7seg port map(q2,hex2);
U13 : BCD_to_7seg port map(q3,hex3);

end architecture;
