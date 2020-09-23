###################################################################

# Created by write_sdc on Wed Sep  2 21:50:53 2020

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
create_clock -name CLK  -period 65  -waveform {0 32.5}
set_max_delay 65  -from [list [get_ports {DATAOUT_RAM[16]}] [get_ports {DATAOUT_RAM[9]}]        \
[get_ports {DATAOUT_RAM[47]}] [get_ports {DATAOUT_RAM[57]}] [get_ports         \
{DATAOUT_RAM[12]}] [get_ports {DATAOUT_RAM[43]}] [get_ports {DATAOUT_RAM[62]}] \
[get_ports {DATAOUT_RAM[38]}] [get_ports {DATAOUT_RAM[53]}] [get_ports         \
{DATAOUT_RAM[1]}] [get_ports {DATAOUT_RAM[34]}] [get_ports {DATAOUT_RAM[30]}]  \
[get_ports {DATAOUT_RAM[26]}] [get_ports {DATAOUT_RAM[17]}] [get_ports         \
{DATAOUT_RAM[6]}] [get_ports {DATAOUT_RAM[22]}] [get_ports {DATAOUT_RAM[13]}]  \
[get_ports {DATAOUT_RAM[48]}] [get_ports {DATAOUT_RAM[63]}] [get_ports         \
{DATAOUT_RAM[58]}] [get_ports {DATAOUT_RAM[44]}] [get_ports {DATAOUT_RAM[54]}] \
[get_ports {DATAOUT_RAM[2]}] [get_ports {DATAOUT_RAM[40]}] [get_ports          \
{DATAOUT_RAM[39]}] [get_ports {DATAOUT_RAM[50]}] [get_ports {DATAOUT_RAM[27]}] \
[get_ports {DATAOUT_RAM[35]}] [get_ports {DATAOUT_RAM[23]}] [get_ports         \
{DATAOUT_RAM[18]}] [get_ports {DATAOUT_RAM[31]}] [get_ports {DATAOUT_RAM[14]}] \
[get_ports {DATAOUT_RAM[3]}] [get_ports {DATAOUT_RAM[10]}] [get_ports          \
{DATAOUT_RAM[7]}] [get_ports {DATAOUT_RAM[49]}] [get_ports {DATAOUT_RAM[60]}]  \
[get_ports {DATAOUT_RAM[59]}] [get_ports {DATAOUT_RAM[45]}] [get_ports         \
{DATAOUT_RAM[28]}] [get_ports {DATAOUT_RAM[55]}] [get_ports {DATAOUT_RAM[41]}] \
[get_ports {DATAOUT_RAM[36]}] [get_ports {DATAOUT_RAM[24]}] [get_ports         \
{DATAOUT_RAM[51]}] [get_ports {DATAOUT_RAM[32]}] [get_ports {DATAOUT_RAM[20]}] \
[get_ports {DATAOUT_RAM[19]}] [get_ports {DATAOUT_RAM[4]}] [get_ports          \
{DATAOUT_RAM[15]}] [get_ports {DATAOUT_RAM[8]}] [get_ports {DATAOUT_RAM[11]}]  \
[get_ports {DATAOUT_RAM[46]}] [get_ports {DATAOUT_RAM[37]}] [get_ports         \
{DATAOUT_RAM[61]}] [get_ports {DATAOUT_RAM[56]}] [get_ports {DATAOUT_RAM[0]}]  \
[get_ports {DATAOUT_RAM[42]}] [get_ports {DATAOUT_RAM[33]}] [get_ports         \
{DATAOUT_RAM[29]}] [get_ports {DATAOUT_RAM[52]}] [get_ports {DATAOUT_RAM[25]}] \
[get_ports {DATAOUT_RAM[5]}] [get_ports {DATAOUT_RAM[21]}]]  -to [list [get_pins {ID_EX_MEM_WB_stages/ALU_REG/data_in[47]}] [get_pins      \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[43]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[38]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[61]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[56]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[34]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[26]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[52]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[30]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[22]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[17]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[13]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[7]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[48]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[3]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[44]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[39]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[62]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[40]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[57]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[35]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[27]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[0]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[53]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[31]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[23]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[18]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[14]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[8]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[49]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[10]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[4]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[45]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[63]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[41]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[58]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[36]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[28]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[1]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[54]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[32]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[24]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[19]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[50]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[20]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[15]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[9]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[11]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[5]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[46]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[42]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[59]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[37]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[29]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[60]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[2]}] [get_pins                            \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[55]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[33]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[25]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[51]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[21]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[16]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[12]}] [get_pins                           \
{ID_EX_MEM_WB_stages/ALU_REG/data_in[6]}]]
