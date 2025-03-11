

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity menu_displayed is
    Port ( 
           
           M,E,N,U: out std_logic_vector(3 downto 0)
           );
end menu_displayed;

architecture Behavioral of menu_displayed is

begin

	U <="1011";
	N <= "1110"; 
	E <= "1101"; 
	M <= "1010";
	
end Behavioral;