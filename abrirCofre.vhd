library IEEE;
use IEEE.std_logic_1164.all;
use work.senha.all;

entity abrirCofre is
  port(
    chaves: in std_logic_vector(0 to 15);
    botaoSet: in std_logic;
	tiposenha: in std_logic;
    destravaPorta: out std_logic
    );
end entity abrirCofre;

architecture comportamental of abrirCofre is
  type State_type is (op0, op1, d0, d1, d2, d3, abrir, erro, bloqueio, m0, m1, m2, m3)
  signal destravaPorta: std_logic;
  signal y: State_type
  constant attempts : integer := 3
  constant SENHA_MESTRE: int_array;
  
component Comparador
	generic(SENHA_MESTRE : int_array:= (1, 2, 3, 4);
			SENHA_PADRAO : int_array);
	port (senhaDigitada: in int_array;
		  tipoSenha: in std_logic;
		  resultado: out std_logic
		  );
end component;

component BCD
	port (binario: in std_logic(0 to 3);
		  inteiro: out integer
		  );
end component;		  

  
  --signal senha_salva: std_logic_vector(0 to 15);
  --signal senha_mestre: std_logic_vector(0 to 15);
  --signal senha_binaria: std_logic_vector(0 to 15);
  --signal contador: integer := 1;
  
begin

conversorD0: BCD 
	port map ( chaves(0 to 3) => binario(0 to 3), senhaDigitada(0) => inteiro );

conversorD1: BCD 
	port map ( chaves(4 to 7) => binario(0 to 3), senhaDigitada(1) => inteiro );

conversorD2: BCD 
	port map ( chaves(8 to 11) => binario(0 to 3), senhaDigitada(2) => inteiro );

conversorD3: BCD 
	port map ( chaves(12 to 15) => binario(0 to 3), senhaDigitada(3) => inteiro );
	
	
comparador: Comparador 
	generic map ( SENHA_MESTRE => SENHA_MESTRE , SENHA_PADRAO => SENHA_PADRAO )
	port map (senhaDigitada => senhaDigitada , tipoSenha => tipoSenha, destravaPorta => resultado );

  -- inicialmente a senha esta sendo digitada e armazenada em binario, necessario converter para inteiro
  process(botaoSet)
  begin
    if botaoSet = '0' then
    	y <= op1 -- estado inicial Op0
    else if rising_edge(botaoSet) then
      case y
        when op1 => 
       	  chaves(0 to 3) = senha_binaria(0 to 3);
          y <= d0;
        when d0 =>
       	  chaves(0 to 3) = senha_binaria(4 to 7);
          y <= d1;
        when d1 =>
       	  chaves(0 to 3) = senha_binaria(8 to 11);
          y <= d2;
        when d2 =>
       	  chaves(0 to 3) = senha_binaria(12 to 15);
          y <= d3;
        when d3 =>
       	  if senha_binaria(0 to 15) == senha_salva(0 to 15) then
            y <= abrir;
          else
            contador <= contador + 1;
            y <= erro;
          end if;
        when abrir =>
          destravaPorta = '1';
       	  y <= op0;
        when erro =>
       	  if contador <= attempts then
            y <= d0;
          else
            y <= bloqueio;
            destravaPorta = '0';
          end if;
        when bloqueio =>
       	  chaves(0 to 3) = senha_binaria(0 to 3);
          y <= m0;
        when m0 =>
       	  chaves(0 to 3) = senha_binaria(4 to 7);
          y <= m1;
        when m1 =>
       	  chaves(0 to 3) = senha_binaria(8 to 11);
          y <= m2;
        when m2 =>
       	  chaves(0 to 3) = senha_binaria(12 to 15);
          y <= m3;
        when m3 =>
       	  if senha_binaria(0 to 15) == senha_mestre(0 to 15) then
            y <= op0;
          else
            y <= op0; -- não sei para onde vai esse caso.
          end if;
      end case;
    end if;
  end process;
end comportamental;
