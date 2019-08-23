library ieee;
use ieee.std_logic_1164.all;
use work.senha.all;

entity Verificador is
	port (
		senha_salva: in int_array;
		senha_digitada: in int_array;
		LED: out std_logic_vector(0 to 1)
	);
end Verificador;

architecture Comportamental of Verificador is
signal count : integer := 0;

begin
	process is
	begin
		for i in 0 to 3 loop 
			if (senha_digitada(i) = senha_salva(1) or senha_digitada(i) = senha_salva(1) or senha_digitada(i) = senha_salva(2) or senha_digitada(i) = senha_salva(3)) then
				count <= count + 1;
			end if;
		end loop;
	end process;
	
	with count select
		LED <=
			"00" when 0,
			"01" when 1,
			"10" when 2,
			"11" when 3,
			"XX" when others;
end architecture;
