
/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: X11
*/


`timescale 1ns / 1ps


module dlbf_data_cdc (
	input wire          bram_clk_a,
	input wire          m_axis_clk,
	
	input wire          go_bram,
	input wire          m_axis_rst_bram,
	input wire          m0_done_maxis,
	input wire          m1_done_maxis,
	input wire          m2_done_maxis,
	input wire          m3_done_maxis,
	input wire [11:0]   niter_bram,
	input wire [11:0]   block_size_bram,
	input wire [15:0]   rollover_addr_bram,
	input wire [15:0]   addrb_wire_maxis0,
	input wire [15:0]   addrb_wire_maxis1,
	input wire [15:0]   addrb_wire_maxis2,
	input wire [15:0]   addrb_wire_maxis3,

	output wire         go_maxis,
	output wire         m_axis_rst_maxis,
	output wire         m0_done_bram,
	output wire         m1_done_bram,
	output wire         m2_done_bram,
	output wire         m3_done_bram,
	output wire [11:0]  niter_maxis,
	output wire [11:0]  block_size_maxis,
	output wire [15:0]  rollover_addr_maxis,
	output wire [15:0]  addrb_wire_bram0,
	output wire [15:0]  addrb_wire_bram1,
	output wire [15:0]  addrb_wire_bram2,
	output wire [15:0]  addrb_wire_bram3
 );

    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
       )
    xpm_cdc_single_go (
       .dest_out(go_maxis), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(m_axis_clk), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(bram_clk_a),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(go_bram)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );

    
    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
       )
    xpm_cdc_single_m_axis_rst (
       .dest_out(m_axis_rst_maxis), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(m_axis_clk), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(bram_clk_a),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(m_axis_rst_bram)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );   


    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
        )
    xpm_cdc_single_m0_done (
       .dest_out(m0_done_bram), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(bram_clk_a), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(m_axis_clk),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(m0_done_maxis)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );   

    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
        )
    xpm_cdc_single_m1_done (
       .dest_out(m1_done_bram), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(bram_clk_a), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(m_axis_clk),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(m1_done_maxis)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );   

    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
        )
    xpm_cdc_single_m2_done (
       .dest_out(m2_done_bram), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(bram_clk_a), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(m_axis_clk),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(m2_done_maxis)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );   

    xpm_cdc_single #(
       .DEST_SYNC_FF(4),   // DECIMAL; range: 2-10
       .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       .SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
       .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
        )
    xpm_cdc_single_m3_done (
       .dest_out(m3_done_bram), // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
       .dest_clk(bram_clk_a), // 1-bit input: Clock signal for the destination clock domain.
       .src_clk(m_axis_clk),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
       .src_in(m3_done_maxis)      // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );   

    xpm_cdc_gray #(
        .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
        .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
        .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
        .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
        .WIDTH(12)                  // DECIMAL; range: 2-32
        )
    xpm_cdc_gray_niter (
        .dest_out_bin(niter_maxis), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.

        .dest_clk(m_axis_clk),         // 1-bit input: Destination clock.
        .src_clk(bram_clk_a),           // 1-bit input: Source clock.
        .src_in_bin(niter_bram)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.
    );


    xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(12)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_block_size (
      .dest_out_bin(block_size_maxis), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.

      .dest_clk(m_axis_clk),         // 1-bit input: Destination clock.
      .src_clk(bram_clk_a),           // 1-bit input: Source clock.
      .src_in_bin(block_size_bram)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.

   );

    xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(16)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_rollover_addr (
      .dest_out_bin(rollover_addr_maxis), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.

      .dest_clk(m_axis_clk),         // 1-bit input: Destination clock.
      .src_clk(bram_clk_a),           // 1-bit input: Source clock.
      .src_in_bin(rollover_addr_bram)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.

   );


    xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(16)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_addrb0 (
      .dest_out_bin(addrb_wire_bram0), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.
      .dest_clk(bram_clk_a),         // 1-bit input: Destination clock.
      .src_clk(m_axis_clk),           // 1-bit input: Source clock.
      .src_in_bin(addrb_wire_maxis0)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.
);

    xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(16)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_addrb1 (
      .dest_out_bin(addrb_wire_bram1), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.
      .dest_clk(bram_clk_a),         // 1-bit input: Destination clock.
      .src_clk(m_axis_clk),           // 1-bit input: Source clock.
      .src_in_bin(addrb_wire_maxis1)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.
);

   xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(16)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_addrb2 (
      .dest_out_bin(addrb_wire_bram2), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.
      .dest_clk(bram_clk_a),         // 1-bit input: Destination clock.
      .src_clk(m_axis_clk),           // 1-bit input: Source clock.
      .src_in_bin(addrb_wire_maxis2)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.
);

    xpm_cdc_gray #(
      .DEST_SYNC_FF(4),          // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),          // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .REG_OUTPUT(1),            // DECIMAL; 0=disable registered output, 1=enable registered output
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .SIM_LOSSLESS_GRAY_CHK(0), // DECIMAL; 0=disable lossless check, 1=enable lossless check
      .WIDTH(16)                  // DECIMAL; range: 2-32
   )
   xpm_cdc_gray_addrb3 (
      .dest_out_bin(addrb_wire_bram3), // WIDTH-bit output: Binary input bus (src_in_bin) synchronized to
                                   // destination clock domain. This output is combinatorial unless REG_OUTPUT
                                   // is set to 1.
      .dest_clk(bram_clk_a),         // 1-bit input: Destination clock.
      .src_clk(m_axis_clk),           // 1-bit input: Source clock.
      .src_in_bin(addrb_wire_maxis3)      // WIDTH-bit input: Binary input bus that will be synchronized to the
                                   // destination clock domain.

   );

endmodule

