Library IEEE;
use IEEE.std_logic_1164.all;

Entity FSM is
	port(sw2,sw1,sw0,key0,clk : in std_logic;
	     output : out std_logic);
end entity;

Architecture behavioral of FSM is
type FSM_states is(INIT,RUN,STOP);
signal current_state, next_state : FSM_states;
begin

current_state_logic : process(key0,sw0)
begin
	if(sw0='1') then
		current_state <= INIT;
	elsif(rising_edge(key0)) then
		current_state <= next_state;
	end if;
end process current_state_logic;

next_state_logic : process(current_state,sw1,sw2)
begin
	case current_state is
		when INIT =>
			if(sw1='1') then
				next_state <= RUN;
			end if;
		when RUN =>
			if(sw2='1') then
				next_state <= STOP;
			end if;
		when STOP =>
			if(sw1='1') then
				next_state <= RUN;
			end if;
		When others =>
	end case;
end process next_state_logic;

output_logic : process(clk)
begin
	if(rising_edge(clk)) then
		case current_state is
			when INIT => output <= "0";
			when RUN => output <= "1";
			when STOP => output <= "0";
		end case;
end process output_logic;

end architecture;
