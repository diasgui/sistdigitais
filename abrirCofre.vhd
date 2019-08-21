library IEEE;
use IEEE.std_logic_1164.all;

-- esboço da operacao de abrir cofre
entity abrirCofre is
  port(
    senha_digitada: in std_logic_vector(0 to 15);
    senha_salva: in std_logic_vector(0 to 3);
    destravaPorta: out std_logic
    );
end entity abrirCofre;

architecture comportamental of abrirCofre is
  signal senha_inteira: std_logic_vector(0 to 3);
  signal contador: integer := 0;
  constant attempts : integer := 3
begin

  -- decodificar a senha digitada em bcd para senha_inteira

  if senha_salva == senha_inteira and contador < attempts then
    destravaPorta <= '1';
  else
    attempts <= attempls + 1;
  end if;

  if (attempts == 3) then
    destravaPorta <= '0';
    -- retorna a operacao inicial
  end if;

end comportamental;
