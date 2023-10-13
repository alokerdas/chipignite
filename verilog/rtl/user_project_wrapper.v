// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

wire memenb0, memenb1, memenb2, memenb3, memenb4, memenb5, memenb6, memenb7, memenb8, memenb9, memenb10, memenb11;
wire [9:0] adr_mem0, adr_mem1, adr_mem2, adr_mem3, adr_mem4, adr_mem5, adr_mem6, adr_mem7, adr_mem8, adr_mem9, adr_mem10, adr_mem11;
wire [11:0] adr_cpu0, adr_cpu1, adr_cpu2, adr_cpu3, adr_cpu4, adr_cpu5, adr_cpu6, adr_cpu7, adr_cpu8, adr_cpu9, adr_cpu10, adr_cpu11;
wire [15:0] cpdatin0, cpdatin1, cpdatin2, cpdatin3, cpdatin4, cpdatin5, cpdatin6, cpdatin7, cpdatin8, cpdatin9, cpdatin10, cpdatin11;
wire [15:0] cpdatout0, cpdatout1, cpdatout2, cpdatout3, cpdatout4, cpdatout5, cpdatout6, cpdatout7, cpdatout8, cpdatout9, cpdatout10, cpdatout11;
wire [15:0] memdatin0, memdatin1, memdatin2, memdatin3, memdatin4, memdatin5, memdatin6, memdatin7, memdatin8, memdatin9, memdatin10, memdatin11;
wire [15:0] memdatout0, memdatout1, memdatout2, memdatout3, memdatout4, memdatout5, memdatout6, memdatout7, memdatout8, memdatout9, memdatout10, memdatout11;
wire cpuen0, cpuen1, cpuen2, cpuen3, cpuen4, cpuen5, cpuen6, cpuen7, cpuen8, cpuen9, cpuen10, cpuen11;
wire cpurw0, cpurw1, cpurw2, cpurw3, cpurw4, cpurw5, cpurw6, cpurw7, cpurw8, cpurw9, cpurw10, cpurw11;
wire memrwb0, memrwb1, memrwb2, memrwb3, memrwb4, memrwb5, memrwb6, memrwb7, memrwb8, memrwb9, memrwb10, memrwb11;
wire endisp0, endisp1, endisp2, endisp3, endisp4, endisp5, endisp6, endisp7, endisp8, endisp9, endisp10, endisp11;
wire enkbd, rst, clk;
wire [7:0] spi_cpu8, cpu_spi8, spi_cpu9, cpu_spi9, spi_cpu10, cpu_spi10, spi_cpu11, cpu_spi11;

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

soc_config mprj (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .user_clock2(user_clock2),
    .wb_rst_i(wb_rst_i),

    // Logic Analyzer
    .la_data_in(la_data_in[36:0]),
    .la_oenb (la_oenb[36:0]),

    // IO Pads
    .io_in (io_in[21:20]),
    .io_oeb(io_oeb[37:0]),

    // CPU specific
    .en_keyboard(enkbd),
    .soc_clk(clk),
    .soc_rst(rst),

    // CPU0/MEM0 specific
    .addr_from_cpu0(adr_cpu0),
    .data_from_cpu0(cpdatout0),
    .data_to_cpu0(cpdatin0),
    .addr_to_mem0(adr_mem0),
    .data_from_mem0(memdatin0),
    .data_to_mem0(memdatout0),
    .rw_from_cpu0(cpurw0),
    .en_from_cpu0(cpuen0),
    .rw_to_mem0(memrwb0),
    .en_to_memB0(memenb0),
    .en_display0(endisp0),

    // CPU1/MEM1 specific
    .addr_from_cpu1(adr_cpu1),
    .data_from_cpu1(cpdatout1),
    .data_to_cpu1(cpdatin1),
    .addr_to_mem1(adr_mem1),
    .data_from_mem1(memdatin1),
    .data_to_mem1(memdatout1),
    .rw_from_cpu1(cpurw1),
    .en_from_cpu1(cpuen1),
    .rw_to_mem1(memrwb1),
    .en_to_memB1(memenb1),
    .en_display1(endisp1),

    // CPU2/MEM2 specific
    .addr_from_cpu2(adr_cpu2),
    .data_from_cpu2(cpdatout2),
    .data_to_cpu2(cpdatin2),
    .addr_to_mem2(adr_mem2),
    .data_from_mem2(memdatin2),
    .data_to_mem2(memdatout2),
    .rw_from_cpu2(cpurw2),
    .en_from_cpu2(cpuen2),
    .rw_to_mem2(memrwb2),
    .en_to_memB2(memenb2),
    .en_display2(endisp2),

    // CPU3/MEM3 specific
    .addr_from_cpu3(adr_cpu3),
    .data_from_cpu3(cpdatout3),
    .data_to_cpu3(cpdatin3),
    .addr_to_mem3(adr_mem3),
    .data_from_mem3(memdatin3),
    .data_to_mem3(memdatout3),
    .rw_from_cpu3(cpurw3),
    .en_from_cpu3(cpuen3),
    .rw_to_mem3(memrwb3),
    .en_to_memB3(memenb3),
    .en_display3(endisp3),

    // CPU4/MEM4 specific
    .addr_from_cpu4(adr_cpu4),
    .data_from_cpu4(cpdatout4),
    .data_to_cpu4(cpdatin4),
    .addr_to_mem4(adr_mem4),
    .data_from_mem4(memdatin4),
    .data_to_mem4(memdatout4),
    .rw_from_cpu4(cpurw4),
    .en_from_cpu4(cpuen4),
    .rw_to_mem4(memrwb4),
    .en_to_memB4(memenb4),
    .en_display4(endisp4),

    // CPU5/MEM5 specific
    .addr_from_cpu5(adr_cpu5),
    .data_from_cpu5(cpdatout5),
    .data_to_cpu5(cpdatin5),
    .addr_to_mem5(adr_mem5),
    .data_from_mem5(memdatin5),
    .data_to_mem5(memdatout5),
    .rw_from_cpu5(cpurw5),
    .en_from_cpu5(cpuen5),
    .rw_to_mem5(memrwb5),
    .en_to_memB5(memenb5),
    .en_display5(endisp5),

    // CPU6/MEM6 specific
    .addr_from_cpu6(adr_cpu6),
    .data_from_cpu6(cpdatout6),
    .data_to_cpu6(cpdatin6),
    .addr_to_mem6(adr_mem6),
    .data_from_mem6(memdatin6),
    .data_to_mem6(memdatout6),
    .rw_from_cpu6(cpurw6),
    .en_from_cpu6(cpuen6),
    .rw_to_mem6(memrwb6),
    .en_to_memB6(memenb6),
    .en_display6(endisp6),

    // CPU7/MEM7 specific
    .addr_from_cpu7(adr_cpu7),
    .data_from_cpu7(cpdatout7),
    .data_to_cpu7(cpdatin7),
    .addr_to_mem7(adr_mem7),
    .data_from_mem7(memdatin7),
    .data_to_mem7(memdatout7),
    .rw_from_cpu7(cpurw7),
    .en_from_cpu7(cpuen7),
    .rw_to_mem7(memrwb7),
    .en_to_memB7(memenb7),
    .en_display7(endisp7),

    // CPU8/MEM8 specific
    .addr_from_cpu8(adr_cpu8),
    .data_from_cpu8(cpdatout8),
    .data_to_cpu8(cpdatin8),
    .addr_to_mem8(adr_mem8),
    .data_from_mem8(memdatin8),
    .data_to_mem8(memdatout8),
    .rw_from_cpu8(cpurw8),
    .en_from_cpu8(cpuen8),
    .rw_to_mem8(memrwb8),
    .en_to_memB8(memenb8),
    .en_display8(),

    // CPU9/MEM9 specific
    .addr_from_cpu9(adr_cpu9),
    .data_from_cpu9(cpdatout9),
    .data_to_cpu9(cpdatin9),
    .addr_to_mem9(adr_mem9),
    .data_from_mem9(memdatin9),
    .data_to_mem9(memdatout9),
    .rw_from_cpu9(cpurw9),
    .en_from_cpu9(cpuen9),
    .rw_to_mem9(memrwb9),
    .en_to_memB9(memenb9),
    .en_display9(),

    // CPU10/MEM10 specific
    .addr_from_cpu10(adr_cpu10),
    .data_from_cpu10(cpdatout10),
    .data_to_cpu10(cpdatin10),
    .addr_to_mem10(adr_mem10),
    .data_from_mem10(memdatin10),
    .data_to_mem10(memdatout10),
    .rw_from_cpu10(cpurw10),
    .en_from_cpu10(cpuen10),
    .rw_to_mem10(memrwb10),
    .en_to_memB10(memenb10),
    .en_display10(),

    // CPU11/MEM11 specific
    .addr_from_cpu11(adr_cpu11),
    .data_from_cpu11(cpdatout11),
    .data_to_cpu11(cpdatin11),
    .addr_to_mem11(adr_mem11),
    .data_from_mem11(memdatin11),
    .data_to_mem11(memdatout11),
    .rw_from_cpu11(cpurw11),
    .en_from_cpu11(cpuen11),
    .rw_to_mem11(memrwb11),
    .en_to_memB11(memenb11),
    .en_display11()
);

cpu cpu0 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu0),
    .datain(cpdatin0),
    .dataout(cpdatout0),
    .en_inp(enkbd),
    .en_out(endisp0),
    .rdwr(cpurw0),
    .en(cpuen0),
    .keyboard(io_in[7:0]),
    .display(io_out[7:0])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword0 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem0),
    .din0(memdatout0[7:0]),
    .dout0(memdatin0[7:0]),
    .web0(memrwb0),
    .csb0(memenb0),
    .wmask0({cpuen0, cpuen0})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword0 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem0),
    .din0(memdatout0[15:8]),
    .dout0(memdatin0[15:8]),
    .web0(memrwb0),
    .csb0(memenb0),
    .wmask0({cpuen0, cpuen0})
);

cpu cpu1 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu1),
    .datain(cpdatin1),
    .dataout(cpdatout1),
    .en_inp(enkbd),
    .en_out(endisp1),
    .rdwr(cpurw1),
    .en(cpuen1),
    .keyboard(io_in[37:30]),
    .display(io_out[37:30])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword1 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem1),
    .din0(memdatout1[7:0]),
    .dout0(memdatin1[7:0]),
    .web0(memrwb1),
    .csb0(memenb1),
    .wmask0({cpuen1, cpuen1})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword1 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem1),
    .din0(memdatout1[15:8]),
    .dout0(memdatin1[15:8]),
    .web0(memrwb1),
    .csb0(memenb1),
    .wmask0({cpuen1, cpuen1})
);

cpu cpu2 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu2),
    .datain(cpdatin2),
    .dataout(cpdatout2),
    .en_inp(enkbd),
    .en_out(endisp2),
    .rdwr(cpurw2),
    .en(cpuen2),
    .keyboard(io_in[7:0]),
    .display(io_out[7:0])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword2 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem2),
    .din0(memdatout2[7:0]),
    .dout0(memdatin2[7:0]),
    .web0(memrwb2),
    .csb0(memenb2),
    .wmask0({cpuen2, cpuen2})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword2 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem2),
    .din0(memdatout2[15:8]),
    .dout0(memdatin2[15:8]),
    .web0(memrwb2),
    .csb0(memenb2),
    .wmask0({cpuen2, cpuen2})
);

cpu cpu3 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu3),
    .datain(cpdatin3),
    .dataout(cpdatout3),
    .en_inp(enkbd),
    .en_out(endisp3),
    .rdwr(cpurw3),
    .en(cpuen3),
    .keyboard(io_in[37:30]),
    .display(io_out[37:30])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword3 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem3),
    .din0(memdatout3[7:0]),
    .dout0(memdatin3[7:0]),
    .web0(memrwb3),
    .csb0(memenb3),
    .wmask0({cpuen3, cpuen3})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword3 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem3),
    .din0(memdatout3[15:8]),
    .dout0(memdatin3[15:8]),
    .web0(memrwb3),
    .csb0(memenb3),
    .wmask0({cpuen3, cpuen3})
);

cpu cpu4 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu4),
    .datain(cpdatin4),
    .dataout(cpdatout4),
    .en_inp(enkbd),
    .en_out(endisp4),
    .rdwr(cpurw4),
    .en(cpuen4),
    .keyboard(io_in[15:8]),
    .display(io_out[15:8])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword4 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem4),
    .din0(memdatout4[7:0]),
    .dout0(memdatin4[7:0]),
    .web0(memrwb3),
    .csb0(memenb3),
    .wmask0({cpuen4, cpuen4})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword4 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem4),
    .din0(memdatout4[15:8]),
    .dout0(memdatin4[15:8]),
    .web0(memrwb4),
    .csb0(memenb4),
    .wmask0({cpuen4, cpuen4})
);

cpu cpu5 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu5),
    .datain(cpdatin5),
    .dataout(cpdatout5),
    .en_inp(enkbd),
    .en_out(endisp5),
    .rdwr(cpurw5),
    .en(cpuen5),
    .keyboard(io_in[29:22]),
    .display(io_out[29:22])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword5 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem5),
    .din0(memdatout5[7:0]),
    .dout0(memdatin5[7:0]),
    .web0(memrwb5),
    .csb0(memenb5),
    .wmask0({cpuen5, cpuen5})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword5 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem5),
    .din0(memdatout5[15:8]),
    .dout0(memdatin5[15:8]),
    .web0(memrwb5),
    .csb0(memenb5),
    .wmask0({cpuen5, cpuen5})
);

cpu cpu6 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu6),
    .datain(cpdatin6),
    .dataout(cpdatout6),
    .en_inp(enkbd),
    .en_out(endisp6),
    .rdwr(cpurw6),
    .en(cpuen6),
    .keyboard(io_in[15:8]),
    .display(io_out[15:8])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword6 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem6),
    .din0(memdatout6[7:0]),
    .dout0(memdatin6[7:0]),
    .web0(memrwb6),
    .csb0(memenb6),
    .wmask0({cpuen6, cpuen6})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword6 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem6),
    .din0(memdatout6[15:8]),
    .dout0(memdatin6[15:8]),
    .web0(memrwb6),
    .csb0(memenb6),
    .wmask0({cpuen6, cpuen6})
);

cpu cpu7 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu7),
    .datain(cpdatin7),
    .dataout(cpdatout7),
    .en_inp(enkbd),
    .en_out(endisp7),
    .rdwr(cpurw7),
    .en(cpuen7),
    .keyboard(io_in[29:22]),
    .display(io_out[29:22])
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword7 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem7),
    .din0(memdatout7[7:0]),
    .dout0(memdatin7[7:0]),
    .web0(memrwb7),
    .csb0(memenb7),
    .wmask0({cpuen7, cpuen7})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword7 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem7),
    .din0(memdatout7[15:8]),
    .dout0(memdatin7[15:8]),
    .web0(memrwb7),
    .csb0(memenb7),
    .wmask0({cpuen7, cpuen7})
);

cpu cpu8 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu8),
    .datain(cpdatin8),
    .dataout(cpdatout8),
    .en_inp(enkbd),
    .en_out(endisp8),
    .rdwr(cpurw8),
    .en(cpuen8),
    .keyboard(spi_cpu8),
    .display(cpu_spi8)
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword8 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem8),
    .din0(memdatout8[7:0]),
    .dout0(memdatin8[7:0]),
    .web0(memrwb8),
    .csb0(memenb8),
    .wmask0({cpuen8, cpuen8})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword8 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem8),
    .din0(memdatout8[15:8]),
    .dout0(memdatin8[15:8]),
    .web0(memrwb8),
    .csb0(memenb8),
    .wmask0({cpuen8, cpuen8})
);

cpu cpu9 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu9),
    .datain(cpdatin9),
    .dataout(cpdatout9),
    .en_inp(enkbd),
    .en_out(endisp9),
    .rdwr(cpurw9),
    .en(cpuen9),
    .keyboard(spi_cpu9),
    .display(cpu_spi9)
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword9 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem9),
    .din0(memdatout9[7:0]),
    .dout0(memdatin9[7:0]),
    .web0(memrwb9),
    .csb0(memenb9),
    .wmask0({cpuen4, cpuen9})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword9 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem9),
    .din0(memdatout9[15:8]),
    .dout0(memdatin9[15:8]),
    .web0(memrwb9),
    .csb0(memenb9),
    .wmask0({cpuen9, cpuen9})
);

cpu cpu10 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu10),
    .datain(cpdatin10),
    .dataout(cpdatout10),
    .en_inp(enkbd),
    .en_out(endisp10),
    .rdwr(cpurw10),
    .en(cpuen10),
    .keyboard(spi_cpu10),
    .display(cpu_spi10)
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword10 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem10),
    .din0(memdatout10[7:0]),
    .dout0(memdatin10[7:0]),
    .web0(memrwb10),
    .csb0(memenb10),
    .wmask0({cpuen10, cpuen10})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword10 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem10),
    .din0(memdatout10[15:8]),
    .dout0(memdatin10[15:8]),
    .web0(memrwb10),
    .csb0(memenb10),
    .wmask0({cpuen10, cpuen10})
);

cpu cpu11 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif

    .rst(rst),
    .clkin(clk),
    .addr(adr_cpu11),
    .datain(cpdatin11),
    .dataout(cpdatout11),
    .en_inp(enkbd),
    .en_out(endisp11),
    .rdwr(cpurw11),
    .en(cpuen11),
    .keyboard(spi_cpu11),
    .display(cpu_spi11)
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memLword11 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem11),
    .din0(memdatout11[7:0]),
    .dout0(memdatin11[7:0]),
    .web0(memrwb11),
    .csb0(memenb11),
    .wmask0({cpuen11, cpuen11})
);

sky130_sram_1kbyte_1rw1r_8x1024_8 #(.NUM_WMASKS(2)) memHword11 (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
    .clk0(clk),
    .addr0(adr_mem11),
    .din0(memdatout11[15:8]),
    .dout0(memdatin11[15:8]),
    .web0(memrwb11),
    .csb0(memenb11),
    .wmask0({cpuen11, cpuen11})
);

spi_master spi_hub (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),      // User area 1 1.8V power
    .vssd1(vssd1),      // User area 1 digital ground
`endif
// spi0
    .load0(endisp8),
    .unload0(enkbd),
    .datain0(cpu_spi8),
    .dataout0(spi_cpu8),
// spi1
    .load1(endisp9),
    .unload1(enkbd),
    .datain1(cpu_spi9),
    .dataout1(spi_cpu9),
// spi2
    .load2(endisp10),
    .unload2(enkbd),
    .datain2(cpu_spi10),
    .dataout2(spi_cpu10),
// spi3
    .load3(endisp11),
    .unload3(enkbd),
    .datain3(cpu_spi11),
    .dataout3(spi_cpu11),
// common
    .io_in(io_in[19:16]),
    .io_out(io_out[19:16]),
    .io_oeb(io_oeb[19:16]),
    .spirst(rst),
    .spiclk(clk)
);

endmodule	// user_project_wrapper

`default_nettype wire
