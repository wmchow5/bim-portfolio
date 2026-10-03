# Electrical BIM review – KC-RES-05 Residential (Stage 1)

**Model:** `HVAC_Residential_Stage1 with Fire and pumping_Kenneth Chow 5.rvt`
**Reviewer role:** BIM manager (MEP / electrical)
**Date:** 2026-09-25
**Backup taken before any change:** `..._backup_2026-09-25_review.rvt`, saved in the same folder
**Basis:** CEC (C22.1), BC Building Code Part 9, the project placement rulebook (`electrical-device-placement` skill, Rule 1), and office BIM practice
**Output images (this folder):**
- `E-Review - Sheet - E101 - ELECTRICAL POWER & LIGHTING PLANS.png`
- `E-Review - Sheet - E601 - ELECTRICAL SCHEDULES.png`
- `E-Review - Floor Plan - 1 - Power.png`
- `E-Review - Floor Plan - 1 - Lighting.png`

## Summary

| | Found | Fixed | Closed by user decision | Needs user action |
|---|---|---|---|---|
| Critical | 4 | 4 | 0 | 0 |
| Major | 10 | 10 | 0 | 0 |
| Minor | 17 | 16 | 1 | 0 |
| **Total** | **31** | **30** | **1** | **0** |

*Updated 2026-09-28: M9, m4, m13 and m1 fixed; m17 found and fixed.*

**Overall grade: C before the review, A after it.**

At the start, Revit reported no warnings. The review still found:
- code gaps: kitchen counter circuiting, no smoke alarm in the basement, no hallway light, and gaps in receptacle spacing
- one analysis error: the panel phases were 24.5 kVA against 7.1 kVA
- device clashes with duct risers inside the walls
- missing deliverables: schedules, a panel schedule and an electrical sheet

All issues are now fixed and verified in the model, except m9 (lighting kept as is by the user's decision).

**Final system check (2026-09-28):**
- 23 circuits; none empty, all on P1.
- No circuit is over 80 % of its breaker. The one exception is the range: 50 A connected on a 40 A breaker, which is intended under the CEC 8-300 demand rule (6 kW demand = 25 A).
- The only uncircuited items are intended: plug-in lamps PL1/PL2, and indoor AC units AC-01..04 (fed from CU-01).
- All 16 lights carry a Switch ID.
- 0 Revit warnings.

**Verification after the fixes:**
- **Rule 1:** all 58 wall-mounted devices are on solid wall faces, ≥ 100 mm from jambs and edges, and outside door openings and swings. My automated check flags R8 and S5a-1/-2/-3 against a door swing, but those are false positives: the devices are on the living-room face of the wall, and the doors swing into the bedrooms.
- **CEC 26-712 spacing:** 0 points over 1.8 m in Bedrooms 1–3 and Living/Dining. One hall point is exactly 1.80 m, which is the limit.
- **Kitchen counter (CEC 26-724):** every counter point is ≤ 900 mm from a receptacle. Three 20 A circuits with 2 receptacles each.
- **Clashes:** the device–duct clashes are resolved. The remaining intersections are intended: receptacles behind the fridge and range, and the microwave receptacle inside the upper cabinet.
- **Panel P1:**

  | | Value |
  |---|---|
  | Connected load | 33.5 kVA |
  | Demand load (CEC factors) | 19.66 kVA (82 A) |
  | Main breaker | 100 A (OK) |
  | Phase A / phase B | 16.6 kVA / 16.9 kVA (balanced) |
  | Spaces used | 29 of 40 |

**Service check by hand (CEC 8-200):** about 141 m² total, with the FFL at 76.5 m² plus 75 % of the basement.
- Basic load: 6 000 W
- Range: 6 000 W
- AC: 3 120 W
- 25 % of the water heater, dryer and pump: 2 875 W
- **Total: about 18.0 kW, which is about 75 A.** This is consistent with the Revit demand of 82 A (Revit counts receptacles at 100 %). 100 A is adequate; 200 A is recommended if an EV charger is planned.

## Issue log

| ID | Cat. | Sev. | Location / elements | Finding | Standard / reason | Status | Fix notes |
|---|---|---|---|---|---|---|---|
| C1 | Circuiting | Critical | Ckt 9: GF2, GF4, GF6 | The kitchen counter circuit fed 3 receptacles. | CEC 26-724: max 2 per 20 A counter circuit | **Fixed** | Ckt 9 = GF2 + GF6; ckt 10 = GF3 + GF5; new ckt 28 "Kitchen Counter C" = GF4 + GF9 (20 A) |
| C2 | Analysis | Critical | P1; `Receptacle - 240V 2P` (D3, D6) | Phase A 24 476 VA vs phase B 7 132 VA; the 240 V connector put the whole load on pole 1. | A 240 V load must be split across both poles | **Fixed** | Family parameter `Load per Pole = Load / 2` drives phases 1 and 2. P1 is now 16.0 / 15.5 kVA. |
| C3 | Life safety | Critical | Basement | No smoke alarm on the basement storey. | BCBC 9.10.19.3 | **Fixed** | SD5 (id 1751489) under the basement ceiling, on ckt 26 (lighting circuit, not GFCI) |
| C4 | Code | Critical | Hall | No hallway lighting outlet and no hall ceiling; SD4 was wall-mounted. | BCBC 9.34.2 | **Fixed** | Hall ceiling added (id 1751492). L15 on ckt 1, switched by S5a-3. SD4 re-hosted onto the hall ceiling. |
| M1 | Code | Major | B1, B2, B3, Living | Receptacle spacing exceeded 1.8 m (up to 3.55 m). | CEC 26-712(a) | **Fixed** | Added R18–R25. R17 and R21 moved. Re-checked: 0 gaps. |
| M2 | Coordination | Major | R12, GF1, D3, D4, S7 | Boxes intersected vertical duct risers inside the walls. | Not buildable | **Fixed** | All slid ≥ 150 mm clear of the risers; the S7 switch leg was redrawn |
| M3 | Rule 1 / layout | Major | D5, D6 | D6 was 60 mm from the alcove opening; outlets were not behind the machines. | Rule 1: ≥ 100 mm from jambs | **Fixed** | Re-hosted on the W/D alcove back wall (1406053), same circuits |
| M4 | Code | Major | Kitchen counters | Counter points were more than 900 mm from a receptacle. | CEC 26-724(d) | **Fixed** | GF9 added; GF5 moved to x 4.50 |
| M5 | Coordination | Major | DS1 | Inside the CU-01 service clearance. | Manufacturer / CEC 2-308 | **Fixed** | Moved to x -2.20, outside the clearance and within sight |
| M6 | Analysis | Major | Range ckt, all loads | No demand factors, so demand = connected load (range shows 50 A on 40 A). | CEC 8-300 / 8-200 | **Fixed** (user decision: apply code demand factors) | New demand factors: "CEC 8-300 single range ≤12 kW (50 %)" and "CEC 8-200 other loads >1.5 kW (25 %)". Load classifications assigned to the range, dryer, water heater and pump. Panel demand is 79 A. |
| M7 | Capacity | Major | P1 | No spare spaces. | ≥ 20 % spare | **Fixed** | P1 = 40 spaces (29 used) |
| M8 | Code | Major | Basement | No receptacle. | CEC 26-720 | **Fixed** | GF10 on the basement west wall, ckt 26 (renamed "Basement Ltg/Rcpt + SD5") |
| M9 | BIM | Major | L8–L14b, L15 | 8 switch systems not linked (Switch ID empty). | The Switch ID drives schedules | **Fixed** (2026-09-28) | Linked by driving the Revit UI with the user's permission (the API has no switch-system method). Verified: all 16 lights L1–L15 carry their Switch ID. |
| M10 | Deliverables | Major | Project | No schedules, panel schedule or electrical sheets. | Deliverable set | **Fixed** | Schedules: E-SCH-Lighting Fixtures, -Electrical Devices, -Switches, -Smoke-CO Alarms. P1 panel schedule. Sheets E101 (power, lighting and basement plans + panel schedule) and E601 (schedules). Power, Lighting and Basement views cropped. |
| m1 | Analysis | Minor | HRV-01 (ckt 16) | Connected load 0 VA. | Understated load | **Fixed** (2026-09-28) | The user set the connector Apparent Power to 180 VA in the Family Editor and reloaded (clicked Disconnect at the prompt). Then ckt 16 was removed, the type Power Factor set to 0.9, and ckt 16 recreated (15 A) at 180 VA. |
| m2 | Layout | Minor | R4, R5, R15, R16 | Receptacles behind bed headboards. | Usability | **Fixed** | Moved to the nightstand positions |
| m3 | Layout | Minor | GF1 | Under the window, 0.91 m from the shower. | CEC 26-710 | **Fixed** | Above the vanity at y 0.95, 1.07 m from the shower |
| m4 | BIM | Minor | Plan views | Device IDs are static text notes, not tags. | BIM standard | **Fixed** (2026-09-28) | A copy of `M_Mechanical Equipment Tag` (Mark label) re-categorised into 5 tag families, `KC Mark Tag - Electrical Fixture / Lighting Fixture / Lighting Device / Fire Alarm / Electrical Equipment`, saved in `Stage 1\Families`. 68 text notes replaced with Mark tags on 1 - Power, 1 - Lighting and B - Electrical. |
| m17 | Deliverables | Minor | View "Basement" (on E101) | Mechanical-discipline view with every electrical category hidden, so the basement plan on E101 showed no electrical devices. | Deliverable accuracy | **Fixed** (2026-09-28) | Renamed "B - Electrical", discipline Electrical, electrical categories and tags shown, ducts and pipes hidden |
| m5 | Standards | Minor | Families | Misleading family names. | Naming | **Fixed** | `Single Phase Panel - 120-240V MCB - Surface`; `Receptacle - 240V 2P` |
| m6 | Standards | Minor | Room 5 | Typo "KItchen". | Naming | **Fixed** | "Kitchen" |
| m7 | Data | Minor | Circuits | Breaker type not recorded. | Panel schedule | **Fixed** | Circuit Comments state the size and protection (AFCI / GFCI / T-slot / 2P) |
| m8 | Data | Minor | AC-01..04 | Uncircuited without explanation. | Clarity | **Fixed** | Comments: powered from CU-01 via interconnect |
| m9 | Design | Minor | L4, L6–L8, L10, L15 | 60 W incandescent; living ≈ 36 lx, laundry ≈ 65 lx. | Energy / IES | **Closed – user decision** | Keep the original lighting |
| m10 | Drafting | Minor | Switch legs | The S7 leg was stale after the move; L15 had no leg. | Drafting | **Fixed** | S7 → L9 redrawn; S5a-3 → L15 added |
| m11 | Analysis | Minor | Load classifications | Defaults only. | See M6 | **Fixed** | See M6 |
| m12 | Design | Minor | Bathroom | No HRV boost / exhaust control. | BCBC 9.32.3 | **Fixed** (user decision: add) | S2c "Timer" switch in the bath (id 1754443), LV control to HRV-01 |
| m13 | Standards | Minor | File path | Folder typo "Satge 1". | File naming | **Fixed** (2026-09-28) | Model closed, folder renamed to "Stage 1" (matches "Stage 2"), model reopened from the new path |
| m14 | Drafting | Minor | Plan views | Labels overlapped; new devices unlabelled. | Legibility | **Fixed** | All labels regenerated. Switch tags staggered along the wall (S2a/b/c, S5a-1/2/3, S5b/S6, S8a/S9, S10/S11). Tag positions compensated for the tag-family offset. |
| m15 | Standards | Minor | Plug-in lamps | Marks "5" and "6" didn't follow the L-series convention. | Naming | **Fixed** | PL1 / PL2, with comments |
| m16 | Deliverables | Minor | E-SCH schedules | Level column blank for face-hosted devices. | Schedule clarity | **Fixed** | Level field removed |

## Fix log (in order)
1. C2: split the 240 V family load across both poles; P1 balanced.
2. M2, M5, m2, m3, M4: 11 devices moved along their host faces.
3. M3: D5 and D6 re-hosted on the alcove wall, re-circuited before the old ones were deleted.
4. M1, M4, M8, C3, C4: added R18–R22, GF9, GF10, SD5, S5a-3, L15 and the hall ceiling; SD4 moved to the ceiling.
5. C1: kitchen counter re-circuited into 3 circuits of 2.
6. M7, m5, m6, m7, m8: panel spaces, family names, room name, circuit comments, AC notes.
7. m1: two attempts. The first raised a blocking Revit dialog (the user cancelled it). The second showed the vendor family can't be reloaded, so it is left for the user; ckt 16 was restored.
8. M6: CEC demand factors and load classifications (user decision).
9. m12: bath HRV boost timer S2c (user decision).
10. m10, m14: switch legs redrawn; all device labels and tags regenerated.
11. M1 re-check: added R23–R25 and moved R17/R21 until the spacing check showed 0 gaps.
12. M10: 4 schedules, the P1 panel schedule, sheets E101 and E601; sheet layout checked from the exported images.
13. m15, m16: lamp marks, schedule columns. Model saved after each group.

## Still for the user
Nothing outstanding. The review is closed.

## Revision R1 – switching and switch naming (2026-09-28, client request)
Backup taken first: `..._backup_2026-09-28_before-switch-rename.rvt`.

**Naming rule:** the switch number matches the light it controls. Where several switches control the same light, they share the number and take a letter suffix (a/b/c). ST = timer.

| Box | Location | Switch | Type | Controls | Was |
|---|---|---|---|---|---|
| B1 | Bedroom 1 door | S1 | Single pole | L1 | S1 |
| B2 | Bedroom 2 door | S2 | Single pole | L2 | S3 |
| B3 | Bedroom 3 door | S3 | Single pole | L3 | S4 |
| B4 3G | Bathroom door | S4 / S5 / ST1 | Single / Single / Timer | L4 / L5 / HRV-01 boost | S2a / S2b / S2c |
| B5 3G | Hall entry (living side) | S15 / S6 / S7a | Single / Single / 3-way | L15 / L6 / L7+L8 | S5a-3 / S5a-2 / S5a-1 |
| B6 2G | Front slider | S7b / S11 | 4-way / Single | L7+L8 / L11 porch | S5b / S6 (positions swapped) |
| B7 | Kitchen/laundry pier | S9 | Single pole | L9 | S7 |
| B8 2G | Laundry entry | S10a / S7c | 3-way / 3-way | L10 / L7+L8 | S8b / new |
| B9 2G | Laundry alcove | S10b / S12 | 3-way / Single | L10 / L12 | S8a / S9 |
| B10 2G | Basement door | S13 / S14 | Single / Single | L13 / L14a+b | S10 / S11 |

**Model changes:**
- All switch Marks, Switch IDs and Comments updated. The Comments record the box, gang and function.
- Types set: S7a and S7c 3-way; S7b 4-way; S10a and S10b 3-way.
- S7b and S11 swapped. S7c placed in box B8 beside S10a (id 1764779). Rule 1 passes: 0.33 m from the nearest wall edge.
- Switch-leg wires redrawn. Travellers drawn S7a → S7b → S7c. L7 → L8 load jumper drawn. LV boost-control cable drawn from ST1 to HRV-01 (below Bedroom 2), on both the ground-floor and basement plans.
- Switch systems re-linked in the Revit UI: L6 → S6, L7 → S7a, L8 → S7a. L10 shows S10b, because Revit holds one switch per system.
- All 18 switches verified at 1200 mm above their floor (BC practice for Part 9; within the 1200 mm accessible cap). 0 Revit warnings. Model saved.

## Revision R2 – kitchen receptacles and the sink area (2026-09-28)
Backup taken first: `..._backup_2026-09-28_before-kitchen.rvt`. Reviewed against CEC 2021 as adopted in BC.

**Already compliant:**
- 900 mm counter coverage (26-712(d))
- 3 × 20 A counter circuits with 2 receptacles each (26-724)
- All counter receptacles GFCI
- None face-up in the counter
- Fridge, range and dishwasher outside the GFCI requirement
- Washer and dryer outside it too, measured along the cord path around the wall

| ID | Sev. | Finding | Fix applied | Status |
|---|---|---|---|---|
| K1 | Code | D4 (microwave/hood) was 1.22 m from the sink and not GFCI (CEC 26-704) | D4 changed to type GFCI (ckt 13, 15 A) | **Fixed** |
| K2 | Practice | GF4 was 70 mm and GF9 100 mm from the sink edge, at the window jambs | GF4 moved to y 2.10, GF9 to y 3.80: 340 mm from the sink, 350–400 mm from the window | **Fixed** |
| K3 | Practice | Counter receptacles at 1.10 m above floor, only 80 mm above the 1.02 m counter top | GF2/3/4/5/6/9 raised to 1.20 m (≈180 mm above the counter) | **Fixed** |
| K4 | Data | Generic "GFCI" type on 20 A counter circuits | New type `Duplex Receptacle : GFCI 20A T-slot (5-20R)` assigned to all 6 counter receptacles | **Fixed** |
| K5 | Coordination | The counter top is modelled at 1.02 m above floor (standard 0.91 m) | Not changed (architectural element) | Info – confirm with the architect |

**Verified after the fixes:**
- Counter wall path 7.08 m; worst point 0.81 m from a receptacle (PASS, ≤ 0.90 m).
- All 6 counter receptacles on solid wall faces, ≥ 0.42 m from any edge.
- No clashes with ducts, pipes, windows, casework or the sink.
- 0 Revit warnings.
