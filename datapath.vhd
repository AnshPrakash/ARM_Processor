library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
    port (
        clk: in std_logic;
        rst: in std_logic;

        -- Control signals from Controller
        op : in std_logic_vector(3 downto 0);
        p: in std_logic;

        PW : in std_logic;
        IW : in std_logic;
        DW : in std_logic;
        AW : in std_logic;
        BW : in std_logic;
        resW : in std_logic;
        RW : in std_logic;
        MR : in std_logic;
        MW : in std_logic;
        IorD: in std_logic;
        Asrc1 : in std_logic;
        Asrc2 : in std_logic_vector(1 downto 0);
        Rsrc: in std_logic;
        M2R : in std_logic;

        I: in std_logic;
        M: in std_logic;

        out_flags : out std_logic_vector(3 downto 0);
        instruction: out std_logic_vector(31 downto 0);
        result: out std_logic_vector(31 downto 0)
    );
end datapath;

architecture datapath_arc of datapath is
    signal sc : std_logic;
    signal pc, ins : std_logic_vector(31 downto 0);
    signal ad, rd, wd: std_logic_vector(31 downto 0);
    signal dr, res : std_logic_vector(31 downto 0); 
    signal A, B : std_logic_vector(31 downto 0);
    signal rd1, rd2 : std_logic_vector(31 downto 0); 
    signal rad1, rad2 : std_logic_vector(3 downto 0);
    signal ex12, s2, ex8 : std_logic_vector(31 downto 0);
    signal alu_in1, alu_in2 : std_logic_vector(31 downto 0); 
    signal alu_out : std_logic_vector(32 downto 0); 
    signal out_NZCV : std_logic_vector(3 downto 0);

    signal mul_out, shift_out : std_logic_vector(31 downto 0);
    signal shift_in: std_logic_vector(31 downto 0);
    signal shift_amt: std_logic_vector(4 downto 0);
    signal rot_amt : std_logic_vector(4 downto 0);
    signal li, B1: std_logic_vector(31 downto 0);

begin
    -- muxes-----------------------------------
    en_IorD:
    entity WORK.mux2_32 port map(
        a=>pc,
        b=>res,
        s=>IorD,
        o=>ad
    );

    en_Rsrc:
    entity WORK.mux2_4 port map(
        a=>ins(3 downto 0),
        b=>ins(15 downto 12),
        s=>Rsrc,
        o=>rad2
    );

    -- new introduction, for mul.
    en_M_reg:
    entity WORK.mux2_4 port map(
        a=>ins(19 downto 16),
        b=>ins(11 downto 8),
        s=>M,
        o=>rad1
    );

    en_M2R:
    entity WORK.mux2_32 port map(
        a=>res,
        b=>dr,
        s=>M2R,
        o=>wd
    );

    en_Asrc1:
    entity WORK.mux2_32 port map(
        a=>pc,
        b=>A,
        s=>Asrc1,
        o=>alu_in1
    );

    -- new additions for shifting.
    en_Shifter_in:
    entity WORK.mux2_32 port map(
        a=>B,
        b=>ex8,
        s=>I,
        o=>shift_in
    );

    rot_amt<='0'&ins(11 downto 8);
    en_Shifter_amt:
    entity WORK.mux2_5 port map(
        a=>ins(11 downto 7),
        b=>rot_amt,
        s=>I,
        o=>shift_amt
    );

    -- To choose if shifted or multiplied
    en_MulorShift:
    entity WORK.mux2_32 port map(
        a=>shift_out,
        b=>mul_out,
        s=>M,
        o=>B1
    );

    -- Load instruction, shift or imm
    en_LoadImm:
    entity WORK.mux2_32 port map(
        a=>shift_out,
        b=>ex12,
        s=>I,
        o=>li
    );

    en_Asrc2:
    entity WORK.mux4 port map(
        a=>B1,
        b=>"00000000000000000000000000000100",
        c=>li,
        d=>s2,
        s=>Asrc2,
        o=>alu_in2 
    );

    -----------------------------------------------
    -- registers-----------------------------------

    en_PW:
    entity WORK.register32 port map(
        clk=>clk,
        w_en=>PW,
        rst=>rst,
        a=>alu_out(31 downto 0),
        k=>pc);

    en_IW:
    entity WORK.register32 port map(
        clk=>clk,
        w_en=>IW,
        rst=>rst,
        a=>rd,
        k=>ins
    );

    en_DW:
    entity WORK.register32 port map(
        clk=>clk,
        w_en=>DW,
        rst=>rst,
        a=>rd,
        k=>dr
    );

    en_AW:
    entity WORK.register32 port map(
        a=>rd1,
        w_en=>AW,
        rst=>rst,
        clk=>clk,
        k=>A
    );

    en_BW:
    entity WORK.register32 port map(
        a=>rd2,
        w_en=>BW,
        clk=>clk,
        rst=>rst,
        k=>B
    );

    en_resW:
    entity WORK.register32 port map(
        clk=>clk,
        w_en=>resW,
        rst=>rst,
        a=>alu_out(31 downto 0),
        k=>res
    );
    -----------------------------------------------
    -- memory
    en_mem:
    entity WORK.memory port map(
        clk=>clk,
        rst=>rst,
        MR=>MR,
        MW=>MW,
        ad=>ad,
        wd=>rd2,
        rd=>rd
    );

    -- extender
    en_ex12:
    entity WORK.EX12 port map(
        input1=>ins(11 downto 0),
        o=>ex12
    );

    en_ex8:
    entity WORK.EX8 port map(
        input1=>ins(7 downto 0),
        o=>ex8
    );

    en_s2:
    entity WORK.S2 port map(
        input1=>ins(23 downto 0),
        o=>s2
    );

    -- register file
    en_RW:
    entity WORK.reg_file port map(
        clk =>clk,
        rst =>rst,
        RW  =>RW,
        rad1=>rad1,
        rad2=>rad2,
        wad =>ins(15 downto 12),
        wd  =>wd,
        rd1 =>rd1,
        rd2 =>rd2
    );

    -- shifter
    en_shift:
    entity WORK.shifter port map(
        input1 => shift_in,
        shift_type => ins(6 downto 5),
        shift_amount => shift_amt,
        result => shift_out,
        shift_carry=> sc
    );

    -- multiplier
    en_multiply:
    entity WORK.multiplier port map(
        input1=>A,
        input2=>B,
        result=>mul_out
    );

    -- ALU
    en_Alu:
    entity WORK.Alu port map (
        carry=>'0',
        opcode=>op,
        input1=>alu_in1,
        input2=>alu_in2,
        result=>alu_out
    );

    --changing flags
    en_F:
    entity WORK.setFlags port map(
        p=> p,
        input1 => alu_in1,
        input2 => alu_in2,
        result => alu_out,
        out_NZCV => out_flags
    );

    instruction<=ins;
    result<=alu_out(31 downto 0);

end datapath_arc;
