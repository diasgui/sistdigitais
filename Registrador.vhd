library ieee;
use ieee.std_logic_1164.all;
use work.senha.all;

entity Registrador is
	port ( 
		senha_binaria: in std_logic_vector(0 to 15);
		senha_inteira: out int_array
		);
end Registrador;

architecture Comportamental of Registrador is
	
	component BCD
		port (
			binario: in std_logic_vector(0 to 3);
			inteiro: out integer
		);
	end component;
	
begin
	conversorD0: BCD 
	port map ( senha_binaria(0 to 3), senha_inteira(0) );

	conversorD1: BCD 
	port map ( senha_binaria(4 to 7) , senha_inteira(1) );

	conversorD2: BCD 
	port map ( senha_binaria(8 to 11) , senha_inteira(2) );

	conversorD3: BCD 
	port map ( senha_binaria(12 to 15) , senha_inteira(3) );

end architecture;
