/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal wire for symmetry detector output
  wire sym_out;

  // Instantiate symmetry detector
  symmetry_detector sd_inst (
    .out(sym_out),
    .i(ui_in)
  );

  // Assign detector output to LSB of uo_out, rest = 0
  assign uo_out  = {7'b0000000, sym_out};
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in, ena, clk, rst_n, 1'b0};

endmodule
