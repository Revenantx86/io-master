# IHP SG13G2 IO Library Reference

This document details the IO cells available in the `sg13g2` technology (IHP 130nm).

**General Specifications:**
* **Cell Height:** 180.00 µm
* **Site Name:** `sg13g2_ioSite`
* **Metal Layers:** Uses `Metal1` through `TopMetal2` for internal routing and obstructions.

---

## 1. Digital Signal Pads
These cells interface digital logic signals with the external world. They are categorized by direction and drive strength.

### 1.1 Bidirectional & Tri-State
*Cells capable of both input and output, or output with high-Z state.*

| Cell Name | Type | Drive | Pins | Description |
| :--- | :--- | :--- | :--- | :--- |
| **`sg13g2_IOPadInOut4mA`** | **In/Out** | 4mA | `c2p`, `p2c`, `c2p_en` | Bidirectional pad with 4mA output drive. |
| **`sg13g2_IOPadInOut16mA`** | **In/Out** | 16mA | `c2p`, `p2c`, `c2p_en` | Bidirectional pad with 16mA output drive. |
| **`sg13g2_IOPadInOut30mA`** | **In/Out** | 30mA | `c2p`, `p2c`, `c2p_en` | Bidirectional pad with 30mA output drive. |
| **`sg13g2_IOPadTriOut4mA`** | **Tri-State** | 4mA | `c2p`, `c2p_en` | Output-only pad with High-Z capability. |
| **`sg13g2_IOPadTriOut16mA`** | **Tri-State** | 16mA | `c2p`, `c2p_en` | Output-only pad with High-Z capability. |
| **`sg13g2_IOPadTriOut30mA`** | **Tri-State** | 30mA | `c2p`, `c2p_en` | Output-only pad with High-Z capability. |

**Signal Pin Definitions:**
* **`c2p`** (Input): **Core to Pad**. Data signal from the digital core to be driven out.
* **`p2c`** (Output): **Pad to Core**. Data signal from the external pad to the digital core.
* **`c2p_en`** (Input): **Output Enable**. Controls the output driver (likely High=Active, Low=High-Z, depending on specific logic implementation).

### 1.2 Input & Output Only
*Dedicated unidirectional pads.*

| Cell Name | Type | Drive | Pins | Description |
| :--- | :--- | :--- | :--- | :--- |
| **`sg13g2_IOPadIn`** | **Input** | N/A | `p2c` | Dedicated digital input pad. |
| **`sg13g2_IOPadOut4mA`** | **Output** | 4mA | `c2p` | Dedicated output pad. |
| **`sg13g2_IOPadOut16mA`** | **Output** | 16mA | `c2p` | Dedicated output pad. |
| **`sg13g2_IOPadOut30mA`** | **Output** | 30mA | `c2p` | Dedicated output pad. |

---

## 2. Analog & Special Pads

| Cell Name | Type | Description |
| :--- | :--- | :--- |
| **`sg13g2_IOPadAnalog`** | **Analog** | Direct connection to the pad for analog signals. Includes `padres` pin (likely ESD resistor protected path). |

---

## 3. Power Supply Pads
These pads supply power to the IO Ring (3.3V) and the Internal Core (1.2V/1.8V). All power pads maintain the continuity of all 4 rails (`iovdd`, `iovss`, `vdd`, `vss`).

| Cell Name | Connects PAD to... | Description |
| :--- | :--- | :--- |
| **`sg13g2_IOPadIOVdd`** | **`iovdd`** | Supplies the **IO Ring Power**. |
| **`sg13g2_IOPadIOVss`** | **`iovss`** | Supplies the **IO Ring Ground**. |
| **`sg13g2_IOPadVdd`** | **`vdd`** | Supplies the **Core Power**. |
| **`sg13g2_IOPadVss`** | **`vss`** | Supplies the **Core Ground**. |

**Rail Definitions:**
* **`iovdd` / `iovss`**: High voltage supply for the IO drivers.
* **`vdd` / `vss`**: Low voltage supply for the internal logic core.

---

## 4. Physical & Spacer Cells
These cells have no logic connection to the core but are required to build a physical ring.

### 4.1 Corner Cell
* **Macro:** `sg13g2_Corner`
* **Size:** 180µm × 180µm
* **Function:** Turns the 4 power rails 90 degrees at the chip corners. Required 4 times per chip.

### 4.2 Filler Cells
Used to fill gaps between pads to ensure power rail continuity.

| Cell Name | Width | Usage |
| :--- | :--- | :--- |
| **`sg13g2_Filler200`** | **1.000 µm** | Smallest filler. |
| **`sg13g2_Filler400`** | **2.000 µm** | Small gap filler. |
| **`sg13g2_Filler1000`** | **5.000 µm** | Medium gap filler. |
| **`sg13g2_Filler2000`** | **10.000 µm** | Large gap filler. |
| **`sg13g2_Filler4000`** | **20.000 µm** | Extra large filler. |
| **`sg13g2_Filler10000`** | **50.000 µm** | Huge filler for sparse padframes. |

---

## 5. Physical Layout Notes
* **Power Rails:** The library uses 4 continuous rails running horizontally through the cells: `iovdd`, `iovss`, `vdd`, and `vss`.
* **Pad Connection:** The physical bond pad metal (`pad` pin) is primarily on `TopMetal1` and `TopMetal2`, often stacked down to `Metal2`.
* **Obstructions:** All cells contain obstructions on `Metal1` through `TopMetal2` to prevent the autorouter from routing signals over the active IO circuitry.