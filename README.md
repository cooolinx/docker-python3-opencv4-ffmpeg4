# docker-python3-opencv4-ffmpeg4
Docker image including Python 3.7+, OpenCV 4.1+, FFmpeg 4.0+, based on Ubuntu 16.04 LTS https://hub.docker.com/r/cooolin/python3-opencv4-ffmpeg4

```bash
# run image
docker run --rm -it cooolin/python3-opencv4-ffmpeg4 bash
# run python 3
python3
# do something on OpenCV
>>> import cv2; cv2.VideoCapture(0).read()
# truncated for transparency
(True, array([[[ 0, 43, 37], ...]], dtype=uint8))
```
