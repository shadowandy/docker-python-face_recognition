# Docker image based on python-facial_recognition

FROM python:3.6-slim-stretch

RUN apt-get -y update
RUN apt-get install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
    software-properties-common \
    zip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN cd ~ && \
    mkdir -p dlib && \
    git clone https://github.com/davisking/dlib.git && \
    cd dlib/ && \
    python3 setup.py install --yes USE_AVX_INSTRUCTIONS

RUN cd /root/ && \
    git clone https://github.com/ageitgey/face_recognition.git

RUN cd /root/face_recognition && \
    pip3 install -r requirements.txt && \
    python3 setup.py install

RUN pip3 install Flask

CMD ["/bin/bash"]
