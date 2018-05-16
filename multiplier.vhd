library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplier is
    port (
        input1: in std_logic_vector(31 downto 0);
        input2: in std_logic_vector(31 downto 0);
        result: out std_logic_vector(31 downto 0)
    );
end multiplier;

architecture multiplier_arc of multiplier is
    signal temp: std_logic_vector(63 downto 0);
begin
    process(input1, input2) begin
        temp<=std_logic_vector(input1*input2);
    end process;
    result<=temp(31 downto 0);
end multiplier_arc;
