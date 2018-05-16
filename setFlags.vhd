library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity setFlags is
    port (
        p  : in std_logic;
        input1: in std_logic_vector(31 downto 0);
        input2: in std_logic_vector(31 downto 0);
        result: in std_logic_vector(32 downto 0);
        out_NZCV: out std_logic_vector(3 downto 0)
    );
end setFlags;

architecture setFlags_arc of setFlags is
    signal c1, c2: std_logic;
begin
    process(result) begin
        out_NZCV<="0000";
        if p='1' then
            out_NZCV(3)<=result(31);
            if result=0 then
                out_NZCV(2)<='1';
            end if;
            c1<=input1(31) xor input2(31) xor result(31);
            c2<=(input1(31) and input2(31)) 
                or
                (c1 and (input1(31) or input2(31)));
            out_NZCV(1)<=c2;
            out_NZCV(0)<=c1 xor c2;
        else
            c1<='0';
            c2<='0';
        end if;
    end process;
end setFlags_arc;
