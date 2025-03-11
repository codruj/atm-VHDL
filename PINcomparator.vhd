

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PINcomparator IS
  PORT (
  insertedPIN, registerPIN: in std_logic_vector(15 downto 0);
  y: out std_logic
    );
END PINcomparator;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE behavioral OF PINcomparator IS
--signal y1: std_logic_vector(15 downto 0);
BEGIN

--y1(0) <= insertedPIN(0) XNOR registerPIN(0);
--y1(1) <= insertedPIN(1) AND registerPIN(1);
--y1(2) <= insertedPIN(2) AND registerPIN(2);
--y1(3) <= insertedPIN(3) AND registerPIN(3);
--y1(4) <= insertedPIN(4) AND registerPIN(4);
--y1(5) <= insertedPIN(5) AND registerPIN(5);
--y1(6) <= insertedPIN(6) AND registerPIN(6);
--y1(7) <= insertedPIN(7) AND registerPIN(7);
--y1(8) <= insertedPIN(8) AND registerPIN(8);
--y1(9) <= insertedPIN(9) AND registerPIN(9);
--y1(10) <= insertedPIN(10) AND registerPIN(10);
--y1(11) <= insertedPIN(11) AND registerPIN(11);
--y1(12) <= insertedPIN(12) AND registerPIN(12);
--y1(13) <= insertedPIN(13) AND registerPIN(13);
--y1(14) <= insertedPIN(14) AND registerPIN(14);
--y1(15) <= insertedPIN(15) AND registerPIN(15);
--
--y <= y1(0)and y1(1)and y1(2)and y1(3)and y1(4)and y1(5)and (6)and y1(7) and y1(8)and y1(9)and y1(9)and y1(10)and y1(11)and y1(12)and y1(13)and y1(14)and y1 
--
y <= '1' when (insertedPIN = registerPIN) else '0';

END behavioral;
