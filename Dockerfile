FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-runtime


# Install apt dependencies
RUN apt update && apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6 libgl1 git \
    && pip install opencv-python==4.8.1.78 lmdb pillow torchvision nltk natsort fire \
    && git clone --depth=1 https://github.com/zihaomu/deep-text-recognition-benchmark /app \
    && sed -i 's/recurrent.view/recurrent.reshape/' modules/sequence_modeling.py \
    && apt-get autoremove -y && apt-get autoclean -y && rm -rf /var/cache/apt/*

WORKDIR /app
