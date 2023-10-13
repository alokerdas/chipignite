module spi_master (
`ifdef USE_POWER_PINS
  inout vccd1,	// User area 1 1.8V supply
  inout vssd1,	// User area 1 digital ground
`endif

// spi0
  input load0,
  input unload0,
  input [7:0] datain0,
  output [7:0] dataout0,

// spi1
  input load1,
  input unload1,
  input [7:0] datain1,
  output [7:0] dataout1,

// spi2
  input load2,
  input unload2,
  input [7:0] datain2,
  output [7:0] dataout2,

// spi3
  input load3,
  input unload3,
  input [7:0] datain3,
  output [7:0] dataout3,

// common
  output [3:0] io_oeb,
  output [3:0] io_out,
  input [3:0] io_in,
  input spirst,
  input spiclk
);

spi spi0 (
    .rst(spirst),
    .clock_in(spiclk),
    .load(load0),
    .unload(unload0),
    .datain(datain0),
    .dataout(dataout0),
    .miso(io_in[0]),
    .mosi(io_out[0]),
    .ssn(io_oeb[0])
);

spi spi1 (
    .rst(spirst),
    .clock_in(spiclk),
    .load(load1),
    .unload(unload1),
    .datain(datain1),
    .dataout(dataout1),
    .miso(io_in[1]),
    .mosi(io_out[1]),
    .ssn(io_oeb[1])
);

spi spi2 (
    .rst(spirst),
    .clock_in(spiclk),
    .load(load2),
    .unload(unload2),
    .datain(datain2),
    .dataout(dataout2),
    .miso(io_in[2]),
    .mosi(io_out[2]),
    .ssn(io_oeb[2])
);

spi spi3 (
    .rst(spirst),
    .clock_in(spiclk),
    .load(load3),
    .unload(unload3),
    .datain(datain3),
    .dataout(dataout3),
    .miso(io_in[3]),
    .mosi(io_out[3]),
    .ssn(io_oeb[3])
);

endmodule

module spi (
  rst,
  clock_in,
  load,
  unload,
  datain,
  dataout,
  sclk,
  miso,
  mosi,
  ssn
);

  input rst, clock_in, miso, load, unload;
  input [7:0] datain;
  output [7:0] dataout;
  output sclk, mosi, ssn;

  wire int_clk;
  reg [7:0] datareg, dataout;
  reg [2:0] cntreg;

  assign mosi = datareg[7];
  assign ssn = |cntreg;

  always @(posedge clock_in or posedge rst) begin
    if (rst) begin
      datareg  <= 8'h00;
    end else if (load) begin
      datareg <= datain;
    end else if (unload) begin
      dataout <= datareg;
    end else begin
      datareg <= datareg << 1;
      datareg[0] <= miso;
    end
  end

  always @(posedge clock_in or posedge rst) begin
    if (rst) begin
      cntreg  <= 3'h0;
    end else if (ssn || load) begin
      cntreg  <= cntreg + 1;
    end
  end

endmodule
