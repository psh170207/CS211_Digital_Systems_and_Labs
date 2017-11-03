---D Latch---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch is
    Port ( Clk : in  STD_LOGIC;
           D  : in  STD_LOGIC;
           Q  : out STD_LOGIC);
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
    Port ( Clk : in  STD_LOGIC;
           D  : in  STD_LOGIC;
           Q  : out STD_LOGIC);
end component;

signal Qm,Qs : std_logic;

begin
	U0 : d_latch port map(NOT Clk,D,Qm);
	U1 : d_latch port map(Clk,Qm,Qs);
	Q<= '0' when reset = '0' else
	    Qs;
end architecture;

-- T F/F --
Library IEEE;
use IEEE.std_logic_1164.all;
Entity t_ff is
	port(T,Clk_t,reset_t : in std_logic;
		Q : out std_logic);
end Entity;

Architecture Behavioral of t_ff is
component d_ff
	port(D,Clk,reset : in std_logic;
		Q,nQ : out std_logic);
end component;
signal A,B,C,pQ : std_logic;
attribute keep : boolean;
attribute keep of A,B,C,pQ : signal is true;
begin
	A <= (NOT T) AND pQ;
	B <= T AND (NOT pQ);
	C <= A OR B;
	U0 : d_ff port map(C,Clk_t,reset_t,pQ);
	Q <= pQ;
end architecture;

-----------Binary Counter---------
Library IEEE;
use IEEE.std_logic_1164.all;

Entity counter is
	port(EN,Clk,Clear : in std_logic;
		uQ,dQ : out std_logic_vector(3 downto 0));
end Entity;

Architecture Behavioral of counter is
component t_ff
	port(T,Clk_t,reset_t : in std_logic;
		Q : out std_logic);
end component;
signal uq0,uq1,uq2,uq3,dq0,dq1,dq2,dq3,ui0,ui1,ui2,ui3,di0,di1,di2,di3 : std_logic;
attribute keep:boolean;
attribute keep of uq0,uq1,uq2,uq3,dq0,dq1,dq2,dq3 : signal is true;
begin
	ui0 <= EN;
	U0 : t_ff port map(ui0,Clk,NOT Clear,uq0);
	ui1 <= ui0 AND uq0;
	U1 : t_ff port map(ui1,Clk,NOT Clear,uq1);
	ui2 <= ui1 AND uq1;
	U2 : t_ff port map(ui2,Clk,NOT Clear,uq2);
	ui3 <= ui2 AND uq2;
	U3 : t_ff port map(ui3,Clk,NOT Clear,uq3);
	
	di0 <= EN;
	U4 : t_ff port map(di0,Clk,NOT Clear,dq0);
	di1 <= di0 AND (NOT dq0);
	U5 : t_ff port map(di1,Clk,NOT Clear,dq1);
	di2 <= di1 AND (NOT dq1);
	U6 : t_ff port map(di2,Clk,NOT Clear,dq2);
	di3 <= di2 AND (NOT dq2);
	U7 : t_ff port map(di3,Clk,NOT Clear,dq3);
	
	uQ(0)<=uq0;
	uQ(1)<=uq1;
	uQ(2)<=uq2;
	uQ(3)<=uq3;

	dQ(0)<=dq0;
	dQ(1)<=dq1;
	dQ(2)<=dq2;
	dQ(3)<=dq3;
end architecture;

------2nd problem----
Library IEEE;
use IEEE.std_logic_1164.all;
Entity second is
	port(sw : in std_logic_vector(1 downto 0);
		key : in std_logic_vector(0 downto 0);
		ledr : out std_logic_vector(3 downto 0);
		ledg : out std_logic_vector(3 downto 0));
end Entity;

Architecture Behavioral of second is
component counter
	port(EN,Clk,Clear : in std_logic;
		Q : out std_logic_vector(3 downto 0));
end component;

begin
	U0: counter port map(sw(0),key(0),sw(1),ledr(3 downto 0),ledg(3 downto 0));
end architecture;










