---2 to 1 MUX---
Library IEEE;
use IEEE.std_logic_1164.all;

Entity mux21 is
	port(in1,in2,sw : in std_logic;
		output : out std_logic);
end Entity;

Architecture behavioral of mux21 is
begin

output <= in1 when sw = '0'
else in2 when sw='1'

end architecture;


---D Latch---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity d_latch is
Port ( D,Clk : in STD_LOGIC;
Q : out STD_LOGIC);
end d_latch;
 
architecture Behavioral of d_latch is
begin

process (Clk, D)
begin
if (Clk = '1') then
Q <= D;
end if;
end process;

end Behavioral;
---------------------------------------------------------------
--- D F/F(positive edge triggered with reset) ---
Library IEEE;
use IEEE.std_logic_1164.all;
 
Entity d_ff is
port(D,Clk,reset : in std_logic;
Q : out std_logic);
end entity;
 
Architecture Behavioral of d_ff is
component d_latch
Port ( D,Clk : in STD_LOGIC;
Q : out STD_LOGIC);
end component;
 
signal Qm,Qs : std_logic;
 
begin
U0 : d_latch port map(D,NOT Clk,Qm);
U1 : d_latch port map(Qm,Clk,Qs);
Q<= '0' when reset = '0' else
Qs;
end architecture;

-----------4bit Binary Counter---------
Library IEEE;
use IEEE.std_logic_1164.all;
 
Entity counter is
port(EN,Clk,Clear,Load : in std_logic;
     D : in std_logic_vector(3 downto 0);
     Q : out std_logic_vector(3 downto 0));
end Entity;
 
Architecture Behavioral of counter is

component d_ff
port(T,Clk,reset : in std_logic;
Q : out std_logic);
end component;

component mux21
	port(in1,in2,sw : in std_logic;
		output : out std_logic);
end component;

signal q0,q1,q2,q3,i0,i1,i2,i3,a0,a1,a2,a3,a4 : std_logic;
attribute keep:boolean;
attribute keep of q0,q1,q2,q3 : signal is true;
begin

a0 <= EN;
U0 : mux21 port map(q0 XOR a0, D(0), Load, i0);
U1 : d_ff port map(i0,Clk,NOT Clear,q0);

a1 <= EN AND q0;
U2 : mux21 port map(q1 XOR a1, D(1), Load, i1);
U3 : d_ff port map(i1,Clk,NOT Clear,q1);

a2<= a1 AND q1;
U4 : mux21 port map(q2 XOR a2, D(2), Load, i2);
U5 : d_ff port map(i2,Clk,NOT Clear,q2);

a3<= a2 AND q2;
U6 : mux21 port map(q3 XOR a3, D(3), Load, i3);
U7 : d_ff port map(i3,Clk,NOT Clear,q3);

Q(0)<=q0;
Q(1)<=q1;
Q(2)<=q2;
Q(3)<=q3;
end architecture;
-------modulo-9 counter-------
Library IEEE;
use IEEE.std_logic_1164.all;

Entity mod9_counter is
	port(clk,clear : in std_logic;
	     Q : out std_logic);
end entity;

Architecture behavioral of mod9_counter is

component counter
	port(EN,Clk,Clear,Load : in std_logic;
	     D : in std_logic_vector(3 downto 0);
	     Q : out std_logic_vector(3 downto 0));
end component;
signal q0,q1,q2,q3 : std_logic_vector(3 downto 0);
attribute keep:boolean;
attribute keep of q0,q1,q2,q3,count_out : signal is true;

begin
U0 : counter(1,clk,clear,q0 AND q3,count_out);
q0 <= count_out(0);
q3 <= count_out(3);
Q <= count_out;

------2nd problem----
Library IEEE;
use IEEE.std_logic_1164.all;
Entity cs211_lab8_2 is
port(sw : in std_logic_vector(1 downto 0);
key : in std_logic_vector(0 downto 0);
ledr : out std_logic_vector(3 downto 0);
ledg : out std_logic_vector(3 downto 0));
end Entity;
 
Architecture Behavioral of cs211_lab8_2 is
component counter
port(EN,Clk,Clear : in std_logic;
uQ,dQ : out std_logic_vector(3 downto 0));
end component;

begin
U0: counter port map(sw(0),key(0),sw(1),ledr(3 downto 0),ledg(3 downto 0));
end architecture;
