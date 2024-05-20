library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula0_tb is
end;

architecture aUla0_tb of ula0_tb is
    component ula0
        port(   in1 : in unsigned(15 downto 0);
                in2 : in unsigned(15 downto 0);
                selec_op : in unsigned(1 downto 0);
                out_res : out unsigned (15 downto 0);
                carry : out std_logic
        );
    end component;
    signal in1, in2 : unsigned(15 downto 0); 
    signal selec_op : unsigned(1 downto 0);
    signal out_res : unsigned(15 downto 0);
    signal carry : std_logic;

    begin
        uut: ula0 port map ( in1 => in1,
                             in2 => in2,
                             selec_op => selec_op,
                             out_res => out_res,
                             carry => carry );
        
    process
        begin
        in1 <= "0000000000000001";
        in2 <= "0000000000000001";
        selec_op <= "00";
        wait for 50 ns;
        in1 <= "1111111111111111";
        in2 <= "0000000000000001";
        selec_op <= "00";
        wait for 50 ns;
        in1 <= "0000000000000011";
        in2 <= "0000000000000001";
        selec_op <= "01";
        wait for 50 ns;
        in1 <= "0000000000000001";
        in2 <= "0000000000000111";
        selec_op <= "01";
        wait for 50 ns;
        in1 <= "0000000000000001";
        in2 <= "0000000000000001";
        selec_op <= "10";
        wait for 50 ns;
        in1 <= "0000000000000011";
        in2 <= "0000000000000001";
        selec_op <= "10";
        wait for 50 ns;
        in1 <= "0000000000000001";
        in2 <= "0000000000000001";
        selec_op <= "11";
        wait for 50 ns;
        in1 <= "0000000000000011";
        in2 <= "0000000000000001";
        selec_op <= "11";
        wait for 50 ns;

        wait;
    end process;
end architecture;