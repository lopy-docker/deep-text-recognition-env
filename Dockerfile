ARG VARIANT=1

FROM pytorch/pytorch:${VARIANT}

# Install apt dependencies
RUN apt update && apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6 libgl1 git \
    && pip install opencv-python==4.8.1.78 lmdb pillow torchvision nltk natsort fire \
    && git clone --depth=1 https://github.com/zihaomu/deep-text-recognition-benchmark /app \
    && sed -i 's/recurrent.view/recurrent.reshape/' /app/modules/sequence_modeling.py \
    && sed -i '/print(contextual_feature.size())/d' /app/model.py  \
    && sed -i 's/h_size = 32/h_size = opt.imgH/' /app/transform_to_onnx.py \
    && sed -i 's/w_size = 100/w_size = opt.imgW/' /app/transform_to_onnx.py \
    && apt-get autoremove -y && apt-get autoclean -y && rm -rf /var/cache/apt/*

WORKDIR /app
