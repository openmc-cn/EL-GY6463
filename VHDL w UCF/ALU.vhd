------------------------------------------------------
-- ALU component
--
-- This component takes in 2 inputs, performs one of 5 
-- operations between them (add, subtract, and, or, 
-- set-on-less-than), and returns the result.
--
-- Also returns a zero flag that is true if the 2 inputs
-- are equal and false otherwise.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
	port (
		Oprand1, Oprand2: std_logic_vector(31 downto 0);
		ALUOP: in std_logic_vector(2 downto 0);
		ALUResult: out std_logic_vector(31 downto 0)
	);
end ALU;

architecture beh of ALU is
	signal LeftRotate, RightRotate: std_logic_vector(31 downto 0);
	begin
	WITH Oprand2(4 DOWNTO 0) SELECT
    	LeftRotate<= Oprand1(30 DOWNTO 0) & "0" WHEN "00001",
	Oprand1(29 DOWNTO 0) & "00" WHEN "00010",
	Oprand1(28 DOWNTO 0) & "000" WHEN "00011",
	Oprand1(27 DOWNTO 0) & "0000" WHEN "00100",
	Oprand1(26 DOWNTO 0) & "00000" WHEN "00101",
	Oprand1(25 DOWNTO 0) & "000000" WHEN "00110",
	Oprand1(24 DOWNTO 0) & "0000000" WHEN "00111",
	Oprand1(23 DOWNTO 0) & "00000000" WHEN "01000",
	Oprand1(22 DOWNTO 0) & "000000000" WHEN "01001",
	Oprand1(21 DOWNTO 0) & "0000000000" WHEN "01010",
	Oprand1(20 DOWNTO 0) & "00000000000" WHEN "01011",
	Oprand1(19 DOWNTO 0) & "000000000000" WHEN "01100",
	Oprand1(18 DOWNTO 0) & "0000000000000" WHEN "01101",
	Oprand1(17 DOWNTO 0) & "00000000000000" WHEN "01110",
	Oprand1(16 DOWNTO 0) & "000000000000000" WHEN "01111",
	Oprand1(15 DOWNTO 0) & "0000000000000000" WHEN "10000",
	Oprand1(14 DOWNTO 0) & "00000000000000000" WHEN "10001",
	Oprand1(13 DOWNTO 0) & "000000000000000000" WHEN "10010",
	Oprand1(12 DOWNTO 0) & "0000000000000000000" WHEN "10011",
	Oprand1(11 DOWNTO 0) & "00000000000000000000" WHEN "10100",
	Oprand1(10 DOWNTO 0) & "000000000000000000000" WHEN "10101",
	Oprand1(9 DOWNTO 0)  & "0000000000000000000000" WHEN "10110",
	Oprand1(8 DOWNTO 0)  & "00000000000000000000000" WHEN "10111",
	Oprand1(7 DOWNTO 0)  & "000000000000000000000000" WHEN "11000",
	Oprand1(6 DOWNTO 0)  & "0000000000000000000000000" WHEN "11001",
	Oprand1(5 DOWNTO 0)  & "00000000000000000000000000" WHEN "11010",
	Oprand1(4 DOWNTO 0)  & "000000000000000000000000000" WHEN "11011",
	Oprand1(3 DOWNTO 0)  & "0000000000000000000000000000" WHEN "11100",
	Oprand1(2 DOWNTO 0)  & "00000000000000000000000000000" WHEN "11101",
	Oprand1(1 DOWNTO 0)  & "000000000000000000000000000000" WHEN "11110",
	Oprand1(0) & "0000000000000000000000000000000" WHEN "11111",
	Oprand1 WHEN OTHERS;
	
	WITH Oprand2(4 DOWNTO 0) SELECT
    	RightRotate<="0" & oprand1(31 DOWNTO 1)  WHEN "00001",
	 "00" & oprand1(31 DOWNTO 2) WHEN "00010",
	 "000" & oprand1(31 DOWNTO 3) WHEN "00011",
	 "0000" & oprand1(31 DOWNTO 4) WHEN "00100",
	 "00000" & oprand1(31 DOWNTO 5) WHEN "00101",
	 "000000" & oprand1(31 DOWNTO 6) WHEN "00110",
	 "0000000" & oprand1(31 DOWNTO 7) WHEN "00111",
	 "00000000" & oprand1(31 DOWNTO 8) WHEN "01000",
	 "000000000" & oprand1(31 DOWNTO 9) WHEN "01001",
	 "0000000000" & oprand1(31 DOWNTO 10) WHEN "01010",
	 "00000000000" & oprand1(31 DOWNTO 11) WHEN "01011",
	 "000000000000" & oprand1(31 DOWNTO 12) WHEN "01100",
	 "0000000000000" & oprand1(31 DOWNTO 13) WHEN "01101",
	 "00000000000000" & oprand1(31 DOWNTO 14) WHEN "01110",
	 "000000000000000" & oprand1(31 DOWNTO 15) WHEN "01111",
	 "0000000000000000" & oprand1(31 DOWNTO 16) WHEN "10000",
	 "00000000000000000" & oprand1(31 DOWNTO 17) WHEN "10001",
	 "000000000000000000" & oprand1(31 DOWNTO 18) WHEN "10010",
	 "0000000000000000000" & oprand1(31 DOWNTO 19) WHEN "10011",
	 "00000000000000000000" & oprand1(31 DOWNTO 20) WHEN "10100",
	 "000000000000000000000" & oprand1(31 DOWNTO 21) WHEN "10101",
	 "0000000000000000000000" & oprand1(31 DOWNTO 22) WHEN "10110",
	 "00000000000000000000000" & oprand1(31 DOWNTO 23) WHEN "10111",
	 "000000000000000000000000" & oprand1(31 DOWNTO 24) WHEN "11000",
	 "0000000000000000000000000" & oprand1(31 DOWNTO 25) WHEN "11001",
	 "00000000000000000000000000" & oprand1(31 DOWNTO 26) WHEN "11010",
	 "000000000000000000000000000" & oprand1(31 DOWNTO 27) WHEN "11011",
	 "0000000000000000000000000000"	& oprand1(31 DOWNTO 28) WHEN "11100",
	 "00000000000000000000000000000" & oprand1(31 DOWNTO 29) WHEN "11101",
	 "000000000000000000000000000000" & oprand1(31 DOWNTO 30) WHEN "11110",
	 "0000000000000000000000000000000" & oprand1(31) WHEN "11111",
	 oprand1 WHEN OTHERS;
	
	ALUResult <= Oprand1 + Oprand2 when(ALUOP="001") else 
						Oprand1 - Oprand2 when(ALUOP="010") else
						Oprand1 and Oprand2 when(ALUOP="011") else
						Oprand1 or Oprand2 when(ALUOP="100") else
						Oprand1 nor Oprand2 when(ALUOP="101") else
						LeftRotate when(ALUOP="110") else
						RightRotate when(ALUOP="111") else
						x"00000000";
end beh;
