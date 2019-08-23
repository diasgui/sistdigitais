library IEEE;
use IEEE.std_logic_1164.all;

entity BCD is
	port(
    	binario: in std_logic_vector(0 to 3);
		inteiro: out integer
	);
end entity BCD;

architecture comportamental of BCD is
begin
	with binario select
		inteiro <=
			0 when "0000",
			1 when "0001",
			2 when "0010",
			3 when "0011",
			4 when "0100",
			5 when "0101",
			6 when "0110",
			7 when "0111",
			8 when "1000",
			9 when "1001",
			-1 when others;
end comportamental;
