library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_circuit is
  Port ( clk: in std_logic;
         card_no: in std_logic_vector(1 downto 0);
         command: in std_logic_vector(2 downto 0);
         start, confirm, master_reset, exitt: in std_logic;
         --state3, state4: out std_logic;
         breg: out std_logic_vector(15 downto 0);
         JA: inout std_logic_vector(7 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0)
   );
end top_circuit;

architecture Behavioral of top_circuit is

component CU IS
  PORT (
     clk,START,CONFIRM,CORRECT,EXITT,nOT_ENOUGH_SOLD,NOT_ENOUGH_IN_VENDING,done: IN std_logic;
     COMMAND: in std_logic_vector(2 downto 0);
     Option: in std_logic_vector (2 downto 0);
     RSTLive,RSTGreedy,RST200,RST100,RST50,RST10,RST5,RST1,eN200,eN100,eN50,eN10,eN5,eN1: OUT std_logic;
     sUM_LIVE_SSD,ld_live,old_pin_ssd,New_pin,changed_ssd,select_sum_ssd: out std_logic;
     cARD_NO_ssd,CONVERT_SWITCH,pin_ssd,ERROR,ld_TEMPORARY_REG,mENU_ssd,lED1,LED2,LED3,LED4,sold_ssd,NEXTT,INTRODUCED_SUM_ssd,taKE_OUT_VENDING,BANKNOTES_ROLLING,ld_reg,lD_VENDING: OUT STD_LOGIC;
     banknote200,banknote100,banknote50,start_greedy: out std_logic;
     ssd_keypad_check_pin,ssd_keypad_new_pin,ssd_keypad_old_pin: out  std_logic
    );
END component CU;

component SSD is
    Port ( clk : in STD_LOGIC;
           d0 : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : in STD_LOGIC_VECTOR (3 downto 0);
           d2 : in STD_LOGIC_VECTOR (3 downto 0);
           d3 : in STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component SSD;

component PmodKYPD is
    Port ( 
			  clk : in  STD_LOGIC;
			  JA : inout  STD_LOGIC_VECTOR (7 downto 0); -- PmodKYPD is designed to be connected to JA
                cifra : out  STD_LOGIC_VECTOR (3 downto 0)  -- Controls which position of the seven segment display to display
           );
end component PmodKYPD;

component edge_detector is
port ( clk: in  std_logic;
       input: in  std_logic;
       pulse: out std_logic);
end component edge_detector;

component shift_register_4_4 is
    Port ( serial_in : in STD_LOGIC_VECTOR (3 downto 0);
           sh_left : in STD_LOGIC;
           rst: in STD_LOGIC;
           clk : in STD_LOGIC;
           q0, q1, q2, q3 : out STD_LOGIC_VECTOR (3 downto 0));
end component shift_register_4_4;

component debouncer is
    Port ( btn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : out  STD_LOGIC);
end component debouncer;

component DMUX_ld_big IS
  PORT (
      a: in std_logic;
      s: in std_logic_vector(1 downto 0);
      I0,I1,I2,I3: out std_logic
    );
END component DMUX_ld_big;

component Big_register1 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END component Big_register1;

component Big_register2 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END component Big_register2;

component Big_register3 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END component Big_register3;

component Big_register4 IS
  PORT (
      Data: in std_logic_vector(33 downto 0);
      LD,CLK: in std_logic;
      Q: out std_logic_vector(33 downto 0)
      
    );
END component Big_register4;

component PIN_temporary_register IS
  PORT (
      Data: in std_logic_vector(15 downto 0);
      LD,RST,CLK: in std_logic;
      Q: out std_logic_vector(15 downto 0)
      
    );
END component PIN_temporary_register;

component PINcomparator IS
  PORT (
  insertedPIN, registerPIN: in std_logic_vector(15 downto 0);
  y: out std_logic
    );
END component PINcomparator;

component muxx41 IS
  PORT (
  d0,d1,d2,d3,s0,s1: in std_logic;
  y: out std_logic
    );
END component;

component selector_ssd IS
  PORT (
     keypad_pin_check: in std_logic;
     menu_message,pin_message, sold_ssd, old_pin_ssd, new_pin_ssd, rst200: in std_logic;
     
     keypad_pin_check_nr1,keypad_pin_check_nr2,keypad_pin_check_nr3,keypad_pin_check_nr4: in std_logic_vector(3 downto 0);
    
     
     menu_message_nr1,menu_message_nr2,menu_message_nr3,menu_message_nr4:in std_logic_vector(3 downto 0);
     
     pin_message_nr1,pin_message_nr2,pin_message_nr3,pin_message_nr4: in std_logic_vector(3 downto 0);
     sold: in std_logic_vector(15 downto 0);

     nr1,nr2,nr3,nr4: out std_logic_vector(3 downto 0)
    );
END component;

component menu_displayed is
    Port ( 
           
           M,E,N,U: out std_logic_vector(3 downto 0)
           );
end component;

component pin_displayed is
    Port ( 
           
           P,I,N,X: out std_logic_vector(3 downto 0)
           );
end component;

component MUX41_sold IS
  PORT (
             I1,I2,I3,I4:in std_logic_vector(15 downto 0);
             s1,s2: in std_logic;
             y:out std_logic_vector(15 downto 0)
    );
END component MUX41_sold;


signal icif, iq0, iq1, iq2, iq3, ip, pincomp_out: std_logic_vector(3 downto 0);
signal regQ0,regQ1,regQ2,regQ3: std_logic_vector(33 downto 0);
signal shft, irst, ld_temp, ld_big, ld_big1, ld_big2, ld_big3, ld_big4: std_logic;
signal istart, icfrm: std_logic;
signal pin_temp_q: std_logic_vector(15 downto 0);
signal inputMUX0,inputMUX1,inputMUX2,inputMUX3: std_logic;  --pin mux send correct signal
signal icorrect : std_logic; --sends correct signal to CU if pin corresponds to one in big register
signal ikeypad_check_pin, issd_keypad_new_pin,issd_keypad_old_pin, imenu_message,ipin_message, isold_ssd, iexitt, iold_pin, inew_pin: std_logic;
signal menu1,menu2,menu3,menu4: std_logic_vector(3 downto 0);  --fire de la litere
signal pin1,pin2,pin3,pin4: std_logic_vector(3 downto 0);  --fire de la litere
signal issd1,issd2,issd3,issd4: std_logic_vector(3 downto 0);
signal big_pin, isold: std_logic_vector (15 downto 0);
signal show_keypad, rst_keypad, irst200: std_logic;

begin

--ssd 
lssd1: selector_ssd port map(keypad_pin_check=>show_keypad, rst200 => irst200, sold_ssd => isold_ssd, sold => isold, old_pin_ssd => iold_pin, new_pin_ssd => inew_pin, menu_message=>imenu_message,pin_message=>ipin_message,keypad_pin_check_nr1=>iq0,keypad_pin_check_nr2=>iq1,keypad_pin_check_nr3=>iq2,keypad_pin_check_nr4=>iq3,menu_message_nr1=>menu1,menu_message_nr2=>menu2,menu_message_nr3=>menu3,menu_message_nr4=>menu4,pin_message_nr1=>pin1,pin_message_nr2=>pin2,pin_message_nr3=>pin3,pin_message_nr4=>pin4,nr1=>issd1,nr2=>issd2,nr3=>issd3,nr4=>issd4);
ssd2: menu_displayed port map(M=>menu1,E=>menu2,N=>menu3,U=>menu4);
ssd3: pin_displayed port map(P=>pin1,I=>pin2,N=>pin3,x=>pin4);
lssd4: ssd port map(clk => clk,  d0 => issd1, d1 => issd2, d2 => issd3, d3 => issd4, an => an, cat => cat);

l00: dmux_ld_big port map(a => ld_big, s => card_no, i0 => ld_big1, i1 => ld_big2, i2 => ld_big3, i3 => ld_big4);
l01: debouncer port map(clk => clk, btn => start, enable => istart);
l02: debouncer port map(clk => clk, btn => confirm, enable => icfrm);
l002: debouncer port map(clk => clk, btn => exitt, enable => iexitt);
l03: pin_temporary_register port map(data(3 downto 0) => iq0, data(7 downto 4) => iq1, data(11 downto 8) => iq2, data(15 downto 12) => iq3, ld => ld_temp, rst => '1', clk => clk, q => pin_temp_q);
l0: debouncer port map(clk => clk, btn => master_reset, enable => irst);

show_keypad <= ikeypad_check_pin or issd_keypad_old_pin or issd_keypad_new_pin;
rst_keypad <= ipin_message or iold_pin or inew_pin;

---keypad
l1: pmodkypd port map(clk => clk, ja => ja, cifra => icif);
l3: edge_detector port map(clk => clk, input => icif(0), pulse => ip(0));
l4: edge_detector port map(clk => clk, input => icif(1), pulse => ip(1));
l5: edge_detector port map(clk => clk, input => icif(2), pulse => ip(2));
l6: edge_detector port map(clk => clk, input => icif(3), pulse => ip(3));
shft <= ip(0) or ip(1) or ip(2) or ip(3);
l7: shift_register_4_4 port map(serial_in => icif, sh_left => shft, clk => clk, rst => rst_keypad, q0 => iq0, q1 => iq1, q2 => iq2, q3 => iq3);

-- big registers 
--l8: Big_register1 port map(data(15 downto 0) => pin_temp_q, data(33 downto 16) => regq0(33 downto 16), LD=>ld_big1, CLK=>clk, Q=>regQ0);
--l9: Big_register2 port map(data(15 downto 0) => pin_temp_q, data(33 downto 16) => regq1(33 downto 16), LD=>ld_big2, CLK=>clk, Q=>regQ1);
--l10: Big_register3 port map(data(15 downto 0) => pin_temp_q, data(33 downto 16) => regq2(33 downto 16), ld => ld_big3, CLK=>clk, Q=>regQ2);
--l11: Big_register4 port map(data(15 downto 0) => pin_temp_q, data(33 downto 16) => regq3(33 downto 16), LD=>ld_big4, CLK=>clk, Q=>regQ3);

l8: Big_register1 port map(data(15 downto 0) => regq0(15 downto 0), data(33 downto 32) => regq0(33 downto 32), data(31 downto 16) => pin_temp_q, LD=>ld_big1, CLK=>clk, Q=>regQ0);
l9: Big_register2 port map(data(15 downto 0) => regq1(15 downto 0),data (33 downto 32) => regq1(33 downto 32), data(31 downto 16) => pin_temp_q, LD=>ld_big2, CLK=>clk, Q=>regQ1);
l10: Big_register3 port map(data(15 downto 0) => regq2(15 downto 0), data(33 downto 32) => regq2(33 downto 32), data(31 downto 16) => pin_temp_q, ld => ld_big3, CLK=>clk, Q=>regQ2);
l11: Big_register4 port map(data(15 downto 0) => regq3(15 downto 0),data (33 downto 32) => regq3(33 downto 32), data(31 downto 16) => pin_temp_q, LD=>ld_big4, CLK=>clk, Q=>regQ3);


--l8: Big_register1 port map(data=>"0000000000000000000000000000000000", LD=>'1', CLK=>clk, Q=>regQ0);
--l9: Big_register2 port map(data=>"0000000000000000000000000000000000", LD=>'1', CLK=>clk, Q=>regQ1);
--l10: Big_register3 port map(data=>"0000000000000000000000000000000000", LD=>'1', CLK=>clk, Q=>regQ2);
--l11: Big_register4 port map(data=>"0000000000000000000000000000000000", LD=>'1', CLK=>clk, Q=>regQ3);

big_pin <= iq3 & iq2 & iq1 & iq0;
--state3 <= ld_temp;
--state4 <= ld_big1;
breg <= regq0 (31 downto 16);

--connecting big registers to pin comparators
l12: PINcomparator port map(insertedPIN=>big_pin, registerPIN=>regQ0(31 downto 16) , y=>inputMUX0);
l13: PINcomparator port map(insertedPIN=>big_pin, registerPIN=>regQ1(31 downto 16), y=>inputMUX1);
l14: PINcomparator port map(insertedPIN=>big_pin, registerPIN=>regQ2(31 downto 16), y=>inputMUX2);
l15: PINcomparator port map(insertedPIN=>big_pin, registerPIN=>regQ3(31 downto 16), y=>inputMUX3);

---connecting to MUX
l16: muxx41 port map(d0=>inputMux0,d1=>inputMux1,d2=>inputMux2,d3=>inputMux3,s0=>card_no(0),s1=>card_no(1),y=>icorrect);
l166: mux41_sold port map(i1 => regq0(15 downto 0), i2 => regq1(15 downto 0), i3 => regq2(15 downto 0), i4 => regq3(15 downto 0), s1 => card_no(0), s2 => card_no(1), y => isold);

---sorting out CU signals
l17: CU port map(clk=>CLK,START => istart,CONFIRM=> icfrm,CORRECT=>icorrect,EXITT=>iexitt,nOT_ENOUGH_SOLD=>'0',NOT_ENOUGH_IN_VENDING=>'0',done=>'0',COMMAND=>command,option=>"000",RSTLive=>open,RSTGreedy=>open,RST200=>irst200,RST100=>open,RST50=>open,RST10=>open,RST5=>open,RST1=>open,eN200=>open,eN100=>open,eN50=>open,eN10=>open,eN5=>open,eN1=>open, sUM_LIVE_SSD=>open,ld_live=>open,old_pin_ssd=>iold_pin,New_pin=>inew_pin,changed_ssd=>open,select_sum_ssd=>open, cARD_NO_ssd=>open,CONVERT_SWITCH=>open,pin_ssd=>ipin_message,ERROR=>open,ld_TEMPORARY_REG=>ld_temp,mENU_ssd=>imenu_message,lED1=>open,LED2=>open,LED3=>open,LED4=>open,sold_ssd=>isold_ssd,NEXTT=>open,INTRODUCED_SUM_ssd=>open,taKE_OUT_VENDING=>open,BANKNOTES_ROLLING=>open,ld_reg=>ld_big,lD_VENDING=>open,banknote200=>open,banknote100=>open,banknote50=>open,start_greedy=>open,ssd_keypad_check_pin=>ikeypad_check_pin,ssd_keypad_new_pin=>issd_keypad_new_pin,ssd_keypad_old_pin=>issd_keypad_old_pin);

end Behavioral;
