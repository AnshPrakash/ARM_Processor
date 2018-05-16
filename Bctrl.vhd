library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Bctrl is
    port (
        cond: in std_logic_vector(3 downto 0);
        NCZV: in std_logic_vector(3 downto 0);
        p: out std_logic
    );
end Bctrl;

architecture Bctrl_arc of Bctrl is
    signal N,C,Z,V, temp: std_logic;
begin
    N<=NCZV(3);
    C<=NCZV(2);
    Z<=NCZV(1);
    V<=NCZV(0);

    p<=temp;
    process(cond, N, C, Z, V, temp) begin
        case cond is
            when "0000" => temp<=Z;
            when "0001" => temp<=not Z;
            when "0010" => temp<=C;
            when "0011" => temp<=not C;
            when "0100" => temp<=N;
            when "0101" => temp<=not N;
            when "0110" => temp<=V;
            when "0111" => temp<=not V;
            when "1000" => temp<=C and (not Z);
            when "1001" => temp<=Z and (not C);
            when "1010" => temp<=not (N xor V);
            when "1011" => temp<=N xor V;
            when "1100" => temp<=(not Z) and (not (N xor V));
            when "1101" => temp<=Z or (N xor V);
            when "1110" => temp<='1';
            when others => temp<='1';
        end case;
    end process;
end architecture;
