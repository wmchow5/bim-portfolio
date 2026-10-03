# bim-portfolio

Portfolio and study material from **KC-RES-05**, my BCIT residential MEP project in Revit 2027. The house is one storey on a basement in Burnaby, BC, with HVAC, plumbing, fire sprinklers and electrical in one model.

The portfolio is built as a **submittal package**:

- a transmittal cover with the 3D MEP model
- my qualifications
- an RFI log of the 50 issues I raised and closed against BC codes
- six RFIs in full, each with before and after
- the drawing set

**Live site:** <https://wmchow5.github.io/bim-portfolio/> (after GitHub Pages is turned on; see below)
**PDF:** [`docs/Kenneth-Chow-Submittal.pdf`](docs/Kenneth-Chow-Submittal.pdf), 13 landscape letter pages.

## Repository layout

| Path | What it is |
|---|---|
| `docs/` | The portfolio website, served by GitHub Pages: `index.html`, `assets/` (images exported from the Revit model) and the PDF version. |
| `reports/` | Study and review material. `KC-RES-05_Model_Improvement_Tracker.md` is the 50-item code review log. `Electrical_BIM_Review_2026-09-25.md` is the electrical review. The revision report (HTML and PDF) covers the codes, calculations and self-test questions. |
| `revit/families/` | Revit families I built or edited for the model: placeholder equipment, mark tags, and water heater and dryer connectors. |
| `tools/` | `serve.ps1` previews the site locally. `mobile-frame.html` checks the site at phone width. |

The Revit model itself (`.rvt`, about 50 MB) and its backups are not in this repository.

## Preview locally

```powershell
powershell -ExecutionPolicy Bypass -File tools/serve.ps1
```

Then open <http://localhost:8765>. Open <http://localhost:8765/mobile-frame.html> to see the page at 390 px wide.

## Publish with GitHub Pages

1. On GitHub, open **Settings › Pages**.
2. Under **Build and deployment**, choose *Deploy from a branch*.
3. Select branch `main` and folder `/docs`, then save.
4. The site appears at `https://wmchow5.github.io/bim-portfolio/`, the link to put on your resume.

## How the model review was done

I scripted the geometry and code checks through the Revit API (pyRevit) with an AI assistant, Claude. I chose every option, checked each fix in the model, and can walk through any item. Open items stay marked open; R-01 (smoke alarm SD1 too close to a supply diffuser) is still to fix.

## Rights

© 2026 Kenneth Chow. All rights reserved. This is a personal portfolio, shared for viewing. The coursework brief belongs to BCIT.
