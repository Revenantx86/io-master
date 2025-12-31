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

# gf180mcu_fd_io__brk5

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__brk5`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD` (Physical Spacer/Breaker)
* **Dimensions:** 5.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **5µm Power Breaker Cell**. It serves the same function as the `brk2` cell—isolating power domains within the ring—but provides a **wider physical gap (5µm)**. This wider spacing is often used to meet specific DRC requirements or to align pads to a specific grid pitch that a 2µm breaker cannot match.

## Pin Descriptions

### 1. Continuous Rails (Pass-Through)
This cell **maintains continuity** for the global ground rail.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VSS`** | `INOUT` | `Metal3`, `Metal4`, `Metal5` | **IO Ring Ground**. The High Voltage Ground rail is **continuous**. It connects ports on the left (0µm) to ports on the right (5µm), ensuring a common ground reference across the break. |

### 2. Broken Rails (Isolated)
The following pins are **NOT present** in this LEF definition, meaning the power rings are physically cut at this location:

* **`VDD` (IO Ring Power):** **BROKEN**.
* **`DVDD` (Core Power):** **BROKEN**.
* **`DVSS` (Core Ground):** **BROKEN**.

## Physical Information
* **Width:** 5.000 µm (Wider than the standard 2µm breaker).
* **Obstructions:**
    * `Metal1` & `Metal2`: Fully obstructed across the width of the cell.
    * `Metal3`, `Metal4`, `Metal5`: These layers have specific obstruction rectangles in the center of the cell (between x=1.0µm and x=4.0µm) to strictly enforce the power rail break and prevent accidental routing short-circuits.


# gf180mcu_fd_io__cor

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__cor`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `ENDCAP BOTTOMLEFT` (Corner Cell)
* **Dimensions:** 355.000 µm × 355.000 µm
* **Site:** `GF_COR_Site`

## Description
This is the **Corner Cell** required for the IO power ring assembly. It has no logical function (no signal pins) but is critical for physical design. It connects the horizontal power rails from one side of the chip to the vertical power rails of the adjacent side, turning the bus 90 degrees.

**You must instantiate exactly 4 of these cells** (one for each corner: NE, NW, SE, SW) to complete the power ring.

## Pin Descriptions

The cell contains only power and ground pins to maintain ring continuity. Note that because this is a corner cell, ports are located on two adjacent sides (e.g., Bottom and Right) to facilitate the 90-degree turn.

### 1. IO Ring Power (High Voltage)

| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring Power**. 3.3V/5.0V Supply. |
| **`VSS`** | `INOUT` | **IO Ring Ground**. High Voltage Ground. |

### 2. Core Power (Low Voltage)

| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | **Core Power**. 1.8V Supply. |
| **`DVSS`** | `INOUT` | **Core Ground**. Low Voltage Ground. |

## Physical Information
* **Layers:** Uses `Metal3`, `Metal4`, and `Metal5` for the heavy power bus routing.
* **Ports:** The pin definitions show a large number of rectangular ports. This complexity is due to the "L-shaped" nature of the corner connection, ensuring that metal tracks from the X-direction align perfectly with tracks from the Y-direction.
* **Obstructions:**
    * `Nwell`: Large block covering most of the active area (67µm to 350µm).
    * `Metal1` & `Metal2`: Almost entirely obstructed to prevent standard cell routing inside the corner area.
    * `Metal3/4/5`: Obstructed in specific patterns where the power rails are not present, forcing routers to only connect to the designated power ports.

# gf180mcu_fd_io__dvdd

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__dvdd`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD POWER`
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Core VDD Power Supply Pad**. It connects the external bond pad to the internal digital core power grid (typically **1.8V**). It is distinct from the IO Ring power pads because it supplies the voltage required by the standard cell logic inside the chip, rather than the voltage for the IO drivers.

## Pin Descriptions

### 1. Core Power Supply
These pins connect the external supply to the internal core power grid.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | `Metal2`, `3`, `4`, `5` | **Core Power (1.8V)**. This is the main function of the cell. It connects the large external `Metal5` pad area to the internal power distribution network. |
| **`DVSS`** | `INOUT` | `Metal3`, `4`, `5` | **Core Ground**. This rail passes through the cell to ensure continuity of the core ground grid around the ring. |

### 2. IO Ring Support
This cell connects to the IO Ground ring to provide a common reference for ESD protection structures.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. The High Voltage Ground rail passes through this cell to maintain ring continuity. |

> **Note:** This specific LEF definition **does not** contain a `VDD` (IO Ring Power / High Voltage) pin. This suggests that while it maintains the ground continuity (`VSS`), the High Voltage Power rail might be routed around it or is not logically defined as a connection point in this specific macro.

## Physical Information
* **Obstructions:**
    * `Nwell`: Blocks most of the cell area (3.060µm to 345.275µm).
    * `Metal1`: Fully obstructed to prevent routing beneath the pad.
    * `Metal2`: Obstructed in specific stripes, likely to reserve space for the internal power distribution straps (`DVDD` connections).
* **Port Geometry:** The power ports (`DVDD`, `DVSS`, `VSS`) are defined as multiple rectangles across `Metal3`, `Metal4`, and `Metal5` to maximize current carrying capacity and allow robust vertical and horizontal connections .

# gf180mcu_fd_io__dvss

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__dvss`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD POWER` (Ground)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Core VSS Ground Pad**. It connects the external bond pad to the internal digital core ground grid (0V).  It is the complementary pair to the `dvdd` cell. While it allows the high-voltage IO rings to pass through it, its primary purpose is to sink current from the standard cell logic (1.8V domain) to the external ground.

## Pin Descriptions

### 1. Core Power Supply
These pins connect the external supply to the internal core power grid.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVSS`** | `INOUT` | `Metal2`, `3`, `4`, `5` | **Core Ground (0V)**. This is the main function of the cell. It connects the pad to the internal ground distribution. Note the specific `Metal2` ports at the top of the cell (y=349.00) which likely tap into the core ground ring or substrate. |
| **`DVDD`** | `INOUT` | `Metal3`, `4`, `5` | **Core Power**. This rail passes through the cell to ensure continuity of the core power grid (`DVDD`) around the ring, even though this cell is a ground pad. |

### 2. IO Ring Support
This cell maintains the continuity of the high-voltage rings required for the GPIO pads.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. The High Voltage Ground rail passes through this cell. |
| **`VDD`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Power**. The High Voltage Power rail passes through this cell. |

## Physical Information
* **Obstructions:**
    * `Nwell`: Blocks most of the cell area (similar to `dvdd`).
    * `Metal1`: Fully obstructed to prevent routing beneath the pad.
    * `Metal2`: The layout differs slightly from `dvdd`. While `dvdd` had blockages, `dvss` has specific `Metal2` port rectangles defined at the very top edge (Y > 345µm), indicating where the core ground strap connects.
* **Layer Usage:** Utilizes the full stack (`Metal3`, `Metal4`, `Metal5`) for vertical power rails to handle high current density and minimize IR drop.


# gf180mcu_fd_io__fill1

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__fill1`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD SPACER` (Filler Cell)
* **Dimensions:** 1.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **1µm Filler Cell**. It is a mandatory physical-only cell used to fill small gaps between IO pads. Its primary function is to maintain the continuity of the power and ground rails (both Core and IO) around the ring . Without these fillers, the metal rails would have open circuits between adjacent pads.

## Pin Descriptions

The cell contains **no functional signals**. All pins are purely for power rail continuity. Since the cell is only 1µm wide, the ports typically span the entire width of the cell (x=0.000 to x=1.000) to connect the left neighbor directly to the right neighbor.

### 1. IO Ring Power (High Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Power**. 3.3V/5.0V supply rail pass-through. |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. High Voltage Ground rail pass-through. |

### 2. Core Power (Low Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | `Metal3`, `4`, `5` | **Core Power**. 1.8V supply rail pass-through. |
| **`DVSS`** | `INOUT` | `Metal3`, `4`, `5` | **Core Ground**. Low Voltage Ground rail pass-through. |

## Physical Information
* **Width:** 1.000 µm (Minimum width filler).
* **Layer Usage:** `Metal3`, `Metal4`, and `Metal5` are fully utilized for the power rails to ensure low resistance.
* **Obstructions:**
    * `Metal1`: Fully obstructed (-0.160 to 1.160) to prevent routing through the filler.
    * `Metal2`: Obstructed in the power rail region (246.000 to 325.000) to prevent shorts or DRC violations with the power buses.


# gf180mcu_fd_io__fill5

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__fill5`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD SPACER` (Filler Cell)
* **Dimensions:** 5.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **5µm Filler Cell**. Like the 1µm version, it is a physical-only cell used to fill gaps in the IO ring. It is wider (5µm) and is used when larger spaces need to be filled between pads. Its primary function is to maintain the continuity of all power and ground rails (both Core and IO) around the ring .

## Pin Descriptions

The cell contains **no functional signals**. All pins are for power rail continuity.

### 1. IO Ring Power (High Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Power**. 3.3V/5.0V supply rail pass-through. |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. High Voltage Ground rail pass-through. |

### 2. Core Power (Low Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | `Metal3`, `4`, `5` | **Core Power**. 1.8V supply rail pass-through. |
| **`DVSS`** | `INOUT` | `Metal3`, `4`, `5` | **Core Ground**. Low Voltage Ground rail pass-through. |

## Physical Information
* **Width:** 5.000 µm.
* **Layer Usage:** Similar to the 1µm filler, it uses `Metal3`, `Metal4`, and `Metal5` for power rails. The defined ports (RECTs) are wider (spanning roughly 1.000 to 4.000 or 0.000 to 5.000 depending on the rail) to handle the current across the wider gap.
* **Obstructions:**
    * `Metal1`: Fully obstructed to prevent routing.
    * `Metal2`: Obstructed in the power rail region (67.350 to 348.300) to prevent shorts.

# gf180mcu_fd_io__fill10

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__fill10`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD SPACER` (Filler Cell)
* **Dimensions:** 10.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **10µm Filler Cell**. It is the widest standard filler cell in this library subset. It is used to fill large gaps (10µm) between IO pads. Like the smaller fillers, its primary function is to bridge the power and ground rails (both Core and IO) between adjacent pads to form a continuous ring .

## Pin Descriptions

The cell contains **no functional signals**. The pins are defined as ports at the left and right edges of the cell to facilitate abutment with neighboring pads.

### 1. IO Ring Power (High Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Power**. 3.3V/5.0V supply rail. Ports are located at the edges (`x=0..1` and `x=9..10`) to connect left and right neighbors. |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. High Voltage Ground rail. |

### 2. Core Power (Low Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | `Metal3`, `4`, `5` | **Core Power**. 1.8V supply rail. |
| **`DVSS`** | `INOUT` | `Metal3`, `4`, `5` | **Core Ground**. Low Voltage Ground rail. |

## Physical Information
* **Width:** 10.000 µm.
* **Port Configuration:** unlike the 1µm filler which is all port, this cell defines ports specifically at the **left edge** (0.000 to 1.000) and the **right edge** (9.000 to 10.000) of the cell.
* **Obstructions:**
    * `Metal1`: Fully obstructed (-0.160 to 10.160).
    * `Metal2`: Obstructed in the power rail region (68.055 to 348.100).
    * `Metal3/4`: Specifically obstructed in the **center** of the cell (approx `x=1.3` to `8.7`) to ensure routers do not try to drop vias or route signals through the internal power bus structure.

# gf180mcu_fd_io__fillnc

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__fillnc`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD SPACER` (Filler Cell)
* **Dimensions:** 0.100 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Non-Critical (NC) Filler Cell**. It is the smallest possible filler cell with a width of just **0.1µm**. It is typically used for very fine placement adjustments to close gaps that are too small for the standard 1µm filler. Like all filler cells, its purpose is to maintain the continuity of the power and ground rails.

## Pin Descriptions

The cell contains **no functional signals**. The pins are purely for power rail continuity and span the entire width of the cell (0.000 to 0.100).

### 1. IO Ring Power (High Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Power**. 3.3V/5.0V supply rail pass-through. |
| **`VSS`** | `INOUT` | `Metal3`, `4`, `5` | **IO Ring Ground**. High Voltage Ground rail pass-through. |

### 2. Core Power (Low Voltage)

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`DVDD`** | `INOUT` | `Metal3`, `4`, `5` | **Core Power**. 1.8V supply rail pass-through. |
| **`DVSS`** | `INOUT` | `Metal3`, `4`, `5` | **Core Ground**. Low Voltage Ground rail pass-through. |

## Physical Information
* **Width:** 0.100 µm (Extremely narrow).
* **Usage:** Often used by Place & Route tools as a "filler of last resort" to fix DRC spacing violations or fill tiny remaining gaps in the IO ring.
* **Obstructions:**
    * `Metal1`: Fully obstructed to prevent routing.
    * `Metal2`: Obstructed in the power rail region (246.000 to 325.000).

# gf180mcu_fd_io__in_c

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__in_c`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD INPUT` (Input Only)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Standard Input-Only Pad**. It is optimized for receiving digital signals from the outside world. Because it lacks output drivers, it typically has lower capacitance and consumes less area/power than a bidirectional pad. The `_c` likely denotes a standard CMOS input buffer.

## Pin Descriptions

### 1. Digital Signal Interface
Unlike bidirectional pads, this cell has no `A`, `OE`, or `IE` pins. It purely drives a signal *into* the core.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`Y`** | `OUTPUT` | `Metal2` | **Data Output**. The signal read *from* the pad going into the chip's internal core logic. |
| **`PD`** | `INPUT` | `Metal2` | **Pull-Down Enable**. Active high signal to enable an internal pull-down resistor. |
| **`PU`** | `INPUT` | `Metal2` | **Pull-Up Enable**. Active high signal to enable an internal pull-up resistor. |

### 2. Physical Interface
| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PAD`** | `INPUT` | **Physical Pad**. The metal bond pad (`Metal5`) connecting to the package. Note the direction is `INPUT`, unlike bidirectional pads which are `INOUT`. |

### 3. Power Supply (Ring Continuity)
The pad maintains power ring continuity for both Core and IO domains.

| Pin Name | Direction | Domain | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. |

## Physical Information
* **Antenna Info:**
    * `PAD`: Diff Area 258.72 (Same as the standard bidirectional pad, suggesting the ESD diode structure is likely identical).
    * `PD` / `PU`: Gate Area 10.5 / 7.35 respectively.
* **Layout:** Uses the standard 75µm width and maintains all power rail positions (`Metal3-5`), making it fully compatible with the standard IO ring pitch.

# gf180mcu_fd_io__in_s

## Cell Information
* **Macro Name:** `gf180mcu_fd_io__in_s`
* **Library:** `gf180mcu_fd_io` (Foundation IO)
* **Type:** `PAD INPUT` (Input Only)
* **Dimensions:** 75.000 µm × 350.000 µm
* **Site:** `GF_IO_Site`

## Description
This is the **Schmitt Trigger Input-Only Pad**.  It is structurally similar to the standard CMOS input pad (`_in_c`) but includes a Schmitt trigger circuit on the input buffer. This provides **hysteresis**, making it ideal for receiving slow-rising signals or noisy inputs (like reset buttons or external clocks) where clean logic transitions are required.

## Pin Descriptions

### 1. Digital Signal Interface
This cell drives a signal *into* the core.

| Pin Name | Direction | Layer | Function |
| :--- | :--- | :--- | :--- |
| **`Y`** | `OUTPUT` | `Metal2` | **Data Output**. The clean digital signal read *from* the pad going into the chip's internal core logic. |
| **`PD`** | `INPUT` | `Metal2` | **Pull-Down Enable**. Active high signal to enable an internal pull-down resistor. |
| **`PU`** | `INPUT` | `Metal2` | **Pull-Up Enable**. Active high signal to enable an internal pull-up resistor. |

### 2. Physical Interface
| Pin Name | Direction | Function |
| :--- | :--- | :--- |
| **`PAD`** | `INPUT` | **Physical Pad**. The metal bond pad (`Metal5`) connecting to the package. |

### 3. Power Supply (Ring Continuity)
The pad maintains power ring continuity for both Core and IO domains.

| Pin Name | Direction | Domain | Function |
| :--- | :--- | :--- | :--- |
| **`VDD`** | `INOUT` | **IO Ring** | High Voltage Supply (3.3V / 5.0V). |
| **`VSS`** | `INOUT` | **IO Ring** | High Voltage Ground. |
| **`DVDD`** | `INOUT` | **Core** | Low Voltage Supply (1.8V). |
| **`DVSS`** | `INOUT` | **Core** | Low Voltage Ground. |

## Physical Information
* **Antenna Info:**
    * `PAD`: Diff Area 258.72 (Identical to `_in_c` and `_bi_t`).
    * `PD` / `PU`: Gate Area 10.5 / 7.35 respectively.
* **Layout:** Uses the standard 75µm width and maintains all power rail positions (`Metal3-5`), allowing it to be swapped freely with `_in_c` or `_bi_t` pads without changing the ring floorplan.
