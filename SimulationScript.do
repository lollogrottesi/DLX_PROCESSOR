#source /software/scripts/init_questa10.7c

#vlib work
vcom -reportprogress 300 -work work ./DLX_syn/00-myTypes.vhd
vcom -reportprogress 300 -work work ./DLX_syn/01-FF.vhd
vcom -reportprogress 300 -work work ./DLX_syn/02-FFD.vhd
vcom -reportprogress 300 -work work ./DLX_syn/03-FFD_RST.vhd
vcom -reportprogress 300 -work work ./DLX_syn/04-Register_Generic.vhd
vcom -reportprogress 300 -work work ./DLX_syn/05-Register_Generic_rst.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.a-CONTROL_UNIT.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.c-Fetch.core/a.c.a-IRAM.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.a-MASK_AND_ALIGN.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.b-DLX_RF.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.d-SHIFT_AND_ALIGN.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.e-LOGIC_JMP.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.f-FORWARDING_UNIT.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.g-EXT_IMM.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.h-DLX_RAM.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/01-fa.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/02-G.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/03-PG.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/04-PG_Network.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/05-Carry_look_ahead.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.h-Cellular_array_divider/01-Division_cell.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.h-Cellular_array_divider/02-Division_cell_row.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.h-Cellular_array_divider/03-Cellular_array_divider.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/01-Carry_network.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/02-Equality_PG_network.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/03-Equality_check_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/04-Carry_out_network.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/05-Comparator.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.g-Comparator/06-zero_detector.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.f-Array_multiplier/01-Half_adder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.f-Array_multiplier/02-FullAdder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.f-Array_multiplier/03-FastAdder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.f-Array_multiplier/04-Array_multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/000-constants.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/01-iv.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/02-nd2.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/03-rca.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/04-rca_gen.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/05-mux21_generic.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/06-mux21.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/07-mux2to1.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/08-mux_8to1.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/09-shifter.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/10-Shifter_gen.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/11-Carry_Select_Block.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/12-Carry_Select_Sum_Generator.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/13-CLA_Sparse_Tree_Generator.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/14-Pentium_IV_Adder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/15-Booth_Multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/16-Adder_subctractor.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/17-integer_comparator.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/18-logic_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.core/19-Multiplier_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.a-ALU_Integer.vhd
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/01-Generic_normlization_unit.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/02-Floating_point_double_precision_to_integer.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/03-Floating_point_double_precision_to_single.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/04-Floating_point_single_precision_to_double.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/05-Floating_point_single_precision_to_integer.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/06-Integer_to_floating_point_double.vhd}
vcom -reportprogress 300 -work work {./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-ALU_Converter unit.core/07-Integer_to_floating_point_single_precision.vhd}
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.b-Converter_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/01-Alignment_compare_E.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/02-Mantissa_shifter.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/03-mantissa_add_sub.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/04-Generic_normalization_double_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/05-Double_add_sub.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.a-Add_sub/06-Double_cmp_add_sub.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.b-Divider/01-Exponent_subctrator_fp_double.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.b-Divider/02-Mantissa_divider.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.b-Divider/03-Generic_normalization_double_DIV_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.b-Divider/04-Double_Floating_Point_Divider.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.d-Mul/01-Exponent_Adder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.d-Mul/02-Generic_normalization_double_MUL_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.d-Mul/03-Mantissa_multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-ALU_FP_Double.core/a.b.c.d.d-Mul/04-Double_Floating_Point_Multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/01-Alignment_compare_E_ADD_single.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/02-Mantissa_shifter.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/03-mantissa_add_sub.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/04-postnormalization_ADD_SUB_single.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/05-IEEE_754_floating_add_sub.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.a-add_sub/06-IEEE_754_Add_Cmp_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.b-div/01-Mantissa_divider.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.b-div/02-postnormalization_DIV_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.b-div/03-Exponent_subctrator_fp_single.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.b-div/04-IEEE_754_Fast_Divider.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.c-mul/01-Exponent_Adder.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.c-mul/02-Mantissa_multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.c-mul/03-postnormalization_multiplier_unit_single.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-ALU_FP_Single.core/a.b.c.e.c-mul/04-IEEE_754_Floating_Point_Multiplier.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.d-Floating_Point_Double_Precision_Unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.core/a.b.c.e-Floating_Point_Single_Precision_unit.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-Datapath.core/a.b.c-ALU.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.b-DataPath.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a.c-DLX_Fetch_Stage.vhd
vcom -reportprogress 300 -work work ./DLX_syn/a-DLX.vhd
vcom -reportprogress 300 -work work ./DLX_syn/test/TB_DLX.vhd

vsim -gui -t 10ns -vopt work.tb_dlx

add wave -position insertpoint  \
sim:/tb_dlx/clk \
sim:/tb_dlx/rst
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/IF_stage/IR
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/INTEGER_REGISTER_FILE/regFile
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/FLOATING_REGISTER_FILE/regFile
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DOUBLE_REGISTER_FILE/regFile
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPA \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/OPB \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/EX_ALU/ALU_Out
add wave -position insertpoint  \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_A_CTRL \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_B_CTRL \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_C_CTRL \
sim:/tb_dlx/DLX_DUT/ID_EX_MEM_WB_stages/DATA_FORWORDING_UNIT/MUX_FRW_D_CTRL
add wave -position insertpoint  \
sim:/tb_dlx/RAM/ram

run 1000 ns


