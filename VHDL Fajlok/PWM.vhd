

-- BME VIK Mikroelektronika labor 2020 tavasz
-- PWM vezerlo kod
-- Gyuros Peter & Guruczi Tamas


-- Könyvtárak 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

--Entity
entity PWM is
Generic(
	BIT_MELYSEG 		:integer:= 9; -- vagy 512 vagy 256 (2^9 vagz 2^8)
	INPUT_CLK 			:integer:= 500000000; -- 50 MHz
	FREQ					:integer:= 50); --50 Hz

Port(
	PWM_ki				:out std_logic;
	Kitoltesi_Tenyezo	:in std_logic_vector(BIT_MELYSEG - 1 downto 0);
	CLK					:in std_logic;
	Enable				:in std_logic);

end PWM;


--Architektura
architecture behaviour of PWM is 

--Konstansok
constant max_freq_szam 	:integer:= INPUT_CLK / FREQ;							-- Ennyi felfuto el egy periodus, ezutan biztosan felhuzzuk a kimenetet, meddig szamolunk hogz megkapjuk a frekit
constant pwm_step 		:integer:= max_freq_count / (2**BIT_MELYSEG);	-- PWM lepesek felbontasa a periodus es a bitmelyseg hanyadosa

--Jelek
signal pwm_kimenet		:std_logic:= '0';	 										-- Kimeneti valtozo, melyet a kimeneti portra kotunk
signal freq_szam 			:integer range from 0 to max_freq_szam		:=0;	-- Frekvencia perioudusok szamlalo
signal pwm_szam			:integer range from 0 to 2**BIT_MELYSEG	:=0;	-- Mennyi ideig magas a PWM, ezutan alacsonyra huzza
signal max_pwm_szam		:integer range from 0 to 2**BIT_MELYSEG	:=0;	-- PWM periodus teljes hossza
signal pwm_step_szam		:integer range from 0 to max_freq_count	:=0;	-- 

begin

	max_pwm_szam <= to_integer(unsigned(Kitoltesi_Tenyezo)); 				-- Konvertaljuk a kitoltest a max pwm szamra
	Pwm_ki <= pwm_kimenet; 																-- Kimeneti erteket hozzarendelem a kimenethez
	
	--Folyamat ami a kimenetet allitja
	freq_szamlalo: process(CLK)
	begin
		if rising_edge(CLK) then -- Felfuto elre kezdunk
			if (Enable = '1') then -- Ha az enable magas, akkor fut a ciklus
				if(freq_szam < max_freq_szam) then -- Ha a felfutoelek szama kisebb, mint a max
					freq_szam <= freq_szam + 1;
					if(pwm_szam < max_pwm_szam) then
						pwm_kimenet <= '1';
						if (pwm_step_szam < pwm_szam) then
							pwm_step_szam <= pwm_step_szam + 1;
						else
							pwm_step_szam <= 0;
							pwm_szam <=0;
						end if;
					else
						pwm_kimenet <= '0';
					end if;	
				else
					freq_szam <= 0;
					pwm_szam <= 0;	
				end if;
			else
				pwm_kimenet <= '0'
			end if;
		end if;
	end process freq_szamlalo;

end behaviour;
