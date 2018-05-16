library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alu is
    port (
        carry : in std_logic;
        opcode: in std_logic_vector(3 downto 0);
        input1: in std_logic_vector(31 downto 0);
        input2: in std_logic_vector(31 downto 0);
        result: out std_logic_vector(32 downto 0)
    );
end Alu;

architecture Alu_arc of Alu is
    signal a, b, temp:  std_logic_vector(32 downto 0);
begin
    a<='0'&input1;
    b<='0'&input2;
    process(a, b, opcode) begin
        case opcode is 
            when "0000" => temp <= b and a;                 --and
            when "0001" => temp <= b xor a;                 --eor
            when "0010" => temp <= (not b) + a + 1;         --sub
            when "0011" => temp <= b + (not a) + 1;         --rsb
            when "0100" => temp <= b + a;                   --add
            when "0101" => temp <= b + a + carry;           --adc
            when "0110" => temp <= (not b) + a + carry;     --sbc
            when "0111" => temp <= b + (not a) + carry;     --rsc
            when "1000" => temp <= b and a;                 --tst;
            when "1001" => temp <= b xor a;                 --teq;
            when "1010" => temp <= (not b) + a + 1;         --cmp;
            when "1011" => temp <= b + a;                   --cmn;
            when "1100" => temp <= b or a;                  --orr
            when "1101" => temp <= b;                       --mov
            when "1110" => temp <= (not b) and  a;          --bic
            when "1111" => temp <= not b;                   --mvn
            when others => temp <= (others=>'0');
        end case;
    end process;
    result<=temp;
end Alu_arc;
