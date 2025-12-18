module top (
    inout vccd1, inout vssd1, // Digital supply
    inout vdda1, inout vssa1  // Analog supply
);

    // --- 1. NORTH: Power & Control ---
    sky130_fd_io__top_power_hvc_wpad pad_vccd_main (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));
    sky130_fd_io__top_ground_hvc_wpad pad_vssd_main (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));
    
    // Analog Supplies
    sky130_fd_io__top_power_hvc_wpad pad_vdda_main (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));
    sky130_fd_io__top_ground_hvc_wpad pad_vssa_main (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));

    // System Control (Input type)
    sky130_fd_io__top_gpiov2 pad_clk   (.ENABLE_H(1'b1), .ENABLE_INP_H(1'b1), .PAD(), .vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));
    sky130_fd_io__top_gpiov2 pad_rst_n (.ENABLE_H(1'b1), .ENABLE_INP_H(1'b1), .PAD(), .vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));

    // Aux Power (Repeat to fill space)
    sky130_fd_io__top_power_hvc_wpad pad_vccd_aux (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));
    sky130_fd_io__top_ground_hvc_wpad pad_vssd_aux (.vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1));


    // --- 2. EAST: Digital Inputs (0-7) ---
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : gen_east_pads
            sky130_fd_io__top_gpiov2 pad_gpio_in (
                .ENABLE_H(1'b1), .ENABLE_INP_H(1'b1), // Input Enabled
                .PAD(), // External Pin
                .vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1)
            );
        end
    endgenerate

    // --- 3. SOUTH: Digital Outputs (0-7) ---
    generate
        for (i=0; i<8; i=i+1) begin : gen_south_pads
            sky130_fd_io__top_gpiov2 pad_gpio_out (
                .ENABLE_H(1'b1), .ENABLE_INP_H(1'b0), // Output Enabled
                .PAD(), 
                .vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1)
            );
        end
    endgenerate

    // --- 4. WEST: Analog/Misc (0-7) ---
    generate
        for (i=0; i<8; i=i+1) begin : gen_west_pads
            sky130_fd_io__top_gpiov2 pad_analog (
                .ENABLE_H(1'b0), .ENABLE_INP_H(1'b0), // High-Z / Analog Mode
                .PAD(), 
                .vccd_h(vccd1), .vccd_l(vccd1), .vssd_h(vssd1), .vssd_l(vssd1), .vdda_h(vdda1), .vdda_l(vdda1), .vssa_h(vssa1), .vssa_l(vssa1)
            );
        end
    endgenerate

endmodule