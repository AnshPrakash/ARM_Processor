library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use WORK.mytypes.all;

entity Actrl is
    port (
        -- 27-26, 24-20, 7-4
        state: in state;
        ins: in std_logic_vector(10 downto 0);
        op: out std_logic_vector(3 downto 0)
    );
end Actrl;

architecture Actrl_arc of Actrl is
    signal F: std_logic_vector(1 downto 0);
    signal opcode: std_logic_vector(3 downto 0);
    signal L, U : std_logic;
    signal M: std_logic_vector(3 downto 0); --Checking for Mul.
begin
    F<=ins(10 downto 9);
    opcode<=ins(8 downto 5);
    U<=ins(7);
    -- not really needed.
    -- too lazy to change everywhere.
    L<=ins(4);
    M<=ins(3 downto 0);

    process(F, opcode, L, M, U,state) begin
        if state=fetch  then
            op<="0100";
        elsif F="00" then --DP
            if M="1001" then
                op<="1101";
            else
                op<=opcode;
            end if;
        elsif F="01" then --DT
            if U='1' then
                op<="0100";
            else
                op<="0010";
            end if;
        else
            op<="0100";
        end if;
    end process;
end architecture;
