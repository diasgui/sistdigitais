library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

-- initial entity
entity senhaCofre is 
  port(chaves : in std_logic_vector(0 to 3);
    botaoSet : in std_logic;
    destravaPorta : out std_logic;
    senhaAlterada : out std_logic;
    digitosCorretos  : out std_logic_vector(0 to 3));
end entity senhaCofre;
