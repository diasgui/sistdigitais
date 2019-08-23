-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "08/23/2019 15:17:03"
                                                            
-- Vhdl Test Bench template for design  :  senhaCofre
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY senhaCofre_vhd_tst IS
END senhaCofre_vhd_tst;
ARCHITECTURE senhaCofre_arch OF senhaCofre_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL botaoSet : STD_LOGIC;
SIGNAL chaves : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL destravaPorta : STD_LOGIC;
SIGNAL digitosCorretos : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL senhaAlterada : STD_LOGIC;
COMPONENT senhaCofre
	PORT (
	botaoSet : IN STD_LOGIC;
	chaves : IN STD_LOGIC_VECTOR(0 TO 3);
	destravaPorta : OUT STD_LOGIC;
	digitosCorretos : OUT STD_LOGIC_VECTOR(0 TO 3);
	senhaAlterada : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : senhaCofre
	PORT MAP (
-- list connections between master ports and signals
	botaoSet => botaoSet,
	chaves => chaves,
	destravaPorta => destravaPorta,
	digitosCorretos => digitosCorretos,
	senhaAlterada => senhaAlterada
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
	botaoSet <= '0';
	wait for 200 ns;
	
	botaoSet <= '1';
	chaves <= "0000";
	wait for 200 ns;
	
	botaoSet <= '1';
	chaves <= "0001";
	wait for 200 ns;
	
	botaoSet <= '1';
	chaves <= "0010";
	wait for 200 ns;
	
	botaoSet <= '1';
	chaves <= "0011";
	wait for 200 ns;
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END senhaCofre_arch;
