library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity keypad_test is
  Port ( clk: in std_logic;
         rst: in std_logic;
         JA: inout std_logic_vector(7 downto 0);
         an: out std_logic_vector(3 downto 0);
         cat: out std_logic_vector(6 downto 0)
   );
end keypad_test;

architecture Behavioral of keypad_test is

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

signal icif, iq0, iq1, iq2, iq3, ip: std_logic_vector(3 downto 0);
signal shft, irst: std_logic;


begin

l0: debouncer port map(clk => clk, btn => rst, enable => irst);
l1: pmodkypd port map(clk => clk, ja => ja, cifra => icif);
l2: ssd port map(clk => clk,  d0 => iq0, d1 => iq1, d2 => iq2, d3 => iq3, an => an, cat => cat);
l3: edge_detector port map(clk => clk, input => icif(0), pulse => ip(0));
l4: edge_detector port map(clk => clk, input => icif(1), pulse => ip(1));
l5: edge_detector port map(clk => clk, input => icif(2), pulse => ip(2));
l6: edge_detector port map(clk => clk, input => icif(3), pulse => ip(3));
shft <= ip(0) or ip(1) or ip(2) or ip(3);
l7: shift_register_4_4 port map(serial_in => icif, sh_left => shft, clk => clk, rst => irst, q0 => iq0, q1 => iq1, q2 => iq2, q3 => iq3);
end Behavioral;
