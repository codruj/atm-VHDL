

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity pin_displayed is
    Port ( 
           
           P,I,N,X: out std_logic_vector(3 downto 0)
           );
end pin_displayed;

architecture Behavioral of pin_displayed is

begin

	x<="1111";
	n <= "1100"; 
	i <= "1101"; 
	p<= "1010";
	
end Behavioral;