library IEEE;
use IEEE.std_logic_1164.all;

-- esboço da operacao de abrir cofre
entity abrirCofre is
  port(
    chaves: in std_logic_vector(0 to 3);
    botaoSet: in std_logic;
    destravaPorta: out std_logic
    );
end entity abrirCofre;

architecture comportamental of abrirCofre is
  type State_type is (op0, op1, d0, d1, d2, d3, abrir, erro, bloqueio, m0, m1, m2, m3)
  
  signal y: State_type
  
  signal senha_salva: std_logic_vector(0 to 15);
  signal senha_mestre: std_logic_vector(0 to 15);
  signal senha_binaria: std_logic_vector(0 to 15);
  signal contador: integer := 1;
  
  constant attempts : integer := 3
begin

  -- inicialmente a senha esta sendo digitada e armazenada em binario, necessario converter para inteiro
  process(botaoSet)
  begin
    if botaoSet = '0' then
    	y <= op0 -- estado inicial Op0
    else if rising_edge(botaoSet) then
      case y
        when op0 => 
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
       	  if senha_binaria(0 to 15) == senha_salva(0 to 15)
            y <= abrir;
          else
            contador <= contador + 1;
            y <= erro;
          end if;
        when abrir =>
          destravaPorta = '1';
       	  y <= op0;
        when erro =>
       	  if contador > attempts
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
       	  if senha_binaria(0 to 15) == senha_mestre(0 to 15)
            y <= op0;
          else
            y <= op0; -- não sei para onde vai esse caso.
          end if;
      end case;
    end if;
  end process;
end comportamental;
