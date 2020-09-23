#source /software/scripts/init_questa10.7c

#vlib work

vlog -reportprogress 300 -work work ./postSynthesysConstrainedDLX.v

vcom -reportprogress 300 -work work ./a.c.a-IRAM.vhd

vcom -reportprogress 300 -work work ./a.b.h-DLX_RAM.vhd

vcom -reportprogress 300 -work work ./TB_DLX.vhd

vsim -L /software/dk/nangate45/verilog/msim6.5c work.TB_DLX
#FOR VHDL
#add wave -position insertpoint  \
#sim:/tb_dlx/clk \
#sim:/tb_dlx/rst
#add wave -position insertpoint  \
#sim:/tb_dlx/RAM/ram
#add wave -position insertpoint  \
#sim:/tb_dlx/DLX_DUT/IF_stage/IR
#add wave -position insertpoint  \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPA \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPB
#add wave -position insertpoint  \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/ALU_Out
#add wave -position insertpoint  \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/INTEGER_REGISTER_FILE/OUT1 \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/INTEGER_REGISTER_FILE/OUT2
#add wave -position insertpoint  \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_A_CTRL \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_B_CTRL \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_C_CTRL \
#sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_D_CTRL

#FOR VERILOG
add wave -position insertpoint  \
sim:/tb_dlx/clk \
sim:/tb_dlx/rst
add wave -position insertpoint  \
sim:/tb_dlx/IRAM_DLX/Dout
add wave -position insertpoint  \
sim:/tb_dlx/RAM/ram
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPA \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPB \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/ALU_Out


run 10000 ns

