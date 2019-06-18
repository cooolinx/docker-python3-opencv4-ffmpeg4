# Reference: 
# https://hub.docker.com/r/valian/docker-python-opencv-ffmpeg/dockerfile
# https://websiteforstudents.com/installing-the-latest-python-3-7-on-ubuntu-16-04-18-04/
# https://www.pyimagesearch.com/2018/08/15/how-to-install-opencv-4-on-ubuntu/
# https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa

FROM ubuntu:16.04

LABEL maintainer "fallen_lord@126.com"
ENV OPENCV_VERSION 4.1.0
ENV PYTHON_VERSION 3.7

# Install base utilities
RUN apt-get -y update && \
    apt-get -y install \
        locales \
        wget \
        cmake \
        build-essential \
        pkg-config \
    && \
    apt-get -y install \
        python3 \
        python3-dev \
        software-properties-common && \
    sed -i '1s/python3/python3.5/g' /usr/bin/add-apt-repository \
    && \
    # Clean
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -y update && \
    apt-get -y install python$PYTHON_VERSION python$PYTHON_VERSION-dev && \
    rm /usr/bin/python3 && \
    ln -s /usr/bin/python$PYTHON_VERSION /usr/bin/python3 && \
    rm /usr/bin/python3m && \
    ln -s /usr/bin/python$PYTHON_VERSIONm /usr/bin/python3m \
    && \
    # Clean
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install PIP
RUN rm -f /usr/bin/lsb_release && \
    wget --quiet https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm -f get-pip.py && \
    pip3 install --upgrade pip && \
    pip3 install numpy && \
    pip3 install scipy \
    && \
    # Clean
    rm -rf ~/.cache/pip

# Install OpenCV
RUN apt-get -y update && \
    apt-get -y install \
        libjasper-dev \
        libgtk-3-dev \
        libatlas-base-dev gfortran \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libjpeg-dev libpng-dev libtiff-dev \
        libxvidcore-dev libx264-dev \
    && \
    # Download
    wget --quiet https://github.com/opencv/opencv/archive/$OPENCV_VERSION.tar.gz -O opencv.tar.gz && \
    tar xfz opencv.tar.gz && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv.tar.gz && \
    wget --quiet https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.tar.gz -O opencv_contrib.tar.gz && \
    tar xfz opencv_contrib.tar.gz && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib.tar.gz \
    && \
    # Prepare build
    mkdir /opencv/build && cd /opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D BUILD_PYTHON_SUPPORT=ON \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
      -D BUILD_EXAMPLES=OFF \
      -D PYTHON_EXECUTABLE=/usr/bin/python3 \
      -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
      -D BUILD_opencv_python3=ON \
      -D BUILD_opencv_python2=OFF \
      -D WITH_IPP=OFF \
      -D WITH_FFMPEG=ON \
      -D WITH_V4L=ON .. \
    && \
    # Install
    cd /opencv/build && \
    make -j$(nproc) && \
    make install && \
    ldconfig \
    && \
    # Clean
    apt-get -y remove \
        libjasper-dev \
        libgtk-3-dev \
        libatlas-base-dev gfortran \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libjpeg-dev libpng-dev libtiff-dev \
        libxvidcore-dev libx264-dev \
    && \
    apt-get clean && \
    rm -rf /opencv /opencv_contrib /var/lib/apt/lists/*

# Install FFmpeg
RUN add-apt-repository -y ppa:jonathonf/ffmpeg-4 && \
    apt-get -y update && \
    apt-get -y install ffmpeg \
    && \
    # Clean
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Define default command.
CMD ["python3 --version"]
