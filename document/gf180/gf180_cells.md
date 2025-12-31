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



# gf180mcu_fd_io__bi_24t

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__bi_24t`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD INOUT` (Bidirectional)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **High-Drive Strength Bidirectional GPIO** pad. It functions similarly to the standard digital pad but is capable of sinking/sourcing significantly higher current (typically **24mA**). It is designed for driving heavy loads such as LEDs, long transmission lines, or high-capacitance off-chip traces.

## Pin Descriptions

### 1. Digital Signal Interface
These pins connect to the internal digital core of the chip.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`A`** | `INPUT` | `Metal2` | **Data Input**. The signal coming *from* the core to be driven out to the pad. |
| **`Y`** | `OUTPUT` | `Metal2` | **Data Output**. The signal read *from* the pad going into the core. |
| **`OE`** | `INPUT` | `Metal2` | **Output Enable**. High = Drive `A` to Pad. Low = Input mode (High-Z). |
| **`IE`** | `INPUT` | `Metal2` | **Input Enable**. High = Enable input buffer (value appears on `Y`). |
| **`CS`** | `INPUT` | `Metal2` | **Chip Select**. Active control to enable the pad interface. |

### 2. Configuration Control
These inputs configure the electrical characteristics of the pad.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`PU`** | `INPUT` | `Metal2` | **Pull-Up Enable**. Activates internal pull-up resistor. |
| **`PD`** | `INPUT` | `Metal2` | **Pull-Down Enable**. Activates internal pull-down resistor. |
| **`SL`** | `INPUT` | `Metal2` | **Slew Rate**. Selects fast or slow edge rates. |

> **Note:** Unlike the `ef` library version, this `fd` macro does *not* expose `PDRV` (drive strength) pins in this LEF definition, implying the drive strength is fixed at the high (24mA) level or handled differently in this subset.

### 3. Physical Interface
| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PAD`** | `INOUT` | **Physical Pad**. The large metal bond pad (`Metal5`) connecting to the package. |

### 4. Power Supply (Ring Continuity)
The pad maintains power ring continuity for both Core and IO domains.

| Pin Name | Direction | Domain | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. |

## Physical Information
* **Antenna Info:**
    * `A`: Gate Area 4.2, Diff Area 1.0
    * `PAD`: Diff Area 335.28 (Significantly larger than standard pads due to larger driver transistors).
* **Obstructions:** Contains standard `Nwell` and `Metal1-5` obstructions to preventing routing over the active circuitry.


# gf180mcu_fd_io__bi_t

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__bi_t`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD INOUT` (Bidirectional)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Standard Bidirectional GPIO** pad from the Foundation library. It is the most commonly used pad for general-purpose digital I/O. Unlike the High-Drive (`24t`) version, this cell exposes drive strength configuration pins (`PDRV`), allowing you to dynamically adjust the output current capability.

## Pin Descriptions

### 1. Digital Signal Interface
These pins connect to the internal digital core of the chip.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`A`** | `INPUT` | `Metal2` | **Data Input**. The signal coming *from* the core to be driven out to the pad. |
| **`Y`** | `OUTPUT` | `Metal2` | **Data Output**. The signal read *from* the pad going into the core. |
| **`OE`** | `INPUT` | `Metal2` | **Output Enable**. High = Drive `A` to Pad. Low = Input mode (High-Z). |
| **`IE`** | `INPUT` | `Metal2` | **Input Enable**. High = Enable input buffer (value appears on `Y`). |
| **`CS`** | `INPUT` | `Metal2` | **Chip Select**. Enables the pad interface. |

### 2. Configuration Control
These inputs configure the electrical characteristics of the pad.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`PDRV0`** | `INPUT` | `Metal2` | **Drive Strength Bit 0**. |
| **`PDRV1`** | `INPUT` | `Metal2` | **Drive Strength Bit 1**. Controls output current (e.g., 4mA, 8mA, etc.). |
| **`PU`** | `INPUT` | `Metal2` | **Pull-Up Enable**. Activates internal pull-up resistor. |
| **`PD`** | `INPUT` | `Metal2` | **Pull-Down Enable**. Activates internal pull-down resistor. |
| **`SL`** | `INPUT` | `Metal2` | **Slew Rate**. Selects fast or slow edge rates to manage noise/EMI. |

### 3. Physical Interface
| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PAD`** | `INOUT` | **Physical Pad**. The large metal bond pad (`Metal5`) connecting to the package. |

### 4. Power Supply (Ring Continuity)
The pad maintains power ring continuity for both Core and IO domains.

| Pin Name | Direction | Domain | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. |

## Comparison Notes
* **Vs. `ef_io__bi_t`:** This `fd` version lacks the `ANA` (Analog Pass-through) pin found in the `ef` (Extra Features) version.
* **Vs. `fd_io__bi_24t`:** This standard version includes `PDRV` pins for adjustable drive strength, whereas the `24t` version (in the previous LEF) had fixed high drive strength.

## Physical Information
* **Antenna Info:**
    * `A`: Gate Area 4.2, Diff Area 1.0.
    * `PAD`: Diff Area 258.72 (Smaller than the high-drive version).
* **Layers:** Uses `Metal2` for logic connections and `Metal3/4/5` for power rail distribution.

# gf180mcu_fd_io__brk2

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__brk2`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD` (Physical Spacer/Breaker)
* **Dimensions:** 2.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is a **2µm Power Breaker Cell**. It is inserted into the IO ring to physically break the continuity of specific power rails. This allows the creation of isolated voltage domains (e.g., separating noisy Digital IO power from sensitive Analog IO power) while maintaining a common ground reference.

## Pin Descriptions

### 1. Continuous Rails (Pass-Through)
This cell **maintains continuity** for the following rail. The metal connection exists and passes through the cell.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VSS`** | `INOUT` | `Metal3`, `Metal4`, `Metal5` | **IO Ring Ground**. The High Voltage Ground rail is **continuous** through this breaker. This ensures a common ESD discharge path and ground reference across domains. |

### 2. Broken Rails (Isolated)
The following pins are **NOT present** in this LEF definition. Therefore, these rails are **cut (discontinued)** at this cell location:

* **`VDD` (IO Ring Power):** **BROKEN**. 3.3V/5.0V power does not pass through.
* **`DVDD` (Core Power):** **BROKEN**. 1.8V core power does not pass through.
* **`DVSS` (Core Ground):** **BROKEN**. 1.8V core ground does not pass through.

> **Design Note:** Use this cell when you need separate VDD supplies but want to keep a unified VSS (Common Ground) on the IO ring.

## Physical Information
* **Width:** Very narrow (2.000 µm).
* **Obstructions:**
    * `Metal1`: Blocked explicitly to prevent routing through the gap.
    * `Metal2`: Blocked explicitly.
    * Higher metals (M3/M4/M5) are not obstructed generally, but since there are no ports defined for VDD/DVDD/DVSS, standard routers will not try to connect those specific nets across this gap.