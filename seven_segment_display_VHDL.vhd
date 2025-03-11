---ssd will show different stuff(mesages, numbers etc.)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity seven_segment_display_VHDL is
   Port ( clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
          --reset : in STD_LOGIC; -- reset
          nr1,nr2,nr3,nr4 : in std_logic_vector(3 downto 0);
          Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
          LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end seven_segment_display_VHDL;

architecture Behavioral of seven_segment_display_VHDL is
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat
begin
-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display
process(LED_BCD)
begin
   case LED_BCD is
   when "0000" => LED_out <= "1111110"; -- "0"    
   when "0001" => LED_out <= "0110000"; -- "1"
   when "0010" => LED_out <= "1101101"; -- "2"
   when "0011" => LED_out <= "1111001"; -- "3"
   when "0100" => LED_out <= "0110011"; -- "4"
   when "0101" => LED_out <= "1011011"; -- "5"
   when "0110" => LED_out <= "1011111"; -- "6"
   when "0111" => LED_out <= "1110000"; -- "7"
   when "1000" => LED_out <= "1111111"; -- "8"    
   when "1001" => LED_out <= "1111011"; -- "9"
   when "1010" => LED_out <= "1010101"; -- M
   when "1011" => LED_out <= "1011011"; -- S
   when "1100" => LED_out <= "0000001"; -- -
   when "1101" => LED_out <= "0010101"; -- N
   when "1110" => LED_out <= "1001111"; -- E
   when others => LED_out <= "1100111"; -- P
   --menu->M, selectSum->S, old->nn, new->n,next->NE,pin->P,changed->SP
   end case;
end process;
-- 7-segment display controller
-- generate refresh period of 10.5ms
process(clock_100Mhz)--reset)
begin
  
   if(rising_edge(clock_100Mhz)) then
     if(refresh_counter = "111111111111111111") then  -- if counter reaches maximum value, wrap around to 0
           refresh_counter <= (others => '0');
           else
       refresh_counter <= refresh_counter + 1;
      end if;
   end if;
end process;
LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs
process(LED_activating_counter)
begin
   case LED_activating_counter is
   when "00" =>
       Anode_Activate <= "1000";
       -- activate LED1 and Deactivate LED2, LED3, LED4
     
       --first hex digit of the current nr
   when "01" =>
       Anode_Activate <= "0100";
       -- activate LED2 and Deactivate LED1, LED3, LED4
     
       --second hex digit of current nr
   when "10" =>
       Anode_Activate <= "0010";
       -- activate LED3 and Deactivate LED2, LED1, LED4
      
       --first hex digit of the average
   when others =>
       Anode_Activate <= "0001";
       -- activate LED4 and Deactivate LED2, LED3, LED1
       LED_BCD <= nr1;
       --second hex digit of the average   
   end case;
end process;
process(LED_activating_counter)
begin
   case LED_activating_counter is
   when "00" =>  LED_BCD <= nr4;
   when "01" =>  LED_BCD <= nr3;
   when "10" => LED_BCD <= nr2;
   when others => LED_BCD <= nr1;
   end case;
   end process;
end Behavioral;
