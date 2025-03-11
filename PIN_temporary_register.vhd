---temporary register when entering PIN on keypad it keeps value step by step until it is needed to put in comparator
---reset and load active on 0
---16 bit long


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PIN_temporary_register IS
  PORT (
      Data: in std_logic_vector(15 downto 0);
      LD,RST,CLK: in std_logic;
      Q: out std_logic_vector(15 downto 0)
      
    );
END PIN_temporary_register;


ARCHITECTURE A1 OF PIN_temporary_register IS

signal intQ: std_logic_vector(15 downto 0);

BEGIN

   process(CLK,RST)
     
	begin
	 	if rising_edge(CLK) then
	 		if RST='0' then 
	 		    intQ <="0000000000000000";
	 		elsif RST='1' and LD='0' then
	 		    intQ <=Data;
	 		else
	 		    intQ <= intQ;
	 		end if;
	 	end if;
	end process;
	Q<=intQ;

END A1;
