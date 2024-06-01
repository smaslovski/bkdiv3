library ieee;
use ieee.std_logic_1164.all;

entity dff is
  generic (
    q0 : std_logic := '0');
  port (
    rn, sn, d, c : in  std_logic;
    q            : out std_logic := q0;
    qn           : out std_logic := not q0);
end entity;

architecture behav of dff is
  function trigger(signal s : std_logic) return std_logic is
  begin
    if rising_edge(s) then return '1'; else return '0'; end if;
  end function;
begin
  with rn & sn & trigger(c) select?
    q <= '0' when "01-",
         '1' when "10-",
          q  when "110",
          d  when "111",
         'X' when others;
  qn <= not q;
end architecture;
