library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

-- initial entity
entity senhaCofre is 
	port(
		chaves : in std_logic_vector(0 to 3);
		botaoSet : in std_logic;
		destravaPorta : out std_logic;
		senhaAlterada : out std_logic;
		digitosCorretos  : out std_logic_vector(0 to 3));
end entity senhaCofre;

architecture comportamental of senhaCofre is
	type State_type is (A, B, C, D); -- estados iniciais das operacoes
	signal y: State_type;
	
	-- componente para conversão da senha digitada
	component BCD
		port (
			senha_binaria: in std_logic_vector(15 downto 0);
			senha_inteira: out integer
		);
	end component;
	
	component sete_segmentos
		port (
			qtd_digitos: in std_logic_vector(0 to 3);
			HEX0: in std_logic_vector(6 downto 0)
		);
	end component;

begin
	process (botaoSet)	
	begin
		if botaoSet = '0' then
			y <= A; -- estado inicial A
		elsif (rising_edge(botaoSet)) then
			case y is
				when A => -- escolha de modo
					if chaves(2 to 3) = "01" then -- dois bits menos significativos
						y <= B;
					elsif chaves(2 to 3) = "10" then
						y <= C;
					elsif chaves(2 to 3) = "11" then
						y <= D;
					else
						y <= A;
					end if;
				when B =>
					-- programar operacao de inserir senha
				when C =>
					-- programar operacao de nova senha
				when D =>
					-- programar operacao de ajuda para recordar senha
			end case;
		end if;
	end process;
end;
