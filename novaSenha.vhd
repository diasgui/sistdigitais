library IEEE;
use IEEE.std_logic_1164.all;

-- esboço da operacao de abrir cofre
entity novaSenha is
  port(
    chaves: in std_logic_vector(0 to 3);
    botaoSet: in std_logic
    );
end entity novaSenha;

architecture comportamental of novaSenha is
  type State_type is (op0, op2, d0, d1, d2, d3, erro, novo, n0, n1, n2, n3)
  
  signal y: State_type
  
  signal senha_salva: std_logic_vector(0 to 15);
  signal senha_mestre: std_logic_vector(0 to 15);
  signal senha_binaria: std_logic_vector(0 to 15);
  signal contador: integer := 1;
  
  constant attempts: integer := 3;
  
begin

  -- inicialmente a senha esta sendo digitada e armazenada em binario, necessario converter para inteiro
  process(botaoSet)
  begin
    if botaoSet = '0' then
      y <= op2;
    else if rising_edge(botaoSet) then
      case y
        when op2 => 
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
          if senha_binaria(0 to 15) == senha_salva(0 to 15) or senha_binaria(0 to 15) == senha_mestre(0 to 15) then
            y <= novo;
          else
            contador <= contador + 1;
            y <= erro;
          end if;
        when erro =>
          if contador <= attempts then
            y <= op2;
          else
            y <= op0;
          end if;
        when novo =>
       	  chaves(0 to 3) = senha_salva(0 to 3);
          y <= n0;
        when n0 =>
       	  chaves(0 to 3) = senha_salva(4 to 7);
          y <= n1;
        when n1 =>
       	  chaves(0 to 3) = senha_salva(8 to 11);
          y <= n2;
        when n2 =>
       	  chaves(0 to 3) = senha_salva(12 to 15);
          y <= n3;
        when n3 =>
          y <= op0;
      end case;
    end if;
  end process;

end comportamental;
