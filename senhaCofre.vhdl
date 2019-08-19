library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

-- initial entity
entity senhaCofre is 
  port(
  	clock, resetn : in std_logic;
  	chaves : in std_logic_vector(0 to 3);
    botaoSet : in std_logic;
    destravaPorta : out std_logic;
    senhaAlterada : out std_logic;
    digitosCorretos  : out std_logic_vector(0 to 3));
end entity senhaCofre;

architecture comportamental of senhaCofre is
	type State_type is (A, B, C, D) -- estados iniciais das operacoes
	signal y: State_type;
begin
	process (resetn, clock, chaves)
	begin
		if resetn = '0' then
			y <= A; -- estado inicial A
		elsif (clock'event and clock = '1') then
			case y iniciais
				when A => -- escolha de modo
					if chaves(2 to 3) = '01' then -- dois bits menos significativos
						y <= B;
					elsif chaves(2 to 3) = '10' then
						y <= C;
					elsif chaves(2 to 3) = '11' then
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
