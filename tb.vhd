library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb is
  generic (
    ISTATE : std_logic_vector (1 to 3) := "100");
end entity;

architecture sim of tb is
  signal osc_clk : std_logic := '0';
  signal cpu_clk, pla_clk : std_logic;
  alias s is to_string [std_logic return string];
begin
  osc_clk <= not osc_clk after 41.667 ns;
  fdiv: entity work.bkdiv3
    generic map (
      init_state => ISTATE)
    port map (
      clk_in => osc_clk, clk2_out => pla_clk, clk3_out => cpu_clk);
  postponed process (all) is
  begin
    report "osc_clk = " & s(osc_clk) & ", cpu_clk = " & s(cpu_clk) & ", pla_clk = " & s(pla_clk);
    if now > 3000 ns then finish; end if;
  end process;
end architecture;
