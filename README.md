# 🌿 EcoHealth-ShrubMap

> **End-to-end pipeline for mapping shrub distributions using LiDAR and high-resolution NAIP imagery, with applications for environmental health risk assessment.**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://python.org)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.1+-red.svg)](https://pytorch.org)
[![Challenge](https://img.shields.io/badge/Shrubwise-Sprint%204-orange.svg)](https://wildfirecommons.org)

---

## 🔍 Overview

**EcoHealth-ShrubMap** is an open-source project integrating LiDAR point clouds and high-resolution NAIP imagery to detect and map shrub distributions across multiple sites. The pipeline produces rasterized shrub masks (GeoTIFF), calculates shrub density, and identifies high-density zones interpreted as potential environmental health risk areas.

These zones correspond to areas where dense shrub coverage may contribute to **wildfire fuel load**, which can lead to smoke exposure affecting **respiratory and cardiovascular health**.

The pipeline is **trained and optimized on Sedgwick Reserve**, with validation on **Independence Lake** to ensure generalization across different landscapes.

This project demonstrates how **multimodal environmental data + AI** can support:
- 🔥 Public health preparedness
- 🌱 Ecological monitoring
- 🚒 Wildfire risk management

---

## 🏗️ Pipeline Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Training       │───▶│  Training       │───▶│  Model          │───▶│  Model          │
│  Labels         │    │  Data           │    │  Development    │    │  Application    │
│                 │    │                 │    │                 │    │                 │
│ Shrub mask &    │    │ NAIP + LiDAR    │    │ PyTorch seg.    │    │ GeoTIFF output  │
│ height labels   │    │ fusion, CHM,    │    │ model training  │    │ all sites +     │
│ from TLS/ALS    │    │ NDVI, cleaning  │    │ & tuning        │    │ health overlays │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Step-by-step:
1. **Data Ingestion** — NAIP imagery + ALS LiDAR via STAC catalog
2. **Preprocessing** — Point cloud filtering, CHM generation, NDVI computation
3. **Feature Engineering** — Height normalization, spectral + structural features
4. **Model Training** — PyTorch segmentation on Sedgwick Reserve
5. **Inference at Scale** — Apply to all 8 sites, output GeoTIFF masks
6. **Bonus: Height Extraction** — Shrub height raster as additional attribute
7. **Health Risk Visualization** — Density maps with high-risk zone overlays

---

## 📁 Repository Structure

```
EcoHealth-ShrubMap/
│
├── notebooks/
│   └── shrub_pipeline_sprint4.ipynb   # Full end-to-end pipeline
│
├── outputs/
│   ├── sedgwick_shrub_mask.tif        # Binary shrub mask — training site
│   ├── independence_shrub_mask.tif    # Generalization test output
│   └── shrub_density_map.tif          # Density + height attributes
│
├── README.md                          # This file
└── requirements.txt                   # Python dependencies
```

---

## 🗂️ Datasets

| Dataset | Type | Site |
|---|---|---|
| NAIP 3DEP Product - Sedgwick | Imagery + Elevation | Sedgwick Reserve *(train)* |
| Sedgwick Reserve: LiDAR Directory | ALS Point Cloud | Sedgwick Reserve *(train)* |
| NAIP 3DEP Product - Independence Lake | Imagery + Elevation | Independence Lake *(validation)* |
| Independence Lake: LiDAR Directory | ALS Point Cloud | Independence Lake *(validation)* |
| NAIP 3DEP Product - DL Bliss | Imagery + Elevation | D.L. Bliss State Park |
| NAIP 3DEP Product - Calaveras Big Trees | Imagery + Elevation | Calaveras Big Trees SP |
| NAIP 3DEP Product - Shaver Lake | Imagery + Elevation | Shaver Lake |
| NAIP 3DEP Product - Pacific Union College | Imagery + Elevation | Pacific Union College |

> Datasets are accessible programmatically via the Shrubwise workspace STAC catalog. No manual download required on the challenge JupyterHub.

---

## ⚙️ Environment Setup

### Option A — NRP JupyterHub *(Recommended — GPU required for training)*

1. Log in at [NRP JupyterHub](https://datachallenge-jupyterhub.wildfirecommons.org)
2. Configure your server:

| Setting | Value |
|---|---|
| GPU | 1 × NVIDIA GeForce GTX 1080 Ti |
| CPU Cores | 8–16 |
| RAM | 32–64 GB |
| Image | Minimal Starter Jupyter Lab |
| /dev/shm for PyTorch | ✅ Enabled |
| Architecture | amd64 |

3. Upload the notebook and run

> ⚠️ **Note:** GPUs are only available on NRP, not on the dedicated challenge JupyterHub. The two platforms are not synchronized — keep all files on one platform.

### Option B — Docker

```bash
docker pull pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime
pip install -r requirements.txt
```

### Option C — Local (CPU only)

```bash
git clone https://github.com/your-username/EcoHealth-ShrubMap.git
cd EcoHealth-ShrubMap
pip install -r requirements.txt
jupyter lab
```

---

## 🚀 How to Run

```bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Open the notebook
jupyter lab notebooks/shrub_pipeline_sprint4.ipynb

# 3. Run all cells
# Kernel → Restart & Run All
```

Outputs (GeoTIFF) will be saved to the `outputs/` directory.

---

## 📊 Output Format

| Output | Format | Description |
|---|---|---|
| `*_shrub_mask.tif` | GeoTIFF, EPSG:4326 | Binary shrub / no-shrub mask |
| `shrub_density_map.tif` | GeoTIFF | Continuous shrub density |
| `*_shrub_height.tif` | GeoTIFF *(bonus)* | Estimated shrub height (m) |
| High-risk zone overlay | Visualization | Red zones = high wildfire fuel load |

---

## 🏥 Public Health Application

The shrub density maps are interpreted through a **health risk lens**:

- 🫁 **Respiratory** — High-density zones predict PM2.5 peaks and asthma/COPD exacerbation risk
- 🫀 **Cardiovascular** — Early warning for VOC inhalation exposure in vulnerable populations
- 🚒 **First Responder Safety** — Identification of ladder fuels to prevent flashover events

---

## 🔑 Keywords

`LiDAR` · `NAIP imagery` · `shrub detection` · `wildfire risk` · `environmental health` · `geospatial AI` · `public health` · `remote sensing` · `GIS` · `machine learning` · `PyTorch` · `GeoTIFF` · `point cloud` · `ALS` · `CHM`

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

