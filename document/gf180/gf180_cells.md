# GF180MCU IO Library Cell List

This document lists the available IO cells found in gf180mcu

# GF180MCU IO Cell Library Reference

This document details the IO cells available in the `gf180mcu_fd_io` (Foundation) and `gf180mcu_ef_io` (Extra Features) libraries.

## 1. General Purpose I/O (GPIO) & Analog
These cells handle signals entering and exiting the chip.

| Cell Name | Library Subset | Type | Description |
| :--- | :--- | :--- | :--- |
| **`gf180mcu_fd_io__bi_t`** | Foundation (`fd`) | **Bidirectional** | The standard Digital I/O pad. 3.3V/5.0V tolerant with configurable drive strength. Used for most general logic. |
| **`gf180mcu_ef_io__bi_t`** | Extra Features (`ef`) | **Bidirectional** | Similar to the standard `bi_t` but from the `ef` library. *Note: Ensure voltage domain compatibility if mixing `ef` and `fd` pads.* |
| **`gf180mcu_fd_io__bi_24t`** | Foundation (`fd`) | **High-Drive** | A generic bidirectional pad capable of higher current drive (24mA). Ideal for driving LEDs or long external traces. |
| **`gf180mcu_fd_io__in_c`** | Foundation (`fd`) | **Input Only** | CMOS Input. Standard digital input buffer. Lower capacitance than bidirectional pads. |
| **`gf180mcu_fd_io__in_s`** | Foundation (`fd`) | **Input Only** | Schmitt Trigger Input. Includes hysteresis to clean up noisy or slow-rising signals (e.g., Reset pins, Buttons). |
| **`gf180mcu_fd_io__asig_5p0`** | Foundation (`fd`) | **Analog** | 5.0V Analog Pass-through. A direct low-resistance metal connection from pad to core with ESD protection. Use for ADC/DAC signals. |

## 2. Core Power Supply
These pads supply power to the internal logic (Standard Cells) inside the chip.

| Cell Name | Type | Description |
| :--- | :--- | :--- |
| **`gf180mcu_fd_io__dvdd`** | **Core VDD** | Supplies **1.8V** (typical) to the digital core. Passes the 3.3V/5.0V ring power rails through for continuity. |
| **`gf180mcu_fd_io__dvss`** | **Core VSS** | Supplies **Ground** to the digital core. |

> **Note:** These cells **do not** power the IO Ring itself. You must ensure `VDDIO` and `VSSIO` are connected via the ring rails inherent in all these cells.

## 3. Physical & Spacer Cells (Mandatory)
These cells contain no logic but are required to build a DRC-clean power ring.

| Cell Name | Width | Function |
| :--- | :--- | :--- |
| **`gf180mcu_fd_io__cor`** | 355µm | **Corner Cell**. Required at all 4 corners of the chip to turn the power buses 90 degrees. |
| **`gf180mcu_fd_io__fill1`** | 1µm | **Filler**. Fills small 1µm gaps between pads. |
| **`gf180mcu_fd_io__fill5`** | 5µm | **Filler**. Fills 5µm gaps. |
| **`gf180mcu_fd_io__fill10`** | 10µm | **Filler**. Fills 10µm gaps. |
| **`gf180mcu_fd_io__fillnc`** | Variable | **Filler (NC)**. Often used for non-critical gap filling or capacitor filling. Ensures ring continuity. |



## 4. Power Breaker Cells
Used to isolate power domains within the ring (e.g., separating Noisy Digital Power from Sensitive Analog Power).

| Cell Name | Width | Description |
| :--- | :--- | :--- |
| **`gf180mcu_fd_io__brk2`** | 2µm | Cuts the power rail continuity. Used when you have multiple VDDIO/VSSIO domains. |
| **`gf180mcu_fd_io__brk5`** | 5µm | A wider version of the power breaker. |


# gf180mcu_ef_io__bi_t

## Cell Information
* **Macro Name:** `gf180mcu_ef_io__bi_t`
* **Library:** `gf180mcu_ef_io` (Extra Features IO)
* **Type:** `PAD INOUT` (Bidirectional)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Pin Descriptions

### 1. Digital Signal Interface
These pins connect to the internal digital core of the chip.

| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`A`** | `INPUT` | **Data Input**. The signal coming *from* the core to be driven out to the pad. |
| **`Y`** | `OUTPUT` | **Data Output**. The signal read *from* the pad going into the core. |
| **`OE`** | `INPUT` | **Output Enable**. Controls the output driver. |
| **`IE`** | `INPUT` | **Input Enable**. Controls the input buffer. |
| **`CS`** | `INPUT` | **Chip Select**. Enables the pad interface. |

### 2. Configuration Control
These inputs configure the electrical characteristics of the pad.

| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PDRV0`** | `INPUT` | **Drive Strength Bit 0**. |
| **`PDRV1`** | `INPUT` | **Drive Strength Bit 1**. |
| **`PU`** | `INPUT` | **Pull-Up Enable**. Activates internal pull-up resistor. |
| **`PD`** | `INPUT` | **Pull-Down Enable**. Activates internal pull-down resistor. |
| **`SL`** | `INPUT` | **Slew Rate**. Selects fast or slow edge rates. |

### 3. Physical Interface
These pins connect to the external world or special analog circuits.

| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PAD`** | `INOUT` | **Physical Pad**. The metal bond pad connecting to the package. |
| **`ANA`** | `INOUT` | **Analog Pass-through**. Direct connection to the PAD (bypasses digital logic). |

### 4. Power Supply
The pad requires two separate voltage domains.

| Pin Name | Direction | Domain | Description |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. |

# gf180mcu_fd_io__asig_5p0

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__asig_5p0`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD INOUT` (Analog Pass-through)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This cell is a **5.0V Analog Signal Pass-through**. Unlike digital GPIO pads, it provides a direct, low-resistance metal connection from the external bond pad to the internal core, bypassing digital buffers. It is typically used for connecting signals to ADCs, DACs, or other analog IP blocks.

## Pin Descriptions

### 1. Functional Signal
| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`ASIG5V`** | `INOUT` | `Metal2` | **Analog Signal**. This is the direct connection point for your analog signal. It connects the physical bond pad to the internal wire. |

> **Note:** There are no digital control pins (`OE`, `IE`, `CS`) because this is a passive analog connection.

### 2. Power Supply (Ring Continuity)
Even though this is an analog pad, it includes the standard power rail connections to maintain the continuity of the ESD and power rings around the chip.

| Pin Name | Direction | Domain | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). Passes through on `Metal3`, `Metal4`, `Metal5`. |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. Passes through on `Metal3`, `Metal4`, `Metal5`. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). Passes through on `Metal3`, `Metal4`, `Metal5`. |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. Passes through on `Metal3`, `Metal4`, `Metal5`. |

## Physical Information
* **Obstructions:** The cell has `OBS` (obstruction) definitions on layers `Nwell` and `Metal1` through `Metal5`. You cannot route over this cell; signals must connect only to the defined ports.
* **Antenna Info:** The `ASIG5V` pin has a defined antenna difference area of `1200.0`.