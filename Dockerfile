FROM jupyter/scipy-notebook:python-3.10

USER root

# GDAL système
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    gdal-bin \
    && rm -rf /var/lib/apt/lists/*

# Packages géospatiaux
RUN pip install --no-cache-dir \
    rasterio \
    geopandas \
    shapely \
    pyproj \
    fiona \
    pystac-client \
    laspy \
    folium

# PyTorch compatible CC 6.1
RUN pip install --no-cache-dir \
    torch==1.13.1 \
    torchvision==0.14.1 \
    scikit-learn \
    tqdm

USER jovyan
WORKDIR /home/jovyan/work
EXPOSE 8888
