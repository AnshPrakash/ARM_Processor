library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.mytypes.all;

entity Main_Controller is
    port (
        p: in std_logic;
        -- 25, 7-4
        ins: in std_logic_vector(4 downto 0);
        current_state: in state;

        PW: out std_logic;
        IW: out std_logic;
        DW: out std_logic;
        AW: out std_logic;
        BW: out std_logic;
        resW: out std_logic;
        RW: out std_logic;
        MR: out std_logic;
        MW: out std_logic;
        IorD: out std_logic;
        Asrc1: out std_logic;
        Asrc2: out std_logic_vector(1 downto 0);
        Rsrc: out std_logic;
        M2R: out std_logic;

        I: out std_logic; -- Immediate
        M: out std_logic -- Multiplication
    );
end entity;

architecture Main_Controller_arc of Main_Controller is
    signal cs: state;
    
begin
    cs<=current_state;
    process(cs, p)
    begin
        case cs is
            when fetch =>
                PW<='1';
                Asrc1<='0';
                Asrc2<="01";
                IW<='1';
                MR<='1';
                IorD<='0';
--                op
                DW<='0';
                AW<='0';
                BW<='0';
                resW<='0';
                RW<='0';
                MW<='0';
                
--                PW<='0';--error
--                IorD<='0';
--                Asrc1<='0';
--                Asrc2<="01";
--                IW<='1';
--                MR<='1';
--                -- -------
--                DW<='0';
--                AW<='0';
--                BW<='0';
--                resW<='0';
--                RW<='0';
--                MW<='0';
--            when nope=>
--                PW<='1';
--                IorD<='0';
--                Asrc1<='0';
--                Asrc2<="01";
--                IW<='1';
--                MR<='1';
----                op
----                IW<='0';
--                DW<='0';
--                AW<='0';
--                BW<='0';
--                resW<='0';
----                MR<='0';
--                MW<='0';                
                
            when rdAB=>
                PW<='0';
                AW<='1';
                BW<='1';
                Rsrc<='0';
                -- new additions.
                if ins(3 downto 0)="1001" then
                    M<='1';
                else
                    M<='0';
                end if;
                -----------------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                RW<='0';
                resW<='0';
            when arith=>
                PW<='0';
                resW<='1';
                Asrc1<='1';
                Asrc2<="00";
                -- new additions.
                if ins(3 downto 0)="1001" then
                    M<='1';
                else
                    M<='0';
                end if;
                I<=ins(4);
                ------------------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                RW<='0';
                BW<='0';
                AW<='0';
            when wrRF=>
                PW<='0';
--                PW<='1';--error
                RW<=p;
                M2R<='0';
                -----------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                BW<='0';
                AW<='0';
                resW<='0';
                
            when addr=>
                PW<='0';
                resW<='1';
                Asrc1<='1';
                Asrc2<="10";
                Rsrc<='1';
                -- new additions.
                I<=ins(4);
                -------------------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                RW<='0';
                BW<='0';
                AW<='0';
            when wrM=>
                PW<='0';
                MW<=p;
                IorD<='1';
                ------------------
                MR<='0';
                IW<='0';
                DW<='0';
                RW<='0';
                BW<='0';
                AW<='0';
                resW<='0';
            when rdM=>
                PW<='0';
                DW<='1';
                MR<='1';
                IorD<='1';
                ------------------------
                IW<='0';
                MW<='0';
                RW<='0';
                BW<='0';
                AW<='0';
                resW<='0';
            when M2RF=>
                PW<='0';
--                PW<='1';--Error
                RW<=p;
                M2R<='1';
                ---------------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                BW<='0';
                AW<='0';
                resW<='0';
            when brn=>
                PW<=p;
                Asrc1<='0';
                Asrc2<="11";
                -------------
                MR<='0';
                IW<='0';
                DW<='0';
                MW<='0';
                RW<='0';
                BW<='0';
                AW<='0';
                resW<='0';                
            when others =>
                null;
        end case;
    end process;
end Main_Controller_arc;
