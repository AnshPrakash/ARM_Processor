library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.mytypes.all;

entity Controller is
    port (
        clk :in std_logic;
        rst: in std_logic;
        NCZV: in std_logic_vector(3 downto 0);
        ins :in std_logic_vector(31 downto 0);

        -- output of Actrl.
        op:out std_logic_vector(3 downto 0);

        -- output of Bctrl.
        p: out std_logic;

        -- output of Main Controller
        PW:out std_logic;
        IW:out std_logic;
        DW:out std_logic;
        AW:out std_logic;
        BW:out std_logic;
        resW:out std_logic;
        RW:out std_logic;
        MR:out std_logic;
        MW:out std_logic;
        IorD:out std_logic;
        Asrc1:out std_logic;
        Asrc2:out std_logic_vector(1 downto 0);
        Rsrc:out std_logic;
        M2R:out std_logic;
        I:out std_logic;
        M:out std_logic

        -- not_implemented:out std_logic;
        -- undefined:out std_logic;
    );
end entity Controller;

architecture Controller_arc of Controller is
    signal actrl_ins: std_logic_vector(10 downto 0);
    signal MC_ins: std_logic_vector(4 downto 0);
    signal ns_ins: std_logic_vector(2 downto 0);
    signal flag: std_logic;
    signal cs, ns: state;
begin
    p<=flag;
    actrl_ins<=ins(27 downto 26)&ins(24 downto 20)&ins(7 downto 4);

    Actrl:
    entity WORK.Actrl port map(
        state=> cs,
        ins=> actrl_ins,
        op=>op
    );

    Bctrl:
    entity WORK.Bctrl port map(
        cond=>ins(31 downto 28),
        NCZV=>NCZV,
        p=>flag
    );

    MC_ins<=ins(25)&ins(7 downto 4);
    MC:
    entity WORK.Main_Controller port map(
        p=>flag,
        ins=>MC_ins,
        current_state=>cs,

        PW=>PW,
        IW=>IW,
        DW=>DW,
        AW=>AW,
        BW=>BW,
        resW=>resW,
        RW=>RW,
        MR=>MR,
        MW=>MW,
        IorD=>IorD,
        Asrc1=>Asrc1,
        Asrc2=>Asrc2,
        Rsrc=>Rsrc,
        M2R=>M2R,

        I=>I,
        M=>M
    );

    ns_ins<=ins(27 downto 26)&ins(20);
    Next_State:
    entity WORK.next_state port map(
        ins=>ns_ins,
        current_state=>cs,
        next_state=>ns
    );

    Control_state:
    entity WORK.control_state port map(
        clk=>clk,
        rst=>rst,
        next_state=>ns,
        current_state=>cs
    );

    -- ID:
    -- entity WORK.Instruction_decoder port map (
        -- clk=>clk,
        -- ins=>dec_ins,
        -- not_implemented=>not_implemented,
        -- undefined=>undefined
    -- );
end architecture;
