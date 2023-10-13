module soc_config (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    input wb_rst_i,
    input user_clock2,
    // Logic Analyzer Signals
    input  [36:0] la_data_in,
    input  [36:0] la_oenb,

    // IOs
    input [1:0] io_in,
    output [37:0] io_oeb,

    // CPU/MEMORY specific
    output en_keyboard,
    output soc_rst,
    output soc_clk,

    // CPU0/MEMORY0 specific
    input rw_from_cpu0,
    input en_from_cpu0,
    input [11:0] addr_from_cpu0,
    input [15:0] data_from_cpu0,
    input [15:0] data_from_mem0,
    input en_display0,
    output [15:0] data_to_cpu0,
    output [15:0] data_to_mem0,
    output [9:0] addr_to_mem0,
    output en_to_memB0,
    output rw_to_mem0,

    // CPU1/MEMORY1 specific
    input rw_from_cpu1,
    input en_from_cpu1,
    input [11:0] addr_from_cpu1,
    input [15:0] data_from_cpu1,
    input [15:0] data_from_mem1,
    input en_display1,
    output [15:0] data_to_cpu1,
    output [15:0] data_to_mem1,
    output [9:0] addr_to_mem1,
    output en_to_memB1,
    output rw_to_mem1,

    // CPU2/MEMORY2 specific
    input rw_from_cpu2,
    input en_from_cpu2,
    input [11:0] addr_from_cpu2,
    input [15:0] data_from_cpu2,
    input [15:0] data_from_mem2,
    input en_display2,
    output [15:0] data_to_cpu2,
    output [15:0] data_to_mem2,
    output [9:0] addr_to_mem2,
    output en_to_memB2,
    output rw_to_mem2,

    // CPU3/MEMORY3 specific
    input rw_from_cpu3,
    input en_from_cpu3,
    input [11:0] addr_from_cpu3,
    input [15:0] data_from_cpu3,
    input [15:0] data_from_mem3,
    input en_display3,
    output [15:0] data_to_cpu3,
    output [15:0] data_to_mem3,
    output [9:0] addr_to_mem3,
    output en_to_memB3,
    output rw_to_mem3,

    // CPU4/MEMORY4 specific
    input rw_from_cpu4,
    input en_from_cpu4,
    input [11:0] addr_from_cpu4,
    input [15:0] data_from_cpu4,
    input [15:0] data_from_mem4,
    input en_display4,
    output [15:0] data_to_cpu4,
    output [15:0] data_to_mem4,
    output [9:0] addr_to_mem4,
    output en_to_memB4,
    output rw_to_mem4,

    // CPU5/MEMORY5 specific
    input rw_from_cpu5,
    input en_from_cpu5,
    input [11:0] addr_from_cpu5,
    input [15:0] data_from_cpu5,
    input [15:0] data_from_mem5,
    input en_display5,
    output [15:0] data_to_cpu5,
    output [15:0] data_to_mem5,
    output [9:0] addr_to_mem5,
    output en_to_memB5,
    output rw_to_mem5,

    // CPU6/MEMORY6 specific
    input rw_from_cpu6,
    input en_from_cpu6,
    input [11:0] addr_from_cpu6,
    input [15:0] data_from_cpu6,
    input [15:0] data_from_mem6,
    input en_display6,
    output [15:0] data_to_cpu6,
    output [15:0] data_to_mem6,
    output [9:0] addr_to_mem6,
    output en_to_memB6,
    output rw_to_mem6,

    // CPU7/MEMORY7 specific
    input rw_from_cpu7,
    input en_from_cpu7,
    input [11:0] addr_from_cpu7,
    input [15:0] data_from_cpu7,
    input [15:0] data_from_mem7,
    input en_display7,
    output [15:0] data_to_cpu7,
    output [15:0] data_to_mem7,
    output [9:0] addr_to_mem7,
    output en_to_memB7,
    output rw_to_mem7,

    // CPU8/MEMORY8 specific
    input rw_from_cpu8,
    input en_from_cpu8,
    input [11:0] addr_from_cpu8,
    input [15:0] data_from_cpu8,
    input [15:0] data_from_mem8,
    input en_display8,
    output [15:0] data_to_cpu8,
    output [15:0] data_to_mem8,
    output [9:0] addr_to_mem8,
    output en_to_memB8,
    output rw_to_mem8,

    // CPU9/MEMORY9 specific
    input rw_from_cpu9,
    input en_from_cpu9,
    input [11:0] addr_from_cpu9,
    input [15:0] data_from_cpu9,
    input [15:0] data_from_mem9,
    input en_display9,
    output [15:0] data_to_cpu9,
    output [15:0] data_to_mem9,
    output [9:0] addr_to_mem9,
    output en_to_memB9,
    output rw_to_mem9,

    // CPU10/MEMORY10 specific
    input rw_from_cpu10,
    input en_from_cpu10,
    input [11:0] addr_from_cpu10,
    input [15:0] data_from_cpu10,
    input [15:0] data_from_mem10,
    input en_display10,
    output [15:0] data_to_cpu10,
    output [15:0] data_to_mem10,
    output [9:0] addr_to_mem10,
    output en_to_memB10,
    output rw_to_mem10,

    // CPU11/MEMORY11 specific
    input rw_from_cpu11,
    input en_from_cpu11,
    input [11:0] addr_from_cpu11,
    input [15:0] data_from_cpu11,
    input [15:0] data_from_mem11,
    input en_display11,
    output [15:0] data_to_cpu11,
    output [15:0] data_to_mem11,
    output [9:0] addr_to_mem11,
    output en_to_memB11,
    output rw_to_mem11
);

    // LA
    // if la_data_in is input, then wbrst or io_in can be used
    assign io_oeb[20] = la_oenb[0] ? la_data_in[0] : 1'b0;
    assign soc_rst = la_oenb[1] ? la_data_in[1] : (io_oeb[20] ? io_in[0] : wb_rst_i);

    // if la_data_in is input, then usrclk can be used. Else io_in is the clock
    assign io_oeb[21] = la_oenb[2] ? la_data_in[2] : 1'b0;
    assign soc_clk = la_oenb[3] ? la_data_in[3] : (io_oeb[21] ? io_in[1] : user_clock2);

    // Enable keyboard by LA
    assign en_keyboard = la_oenb[4] ? la_data_in[4] : 1'b1;

switch switch0 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[7:0]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu0),
    .data_from_cpu(data_from_cpu0),
    .data_to_cpu(data_to_cpu0),
    .rw_from_cpu(rw_from_cpu0),
    .en_from_cpu(en_from_cpu0),
    .en_display(en_display0),

    // memory specific
    .mem_selection(~la_data_in[36:33]),
    .addr_to_mem(addr_to_mem0),
    .data_to_mem(data_to_mem0),
    .data_from_mem(data_from_mem0),
    .rw_to_mem(rw_to_mem0),
    .en_to_memB(en_to_memB0)
);

switch switch1 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[37:30]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu1),
    .data_from_cpu(data_from_cpu1),
    .data_to_cpu(data_to_cpu1),
    .rw_from_cpu(rw_from_cpu1),
    .en_from_cpu(en_from_cpu1),
    .en_display(en_display1),

    // memory specific
    .mem_selection({~la_data_in[36:34], la_data_in[33]}),
    .addr_to_mem(addr_to_mem1),
    .data_to_mem(data_to_mem1),
    .data_from_mem(data_from_mem1),
    .rw_to_mem(rw_to_mem1),
    .en_to_memB(en_to_memB1)
);

switch switch2 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[15:8]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu2),
    .data_from_cpu(data_from_cpu2),
    .data_to_cpu(data_to_cpu2),
    .rw_from_cpu(rw_from_cpu2),
    .en_from_cpu(en_from_cpu2),
    .en_display(en_display2),

    // memory specific
    .mem_selection({~la_data_in[36:35], la_data_in[34], ~la_data_in[33]}),
    .addr_to_mem(addr_to_mem2),
    .data_to_mem(data_to_mem2),
    .data_from_mem(data_from_mem2),
    .rw_to_mem(rw_to_mem2),
    .en_to_memB(en_to_memB2)
);

switch switch3 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[29:22]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu3),
    .data_from_cpu(data_from_cpu3),
    .data_to_cpu(data_to_cpu3),
    .rw_from_cpu(rw_from_cpu3),
    .en_from_cpu(en_from_cpu3),
    .en_display(en_display3),

    // memory specific
    .mem_selection({~la_data_in[36:35], la_data_in[34:33]}),
    .addr_to_mem(addr_to_mem3),
    .data_to_mem(data_to_mem3),
    .data_from_mem(data_from_mem3),
    .rw_to_mem(rw_to_mem3),
    .en_to_memB(en_to_memB3)
);

switch switch4 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[7:0]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu4),
    .data_from_cpu(data_from_cpu4),
    .data_to_cpu(data_to_cpu4),
    .rw_from_cpu(rw_from_cpu4),
    .en_from_cpu(en_from_cpu4),
    .en_display(en_display4),

    // memory specific
    .mem_selection({~la_data_in[36], la_data_in[35], ~la_data_in[34:33]}),
    .addr_to_mem(addr_to_mem4),
    .data_to_mem(data_to_mem4),
    .data_from_mem(data_from_mem4),
    .rw_to_mem(rw_to_mem4),
    .en_to_memB(en_to_memB4)
);

switch switch5 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[37:30]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu5),
    .data_from_cpu(data_from_cpu5),
    .data_to_cpu(data_to_cpu5),
    .rw_from_cpu(rw_from_cpu5),
    .en_from_cpu(en_from_cpu5),
    .en_display(en_display5),

    // memory specific
    .mem_selection({~la_data_in[36], la_data_in[35], ~la_data_in[34], la_data_in[33]}),
    .addr_to_mem(addr_to_mem5),
    .data_to_mem(data_to_mem5),
    .data_from_mem(data_from_mem5),
    .rw_to_mem(rw_to_mem5),
    .en_to_memB(en_to_memB5)
);

switch switch6 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[15:8]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu6),
    .data_from_cpu(data_from_cpu6),
    .data_to_cpu(data_to_cpu6),
    .rw_from_cpu(rw_from_cpu6),
    .en_from_cpu(en_from_cpu6),
    .en_display(en_display6),

    // memory specific
    .mem_selection({~la_data_in[36], la_data_in[35:34], ~la_data_in[33]}),
    .addr_to_mem(addr_to_mem6),
    .data_to_mem(data_to_mem6),
    .data_from_mem(data_from_mem6),
    .rw_to_mem(rw_to_mem6),
    .en_to_memB(en_to_memB6)
);

switch switch7 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[29:22]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu7),
    .data_from_cpu(data_from_cpu7),
    .data_to_cpu(data_to_cpu7),
    .rw_from_cpu(rw_from_cpu7),
    .en_from_cpu(en_from_cpu7),
    .en_display(en_display7),

    // memory specific
    .mem_selection({~la_data_in[36], la_data_in[35:33]}),
    .addr_to_mem(addr_to_mem7),
    .data_to_mem(data_to_mem7),
    .data_from_mem(data_from_mem7),
    .rw_to_mem(rw_to_mem7),
    .en_to_memB(en_to_memB7)
);

switch switch8 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[7:0]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu8),
    .data_from_cpu(data_from_cpu8),
    .data_to_cpu(data_to_cpu8),
    .rw_from_cpu(rw_from_cpu8),
    .en_from_cpu(en_from_cpu8),
    .en_display(en_display8),

    // memory specific
    .mem_selection({la_data_in[36], ~la_data_in[35:33]}),
    .addr_to_mem(addr_to_mem8),
    .data_to_mem(data_to_mem8),
    .data_from_mem(data_from_mem8),
    .rw_to_mem(rw_to_mem8),
    .en_to_memB(en_to_memB8)
);

switch switch9 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[37:30]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu9),
    .data_from_cpu(data_from_cpu9),
    .data_to_cpu(data_to_cpu9),
    .rw_from_cpu(rw_from_cpu9),
    .en_from_cpu(en_from_cpu9),
    .en_display(en_display9),

    // memory specific
    .mem_selection({la_data_in[36], ~la_data_in[35:34], la_data_in[33]}),
    .addr_to_mem(addr_to_mem9),
    .data_to_mem(data_to_mem9),
    .data_from_mem(data_from_mem9),
    .rw_to_mem(rw_to_mem9),
    .en_to_memB(en_to_memB9)
);

switch switch10 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[15:8]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu10),
    .data_from_cpu(data_from_cpu10),
    .data_to_cpu(data_to_cpu10),
    .rw_from_cpu(rw_from_cpu10),
    .en_from_cpu(en_from_cpu10),
    .en_display(en_display10),

    // memory specific
    .mem_selection({la_data_in[36], ~la_data_in[35], la_data_in[34], ~la_data_in[33]}),
    .addr_to_mem(addr_to_mem10),
    .data_to_mem(data_to_mem10),
    .data_from_mem(data_from_mem10),
    .rw_to_mem(rw_to_mem10),
    .en_to_memB(en_to_memB10)
);

switch switch11 (

    // Logic Analyzer
    .la_data_in(la_data_in[32:5]),
    .la_oenb (la_oenb[36:5]),

    // IO Pads
    .io_oeb(io_oeb[29:22]),

    // CPU specific
    .addr_from_cpu(addr_from_cpu11),
    .data_from_cpu(data_from_cpu11),
    .data_to_cpu(data_to_cpu11),
    .rw_from_cpu(rw_from_cpu11),
    .en_from_cpu(en_from_cpu11),
    .en_display(en_display11),

    // memory specific
    .mem_selection({la_data_in[36], ~la_data_in[35], la_data_in[34:33]}),
    .addr_to_mem(addr_to_mem11),
    .data_to_mem(data_to_mem11),
    .data_from_mem(data_from_mem11),
    .rw_to_mem(rw_to_mem11),
    .en_to_memB(en_to_memB11)
);

endmodule

module switch (

    // Logic Analyzer
    input [27:0] la_data_in,
    input [31:0] la_oenb,

    // IO Pads
    output [7:0] io_oeb,

    // CPU specific
    input [11:0] addr_from_cpu,
    input [15:0] data_from_cpu,
    output [15:0] data_to_cpu,
    input rw_from_cpu,
    input en_from_cpu,
    input en_display,

    // memory specific
    input [3:0] mem_selection, //la_data_in[31:28]
    output [9:0] addr_to_mem,
    output [15:0] data_to_mem,
    input [15:0] data_from_mem,
    output rw_to_mem,
    output en_to_memB
);

    wire en_disp;
    wire [3:0] addr_to_decod;

    // Provision to read/write ram from LA
    assign data_to_cpu = data_from_mem;
    assign addr_to_decod = la_oenb[31:28] ? mem_selection[3:0] : {4{en_from_cpu}};
    assign addr_to_mem = la_oenb[27:18] ? la_data_in[27:18] : addr_from_cpu[9:0];
    assign data_to_mem = la_oenb[17:2] ? la_data_in[17:2] : data_from_cpu;
    assign rw_to_mem = la_oenb[1] ? la_data_in[1] : ~rw_from_cpu; // active low for openram
    assign en_disp = la_oenb[0] ? la_data_in[0] : en_display; // active low for openram
    assign io_oeb = ~{8{en_disp}};
    assign en_to_memB = ~(addr_to_decod[3] & addr_to_decod[2] & addr_to_decod[1] & addr_to_decod[0]); // active low for openram

endmodule
