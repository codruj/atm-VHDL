--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX41_sold IS
  PORT (
             I1,I2,I3,I4:in std_logic_vector(15 downto 0);
             s1,s2: in std_logic;
             y:out std_logic_vector(15 downto 0)
    );
END MUX41_sold;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE behav OF MUX41_sold IS
BEGIN

process(s1,s2)
begin
	if s2='0' and s1='0' then y<=I1;
	elsif s2='0' and s1='1' then y<=I2;
	elsif s2='1' and s1='0' then y<=I3;
	else y<=I4;
	end if;
end process;

END behav;
