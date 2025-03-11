LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CU IS
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
END CU;



ARCHITECTURE TypeArchitecture OF CU IS

type state_T is (idle, chg, check_card, display_pin, old_mes, new_mes, check_pin, menu, sold_interrogation, next_command, select_sum, sum200, sum100, sum50, introduce_sum, sold_comparator, vending_comparator, Greedy, subtractor_sold, subtractor_vending, read_banknotes, adding_sold, adding_vending, insert_old, insert_new);
signal state: state_T := idle; 
signal nxt_state: state_t;
BEGIN



update_state: process(exitt,clk, confirm)
begin
-- if(exitt='1' and confirm='1')then
-- 	state <= menu;
-- els
 if clk'event and clk = '1' then
 	state <= nxt_state;
 end if;
end process update_state;

transitions: process(state,START,CONFIRM,CORRECT,COMMAND,EXITT,Option,nOT_ENOUGH_SOLD,NOT_ENOUGH_IN_VENDING,done)
begin
--init
RSTLive<='1';RSTGreedy<='1'; RST200<='1'; RST100<='1'; RST50<='1'; RST10<='1'; RST5<='1'; RST1<='1'; eN200<='0';eN100<='0';eN50<='0';eN10<='0';eN5<='0';eN1<='0';
    ssd_keypad_check_pin<='0';ssd_keypad_new_pin<='0';ssd_keypad_old_pin<='0';start_greedy<='0'; sUM_LIVE_SSD<='0';ld_live<='1'; old_pin_ssd<='0';New_pin<='0';changed_ssd<='0'; select_sum_ssd<='0';
     cARD_NO_ssd<='0';CONVERT_SWITCH<='0';pin_ssd<='0';ERROR<='0';ld_TEMPORARY_REG<='1'; mENU_ssd<='0';lED1<='0';LED2<='0';LED3<='0';LED4<='0';sold_ssd<='0';NEXTT<='0';INTRODUCED_SUM_ssd<='0';taKE_OUT_VENDING<='0';BANKNOTES_ROLLING<='0';ld_reg<='1'; lD_VENDING<='1';
--end init

case state is
	when idle => if start='1' then
				card_no_ssd <='1';convert_switch<='1';
				nxt_state <= check_card;
			   else nxt_state <= idle;
			   end if;
	when check_card => if confirm='0' then
					nxt_state<=check_card;
				    else PIN_SSD<='1'; nxt_state<=display_pin;
				    end if;
	when display_pin => PIN_SSD <= '1';
	                    if confirm = '0' then
	                       
	                       nxt_state <= display_pin;
	                    else
	                       ssd_keypad_check_pin <= '1';
	                       nxt_state <= check_pin;
	                    end if;	       
	when check_pin =>  ssd_keypad_check_pin<='1';
	                   if confirm='0'then
					nxt_state<=check_pin;
--					 else
				   else ld_temporary_reg<='0';
				   		if correct ='0' then 
				   			error <= '1';
				   			nxt_state <= display_pin;
				   		else nxt_state<= menu;
				   		end if;
				   end if;
	when menu => menu_ssd <= '1'; led1<='1';led2<='1';led3<='1';led4<='1';
	               if confirm = '1' then
						if command = "001" then 
							led1<='1'; led2<='0';led3<='0';led4<='0';
							nxt_state<=sold_interrogation;
						elsif command = "010" then 
							led1<='0'; led2<='1';led3<='0';led4<='0';
							nxt_state<=select_sum;
						elsif command = "011" then 
							led1<='0'; led2<='0';led3<='1';led4<='0';
							en1<='1';en5<='1';en10<='1';en50<='1';en100<='1';en200<='1';
							rst1<='0';rst5<='0';rst10<='0';rst50<='0';rst100<='0';rst200<='0';
							nxt_state<=read_banknotes;
						elsif command = "100" then 
							led1<='0'; led2<='0';led3<='0';led4<='1';
							nxt_state<=old_mes;
						else error<='1'; nxt_state <= menu;
						end if;
				    elsif exitt = '1' then nxt_state <= idle;
				    else nxt_state <= menu;
					end if;
	when sold_interrogation => sold_ssd<='1'; 
						if confirm ='1' then 
							nxt_state<= next_command;
						else nxt_state<=sold_interrogation;
						end if;
	when next_command => nextt<='1'; --ld_reg <= '0'; ld_temporary_reg<='0';
					 if exitt ='0' then 
					 	nxt_state <= next_command;
					 else
						nxt_state <= menu;
					end if;
	when select_sum => select_sum_ssd<='1';
	                    if option ="100" then
						nxt_state <= introduce_sum;
					elsif option = "001" then --200
						nxt_state <= sum200;
					elsif option = "010" then --100
						nxt_state <= sum100;
					elsif option = "011" then -- 50
						nxt_state <= sum50;
					else error <= '1'; nxt_state <= select_sum;
					end if;
	when sum200 => banknote200<='1'; nxt_state<=sold_comparator;
	when sum100 => banknote100<='1'; nxt_state<=sold_comparator;
	when sum50 => banknote50<='1';nxt_state<=sold_comparator;
	when introduce_sum =>INTRODUCED_SUM_ssd<='0';
					  if confirm ='0' then 
					  	nxt_state <= introduce_sum;
					  else nxt_state <= sold_comparator;
					  end if;
	when sold_comparator => if not_enough_sold = '1' then
							error <= '1';
							nxt_state <= introduce_sum;
						else take_out_vending <= '1';
							nxt_state <= vending_comparator;
						end if;
	when vending_comparator => if not_enough_in_vending = '1' then 
							error <= '1';
							nxt_state <= introduce_sum;
						  else nxt_state <= greedy;
				
						end if;
	when greedy => start_greedy<='1';
	           if done = '0' then 
					nxt_state<=greedy;
				else banknotes_rolling<='1';
					nxt_state <= subtractor_sold;
				end if;
	when subtractor_sold => ld_reg <= '0';
					    nxt_state <= subtractor_vending;
	when subtractor_vending => ld_vending<='0';
						  nxt_state<=sold_interrogation;
	when read_banknotes => sum_live_ssd<='1'; ld_live<='0';
						if confirm = '0' then 
							nxt_state <= read_banknotes;
						else eN200<='0';eN100<='0';eN50<='0';eN10<='0';eN5<='0';eN1<='0';
							nxt_state <= adding_sold;
						end if;
	when adding_sold=> ld_reg<='0';
					nxt_state<= adding_vending;
	when adding_vending => ld_vending<='0';
					   nxt_state<=sold_interrogation;
	when old_mes =>  old_pin_ssd<='1';
	                 if confirm = '1' then
	                   nxt_state <= insert_old;
	                 else
	                   nxt_state <= old_mes;
	                 end if;
	when insert_old => ssd_keypad_new_pin<='1'; --ld_temporary_reg<='0';
				    if confirm = '0' then
				    		nxt_state<=insert_old;
				    	else if correct = '0' then 
				    		nxt_state<=old_mes;
				    		else nxt_state <= new_mes;
				    		end if;
				    	end if;
    when new_mes => new_pin <='1';
                    if confirm = '0' then
                        nxt_state <= new_mes;
                    else nxt_state <= insert_new;
                    end if;
	when insert_new => ssd_keypad_new_pin<='1';  ld_temporary_reg<='0';
					if confirm ='0' then
						nxt_state<=insert_new;
					else changed_ssd <='1'; ld_reg<='0';
						nxt_state<= chg;
					end if;
	when chg => ld_reg <= '0'; rst200 <= '0';
	            if confirm ='0' then
	               nxt_state <= chg;
	            else
	               nxt_state <= next_command;
	            end if;
					   
	
end case;
end process transitions;

END TypeArchitecture;