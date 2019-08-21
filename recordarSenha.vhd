library IEEE;
use IEEE.std_logic_1164.all;

-- esboço da operacao de recordar senha
entity recordarSenha is
	port(
    	senha_digitada: in std_logic_vector(0 to 3);
        senha_salva: in std_logic_vector(0 to 3);
        qtd_digitos: out integer
        );
end entity recordarSenha;

architecture comportamental of recordarSenha is
begin
	qtd_digitos <= 0;
	
	-- senhas digitada e salva em inteiros (bcd)
	for count in 0 to 3 loop
    	if senha_digitada(count) == senha_salva(0)
        	qtd_digitos <= qtd_digitos +1;
        elsif senha_digitada == senha_salva(1)
        	qtd_digitos <= qtd_digitos +1;
        elsif senha_digitada == senha_salva(2)
        	qtd_digitos <= qtd_digitos +1;
        end if;
    end loop;                                     

end comportamental;
