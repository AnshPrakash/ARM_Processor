library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use WORK.mytypes.all;

entity next_state is
    port (
        --  27,, 26, 20
        ins: in std_logic_vector(2 downto 0);
        current_state: in state;
        next_state: out state
    );
end next_state;

architecture next_state_arc of next_state is
    signal cs, ns: state;

    signal F: std_logic_vector(1 downto 0);
    signal L: std_logic;
begin
    F<=ins(2 downto 1);
    L<=ins(0);
    cs<=current_state;
    next_state<=ns;

    process(F, L, cs) begin
        case cs is
            when fetch =>ns<=rdAB;
--            when nope=> ns<=rdAB;
            when rdAB =>
                if F="00" then
                    ns<=arith;
                elsif F="01" then
                    ns<=addr;
                else
                    ns<=brn;
                end if;

             -- DP instruction
            when arith => ns<=wrRF;
            when wrRF =>ns<=fetch;

             -- DT instruction
            when addr =>
                if L='1' then
                    ns<=rdM;
                else
                    ns<=wrM;
                end if;
            when rdM => ns<=M2RF;
                when M2RF =>ns<=fetch;
                when wrM => ns<=fetch;
            -- Branch instruction
            when brn => ns<=fetch;
            when others=> null;
        end case;
    end process;
end architecture;
