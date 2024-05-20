library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
	port(	clk     : in std_logic;
			address : in unsigned(6 downto 0);
			output  : out unsigned(15 downto 0)
		);
end entity;

architecture a_ROM of ROM is
	type mem is array (0 to 127) of unsigned (15 downto 0);
	constant conteudo_rom : mem :=( 
		0 => "1001000000000010",
		1 => "0100000000000000",
		2 => "0100000000000000",
		3 => "0000000000000000",
		4 => "0000000000000000",
		5 => "1001000000000011",
		
		others => (others => '0')
	);
	begin
		
	process(clk) begin
			
		if(rising_edge(clk)) then
			output <= conteudo_rom(to_integer(address));
		end if;
	end process;
end architecture;	