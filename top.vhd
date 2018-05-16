library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity DP_C is
    port(
        clk: in std_logic;
        rst: in std_logic
    );
end entity;

architecture DP_C_arc of DP_C is

    -- for datapath
    signal result: std_logic_vector(31 downto 0);
    signal instruction: std_logic_vector(31 downto 0);

    -- out from datapath into controller
    signal NCZV: std_logic_vector(3 downto 0):= "0000";

    -- Control signals
    -- Actrl
    signal op: std_logic_vector(3 downto 0);

    -- Bctrl
    signal p:std_logic;

    -- Main Controller
    signal PW: std_logic;
    signal IW: std_logic;
    signal DW: std_logic;
    signal AW: std_logic;
    signal BW: std_logic;
    signal resW: std_logic;
    signal RW: std_logic;
    signal MR: std_logic;
    signal MW: std_logic;
    signal IorD: std_logic;
    signal Asrc1: std_logic;
    signal Asrc2: std_logic_vector(1 downto 0);
    signal Rsrc: std_logic;
    signal M2R: std_logic;

    signal I: std_logic;
    signal M: std_logic;
begin

    DP:
    entity WORK.datapath port map(
        clk=>clk,
        rst=>rst,

        op=>op,
        p=>p,

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
        M=>M,

        out_flags=>NCZV,
        instruction=>instruction,
        result=>result
    );

    Controller:
    entity WORK.Controller port map(
        clk=>clk,
        rst=>rst,
        NCZV=>NCZV,
        ins=>instruction,

        op=>op,

        p=>p,

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
end architecture;
