

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY selector_ssd IS
  PORT (
     keypad_pin_check: in std_logic;
     menu_message,pin_message, sold_ssd, old_pin_ssd, new_pin_ssd, rst200: in std_logic;
     
     keypad_pin_check_nr1,keypad_pin_check_nr2,keypad_pin_check_nr3,keypad_pin_check_nr4: in std_logic_vector(3 downto 0);
    
     
     menu_message_nr1,menu_message_nr2,menu_message_nr3,menu_message_nr4:in std_logic_vector(3 downto 0);
     
     pin_message_nr1,pin_message_nr2,pin_message_nr3,pin_message_nr4: in std_logic_vector(3 downto 0);
     sold: in std_logic_vector(15 downto 0);
     

     nr1,nr2,nr3,nr4: out std_logic_vector(3 downto 0)
    );
END selector_ssd;

ARCHITECTURE behavior OF selector_ssd IS
BEGIN
  PROCESS (keypad_pin_check, menu_message, pin_message)
  BEGIN
    IF keypad_pin_check = '1' THEN
      nr1 <= keypad_pin_check_nr1;
      nr2 <= keypad_pin_check_nr2;
      nr3 <= keypad_pin_check_nr3;
      nr4 <= keypad_pin_check_nr4;
    ELSIF menu_message = '1' THEN
      nr1 <= menu_message_nr1;
      nr2 <= menu_message_nr2;
      nr3 <= menu_message_nr3;
      nr4 <= menu_message_nr4;
    ELSIF pin_message = '1' THEN
      nr1 <= pin_message_nr1;
      nr2 <= pin_message_nr2;
      nr3 <= pin_message_nr3;
      nr4 <= pin_message_nr4;
    ELSIF sold_ssd = '1' then
      nr1 <= sold(3 downto 0);
      nr2 <= sold(7 downto 4);
      nr3 <= sold(11 downto 8);
      nr4 <= sold(15 downto 12);
    elsif old_pin_ssd = '1' then
        nr4 <= "0000";
        nr3 <= "1100";
        nr2 <= "1010";
        nr1 <= "1010";
    elsif new_pin_ssd = '1' then
        nr4 <= "1101";
        nr3 <= "1110";
        nr2 <= "1010";
        nr1 <= "1010";
    elsif rst200 <= '0' then
        nr4 <= "0000";
        nr3 <= "1101";
        nr2 <= "1110";
        nr1 <= "1010";
    ELSE
     nr1 <= (others => '0');
    nr2 <= (others => '0');
    nr3 <= (others => '0');
   nr4 <= (others => '0');
END IF;
END PROCESS;
END behavior;
