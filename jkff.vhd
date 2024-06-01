library ieee;
use ieee.std_logic_1164.all;

entity jkff is
  generic (
    q0 : std_logic := '0');
  port (
    rn, sn, j, k, c : in  std_logic;
    q               : out std_logic := q0;
    qn              : out std_logic := not q0);
end entity;

architecture behav of jkff is
  function trigger(signal s : std_logic) return std_logic is
  begin
    if falling_edge(s) then return '1'; else return '0'; end if;
  end function;
begin
  with rn & sn & j & k & trigger(c) select?
    q <= '0'   when "01---" | "11011",
         '1'   when "10---" | "11101",
          q    when "1100-" | "11110",
         not q when "11111",
         'X'   when others;
  qn <= not q;
end architecture;
