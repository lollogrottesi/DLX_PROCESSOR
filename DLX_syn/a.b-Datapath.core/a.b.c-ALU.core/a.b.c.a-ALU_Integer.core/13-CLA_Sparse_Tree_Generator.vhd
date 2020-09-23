----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2020 15:13:54
-- Design Name: 
-- Module Name: CLA_Sparse_Tree_Generator - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLA_Sparse_Tree_Generator is
    generic (N : integer := 5);--N is equal to log2 di nbit and it is the number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          carry_out: OUT std_logic_vector((2**(N-2))- 1 downto 0));
end CLA_Sparse_Tree_Generator;

architecture Structural of CLA_Sparse_Tree_Generator is

component PG_Network is
    generic (N : integer := 32);
    port (A: IN std_logic_vector(N-1 downto 0);
          B: IN std_logic_vector(N-1 downto 0); 
          cin: IN std_logic;
          p_out: OUT std_logic_vector(N-1 downto 0);
          g_out: OUT std_logic_vector(N-1 downto 0));
end component;

component G is
    port ( g_ik : IN std_logic;
           p_ik : IN std_logic;
           g_k_1_j: IN std_logic;
           g_ij: OUT std_logic);
end component;

component PG is
    port( g_ik : IN std_logic;
          p_ik : IN std_logic;
          g_k_1_j: IN std_logic;
          p_k_1_j: IN std_logic;
          g_ij: OUT std_logic; 
          p_ij: OUT std_logic); 
end component;

type net_matrix is array (2**N-1 downto 0) of std_logic_vector(2**N-1 downto 0);
signal net_p : net_matrix; --matrix that map the p signals
signal net_g : net_matrix; --matrix that map the g signals
signal tmp_p: std_logic_vector(2**N-1 downto 0); --exit of PG_Net and diagonal of net_p
signal tmp_g: std_logic_vector(2**N-1 downto 0); --exit of PG_Net and diagonal of net_g

begin

PG_Net: PG_Network generic map (2**N) port map(A, B, cin, tmp_p, tmp_g);


p_g_matrix: for i in 0 to (2**N)-1 generate
    net_p(i)(i)<= tmp_p(i);
    net_g(i)(i)<= tmp_g(i);
end generate p_g_matrix;


row_gen: 
    for row in 0 to N-1 generate --the number of row depends on the number of bits
            gen_first_row:if row = 0 generate -- it generate alway a g component and nbit/2-1 pg compnents, it correspond at the first row of the tree
                G_0 : G port map (net_g(1)(1), net_p(1)(1), net_g(0)(0), net_g(1)(0));
                generate_pg_first_row: for i in 1 to (2**(N-1)-1) generate
                    PG_first: PG port map (net_g(2*i+1)(2*i+1), net_p(2*i+1)(2*i+1), net_g(2*i)(2*i), net_p(2*i)(2*i), net_g(2*i+1)(2*i), net_p(2*i+1)(2*i));
                end generate generate_pg_first_row;  
            end generate gen_first_row;
            
            gen_second_row:if row = 1 generate -- it generate alway a g component and nbit/4-1 pg compnents, it correspond at the second row of the tree
                G_1 : G port map (net_g(3)(2), net_p(3)(2), net_g(1)(0), net_g(3)(0));
                generate_pg_second_row: for i in 1 to (2**(N-2)-1) generate
                    PG_first: PG port map (net_g(4*i+3)(4*i+2), net_p(4*i+3)(4*i+2), net_g(4*i+1)(4*i), net_p(4*i+1)(4*i), net_g(4*i+3)(4*i), net_p(4*i+3)(4*i));
                end generate generate_pg_second_row;  
            end generate gen_second_row;
            
            gen_all_row:if row >= 2 generate -- it generate al the g and pg components for all the remainings levels
            gen_all_G:for i in 0 to 2**(row-2)-1 generate -- the number of g components depend on the row
                Tree_g_i: G port map (net_g(2**(row+1)-1-4*i)(2**row), net_p(2**(row+1)-1-4*i)(2**row), net_g((2**row)-1)(0), net_g(2**(row+1)-1-4*i)(0)); 
            end generate gen_all_G;  
                   
            gen_all_groups:for i in 0 to 2**(N-row-1)-2 generate --pg ports are divided in groups of adiacent ports that decrement in order of row.
                gen_PG_in_group:for j in 0 to 2**(row-2)-1 generate --the number of element per group increment in order of row.
                        --i_pg = ((2**N)-1)-(4*j)-(2**(row+1)*i) = max_index-1 - 4*group_element - 2**(row+1)*group_number.
                        --j_pg = (2**N)-2**(row+1)*(i+1) = max_index - 2**(row+1)*(group_number+1).
                        --k_pg = 2**N-(2**row)-(2**(row+1)*i) = max_index - 2**row - 2**(row+1)*group_number.
                    Tree_pg_i: PG port map (g_ik => net_g(((2**N)-1)-(4*j)-(2**(row+1)*i))(2**N-(2**row)-(2**(row+1)*i)),p_ik => net_p(((2**N)-1)-(4*j)-(2**(row+1)*i))(2**N-(2**row)-(2**(row+1)*i)), g_k_1_j => net_g(2**N-(2**row)-(2**(row+1)*i)-1)((2**N)-2**(row+1)*(i+1)), p_k_1_j=>net_p(2**N-(2**row)-(2**(row+1)*i)-1)((2**N)-2**(row+1)*(i+1)),  g_ij => net_g(((2**N)-1)-(4*j)-(2**(row+1)*i))((2**N)-2**(row+1)*(i+1)),  p_ij => net_p(((2**N)-1)-(4*j)-(2**(row+1)*i))((2**N)-2**(row+1)*(i+1)));
                end generate gen_PG_in_group;
            end generate gen_all_groups;
                
        end generate gen_all_row;
    end generate row_gen; 
    
    

connect_out:for i in 0 to 2**(N-2)-1 generate --all the carry outs are in the first column of net_g 
    carry_out(i) <= net_g(4*i+3)(0);
end generate connect_out;

end Structural;
