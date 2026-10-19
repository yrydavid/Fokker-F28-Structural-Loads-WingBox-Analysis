# Fokker F28 Fellowship (Mk 4000): Structural Flight Loads, Wing-Box Sizing & Elastic Stability

A computational aerospace structures and flight loads engineering suite developed in **MATLAB** for the **Fokker F28 Fellowship Mk 4000** twin-turbofan regional jet airliner.

This repository covers the complete structural analysis, internal effort integration, and preliminary wing-box sizing workflow in accordance with **FAR 25 / CS-25** airworthiness regulations:
1. **Weight & Balance Breakdown & Center of Gravity (CG) Positioning** using empirical Raymer/Torenbeek structural mass estimation formulas.
2. **Aerodynamic Surface Parameterization & Compressible Subsonic Corrections** ($M_c = 0.74$) for the main wing, T-tail horizontal stabilizer (HTP), and vertical stabilizer (VTP).
3. **Flight Maneuver & Gust Envelope (V-n Diagram) & Tailplane Dynamic Loads** under abrupt/checked elevator pitch maneuvers, abrupt rudder yaw maneuvers, and landing gear impact cases.
4. **Spanwise Wing Load Distribution (Diederich Method) & Internal Sectional Efforts** computing Shear Force $T_z(y)$, Bending Moment $M_x(y)$, Distributed Torque $m_t(y)$, and Torsion Moment $M_t(y)$.
5. **Preliminary Wing-Box Structural Sizing & Post-Buckling Elastic Stability** for the **Al 2024-T3** duralumin primary structure (spars, stringers, stressed skin, and Von Kármán effective width verification).

---

## Aircraft Technical Baseline (Fokker F28 Mk 4000)

| Parameter | Symbol | Value | Unit |
| :--- | :---: | :---: | :---: |
| Maximum Takeoff Weight (MTOW) | $m_{\text{MTOW}}$ | 33,110 | $\text{kg}$ |
| Operating Empty Weight (Detailed Estimation) | $G_{\text{empty}}$ | 17,611 | $\text{daN}$ |
| Empty Aircraft Center of Gravity | $X_{\text{CG,empty}}$ | 15.33 | $\text{m}$ |
| Fuselage Overall Length / Height | $L_{\text{tot}} \text{ / } H_{\text{tot}}$ | 29.61 / 8.47 | $\text{m}$ |
| Main Wing Span / Semi-Span | $2b \text{ / } b$ | 25.07 / 12.54 | $\text{m}$ |
| Main Wing Reference Area | $S$ | 79.00 | $\text{m}^2$ |
| Wing Aspect Ratio / Quarter-Chord Sweep | $\lambda_a \text{ / } \chi_{0.25}$ | 7.95 / $16^\circ$ | $-$ |
| Wing Mean Geometric / Aerodynamic Chord | $\text{CMG} \text{ / } \text{CMA}$ | 3.15 / 3.48 | $\text{m}$ |
| Horizontal Tailplane (HTP) Area / Span | $S_{ao} \text{ / } b_{ao}$ | 19.30 / 8.64 | $\text{m}^2 \text{ / m}$ |
| Vertical Tailplane (VTP) Area | $S_{av}$ | 12.30 | $\text{m}^2$ |
| Powerplant (2x Rolls-Royce Spey Mk 555-15H) | $T_0$ | $2 \times 43.90$ | $\text{kN}$ |
| High-Altitude Cruise Mach Number ($H = 10,000\text{ m}$) | $M_c$ | 0.74 | $-$ |
| Structural Design Cruise Speed ($H = 1,500\text{ m}$) | $V_C$ | 224.00 | $\text{m/s}$ |
| Design Stall / Maneuvering / Dive Speeds | $V_S \text{ / } V_A \text{ / } V_D$ | 73.95 / 116.92 / 280.00 | $\text{m/s}$ |
| Limit Maneuver Load Factors (FAR 25) | $n_1 \text{ / } n_2$ | $+2.50 \text{ / } -1.00$ | $\text{g}$ |

---

## Repository Structure

| File / Directory | Engineering Module & Technical Description |
| :--- | :--- |
| `naca_0014_40Ymod.m` | **Aerodynamics:** Wing root modified symmetrical airfoil generator ($t/c = 14\%$, max thickness at $40\%c$) |
| `NACA_64A012.m` | **Aerodynamics:** Horizontal tailplane (HTP) laminar symmetrical airfoil generator ($t/c = 12\%$) |
| `naca_0015_40Ymod.m` | **Aerodynamics:** Vertical tailplane (VTP) modified high-speed airfoil generator ($t/c = 15\%$) |
| `DISTRIBUTIA_FACTORULUI_DE_SARCINA_LOCAL.m` | **Flight Loads:** Longitudinal load factor distribution $n(x')$ under abrupt elevator deflection ($\Delta\beta_{\max} = +25^\circ / -20^\circ$) |
| `MANEVRA_CONTROLATA_DE_PROFUNDOR.m` | **Flight Loads:** Longitudinal inertia and load factor distribution during checked pitch maneuver ($n_1 = 2.5$) |
| `DISTRIBUTIA_FACTORULUI_DE_SARCINA_LATERAL_n_y.m` | **Flight Loads:** Lateral load factor distribution $n_y(x')$ under abrupt rudder yaw input ($\Delta\beta_{\max} = \pm 25^\circ$) |
| `REPARTITIA_SARCINILOR_AERODINAMICE_SI_MASICE.m` | **Wing Loads:** Diederich spanwise aerodynamic lift $p_a(y)$, structural weight $-p_g(y)$, and fuel relief $-p_{gc}(y)$ |
| `generarea_diagramei_fortei_taietoare_Tzy.m` | **Sectional Efforts:** Piecewise analytical integration of spanwise wing shear force $T_z(y)$ |
| `generarea_diagramei_momentului_incovoietor_Mxy.m` | **Sectional Efforts:** Piecewise analytical integration of spanwise wing bending moment $M_x(y)$ |
| `generarea_diagramei_momentului_de_torsiune_repartizat_mty.m` | **Sectional Efforts:** Spanwise distributed torsional moment $m_t(y)$ about the $40\%c$ elastic axis |
| `diagrama_momentului_de_torsiune_Mty.m` | **Sectional Efforts:** Piecewise analytical integration of total wing torsion moment $M_t(y)$ |
| `figures/` | Directory containing all 11 high-resolution MATLAB validation plots (`.png`) |
| `README.md` | Complete mathematical formulation and structural engineering documentation |

---

## 1. Weight & Balance & Aerodynamic Surface Parameterization

### Detailed Mass Breakdown & Empty Weight Center of Gravity
Using detailed component-level statistical sizing equations (accounting for ultimate load factor $N_z = 3.75$, aspect ratio, sweep, and taper ratio), the Operating Empty Weight is established at $G_{\text{empty}} = 17,611\text{ daN}$:

| Structural Component | Mass Estimation $G_i$ [daN] | Longitudinal Station $X_i$ [m] | Static Moment $G_i X_i$ [daN$\cdot$m] | Offset $x_i = X_i - X_{\text{CG}}$ [m] |
| :--- | :---: | :---: | :---: | :---: |
| **Main Wing** | 2,396 | 14.50 | 34,742 | $-0.83$ |
| **Fuselage Structure** | 7,397 | 14.00 | 103,558 | $-1.33$ |
| **Horizontal Tailplane (HTP)** | 234 | 28.50 | 6,669 | $+13.17$ |
| **Vertical Tailplane (VTP)** | 334 | 27.00 | 9,018 | $+11.67$ |
| **Propulsion Group (2x Spey)** | 2,990 | 23.00 | 68,770 | $+7.67$ |
| **Main Landing Gear** | 1,159 | 15.50 | 17,964 | $+0.17$ |
| **Nose Landing Gear** | 265 | 3.50 | 927 | $-11.83$ |
| **Systems & Equipment** | 2,836 | 10.00 | 28,360 | $-5.33$ |
| **Total Empty Aircraft** | **17,611** | **$X_{\text{CG}} = 15.33\text{ m}$** | **270,008** | $-$ |

### Airfoil Geometry & Compressible Subsonic Aerodynamics ($M_c = 0.74$)
To delay transonic drag divergence and shock-induced buffet at $M_c = 0.74$ ($H = 10,000\text{ m}$, $a = 299.53\text{ m/s}$), the Fokker F28 utilizes modified symmetrical sections with maximum thickness shifted aft to $40\%c$, paired with a laminar NACA 64A-series T-tail stabilizer:
* **Main Wing:** `NACA 0014 40Y mod` at root ($t/c = 14\%$) tapering to `NACA 0010 40Y mod` at tip ($t/c = 10\%$).
* **Horizontal Tailplane (HTP):** `NACA 64A012` ($t/c = 12\%$), minimizing center-of-pressure shift at high subsonic speeds.
* **Vertical Tailplane (VTP):** `NACA 0015 40Y mod` ($t/c = 15\%$).

Applying Prandtl-Glauert compressibility corrections ($\beta = \sqrt{1 - M^2}$, equivalent sweep $\chi_e = \arctan(\tan\chi / \beta)$), the 3D lift-curve slopes and aerodynamic coefficients are:

$$C_z^\alpha\Big\vert{}_{\text{Wing}} = 5.71\text{ rad}^{-1}, \quad C_z^\alpha\Big\vert{}_{\text{HTP}} = 4.12\text{ rad}^{-1}, \quad C_z^\alpha\Big\vert{}_{\text{VTP}} = 3.67\text{ rad}^{-1}, \quad \frac{dC_z}{d\alpha}\Big\vert{}_{\text{Aircraft}} = 6.722\text{ rad}^{-1}$$

<p align="center">
  <img src="figures/airfoil_wing_root_naca0014.png" width="32%" alt="Wing Root NACA 0014 40Y mod">
  <img src="figures/airfoil_htp_naca64a012.png" width="32%" alt="HTP NACA 64A012">
  <img src="figures/airfoil_vtp_naca0015.png" width="32%" alt="VTP NACA 0015 40Y mod">
</p>

---

## 2. Flight Envelope (V-n Diagram) & Tailplane Maneuver Loads

At structural calculation altitude $H = 1,500\text{ m}$ ($\rho = 1.058\text{ kg/m}^3$, $T = 278.4\text{ K}$), the maneuver and linear progressive gust envelope ($\eta_G = 0.796$, mass parameter $\mu_G = 50.21$) yields the following load factors:
* **At Design Maneuvering Speed ($V_B / V_A = 116.92\text{ m/s}$, $w_0 = 20\text{ m/s}$):** $n = 1 \pm 0.45 \implies (+1.45\text{ g}, +0.55\text{ g})$.
* **At Design Cruise Speed ($V_C = 224.00\text{ m/s}$, $w_0 = 15\text{ m/s}$):** $n = 1 \pm 1.55 \implies (+2.55\text{ g}, -0.55\text{ g})$.
* **At Design Dive Speed ($V_D = 280.00\text{ m/s}$, $w_0 = 7.5\text{ m/s}$):** $n = 1 \pm 0.35 \implies (+1.35\text{ g}, +0.65\text{ g})$.

### Longitudinal Maneuver Loads on Horizontal Tailplane (HTP)
1. **Abrupt Elevator Deflection at $V_A = 116.92\text{ m/s}$ ($\Delta\beta_{\max}^+ = +25^\circ$, $\Delta\beta_{\max}^- = -20^\circ$):**
   * Incremental HTP aerodynamic loads: $\Delta P_{ao}^+ = +84,056\text{ N}$ and $\Delta P_{ao}^- = -67,256\text{ N}$.
   * Pitching moments ($L_{ao} = 11.5\text{ m}$): $\Delta M_y^+ = -966,642\text{ Nm}$ and $\Delta M_y^- = +773,446\text{ Nm}$.
   * Pitching angular accelerations ($J_y = 1.81 \times 10^6\text{ kg}\cdot\text{m}^2$, $r_y = 7.4\text{ m}$): $\varepsilon_y^+ = -0.534\text{ rad/s}^2$, $\varepsilon_y^- = +0.427\text{ rad/s}^2$.
   * Local load factor distribution along fuselage station $x' \in [0, 29.61]\text{ m}$ ($x_{\text{CG}} = 13.5\text{ m}$):

$$n^\pm(x') = 1 + \frac{\Delta P_{ao}^\pm}{G} \left[ 1 + \frac{L_{ao}(x' - x_{\text{CG}})}{r_y^2} \right]$$

2. **Checked Elevator Pitch Maneuver ($n_1 = 2.5$):**
   * Pitch angular acceleration and balancing tail load:

$$\varepsilon_y = \frac{20}{V_A} n_1 (n_1 - 1.5) = 0.4276\text{ rad/s}^2 \implies \Delta P_{ao} = -\frac{G}{g} \frac{r_y^2}{L_{ao}} \varepsilon_y = -67,423\text{ N}$$

$$n(x') = 1 - \frac{\varepsilon_y}{g} \left[ \frac{r_y^2}{L_{ao}} + (x' - x_{\text{CG}}) \right]$$

### Directional Maneuver Loads on Vertical Tailplane (VTP) & Landing Loads
* **Abrupt Rudder Deflection ($\Delta\beta_{\max}^\pm = \pm 25^\circ$ at $V_A$):** Generates incremental VTP lateral force $\Delta P_{av}^\pm = \pm 55,626\text{ N}$, roll moment $\Delta M_x^+ = -178,004\text{ Nm}$, yaw moment $\Delta M_z^+ = +639,703\text{ Nm}$, roll acceleration $\varepsilon_x^\pm = \mp 0.274\text{ rad/s}^2$ ($r_x = 4.43\text{ m}$), and yaw acceleration $\varepsilon_z^\pm = \pm 0.328\text{ rad/s}^2$ ($r_z = 7.67\text{ m}$).
* **Landing Gear Impact ($n_{at} = 2.667$, lift fraction $L = 0.667$, friction $\mu = 0.33$):**
  * **Two-Point Main Gear Landing:** Vertical reaction $Rz_{tp} = 649,618\text{ N}$, drag reaction $Rx_{tp} = 214,374\text{ N}$, pitch-down angular acceleration $\varepsilon_y = 0.691\text{ rad/s}^2$.
  * **Three-Point Landing:** Nose gear vertical reaction $Rz_{tb} = 69,660\text{ N}$ ($Rx_{tb} = 22,969\text{ N}$), main gear vertical reaction $Rz_{tp} = 580,016\text{ N}$ ($Rx_{tp} = 191,405\text{ N}$).

<p align="center">
  <img src="figures/load_factor_abrupt_elevator.png" width="32%" alt="Abrupt Elevator Load Factor">
  <img src="figures/load_factor_checked_elevator.png" width="32%" alt="Checked Elevator Load Factor">
  <img src="figures/lateral_load_factor_rudder.png" width="32%" alt="Lateral Load Factor Rudder">
</p>

---

## 3. Spanwise Wing Loads & Sectional Internal Efforts ($T_z, M_x, M_t$)

### Diederich Spanwise Aerodynamic & Inertial Load Distribution
Spanwise lift distribution across the semi-span ($b = 12.54\text{ m}$, total wing lift $P_a = 827,650\text{ N}$, wing pitching moment $M_{Fa} = -2,097.31\text{ kNm}$) is resolved via the **Diederich method** ($C_1 = 0.50, C_2 = 0.16, C_3 = 0.38$):

$$L_a(\eta) = C_1 \frac{c(\eta)}{\text{CMG}} + C_2 \frac{4}{\pi}\sqrt{1 - \eta^2} + C_3 f(\eta), \quad p_a(y) = \frac{P_a}{2b} L_a(\eta)$$

Inertial relief from the wing structure ($m_a = 3,600\text{ kg} \implies p_g = 1,118\text{ N/m}$) and integral fuel tanks ($m_c = 8,000\text{ kg} \implies p_{gc} = 6,330.7\text{ N/m}$) counteracts aerodynamic bending. Following standard instructional structural sizing methodology, discrete inertial relief from concentrated powerplant and main landing gear masses ($N_M = 27.21\text{ kN}$, $N_{TP} = 42.26\text{ kN}$) is modeled at spanwise station $y_{MT} = 3.20\text{ m}$.

<p align="center">
  <img src="figures/wing_distributed_loads.png" width="680" alt="Spanwise Distributed Aerodynamic and Mass Loads">
</p>

### Piecewise Analytical Integration across 4 Wing Intervals
The semi-span is partitioned into four structural domains:
* **Interval 1 ($8.50 \le y \le 12.54\text{ m}$):** Outboard wing tip (aerodynamic lift $p_a(y)$ + structural mass relief $-p_g$).
* **Interval 2 ($3.20 \le y \le 8.50\text{ m}$):** Integral fuel tank bay (adds distributed fuel inertial relief $-p_{gc}$).
* **Interval 3 ($1.65 \le y \le 3.20\text{ m}$):** Inboard of nacelle/landing gear station (incorporates discrete shear step $\Delta T_z = -69.47\text{ kN}$ and concentrated torque step $M_{t,MT} = -9.01\text{ kNm}$).
* **Interval 4 ($0 \le y \le 1.65\text{ m}$):** Wing-fuselage carry-through root section.

$$T_z(y) = \int_y^{12.54} q_{\text{net}}(\xi)\,d\xi, \quad M_x(y) = \int_y^{12.54} T_z(\xi)\,d\xi, \quad M_t(y) = \int_y^{12.54} m_t(\xi)\,d\xi$$

| Spanwise Station $y$ [m] | Structural Location | Shear Force $T_z$ [kN] | Bending Moment $M_x$ [kNm] | Torsion Moment $M_t$ [kNm] |
| :---: | :--- | :---: | :---: | :---: |
| **12.54** | Wing Tip | 0.00 | 0.00 | 0.00 |
| **8.50** | Outboard Fuel Tank Boundary | 92.48 | 161.51 | 18.89 |
| **3.20 (+)** | Outboard of Landing Gear / Nacelle | 243.07 | 1,033.39 | 183.37 |
| **3.20 (-)** | Inboard of Landing Gear / Nacelle | 173.60 | 1,033.39 | 192.39 |
| **1.65** | Wing-Fuselage Root Junction | 223.02 | 1,340.61 | 210.89 |
| **0.00** | Aircraft Centerline (Max Root Load) | **286.97** | **1,761.29** | **231.02** |

<p align="center">
  <img src="figures/wing_shear_force_Tz.png" width="48%" alt="Wing Shear Force Diagram">
  <img src="figures/wing_bending_moment_Mx.png" width="48%" alt="Wing Bending Moment Diagram">
</p>

<p align="center">
  <img src="figures/wing_distributed_torque_mt.png" width="48%" alt="Distributed Torque Diagram">
  <img src="figures/wing_torsion_moment_Mt.png" width="48%" alt="Wing Torsion Moment Diagram">
</p>

---

## 4. Wing-Box Structural Sizing & Post-Buckling Elastic Stability

The primary wing-box structure is designed using **Al 2024-T3** duralumin ($\sigma_R^+ = 440\text{ MPa}$, $\sigma_{cc} = 315\text{ MPa}$, $\tau_{\text{adm}} = 220\text{ MPa}$, $E = 73\text{ GPa}$, $\nu = 0.3$, $\rho = 2,780\text{ kg/m}^3$) in a two-spar torsion-box layout positioned at $15\%c$ ($h_1 = 0.6075\text{ m}$) and $65\%c$ ($h_2 = 0.5346\text{ m}$), with structural box width $\Delta = 2.25\text{ m}$ and enclosed cell area $\Omega = 1.2849\text{ m}^2$.

### Root Section Preliminary Sizing ($k = 0.5$ Bending Split, Safety Factor $SF = 1.5$)
* **Ultimate Root Design Loads:** $T_{zU} = 430.46\text{ kN}$, $M_{xU} = 2,641.94\text{ kNm}$, $M_{tU} = 186.44\text{ kNm}$ (corresponding to limit root design torque $M_{tL} = 124.30\text{ kNm}$).
* **Front Spar (Spar 1):** Tension flange area $A_{T1}^+ = 4,408.55\text{ mm}^2$ ($\sigma_1^+ = 293.33\text{ MPa} < 440\text{ MPa}$); Compression flange area $A_{T1}^- = 10,263.28\text{ mm}^2$ ($\sigma_1^- = 126.00\text{ MPa} < 315\text{ MPa}$); Web thickness $\delta_1 = 2.54\text{ mm}$ ($q_{U1}^* = 557.80\text{ kN/m}$).
* **Rear Spar (Spar 2):** Tension flange area $A_{T2}^+ = 3,879.52\text{ mm}^2$ ($\sigma_2^+ = 258.13\text{ MPa} < 440\text{ MPa}$); Compression flange area $A_{T2}^- = 9,031.69\text{ mm}^2$ ($\sigma_2^- = 110.88\text{ MPa} < 315\text{ MPa}$); Web thickness $\delta_2 = 2.19\text{ mm}$ ($q_{U2}^* = 481.33\text{ kN/m}$).
* **Stiffened Upper Skin Panel ($N^- = 4$ stringers, pitch $b_l = 450\text{ mm}$, rib spacing $a = 900\text{ mm}$):**
  * Initial buckling skin thickness $\delta_1 = 4.31\text{ mm}$ with stringer area $A_{\text{lise}}^- = 1,454.26\text{ mm}^2$.
  * Adopted working skin thickness $\delta^- = 11.0\text{ mm}$, yielding a Von Kármán effective working panel area $A_{\text{panou}}^- = 26,597.48\text{ mm}^2 \ge 12,239.31\text{ mm}^2$ (Verified).

### Post-Buckling & Elastic Stability Verification
For the upper compression skin panel ($a = 0.90\text{ m}$, $b = 0.45\text{ m}$, $\delta = 11\text{ mm}$, wing-box moment of inertia $I_x = 0.02293\text{ m}^4$):

$$\sigma_{\text{cr}} = \frac{k_\sigma \pi^2 E}{12(1 - \nu^2)} \left(\frac{\delta}{b}\right)^2, \quad \tau_{\text{cr}} = \frac{k_\tau \pi^2 E}{12(1 - \nu^2)} \left(\frac{\delta}{b}\right)^2$$

| Stability Mode | Boundary Condition | Buckling Coeff. | Critical Buckling Stress | Operating Limit Stress | Status |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Compressive Buckling** | Simply Supported (4 edges) | $k_\sigma = 4.00$ | $\sigma_{\text{cr},1} = 157.70\text{ MPa}$ | $\sigma_{\text{ef}} = 24.20\text{ MPa}$ | **STABLE** |
| **Compressive Buckling** | Clamped Loaded Edges | $k_\sigma = 7.00$ | $\sigma_{\text{cr},2} = 275.97\text{ MPa}$ | $\sigma_{\text{ef}} = 24.20\text{ MPa}$ | **STABLE** |
| **Shear Buckling** | Simply Supported (4 edges) | $k_{\tau,1} = 6.35$ | $\tau_{\text{cr},1} = 250.34\text{ MPa}$ | $\tau_{SL} = 4.40\text{ MPa}$ | **STABLE** |
| **Shear Buckling** | Clamped Spar Flanges | $k_{\tau,2} = 9.98$ | $\tau_{\text{cr},2} = 393.45\text{ MPa}$ | $\tau_{SL} = 4.40\text{ MPa}$ | **STABLE** |

---

## How to Run

1. Clone the repository:
   * `git clone https://github.com/yrydavid/Fokker-F28-Structural-Loads-WingBox-Analysis.git`
   * `cd Fokker-F28-Structural-Loads-WingBox-Analysis`
2. Open MATLAB in the repository root directory and run any of the 11 scripts to generate the aerodynamic profiles, fuselage maneuver load distributions, or spanwise wing effort diagrams.

---

## Author & Contact

**David Irinei**  
Aerospace Engineering Student – National University of Science and Technology POLITEHNICA Bucharest  
Specialization: Aerospace Construction (*Construcții Aerospațiale*)  
Email: [yrydavid@gmail.com](mailto:yrydavid@gmail.com)
