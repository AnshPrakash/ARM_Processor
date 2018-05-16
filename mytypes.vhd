library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


package mytypes is
    type state is (fetch, rdAB, arith, wrRF, addr, wrM, rdM, M2RF, brn, nope);
    type memory_array is array(0 to 63) of std_logic_vector(31 downto 0);
    type register_array is array (0 to 15) of std_logic_vector(31 downto 0);
end package;

package body mytypes is
end mytypes;
