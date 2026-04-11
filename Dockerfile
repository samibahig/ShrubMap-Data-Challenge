FROM jupyter/scipy-notebook:latest

USER root

# GDAL et dépendances système
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    gdal-bin \
    && rm -rf /var/lib/apt/lists/*

# Packages géospatiaux
RUN pip install --no-cache-dir \
    rasterio \
    geopandas \
    pystac-client \
    laspy \
    folium

# PyTorch CPU/GPU
RUN pip install --no-cache-dir \
    torch==1.13.1 \
    torchvision==0.14.1

USER jovyan
WORKDIR /home/jovyan/work
EXPOSE 8888
