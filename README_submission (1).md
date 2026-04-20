# ShrubMap Data Challenge — Submission README

**Author:** Sami Bahig — AI Engineer & ML Researcher, MD MSc  
**Challenge:** Shrubwise Data Challenge — Sprint 4  
**Date:** April 20, 2026  
**Institution:** Wildfire Science & Technology Commons, University of California San Diego

---

## Best Performance (Sprint 4)

| Model | IoU | F1 | Recall | Precision |
|---|---|---|---|---|
| ResNet34-UNet 192×192 run3 ★ | **0.8397** | 0.9055 | 0.9585 | 0.8579 |
| Ensemble 2×ResNet34 (run2+3) | 0.8320 | 0.9083 | 0.9607 | 0.8613 |

---

## Submitted Files

| File | Description |
|---|---|
| `ShrubMap_Report_v6.pdf` | PDF report addressing Questions 1–5 |
| `01_data_preparation.ipynb` | Feature engineering, patch extraction, label alignment (6 sites) |
| `01b_data_preparation_extra.ipynb` | Augmentation ×6 (MixUp, CutMix, Copy-Paste Shrub) |
| `02_baseline_models.ipynb` | Random Forest, XGBoost, SVM baselines + SHAP analysis |
| `03_deep_learning.ipynb` | ResNet34/50-UNet 192×192 training, ensembles (Sprint 4) |
| `04_comparison_report.ipynb` | Model comparison, training curves, ensemble evaluation |
| `README.md` | This file |
| `requirements.txt` | Python dependencies |

---

## Environment

**Platform:** JupyterHub NRP — datachallenge-jupyterhub.wildfirecommons.org  
**Resources:** 16 CPU cores, 64 GB RAM, GPU automatically allocated via `torch.cuda.is_available()`  
**Python:** 3.10+

---

## How to Run

### Step 1 — Install dependencies
```bash
pip install -r requirements.txt
```

### Step 2 — Run notebooks in order

```bash
# Data preparation (patches + augmentation)
jupyter nbconvert --to notebook --execute 01_data_preparation.ipynb
jupyter nbconvert --to notebook --execute 01b_data_preparation_extra.ipynb

# Baseline models
jupyter nbconvert --to notebook --execute 02_baseline_models.ipynb

# Deep learning training (~2-4 hours with GPU)
jupyter nbconvert --to notebook --execute 03_deep_learning.ipynb

# Comparison report
jupyter nbconvert --to notebook --execute 04_comparison_report.ipynb
```

Or open each notebook and run **Kernel → Restart & Run All**.

---

## Data

All datasets are accessible via the Shrubwise workspace STAC catalog:
- NAIP 0.6m imagery — 6 California sites
- TLS LiDAR shrub masks — 299 annotated masks
- DL Bliss full image (816 MB) — downloaded via gdown from Google Drive

**Data paths expected:**
```
./naip/                    # NAIP GeoTIFF files
./mask_outputs/            # TLS LiDAR mask files
./patches/                 # Generated during notebook 01
./patches_192_aug/         # Generated during notebook 01b
./models/                  # Model checkpoints saved during notebook 03
```

---

## Pipeline Summary

```
NAIP 0.6m (4 bands)
    ↓
12-channel feature stack (NDVI, EVI, TGI, NDWI, Brightness, VARI, texture_var, texture_ent)
    ↓
TLS LiDAR masks → reprojection EPSG:26910 → binary label maps
    ↓
Patch extraction 64×64 (stride=16, min_shrub=5%) → 6,566 patches / 6 sites
    ↓
Upsample 192×192 + per-channel normalization (p1–p99)
    ↓
Augmentation ×6 (MixUp, CutMix, Copy-Paste, geometric, spectral)
    ↓
ResNet34-UNet (Dice+BCE loss, pos_weight=21, early stopping patience=15)
    ↓
IoU-weighted ensemble soft voting
```

---

## Key Results

| Model | IoU | F1 | Recall | Precision | Epochs |
|---|---|---|---|---|---|
| NDVI Threshold (baseline) | 0.185 | 0.312 | 0.760 | — | — |
| Random Forest 128×128 + SMOTE | 0.571 | 0.728 | 0.827 | 0.651 | — |
| UNet-ResNet50 128×128 | 0.757 | 0.844 | 0.957 | — | 124 |
| **ResNet34-UNet 192×192 run3 ★** | **0.8397** | **0.9055** | **0.9585** | **0.8579** | **35** |
| Ensemble 2×ResNet34 (run2+3) | 0.8320 | 0.9083 | 0.9607 | 0.8613 | — |

**Literature benchmark surpassed:** Zhu et al. (2025) F1=0.789

---

## Pre-trained Model

Best model checkpoint available on request.  
Architecture: `segmentation_models_pytorch.Unet(encoder_name='resnet34', in_channels=12, classes=1)`

---

## License

MIT License
