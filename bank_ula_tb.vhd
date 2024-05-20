library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank_ula_tb is
end;

architecture a_bank_ula_tb of bank_ula_tb is
    component bank_ula is
        port( rst, clk, load_src, ula_src, acc_wr_en, rb_wr_en : in std_logic;
              reg_code                                         : in unsigned(2 downto 0);
              ula_op                                           : in unsigned(1 downto 0);
              constgen                                         : in unsigned(15 downto 0);
              carry_out                                        : out std_logic;
              d_acc_out, d_rb_out , d_ula_out                  : out unsigned(15 downto 0)
        );
    end component;

    signal rst, clk                           : std_logic := '0';
    signal ula_src, load_src                  : std_logic := '0';
    signal acc_wr_en, rb_wr_en                : std_logic := '0';
    signal reg_code                           : unsigned(2 downto 0) := "000";
    signal ula_op                             : unsigned(1 downto 0) := "00";
    signal constgen                           : unsigned(15 downto 0) := "0000000000000000";
    signal carry_out                          : std_logic := '0';
    signal d_acc_out, d_rb_out , d_ula_out    : unsigned(15 downto 0) := "0000000000000000";
    signal finished                           : std_logic := '0';
    constant period_time                     : time := 100 ns;

    begin
        uut: bank_ula port map(
            clk => clk,
            rst => rst,
            ula_src => ula_src,
            load_src => load_src,
            acc_wr_en => acc_wr_en,
            rb_wr_en => rb_wr_en,
            reg_code => reg_code,
            ula_op => ula_op,
            constgen => constgen,
            carry_out => carry_out,
            d_acc_out => d_acc_out,
            d_rb_out => d_rb_out,
            d_ula_out => d_ula_out
        );

        reset_global: process
        begin
            rst <= '1';
            wait for period_time*2;
            rst <= '0';
            wait;
        end process;

        sim_time_proc: process
        begin
            wait for 10 us;
            finished <= '1';
            wait;
        end process;

        clk_proc: process
        begin
            while finished /= '1' loop
                clk <= '0';
                wait for period_time/2;
                clk <= '1';
                wait for period_time/2;
            end loop;
            wait;
        end process;

        process
        begin
            wait for 200 ns;
            load_src <= '1';
            rb_wr_en <= '1';
            ula_src <= '0';

            --load zero
            constgen <= "0000000000000000";
            reg_code <= "000";
            wait for 100 ns;

            --load reg1
            constgen <= "0001000100010001";
            reg_code <= "001";
            wait for 100 ns;

            --load reg2
            constgen <= "0010001000100010";
            reg_code <= "010";
            wait for 100 ns;

            --load reg3
            constgen <= "0000000000000000";
            reg_code <= "011";
            wait for 100 ns;

            --load reg4
            constgen <= "0100010001000100";
            reg_code <= "100";
            wait for 100 ns;

            --load reg5
            constgen <= "0101010101010101";
            reg_code <= "101";
            wait for 100 ns;
             
            --load reg6
            constgen <= "0110011001100110";
            reg_code <= "110";
            wait for 100 ns;

            --load reg7
            constgen <= "0111011101110111";
            reg_code <= "111";
            wait for 100 ns;

            --reg3 <= reg1 + reg2

            --primeiro clock: adiciona o valor de reg1 no acumulador;
            ula_src <= '0';
            rb_wr_en <= '0';
            acc_wr_en <= '1';
            reg_code <= "001";
            ula_op <= "00";
            load_src <= '0';
            wait for 100 ns;

            --segundo clock: realiza a soma e adiciono o valor novo no acumulador;
            reg_code <= "010";
            wait for 100 ns;  

            --terceiro clock: grava o valor do acumulador em reg3;
            rb_wr_en <= '1';
            reg_code <= "011";
            acc_wr_en <= '0';
            wait for 100 ns;  

            wait;
        end process;

    end a_bank_ula_tb;
            


