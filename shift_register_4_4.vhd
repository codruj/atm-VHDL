library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_4_4 is
    Port ( serial_in : in STD_LOGIC_VECTOR (3 downto 0);
           sh_left : in STD_LOGIC;
           rst: in STD_LOGIC;
           clk : in STD_LOGIC;
           q0, q1, q2, q3 : out STD_LOGIC_VECTOR (3 downto 0));
end shift_register_4_4;

architecture Behavioral of shift_register_4_4 is

type mem is array(0 to 3) of std_logic_vector(3 downto 0);
signal memory: mem := (others => "0000");

begin

process(clk)
begin
    if rst = '1' then
        memory <= (others => "0000");
    elsif rising_edge(clk) then
        if sh_left = '1' then
            memory(3) <= memory(2);
            memory(2) <= memory (1);
            memory(1) <= memory(0);
            memory(0) <= serial_in;
        else
            memory <= memory;
        end if;
    end if;
end process;

q0 <= memory(0);
q1 <= memory(1);
q2 <= memory(2);
q3 <= memory(3);

end Behavioral;
