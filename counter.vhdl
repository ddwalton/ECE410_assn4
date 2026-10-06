-- Author: Dion Walton
-- CCID: ddwalton
-- Email: ddwalton@ualberta.ca
-- Student ID: 1761090

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY counter IS 
    GENERIC (
        g_NUM_BITS : NATURAL := 8
    );

    PORT (
        clk  : IN STD_LOGIC; -- clock
        rst  : IN STD_LOGIC; -- reset to zero signal, active high
        incr : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- how much to increment by (0, 1, 2, 3)
        dout : OUT STD_LOGIC_VECTOR(g_NUM_BITS - 1 DOWNTO 0) -- counter value
    );
END ENTITY counter;

ARCHITECTURE Behavioral OF counter IS
    SIGNAL count : unsigned(g_NUM_BITS - 1 DOWNTO 0) := (OTHERS => '0'); -- start count as 0
BEGIN
    count_process : PROCESS(CLK)
    BEGIN
        IF (rising_edge(CLK)) THEN
            IF (rst = '1') THEN
                -- synchronous reset
                count <= (OTHERS => '0');
            ELSE
                -- cast incr to unsigned, pad with zeros to match size of output
                count <= count + resize(unsigned(incr), g_NUM_BITS);
            END IF;
        END IF;
    END PROCESS count_process;
    
    -- drive output with internal signal
    dout <= std_logic_vector(count);
END ARCHITECTURE Behavioral;