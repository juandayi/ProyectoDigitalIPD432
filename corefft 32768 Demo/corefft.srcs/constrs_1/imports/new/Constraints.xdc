## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clkin]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clkin]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets { clk_rx_ready }];

#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { Ena[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { Ena[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
#set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { Ena[2] }]; #IO_L24P_T3_A01_D17_14 Sch=an[2]
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { Ena[3] }]; #IO_L19P_T3_A22_15 Sch=an[3]
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { Ena[4] }]; #IO_L8N_T1_D12_14 Sch=an[4]
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { Ena[5] }]; #IO_L14P_T2_SRCC_14 Sch=an[5]
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { Ena[6] }]; #IO_L23P_T3_35 Sch=an[6]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { Ena[7] }]; #IO_L23N_T3_A02_D18_14 Sch=an[7]

#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { Seg[0] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
#set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { Seg[1] }]; #IO_25_14 Sch=cb
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { Seg[2] }]; #IO_25_15 Sch=cc
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { Seg[3] }]; #IO_L17P_T2_A26_15 Sch=cd
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { Seg[4] }]; #IO_L13P_T2_MRCC_14 Sch=ce
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { Seg[5] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { Seg[6] }]; #IO_L4P_T0_D04_14 Sch=cg

#Uart Port
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports uart_rx]
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports uart_tx]

#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { SW[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { SW[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
#set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { SW[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
#set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { SW[3] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { SW[4] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { S }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]

set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {LEDS[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {LEDS[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {LEDS[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {LEDS[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {LEDS[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {LEDS[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {LEDS[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {LEDS2[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {LEDS2[1]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {LEDS2[2]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {LEDS2[3]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {LEDS2[4]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {LEDS2[5]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {LEDS2[6]}]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { LED[14] }]; #IO_L20N_T3_A07_D23_14 Sch=led[14]
#set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { LED[15] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=led[15]


set_property MARK_DEBUG true [get_nets {your_instance_name/dina[0]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[7]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[10]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[15]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[18]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[20]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[25]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[31]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[5]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[9]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[12]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[19]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[21]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[24]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[28]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[13]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[1]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[2]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[3]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[6]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[8]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[16]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[22]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[27]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[29]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[30]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[4]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[11]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[14]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[17]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[23]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/dina[26]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[1]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[3]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[7]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[11]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[21]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[25]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[27]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[6]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[14]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[15]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[17]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[18]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[24]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[28]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[29]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[2]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[0]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[4]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[10]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[13]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[16]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[23]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[30]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[31]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[5]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[8]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[9]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[12]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[19]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[20]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[22]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/doutb[26]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addra[0]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addra[1]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addra[2]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addra[3]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addra[4]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addrb[0]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addrb[1]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addrb[2]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addrb[3]}]
set_property MARK_DEBUG true [get_nets {your_instance_name/addrb[4]}]

