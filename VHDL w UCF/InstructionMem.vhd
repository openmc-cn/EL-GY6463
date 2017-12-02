------------------------------------------------------
-- Instruction Memory Block
-- 
-- Contains all the instructions to be run.
-- 
-- Memory is kept in rows of 32 bits to represent 32-bit
-- registers.
-- 
-- This component initially reads from the file
-- 'instructions.txt' and saves it into a 2d array.
-- 
-- This component takes in a 32-bit address and returns
-- the instruction at that address.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.textio.all; -- Required for freading a file
entity InstructionMem is
	port (
		clk: in std_logic;
		ReadAddress: in STD_LOGIC_VECTOR (31 downto 0);
		instruction: out STD_LOGIC_VECTOR (31 downto 0);
		LastInsAddress: out STD_LOGIC_VECTOR (31 downto 0);
		changeInstruction: in std_logic_vector(31 downto 0);
		changeAddress: in std_logic_vector(31 downto 0);
		changecommit: in std_logic
	);
end InstructionMem;


architecture behavioral of InstructionMem is	 
type instruction_array is array(0 to 299) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: instruction_array := (
			"00000000000000000000000000000000",
			"00000100010000110000000000011010",
			"00000100010001000000000000000100",
			"00000100010001010000000001001110",
			"00011100111001100000000000000000",
			"00000000000000010000000000010000",
			"00000000000001100000000000010000",
			"00010100000010000000000000000011",
			"00011000000010010000000000011101",
			"00000001000010010000000000010000",
			"00100000111000000000000000000000",
			"00000000000000010000100000010000",
			"00011101011010100000000000011010",
			"00000000001010100110000000010000",
			"00001100001011010000000000011111",
			"00000100010011100000000000100000",
			"00000001110011010111000000010001",
			"00010101100010000000000000000001",
			"00001001101011010000000000000001",
			"00101100010011011111111111111101",
			"00011001100010010000000000000001",
			"00001001110011100000000000000001",
			"00101100010011101111111111111101",
			"00000001000010010000100000010000",
			"00100001011000010000000000011010",
			"00000100111001110000000000000001",
			"00000101011010110000000000000001",
			"00101100111000110000000000000001",
			"00000000111001110011100000010001",
			"00101101011001000000000000000001",
			"00000001011010110101100000010001",
			"00000101111011110000000000000001",
			"00101101111001011111111111100011",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000100010000110000000000001100",
			"00011100010001000000000000000000",
			"00000000000001000000000000010000",
			"00011100010001000000000000000001",
			"00000000001001000000100000010000",
			"00000000000000010010100000010011",
			"00000000000000010011000000010010",
			"00000000101001100010100000010001",
			"00001100001001100000000000011111",
			"00000100010001110000000000100000",
			"00000000111001100100000000010001",
			"00010100101010010000000000000001",
			"00001000110001100000000000000001",
			"00101100010001101111111111111101",
			"00011000101001100000000000000001",
			"00001001000010000000000000000001",
			"00101100010010001111111111111101",
			"00000000110010010010100000010000",
			"00000101010010100000000000000001",
			"00010101010010110000000000000001",
			"00011101011001000000000000000000",
			"00000000101001000000000000010000",
			"00000000000000010010100000010011",
			"00000000000000010011000000010010",
			"00000000101001100010100000010001",
			"00001100000001100000000000011111",
			"00000000111001100100000000010001",
			"00010100101010010000000000000001",
			"00001000110001100000000000000001",
			"00101100010001101111111111111101",
			"00011000101001100000000000000001",
			"00001001000010000000000000000001",
			"00101100010010001111111111111101",
			"00000000110010010010100000010000",
			"00000101011010110000000000000001",
			"00011101011001000000000000000000",
			"00000000101001000000100000010000",
			"00101101010000110000000000011111",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000100010000110000000000001100",
			"00010100011001000000000000000001",
			"00000100100001010000000000000001",
			"00011100101001100000000000000000",
			"00000000001001100000100000010001",
			"00001100000001110000000000011111",
			"00000100010010000000000000100000",
			"00000001000001110100100000010001",
			"00011000001010100000000000000001",
			"00001000111001110000000000000001",
			"00101100010001111111111111111101",
			"00010100001010110000000000000001",
			"00001001001010010000000000000001",
			"00101100010010011111111111111101",
			"00000001010010110000100000010000",
			"00000000000000010101000000010011",
			"00000000000000010101100000010010",
			"00000001010010110000100000010001",
			"00011100100001100000000000000000",
			"00000000000001100000000000010001",
			"00001100001001110000000000011111",
			"00000001000001110100100000010001",
			"00011000000010100000000000000001",
			"00001000111001110000000000000001",
			"00101100010001111111111111111101",
			"00010100000010110000000000000001",
			"00001001001010010000000000000001",
			"00101100010010011111111111111101",
			"00000001010010110000000000010000",
			"00000000000000010101000000010011",
			"00000000000000010101100000010010",
			"00000001010010110000000000010001",
			"00001000011000110000000000000001",
			"00101100010000110000000000011111",
			"00011100010001100000000000000001",
			"00000000001001100000100000010001",
			"00011100010001100000000000000000",
			"00000000000001100000000000010001",			
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"

    );

    begin

--    -- The process for reading the instructions into memory
--    process 
--        file file_pointer : text;
--        variable line_content : string(1 to 32);
--        variable line_num : line;
--        variable i: integer := 0;
--        variable j : integer := 0;
--        variable char : character:='0'; 
--    
--        begin
--        -- Open instructions.txt and only read from it
--        file_open(file_pointer, "instructions.txt", READ_MODE);
--        -- Read until the end of the file is reached  
--        while not endfile(file_pointer) loop
--            readline(file_pointer,line_num); -- Read a line from the file
--            READ(line_num,line_content); -- Turn the string into a line (looks wierd right? Thanks Obama)
--            -- Convert each character in the string to a bit and save into memory
--            for j in 1 to 32 loop        
--                char := line_content(j);
--                if(char = '0') then
--                    data_mem(i)(32-j) <= '0';
--                else
--                    data_mem(i)(32-j) <= '1';
--                end if; 
--            end loop;
--            i := i + 1;
--        end loop;
--        if i > 0 then
--            LastInsAddress <= std_logic_vector(to_unsigned((i-1)*4, LastInsAddress'length));
--        else
--            LastInsAddress <= "00000000000000000000000000000000";
--        end if;
--
--        file_close(file_pointer); -- Close the file 
--        wait; 
--    end process;
	 lastInsaddress <= "00000000000000000000000100101100";
    -- Since the registers are in multiples of 4 bytes, we can ignore the last two bits
    instruction <= data_mem(conv_integer(ReadAddress(31 downto 2)));
	 process(clk)
	 begin
		if (clk'event and clk = '1' ) then
			if(changecommit = '1') then
				data_mem(conv_integer(changeaddress)) <= changeInstruction;
			end if;
		end if;
	 end process;
end behavioral;