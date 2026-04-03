# EcoHealth-ShrubMap
End-to-end pipeline for mapping shrub distributions using LiDAR and high-resolution NAIP imagery, with applications for environmental health risk assessment.
EcoHealth-ShrubMap is an open-source project integrating LiDAR point clouds and high-resolution NAIP imagery to detect and map shrub distributions across multiple sites. The pipeline produces rasterized shrub masks (GeoTIFF), calculates shrub density, and identifies high-density zones interpreted as potential environmental health risk areas.

These zones correspond to areas where dense shrub coverage may contribute to wildfire fuel load, which can lead to smoke exposure affecting respiratory and cardiovascular health.

The pipeline is trained and optimized on Sedgwick Reserve, with validation on Independence Lake to ensure generalization across different landscapes.

This project demonstrates how multimodal environmental data + AI can support public health preparedness, ecological monitoring, and wildfire risk management.

Repo contents include:

Jupyter notebooks implementing the full pipeline
Example GeoTIFF outputs and shrub density visualizations
Instructions for reproducing results (datasets, dependencies, Docker setup)
Code for generating high-risk zone overlays

Keywords / topics (GitHub / ArXiv friendly):
LiDAR, NAIP imagery, shrub detection, wildfire risk, environmental health, geospatial AI, public health, remote sensing, GIS, machine learning
