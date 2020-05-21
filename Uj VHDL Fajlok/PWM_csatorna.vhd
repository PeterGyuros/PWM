
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_csatorna is
	port (
		clk					: in	std_logic;
		reset					: in	std_logic;
		kitoltesi_tenyezo	: in	std_logic_vector (15 downto 0);
		felbontas 			: in 	std_logic;
		PWM_kimenet			: out	std_logic;
	);
end entity PWM_csatorna;


architecture rtl of PWM_channel is 

	signal counter	: std_logic_vector (8 downto 0) := x"0000";
begin 

	process(clk, reset) is
	begin

		if (reset = '0') then
		
			PWM_kimenet <= 'Z';
			counter <= x"0000";
			
		elsif ( rising_edge(clk) ) then
		
			counter <= std_logic_vector( unsigned(counter) + 1 + unsigned(felbontas)); -- Ha a resolution 1 akkor 2esevel ha resolution 0 akkor 1esevel => felbontas
		
			if (unsigned(counter) >= unsigned(kitoltesi_tenyezo)) then
				PWM_kimenet <= '0';
			else 
				PWM_kimenet <= '1';
			end if;
			
		end if;
		
	end process;
	
end architecture rtl;

































