library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED;

entity shifter is
    port (
        input1: in std_logic_vector(31 downto 0);
        shift_type: in std_logic_vector(1 downto 0);
        shift_amount: in std_logic_vector(4 downto 0);
        result: out std_logic_vector(31 downto 0);
        shift_carry:out std_logic
    );
end shifter;

architecture shifter_arc of shifter is
    signal temp: std_logic_vector(31 downto 0);
begin
    process (temp, input1,shift_amount,shift_type) begin
        if shift_amount="00000" then
            temp<=input1;
            shift_carry<='0';
        else
            case shift_type is
                when "00" =>
                    temp <=
                        std_logic_vector(shift_left(unsigned(input1),
                        to_integer(unsigned(shift_amount)))); --LSL
                     shift_carry <= input1(31-to_integer(unsigned(shift_amount)));
                when "01" =>
                    temp <=
                        std_logic_vector(shift_right(unsigned(input1),
                        to_integer(unsigned(shift_amount)))); --LSR
                    shift_carry <= input1(to_integer(unsigned(shift_amount)));
                when "10" =>
                    temp <=
                        std_logic_vector(shift_right(signed(input1),
                        to_integer(unsigned(shift_amount)))); --ASR
                    shift_carry <= input1(to_integer(unsigned(shift_amount)));
                when "11" =>
                    temp <=
                        std_logic_vector(rotate_right(signed(input1),
                        to_integer(unsigned(shift_amount)))); --ROR
                   shift_carry <= input1(to_integer(unsigned(shift_amount)));
                when others=>null;
            end case;
        end if;
        result<=temp;
    end process;
end shifter_arc;
