// src/stubs.v
// Blackbox definitions for Verilator Linting

(* blackbox *)
module sky130_fd_io__top_power_hvc_wpad (
    inout vccd_h,
    inout vccd_l,
    inout vssd_h,
    inout vssd_l,
    inout vdda_h,
    inout vdda_l,
    inout vssa_h,
    inout vssa_l
);
endmodule

(* blackbox *)
module sky130_fd_io__top_ground_hvc_wpad (
    inout vccd_h,
    inout vccd_l,
    inout vssd_h,
    inout vssd_l,
    inout vdda_h,
    inout vdda_l,
    inout vssa_h,
    inout vssa_l
);
endmodule

(* blackbox *)
module sky130_fd_io__top_gpiov2 (
    output IN,
    output IN_H,
    input  HOLD_H,
    input  ENABLE_H,
    input  ENABLE_INP_H,
    input  ENABLE_VDDA_H,
    input  ENABLE_VSWITCH_H,
    input  ENABLE_VDDIO,
    output TIE_HI_ESD,
    output TIE_LO_ESD,
    inout  PAD,
    output OUT, // Added for GPO/BiDir usage
    inout  vccd_h,
    inout  vccd_l,
    inout  vssd_h,
    inout  vssd_l,
    inout  vdda_h,
    inout  vdda_l,
    inout  vssa_h,
    inout  vssa_l
);
endmodule