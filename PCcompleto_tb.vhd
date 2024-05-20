library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCcompleto_tb is
end entity PCcompleto_tb;

architecture teste of PCcompleto_tb is
    component PCcompleto is
        port(
            clk, wrEn, rst, instPulo : in std_logic;
            dadosEntrada                : in unsigned(6 downto 0);
            dadosSaida                  : out unsigned(6 downto 0)
        );
    end component;
    
    -- Definições de sinais
    
    signal clk_tb, wrEn_tb, rst_tb, instPulo_tb : std_logic;
    signal dadosEntrada_tb, dadosSaida_tb         : unsigned (6 downto 0);
    
    signal finalizado                              : std_logic := '0';
    
    -- Constantes
    
    constant periodo_tempo : time := 100 ns;
    constant A             : unsigned(6 downto 0) := "0001010";
    constant B             : unsigned(6 downto 0) := "0001011";
    constant C             : unsigned(6 downto 0) := "0001100";
    constant GND           : unsigned(6 downto 0) := "0000000";
    
begin 
    
    Circuito1 : PCcompleto
    port map(
        clk      => clk_tb,
        wrEn     => wrEn_tb,
        rst      => rst_tb,
        instPulo => instPulo_tb,
        dadosEntrada   => dadosEntrada_tb,
        dadosSaida  => dadosSaida_tb
    );
    
    sim_tempo_proc : process begin -- tempo de simulação
        
        wait for 10 us;
        finalizado <= '1';
        wait;
    end process sim_tempo_proc;
    
    clk_proc : process begin -- sinal periódico de clock
        
        while finalizado /= '1' loop -- enquanto não acabar loop
            clk_tb <= '0';
            wait for periodo_tempo/2;
            clk_tb <= '1';
            wait for periodo_tempo/2;
        end loop;
        wait;
    end process clk_proc;
    
    reset_global : process begin -- sinal de reset inicial
    
        rst_tb <= '1';
        wait for periodo_tempo*2;
        rst_tb <= '0';
        wait;
    end process reset_global;
    
    processo_teste : process begin -- linha de comandos para o PC
    
        wait for periodo_tempo*2; -- espera o reset
        
        wrEn_tb     <= '1';
        instPulo_tb <= '0';
        dadosEntrada_tb   <= A;
        
        wait for periodo_tempo*2;
        
        dadosEntrada_tb <= B;
        
        wait for periodo_tempo*2;
        
        dadosEntrada_tb   <= C;
        instPulo_tb <= '1';
        wrEn_tb     <= '0';
        
        wait for periodo_tempo*2;
        
        wrEn_tb <= '1';
        instPulo_tb <= '0';
        
        wait for periodo_tempo*2;
        
        instPulo_tb <= '1';
        
        wait for periodo_tempo;
        
        instPulo_tb <= '0';
        
        wait for periodo_tempo*3;
        
        wrEn_tb <= '0';
        
        wait for periodo_tempo*3;
        
        wrEn_tb     <= '1';
        instPulo_tb <= '1';
        
        wait for periodo_tempo*2;
        
        dadosEntrada_tb <= GND;
        
        wait for periodo_tempo*2;
        
        instPulo_tb <= '0';
        
        wait;
    end process processo_teste;
end architecture teste;
