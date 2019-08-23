library ieee;
use ieee.std_logic_1164.all;

--definindo um vetor de inteiros
package senha is
	type int_array is array(0 to 3) of integer;
end package senha;

library ieee;
use ieee.std_logic_1164.all;
use work.senha.all;

entity Comparador is
	generic(SENHA_MESTRE : int_array := (1,2,3,4); --qnd chamar usar generic map (SENHA_PADRAO <= (0,0,0,0))
			SENHA_PADRAO : int_array);
	port (senhaDigitada : in int_array;
		  tipoSenha : in std_logic; -- sinal para decidir se caiu em algum estado onde só aceita a senha mestre
		 resultado : out std_logic);
end Comparador;

architecture comportamental of Comparador is

begin
	process
	begin 
		if tipoSenha = '0' then -- se for 0, verifica se é igual a padrão ou a mestre
			if (senhaDigitada = SENHA_PADRAO) or (senhaDigitada = SENHA_MESTRE) then
				resultado <= '1';
			else 
				resultado <= '0';
			end if;
		else -- se for diferente de 0, verifica apenas a mestre
			if senhaDigitada = SENHA_MESTRE then
				resultado <= '1';
			else
				resultado <= '0';
			end if;
		end if;
	end process;
end architecture;