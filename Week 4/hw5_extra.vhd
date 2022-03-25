library ieee;
use ieee.std_logic_1164.all;

entity hw5_extra_vhdl is

	port
	(
		-- Input ports
		A, B	: in  std_logic;
		sel	: in  std_logic_vector (2 downto 0);

		-- Output ports
		Y	: out std_logic
	);
	
end hw5_extra_vhdl;


architecture mux8to1 of hw5_extra_vhdl is

begin
	
	process(sel) is
	
	begin
			
			Case sel IS
		
				When "000" => Y <= A AND B;
				When "001" => Y <= A OR B;
				When "010" => Y <= NOT A;
				When "011" => Y <= A;
				When "100" => Y <= A NAND B;
				When "101" => Y <= A NOR B;
				When "110" => Y <= A XOR B;
				When "111" => Y <= A XNOR B;
				
			End Case; 
		
	end process;


end mux8to1;
