library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.mytypes.all;

entity control_state is
    port (
        clk: in std_logic;
        rst: in std_logic;
        next_state: in state;
        current_state: out state
    );
end entity;

architecture control_state_arc of control_state is
    signal cs, ns: state;
begin
    current_state<=cs;
    ns<=next_state;

    process(clk, rst) begin
        if rst='1' then
            cs<=fetch;
        elsif rising_edge(clk) then
            cs<=ns;
        end if;
    end process;

end architecture;

