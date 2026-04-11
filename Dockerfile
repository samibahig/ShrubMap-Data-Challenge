FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

# Dépendances système pour GDAL/rasterio
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    gdal-bin \
    libproj-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copie requirements.txt
COPY requirements.txt .

# Dépendances Python via requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Jupyter compatible JupyterHub
RUN pip install --no-cache-dir \
    jupyterlab==4.0.9 \
    ipykernel==6.27.1 \
    ipywidgets==8.1.1

WORKDIR /home/jovyan/work

EXPOSE 8888
