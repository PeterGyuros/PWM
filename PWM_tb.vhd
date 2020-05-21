-- Testbench a PWM vezerlohoz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity PWM_teszt is 
end;

architecture test of PWM_teszt is

component PWM 
port (
	PWM_ki				:out std_logic;
	Kitoltesi_Tenyezo	:in std_logic_vector;
	CLK					:in std_logic;
	Enable				:in std_logic
);

end component;

signal Kitoltesi_Tenyezo	:std_logic_vector:='000000000';
signal Enable 					:std_logic:='1';
signal CLK						:std_logic:='1';

begin
	
	teszt: PWM
		port map (Kitoltesi_Tenyezo, Enable, CLK);
	
	clk_stimulus: process
	begin
		wait for 10 ns;
		clk <= not clk;
	end process clk_stimulus;
	
	PWM_stimulus: process
	begin
		wait for 50 ns;
		Kitoltesi_Tenyezo <= Kitoltesi_Tenyezo + 100;
		wait for 150 ns;
	end process PWM_stimulus;