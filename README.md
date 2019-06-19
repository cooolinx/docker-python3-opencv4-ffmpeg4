# docker-python3-opencv4-ffmpeg4
Repository for clean Dockerfile containing Python 3.7+, OpenCV 4.1+, FFmpeg 4.0+, based on Ubuntu 16.04 LTS https://hub.docker.com/r/cooolin/python3-opencv4-ffmpeg4

## Build

First you need install docker on your local computer, see official tutorials for [Mac](https://docs.docker.com/docker-for-mac/install/), [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) or [other platforms](https://docs.docker.com/install/).

You can build it on your own, note it takes lots of time, be prepared.
```bash
git clone <git-repository>
cd docker-python3-opencv4-ffmpeg4
docker image build -t cooolin/docker-python3-opencv4-ffmpeg4 .
```

Another option is using already build image from DockerHub which is significantly faster, it basically download the already build image.
```
docker pull cooolin/docker-python3-opencv4-ffmpeg4
```

## Usage

Image has Python 3.7.3, FFmpeg 4.1.3, OpenCV 4.1.0 ready to use. Example:

```bash
# run image
$ docker run --rm -it cooolin/python3-opencv4-ffmpeg4 bash

# ffmpeg version
$ ffmpeg -version | head -n1
ffmpeg version 4.1.3-0york1~16.04 Copyright (c) 2000-2019 the FFmpeg developers

# python version
$ python3 --version
Python 3.7.3

# opencv version
$ opencv_version
4.1.0

# do something on OpenCV
python3
>>> import cv2
>>> cv2.VideoCapture(0).read()
# truncated for transparency
(True, array([[[ 0, 43, 37], ...]], dtype=uint8))
>>> exit()
```
