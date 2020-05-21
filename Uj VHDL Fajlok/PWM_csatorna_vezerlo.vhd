

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PWM_csatorna_vektor.all; --???

entity PWM_csatorna_vezerlo is 

	generic(
		PWM_csatorna_szam : integer := 16
	);
	
	port (
		-- bemenet 
		konfig						: in  std_logic_vector (15  downto 0);
		clk							: in  std_logic;
		reset 						: in  std_logic;
		-- kimenet
		PWM_kimenetek				: out std_logic_vector(0 to PWM_csatorna_szam-1)
	);

end entity PWM_csatorna_vezerlo;

architecture rtl of PWM_csatorna_vezerlo is
--kimenet
	signal PWM_kimenet_vektor		:std_logic_vector (0 to PWM_csatorna_szam-1)
--PWM jelek	
	signal csatorna_cim				:std_logic_vector (3 downto 0); -- Konfiguraciós vezeték, amemóriacím 1db 1es bittel választjaki az adott csatornát, melyetkonfigurálni akarunk
	signal kitoltesi_tenyezo		:std_logic_vector (8 downto 0); -- A memóriacím legalsó bitjének 1esetén 512; 0 esetén pedig 256bites felbontásba állítja az adottcsatornát
	signal felbontas					:std_logic; -- Az adott kitöltési tényező, alsó 9biten módtól függően
	signal engedelyezes				:std_logic_vector (15 downto 0); -- Channel Enable egyesévelengedélyezi a PWM csatornákat.1es esetén aktív a csatona kimenete
	
begin 

--generic parameter alapjan generalunk X PWM csatornat
	Csatorna_generalas:
		for i in 0 to PWM_csatorna_szam-1 generate 
			CHANNELx: entity work.PWM_csatorna() port map(
				clk,
				reset,
				kitoltesi_tenyezo(i),		
			);
		end generate Csatorna_generalas;
	
	csatorna_cim				<= konfig(15 downto 12);
	kitoltesi_tenyezo 		<= konfig(11 downto 3);
	felbontas 					<= konfig(2);
	engedelyezes 				<= konfig(1);
	
	
	-- main process	
	process(clk, reset) is
	begin
		
		if (reset = '0') then
			-- reset
			for i in 0 to channel_number-1 loop
				PWM_kimenet_vektor(i) <= '0';
			end loop;
		elsif ( rising_edge(clk) ) then
			
			if (engedelyezes = '1') then
				PWM_kimenetek(to_integer(unsigned(csatorna_cim))) <= PWM_kimenet_vektor(to_integer(unsigned(csatorna_cim)));
			else 
				PWM_kimenetek(to_integer(unsigned(csatorna_cim))) <= '0';
			end if;
		
	end process;
	
end architecture;





