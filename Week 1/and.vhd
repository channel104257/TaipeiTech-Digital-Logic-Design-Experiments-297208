library ieee ;
use ieee.std_logic_1164.all ;

entity hw2_extra is
 port ( A,B : in std_logic ;
	Y : out std_logic ) ;
end hw2_extra ;

architecture Arch of hw2_extra is
begin
 Y <= A and B ; 
end Arch ;
