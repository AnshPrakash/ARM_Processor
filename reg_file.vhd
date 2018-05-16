library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register32 is
    port (
        clk: in std_logic;
        w_en:in std_logic;
        rst: in std_logic;
        a: in std_logic_vector(31 downto 0);
        k: out std_logic_vector(31 downto 0)
    );
end entity;

architecture register32_arc of register32 is
begin
    process(clk, rst) begin
        if rst='1' then
            k<=(others=>'0');
        elsif rising_edge(clk) and w_en='1' then
            k<=a;
        end if;
    end process;
end architecture;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use WORK.mytypes.all;

entity reg_file is
  port (
    clk : in std_logic;
    rst : in std_logic;
    RW  : in std_logic;
    rad1: in std_logic_vector(3 downto 0);
    rad2: in std_logic_vector(3 downto 0);
    wad : in std_logic_vector(3 downto 0);
    wd  : in std_logic_vector(31 downto 0);
    rd1 : out std_logic_vector(31 downto 0);
    rd2 : out std_logic_vector(31 downto 0)
  );
end reg_file;

architecture reg_file_arc of reg_file is
    signal reg_arr: register_array;
begin
    rd1<=reg_arr(to_integer(unsigned(rad1)));
    rd2<=reg_arr(to_integer(unsigned(rad2)));

    process(clk) begin
        if rst='1' then
            reg_arr(0)<=(others=>'0');
            reg_arr(1)<=(others=>'0');
            reg_arr(2)<=(others=>'0');
            reg_arr(3)<=(others=>'0');
            reg_arr(4)<=(others=>'0');
            reg_arr(5)<=(others=>'0');
            reg_arr(6)<=(others=>'0');
            reg_arr(7)<=(others=>'0');
            reg_arr(8)<=(others=>'0');
            reg_arr(9)<=(others=>'0');
            reg_arr(10)<=(others=>'0');
            reg_arr(11)<=(others=>'0');
            reg_arr(12)<=(others=>'0');
            reg_arr(13)<=(others=>'0');
            reg_arr(14)<=(others=>'0');
            reg_arr(15)<=(others=>'0');
        elsif rising_edge(clk) and RW='1' then
            
            reg_arr(to_integer(unsigned(wad)))<=wd;
        end if;
    end process;
end architecture;
