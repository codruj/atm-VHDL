

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY selector_ssd IS
  PORT (
     keypad_pin_check,keypad_pin_old,keypad_pin_nou,keypad_introduce_sum: in std_logic;
     banknotes_rolling,sold_ssd: in std_logic;
     menu_message, select_sum_message, old_message, new_message,next_message,pin_message,changed_message: in std_logic;
     
     keypad_pin_check_nr1,keypad_pin_check_nr2,keypad_pin_check_nr3,keypad_pin_check_nr4: in std_logic_vector(3 downto 0);
     keypad_pin_old_nr1,keypad_pin_old_nr2,keypad_pin_old_nr3,keypad_pin_old_nr4: in std_logic_vector(3 downto 0);
     keypad_pin_nou_nr1,keypad_pin_nou_nr2,keypad_pin_nou_nr3,keypad_pin_nou_nr4: in std_logic_vector(3 downto 0);
     keypad_introduce_sum_nr1,keypad_introduce_sum_nr2,keypad_introduce_sum_nr3,keypad_introduce_sum_nr4: in std_logic_vector(3 downto 0);
     
     banknotes_rolling_nr1,banknotes_rolling_nr2,banknotes_rolling_nr3,banknotes_rolling_nr4:in std_logic_vector(3 downto 0);
     sold_ssd_nr1,sold_ssd_nr2,sold_ssd_nr3,sold_ssd_nr4:in std_logic_vector(3 downto 0);
     
     menu_message_nr1,menu_message_nr2,menu_message_nr3,menu_message_nr4:in std_logic_vector(3 downto 0);
     select_sum_message_nr1,select_sum_message_nr2,select_sum_message_nr3,select_sum_message_nr4:in std_logic_vector(3 downto 0);
     old_message_nr1,old_message_nr2,old_message_nr3,old_message_nr4: in std_logic_vector(3 downto 0);
     new_message_nr1,new_message_nr2,new_message_nr3,new_message_nr4: in std_logic_vector(3 downto 0);
     next_message_nr1,next_message_nr2,next_message_nr3,next_message_nr4: in std_logic_vector(3 downto 0);
     pin_message_nr1,pin_message_nr2,pin_message_nr3,pin_message_nr4: in std_logic_vector(3 downto 0);
     changed_message_nr1,changed_message_nr2,changed_message_nr3,changed_message_nr4 : in std_logic_vector(3 downto 0);

     nr1,nr2,nr3,nr4: out std_logic_vector(3 downto 0)
    );
END selector_ssd;

ARCHITECTURE behavior OF selector_ssd IS
BEGIN
  PROCESS (keypad_pin_check, keypad_pin_old, keypad_pin_nou, keypad_introduce_sum,
           banknotes_rolling, sold_ssd, menu_message, select_sum_message, old_message,
           new_message, next_message, pin_message, changed_message)
  BEGIN
    IF keypad_pin_check = '1' THEN
      nr1 <= keypad_pin_check_nr1;
      nr2 <= keypad_pin_check_nr2;
      nr3 <= keypad_pin_check_nr3;
      nr4 <= keypad_pin_check_nr4;
    ELSIF keypad_pin_old = '1' THEN
      nr1 <= keypad_pin_old_nr1;
      nr2 <= keypad_pin_old_nr2;
      nr3 <= keypad_pin_old_nr3;
      nr4 <= keypad_pin_old_nr4;
    ELSIF keypad_pin_nou = '1' THEN
      nr1 <= keypad_pin_nou_nr1;
      nr2 <= keypad_pin_nou_nr2;
      nr3 <= keypad_pin_nou_nr3;
      nr4 <= keypad_pin_nou_nr4;
    ELSIF keypad_introduce_sum = '1' THEN
      nr1 <= keypad_introduce_sum_nr1;
      nr2 <= keypad_introduce_sum_nr2;
      nr3 <= keypad_introduce_sum_nr3;
      nr4 <= keypad_introduce_sum_nr4;
    ELSIF banknotes_rolling = '1' THEN
      nr1 <= banknotes_rolling_nr1;
      nr2 <= banknotes_rolling_nr2;
      nr3 <= banknotes_rolling_nr3;
      nr4 <= banknotes_rolling_nr4;
    ELSIF sold_ssd = '1' THEN
      nr1 <= sold_ssd_nr1;
      nr2 <= sold_ssd_nr2;
      nr3 <= sold_ssd_nr3;
      nr4 <= sold_ssd_nr4;
    ELSIF menu_message = '1' THEN
      nr1 <= menu_message_nr1;
      nr2 <= menu_message_nr2;
      nr3 <= menu_message_nr3;
      nr4 <= menu_message_nr4;
    ELSIF select_sum_message = '1' THEN
      nr1 <= select_sum_message_nr1;
      nr2 <= select_sum_message_nr2;
      nr3 <= select_sum_message_nr3;
      nr4 <= select_sum_message_nr4;
    ELSIF old_message = '1' THEN
      nr1 <= old_message_nr1;
      nr2 <= old_message_nr2;
      nr3 <= old_message_nr3;
      nr4 <= old_message_nr4;
    ELSIF new_message = '1' THEN
      nr1 <= new_message_nr1;
      nr2 <= new_message_nr2;
      nr3 <= new_message_nr3;
      nr4 <= new_message_nr4;
    ELSIF next_message = '1' THEN
      nr1 <= next_message_nr1;
      nr2 <= next_message_nr2;
      nr3 <= next_message_nr3;
      nr4 <= next_message_nr4;
    ELSIF pin_message = '1' THEN
      nr1 <= pin_message_nr1;
      nr2 <= pin_message_nr2;
      nr3 <= pin_message_nr3;
      nr4 <= pin_message_nr4;
    ELSIF changed_message = '1' THEN
      nr1 <= changed_message_nr1;
      nr2 <= changed_message_nr2;
      nr3 <= changed_message_nr3;
      nr4 <= changed_message_nr4;
    ELSE
     nr1 <= (others => '0');
    nr2 <= (others => '0');
    nr3 <= (others => '0');
   nr4 <= (others => '0');
END IF;
END PROCESS;
END behavior;
