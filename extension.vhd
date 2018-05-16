library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX12 is
    port (
        input1: in std_logic_vector(11 downto 0);
        o: out std_logic_vector(31 downto 0)
    );
end EX12;

architecture EX12_arc of EX12 is
begin
    o<="00000000000000000000"&input1;
end EX12_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX8 is
    port (
        input1: in std_logic_vector(7 downto 0);
        o: out std_logic_vector(31 downto 0)
    );
end EX8;

architecture EX8_arc of EX8 is
begin
    o<="000000000000000000000000"&input1;
end EX8_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity S2 is
    port (
        input1:in std_logic_vector(23 downto 0);
        o:out std_logic_vector(31 downto 0)
    );
end S2;

architecture S2_arc of S2 is
begin
    o<=input1(23)&input1(23)&input1(23)&input1(23)&input1(23)&input1(23)&input1&"00";
end S2_arc;
