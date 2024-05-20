library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCcompleto is
    port(
        clk, wrHab, rst, instPulo : in std_logic;
        dadosEntrada               : in unsigned(6 downto 0);
        dadosSaida                 : out unsigned(6 downto 0)
    );
end entity PCcompleto;

architecture a_PCcompleto of PCcompleto is
    
    component ContadorPrograma is
        port(
            clk      : in std_logic;
            wrHab    : in std_logic;
            rst      : in std_logic;
            dadosEntrada  : in  unsigned(6 downto 0);
            dadosSaida    : out unsigned(6 downto 0)
        );
    end component;
    
    -- Declaração de sinais
    signal endAtual, endProx : unsigned(6 downto 0) := "0000000";    -- Endereços por padrão começam em 0

begin
    
    CP0 : ContadorPrograma port map (clk, wrHab, rst, endProx, endAtual);
    
    -- MUX de entrada, para o próximo endereço caso tenha instrução de pulo
    endProx <= endAtual + "0000001" when instPulo = '0' else dadosEntrada;
    dadosSaida <= endAtual;
    
end a_PCcompleto;
