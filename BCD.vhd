library IEEE;
use IEEE.std_logic_1164.all;

entity BCD is
	port(
    	binary: in std_logic_vector(3 downto 0);
        decimal: out integer
        );
end entity BCD;

architecture comportamental of BCD is
begin
	case binary is
    	when "0000" => decimal <= '0';
        when "0001" => decimal <= '1';
        when "0010" => decimal <= '2';
        when "0011" => decimal <= '3';
        when "0100" => decimal <= '4';
        when "0101" => decimal <= '5';
        when "0110" => decimal <= '6';
        when "0111" => decimal <= '7';
        when "1000" => decimal <= '8';
        when "1001" => decimal <= '9';
        when others => decimal <= 'X';
	end case;
end comportamental;
