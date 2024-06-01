library ieee;
use ieee.std_logic_1164.all;

entity bkdiv3 is
  generic (
    init_state : std_logic_vector (1 to 3) := "001");
  port (
    clk_in             : in  std_logic;
    clk2_out, clk3_out : out std_logic);
end entity;

architecture struct of bkdiv3 is
  signal q1, qn1, q2, qn2 : std_logic;
begin
  jkff: entity work.jkff
    generic map (
      q0 => init_state(1))
    port map (
      rn => '1', sn => '1', j => '1', k => '1', c => clk_in, q => clk2_out, qn => open);
  dff1: entity work.dff
    generic map (
      q0 => init_state(2))
    port map (
      rn => q2, sn => '1', d => q2, c => not clk_in, q => q1, qn => qn1);
  dff2: entity work.dff
    generic map (
      q0 => init_state(3))
    port map (
      rn => '1', sn => '1', d => qn1, c => not clk_in, q => q2, qn => open);
  clk3_out <= q1;
end architecture;
