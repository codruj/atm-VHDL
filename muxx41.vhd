LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY muxx41 IS
  PORT (
  d0,d1,d2,d3,s0,s1: in std_logic;
  y: out std_logic
    );
END muxx41;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE dataflow OF muxx41 IS
BEGIN

--y <= ((not s1) and (not s0) and d0) or ((not s1)and s0 and d1) or (s1 and (not s0) and d2) or (s1 and s0 and d3);
y <= d0 when s1 = '0' and s0 = '0' else
     d1 when s1 = '0' and s0 = '1' else
     d2 when s1 ='1' and s0 ='0' else
     d3;
END dataflow;
