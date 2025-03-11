
--34 bit register for storing BCD representations of pin sold and binary represenation for card_no, it doen't need reset
-- data will change using XOR properties for each bit
--bit 33,32 cardno
--bit 31->16 PIN
--bit 15->0 sold

-- load active on 0

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Big_register1 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END Big_register1;


ARCHITECTURE A1 OF Big_register1 IS

signal intQ: std_logic_vector(33 downto 0):="0000010010001101000000001001011000";--cardNo:00, Pin:1234, sold: 258


BEGIN


   process(CLK, LD)
	begin
	   if LD='0' then
	 		    intQ <= Data;
	   else intQ <= intQ;
	   end if;
--	   elsif rising_edge(CLK) then
----	 		if LD='0' then
----	 		    intQ <= Data;
----	 		else
--	 		    intq <= intq;
--	 		end if;
--	 	end if;
	end process;
	Q<=intQ;

END A1;
