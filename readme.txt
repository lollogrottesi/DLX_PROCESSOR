DLX_syn contains the netlist used for both simulation and synthesis. 

The /DLX_Syn folder must be placed in the same folder of SimulationScript.do and SynScript.tcl

For simulation:

Open ModelSim using source /software/scripts/init_questa10.7c -> vlib work -> vsim &. 
On the terminal write: do {SimulationScript.do}

The .mem file must be placed in the DLX_Syn/test/ folder. 

For synthesis:

Open synopsys and type: source ./SynScript.tcl 

The summury of the generated reports and file generated by the synthesis can be find in the /Synthesis folder. Timing reports require some hours to be printed.


Physical design:

For some reasons the hold time report is blank.