
--34 bit register for storing BCD representations of pin sold and binary represenation for card_no, it doen't need reset
-- data will change using XOR properties for each bit
--bit 34,33 cardno
--bit 32->16 PIN
--bit 15->0 sold

-- load active on 0

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Big_register4 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END Big_register4;


ARCHITECTURE A1 OF Big_register4 IS

signal intQ: std_logic_vector(33 downto 0):="1100010000011001010000001000110000";--cardNo:11,PIN: 1065, Sold: 230


BEGIN


   process(CLK)
	begin
	 	if rising_edge(CLK) then
	 		if LD='0' then
	 		    intQ <= Data;
	 		else
	 		    intq <= intq;
	 		end if;
	 	end if;
	end process;
	Q<=intQ;

END A1;
