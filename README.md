# bim-portfolio

Portfolio and study material from **KC-RES-05**, my BCIT residential MEP project in Revit 2027. The house is one storey on a basement in Burnaby, BC, with HVAC, plumbing, fire sprinklers and electrical in one model.

The portfolio is built as a **submittal package**:

- a transmittal cover with the 3D MEP model
- my qualifications
- a design review summary: 51 issues raised against BC code across seven disciplines (39 closed, 6 closed with placeholder families, 3 kept with reasons, 2 documented, 1 open)
- five case studies, each with the code basis, my decision and a before/after
- the drawing set
- Appendix A: the full design review log

**Live site:** <https://wmchow5.github.io/bim-portfolio/> (after GitHub Pages is turned on; see below)
**PDF:** [`docs/Kenneth-Chow-Submittal.pdf`](docs/Kenneth-Chow-Submittal.pdf) (13 landscape letter pages) and the full log as [`docs/KC-RES-05_Design_Review_Log.pdf`](docs/KC-RES-05_Design_Review_Log.pdf) (3 pages).

## Repository layout

| Path | What it is |
|---|---|
| `docs/` | The portfolio website, served by GitHub Pages: `index.html`, `assets/` (images exported from the Revit model), the portfolio PDF and the design review log PDF. |
| `reports/` | Study and review material. `KC-RES-05_Model_Improvement_Tracker.md` is the working tracker behind the design review log. `Electrical_BIM_Review_2026-09-25.md` is the electrical review. The revision report (HTML and PDF) covers the codes, calculations and self-test questions. |
| `revit/families/` | Revit families I built or edited for the model: placeholder equipment, mark tags, and water heater and dryer connectors. |
| `tools/` | `serve.ps1` previews the site locally. `mobile-frame.html` checks the site at phone width. |

The Revit model itself (`.rvt`, about 50 MB) and its backups are not in this repository.

## Preview locally

```powershell
powershell -ExecutionPolicy Bypass -File tools/serve.ps1
```

Then open <http://localhost:8765>. Pass a port to use another one (for example `tools/serve.ps1 8766`). Open <http://localhost:8765/mobile-frame.html> to see the page at 390 px wide.

## Publish with GitHub Pages

1. On GitHub, open **Settings › Pages**.
2. Under **Build and deployment**, choose *Deploy from a branch*.
3. Select branch `main` and folder `/docs`, then save.
4. The site appears at `https://wmchow5.github.io/bim-portfolio/`, the link to put on your resume.

## How the model review was done

I ran the geometry and code checks through the Revit API (pyRevit), with Claude as a scripting assistant. I set the rules, made each decision and verified every change in the model. R-01 (smoke alarm SD1 too close to a supply diffuser) is open, and nine further model items are under re-check; both are listed on the last page of the portfolio.

## Rights

© 2026 Kenneth Chow. All rights reserved. This is a personal portfolio, shared for viewing. The coursework brief belongs to BCIT.
