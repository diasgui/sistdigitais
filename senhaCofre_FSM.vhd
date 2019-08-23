library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.senha.all;

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
	type State_type is (op0, op1, op2, op3, op1_1, op1_2, op1_3, op1_4, op1_5, op1_6, op1_7, op1_8, op1_erro);
	signal y: State_type;
	signal array_senha_inteira, array_senha_mestre: int_array;
	signal count : integer := 0;
	constant attempts : integer := 3;
	
	-- componente para conversão da senha digitada
	component BCD
		port (
			senha_binaria: in std_logic_vector(3 downto 0);
			senha_inteira: out integer
		);
	end component;
	
	component Comparador
		port (
			senha_digitada: in int_array;
			tipoSenha: in std_logic;
			resultado: in std_logic
			);
	end component;
begin
	process (botaoSet)	
	begin
		if botaoSet = '0' then
			y <= A; -- estado inicial A
		elsif (rising_edge(botaoSet)) then
			case y is
				when op0 => -- escolha de modo
					if chaves(2 to 3) = "01" then -- dois bits menos significativos
						y <= op1;
					elsif chaves(2 to 3) = "10" then
						y <= op2;
					elsif chaves(2 to 3) = "11" then
						y <= op3;
					else
						y <= op0;
					end if;
				when op1 => -- operacao 1: abrir cofre
					case y is 
						when op1 =>
							conversor1: BCD port map (
								chaves(0 to 3), array_senha_inteira(0)
								);
							y <= op1_1;
						when op1_1 =>
							conversor2: BCD port map (
								chaves(0 to 3), array_senha_inteira(1)
								);
							y <= op1_2;
						when op1_2 =>
							conversor3: BCD port map (
								chaves(0 to 3), array_senha_inteira(2)
								);
							y <= op1_3;
						when op1_3 =>
							conversor4: BCD port map (
								chaves(0 to 3), array_senha_inteira(3)
								);
							y <= op1_4;
						when op1_4 =>
							variable resultado : std_logic;
							variable tipo : std_logic := '0';
							comparador1: Comparador port map (
								array_senha_inteira, tipo, resultado
								);
							if resultado = '1' then
								destravaPorta = '1';
								y <= op0;
							elsif resultado = '0' and count < attempts then
								count <= count + 1;
								y <= op1;
							else
								y <= op1_erro;
							end if;
						when op1_erro =>
							conversor1: BCD port map (
								chaves(0 to 3), array_senha_mestre(0)
								);
							y <= op1_5;
						when op1_5 =>
							conversor2: BCD port map (
								chaves(0 to 3), array_senha_mestre(1)
								);
							y <= op1_6;
						when op1_6 =>
							conversor3: BCD port map (
								chaves(0 to 3), array_senha_mestre(2)
								);
							y <= op1_7;
						when op1_7 => 
							conversor4: BCD port map (
								chaves(0 to 3), array_senha_mestre(3)
								);
							y <= op1_8;
						when op1_8 =>
							variable resultado : std_logic;
							variable tipo : std_logic := '0';
							comparador1: Comparador port map (
								array_senha_mestre, tipo, resultado
								);
							if resultado = '1' then
								destravaPorta = '0';
								y <= op0;
							else
								y <= op0; -- ??
							end if;
					end case;
				when C =>
					-- programar operacao de nova senha
				when D =>
					-- programar operacao de ajuda para recordar senha
			end case;
		end if;
	end process;
end;
