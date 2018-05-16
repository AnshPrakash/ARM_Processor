library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instruction_decoder is
    port (
        clk :in  std_logic;
        --27-20, 11-4
        ins:in std_logic_vector(15 downto 0);
        not_implemented:out std_logic;
        undefined:out std_logic
    );
end Instruction_decoder;

architecture arc_Imstruction_decoder of Instruction_decoder is
    signal n1,n2,n3,n4,n5,n6,n7,n8:std_logic;
begin
    undefined<=(NOT (ins(15)) AND ins(14) )AND ins(13) AND ins(4);
    not_implemented<=n1 or n2 or n3 or n4 or n5 or n6 or n7 or n8;
    n1<=ins(14) AND ins(15);
    n2<=ins(15) AND NOT (ins(14)) AND (NOT(ins(13)));
    n3<=NOT(ins(15)) AND NOT(ins(14)) AND ins(13);
    n4<=NOT(ins(15)) AND NOT(ins(14)) AND (NOT ins(13)) AND NOT(ins(0));
    n5<=NOT(ins(15)) AND NOT(ins(14)) AND (NOT ins(13)) AND ins(0) AND NOT(ins(7)) AND ins(6) AND ins(5) AND ins(4) AND ins(3);
    n6<=NOT(NOT(ins(15)) AND NOT(ins(14)) AND (NOT ins(13)) AND ins(0) AND ins(7) AND NOT (ins(2)) AND NOT(ins(1)));
    n7<=NOT(ins(15)) AND NOT(ins(14)) AND (NOT ins(13)) AND ins(0) AND ins(7) AND NOT (ins(2)) AND NOT(ins(1)) AND NOT(ins(12)) AND ins(11);
    n8<=NOT(ins(15)) AND NOT(ins(14)) AND (NOT ins(13)) AND ins(0) AND ins(7) AND NOT (ins(2)) AND NOT(ins(1)) AND ins(12);
end architecture arc_Imstruction_decoder;
