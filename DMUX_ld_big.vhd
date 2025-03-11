LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DMUX_ld_big IS
  PORT (
      a: in std_logic;
      s: in std_logic_vector(1 downto 0);
      I0,I1,I2,I3: out std_logic
    );
END DMUX_ld_big;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF DMUX_ld_big IS
BEGIN

process (s)
begin

    case s is
    when "00" => I0 <= a;
    when "01" => I1 <= a;
    when "10" => I2 <= a;
    when others => I3 <= a;
    end case;
end process;

END TypeArchitecture;