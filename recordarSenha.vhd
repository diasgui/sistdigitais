library IEEE;
use IEEE.std_logic_1164.all;

-- esboço da operacao de abrir cofre
entity abrirCofre is
  port(
    chaves: in std_logic_vector(0 to 3);
    botaoSet: in std_logic;
    qtd_digitos: out integer
    );
end entity abrirCofre;

architecture comportamental of abrirCofre is
  type State_type is (op0, op3, d0, d1, d2, d3, final)
  
  signal y: State_type
  
  signal senha_salva: std_logic_vector(0 to 15);
  signal senha_binaria: std_logic_vector(0 to 15);
begin

  -- inicialmente a senha esta sendo digitada e armazenada em binario, necessario converter para inteiro
  process(botaoSet)
  begin
    if botaoSet = '0' then
      y <= op3;
    else if rising_edge(botaoSet) then
      case y
        when op3 =>
       	  if chaves(0 to 3) == senha_salva(0 to 3) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(4 to 7) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(8 to 11) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(12 to 15) then
            qtd_digitos <= qtd_digitos + 1;
          end if;
          
          y <= d0;
        when d0 =>
          if chaves(0 to 3) == senha_salva(0 to 3) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(4 to 7) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(8 to 11) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(12 to 15) then
            qtd_digitos <= qtd_digitos + 1;
          end if;
          
          d0 <= d1;
        when d1 =>
          if chaves(0 to 3) == senha_salva(0 to 3) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(4 to 7) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(8 to 11) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(12 to 15) then
            qtd_digitos <= qtd_digitos + 1;
          end if;
          
          d1 <= d2;
        when d2 =>
          if chaves(0 to 3) == senha_salva(0 to 3) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(4 to 7) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(8 to 11) then
            qtd_digitos <= qtd_digitos + 1;
          elsif chaves(0 to 3) == senha_salva(12 to 15) then
            qtd_digitos <= qtd_digitos + 1;
          end if;
          
          d2 <= d3;
        when d3 =>
          -- acender leds qtd_ditigos
          y <= final;
        when final =>
       	  y <= op0;
      end case;
    end if;
  end process;

end comportamental;
