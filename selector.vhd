library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_4 is
    port(
         a: in std_logic_vector(3 downto 0);
         b: in std_logic_vector(3 downto 0);
         o: out std_logic_vector(3 downto 0);
         s: in std_logic
        );
end entity;

architecture mux2_4_arc of mux2_4 is
begin
    process(a,b,s) begin
        if s='1' then
            o<=b;
        else
            o<=a;
        end if;
    end process;
end mux2_4_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_5 is
    port(
         a: in std_logic_vector(4 downto 0);
         b: in std_logic_vector(4 downto 0);
         o: out std_logic_vector(4 downto 0);
         s: in std_logic
        );
end entity;

architecture mux2_5_arc of mux2_5 is
begin
    process(a,b,s) begin
        if s='1' then
            o<=b;
        else
            o<=a;
        end if;
    end process;
end mux2_5_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_32 is
    port(
         a: in std_logic_vector(31 downto 0);
         b: in std_logic_vector(31 downto 0);
         o: out std_logic_vector(31 downto 0);
         s: in std_logic
        );
end entity;

architecture mux2_32_arc of mux2_32 is
begin
    process(a,b,s) begin
        if s='1' then
            o<=b;
        else
            o<=a;
        end if;
    end process;
end mux2_32_arc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    port(
        a:in std_logic_vector(31 downto 0);
        b:in std_logic_vector(31 downto 0);
        c:in std_logic_vector(31 downto 0);
        d:in std_logic_vector(31 downto 0);
        s:in std_logic_vector(1 downto 0);
        o:out std_logic_vector(31 downto 0)
        );
end entity mux4;

architecture mux4_arc of mux4 is
begin
    process(a,b,c,d,s) begin
        case s is
            when "00" => o<=a;
            when "01" => o<=b;
            when "10" => o<=c;
            when "11" => o<=d;
            when others => o<=(others=>'0');
        end case;
    end process;
end mux4_arc;

