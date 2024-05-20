library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MaquinaEstados is
	port(
		clk   : in std_logic;
		rst   : in std_logic;
		estado : out std_logic
		);
	end entity;
	
architecture a_MaquinaEstados of MaquinaEstados is
	signal estadoTemp : std_logic := '0';
	
	begin 
	
	process(clk, rst)
	begin	
		if rst = '1' then
			estadoTemp <= '0';
		elsif rising_edge(clk) then
			estadoTemp <= not estadoTemp;
		end if;
	end process;
	estado <= estadoTemp;
end architecture;
	