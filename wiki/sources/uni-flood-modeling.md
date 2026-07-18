---
kind: source
domain: education
title: "Automating Flood Modeling (Data+ 2025 poster)"
source_type: local_archive
source_path: "uni/summer 2025/data+/Automated-Flood-Modeling.pdf"
authors: [Will Lin, Keyan Miao, Dave Zheng]
org: Duke Nicholas Institute of Energy, Environment & Sustainability
program: Data+
term: summer 2025
fetched: 2026-07-17
---

# Automating Flood Modeling — Data+ 2025

Dave's first research project: a **Data+** summer 2025 poster, "Automating Flood Modeling," with
Will Lin and Keyan Miao at Duke's Nicholas Institute of Energy, Environment & Sustainability. ^[[uni/summer 2025/data+/Automated-Flood-Modeling.pdf]]
The raw simulation/GIS data lives under `uni/riva labs/Flash Flood Data/` (large NetCDF/raster
files, left in place). This card summarizes the poster; the PDF is the citable source.

**Problem.** Climate change is intensifying floods while insurance retreat leaves communities
without safety nets; existing flood-risk tools are inaccessible or overly complex. ^[[uni/summer 2025/data+/Automated-Flood-Modeling.pdf]]

**Core tool.** **HEC-RAS** — a physics-based hydraulic model from the U.S. Army Corps of Engineers
that simulates water flow through rivers/channels. It has limited support for *batch* automation,
which is the gap this project targets. The team drove four HEC-RAS inputs: friction, inflow,
precipitation, and infiltration. ^[[uni/summer 2025/data+/Automated-Flood-Modeling.pdf]]

**Method — synthetic scenario generation:**
- **Land cover** (friction, infiltration): modeled with a Beta(5, 5) distribution over known value
  ranges.
- **Inflow:** 50 years of USGS discharge data → estimated baseflow via moving averages, fit Beta
  distributions for shape parameters (α, β) to synthesize inflow hydrographs.
- **Precipitation:** sampled storm duration/recurrence/shape from **NOAA Atlas 14** PFE tables,
  generated hyetographs, exported 5-minute cumulative-rainfall DSS files HEC-RAS consumes.

**Post-processing:** HEC-RAS flood surfaces → NetCDF → GeoTIFF overlaid on a basemap; flood depths
and mesh centroids extracted and reprojected to geographic coordinates; an interactive **Folium**
map shows nearest-mesh-cell flood-depth distributions across simulations. ^[[uni/summer 2025/data+/Automated-Flood-Modeling.pdf]]

**Results:** a working synthetic-inflow generator, a framework computing flood-depth outputs across
varied conditions for scenario comparison, and an interactive flood-risk lookup interface.
**Future work:** real-time precipitation forecasts + ML to refine hydrograph shapes, uncertainty
quantification for extremes/expected-damage, and cross-region generalizability testing.

**Concept candidates** (for `/ingest`): synthetic-scenario generation via Beta-distribution fitting
of hydrological parameters; the raster pipeline (NetCDF → GeoTIFF → Folium). This is the one piece
of genuine research knowledge in the education domain — distinct from coursework artifacts.
Anchored in [[academic-timeline]]; see also [[data-plus]].
