library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk50div is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk50div;

architecture Behavioral of clk50div is

--100 MHz = 10^8 Hz
--5 * 10^7

signal count: integer := 0;
signal clk_div: std_logic := '0';

begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if count = 2 then
                count <= 1;
                clk_div <= not clk_div;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    clk_out <= clk_div;

end Behavioral;