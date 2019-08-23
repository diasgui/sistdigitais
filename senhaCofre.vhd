library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.senha.all;

-- initial entity
entity senhaCofre is 
	port(
		clock : in std_logic;
		reset : in std_logic;
		chaves : in std_logic_vector(0 to 3);
		botaoSet : in std_logic;
		destravaPorta : out std_logic;
		senhaAlterada : out std_logic;
		digitosCorretos  : out std_logic_vector(0 to 3));
end entity senhaCofre;

architecture comportamental of senhaCofre is
	type State_type is (op0, op1, op2, op3);
	signal set : std_logic;
	signal y: State_type;
	signal array_senha_inteira, array_senha_mestre: int_array;
	signal count : integer := 0;
	constant attempts : integer := 3;
	
	-- componente para conversão da senha digitada
	component BCD
		port (
			binario: in std_logic_vector(3 downto 0);
			inteiro: out integer
		);
	end component;
	
	component Comparador
		port (
			senha_digitada: in int_array;
			tipoSenha: in std_logic;
			resultado: in std_logic
			);
	end component;
	
	component Registrador
		port (
			senha_binaria: in std_logic_vector(0 to 15);
			senha_inteira: out int_array
		);
	end component;
	
	component Verificador
		port (
			senha_salva: in int_array;
			senha_digitada: in int_array;
			LED: out std_logic_vector(0 to 1)
			);
	end component;
	
	component DeBounce
		port (
			clock : in std_logic;
			reset : in std_logic;
			button_in : in std_logic;
			pulse_out : out std_logic
		);
	end component;
	
begin
	debouncer: DeBounce port map 
		( clock, reset, botaoSet, set );

	process (set)	
	begin
		if set = '0' then
			y <= op0; -- estado inicial A
		else
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
						y <= op0;
				when op2 =>
					y <= op0;
					-- programar operacao de nova senha
				when op3 =>
					y <= op0;
					-- programar operacao de ajuda para recordar senha
			end case;
		end if;
	end process;
end;