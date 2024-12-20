#!/usr/bin/env bash

cd /opt

mkdir /opt/frigate
mkdir /opt/frigate/config
cat > /opt/frigate/config/config.yml <<- EOM
mqtt:
  enabled: false
ffmpeg:
  hwaccel_args: preset-nvidia-h265

objects:
  track:
    - person
    - bicycle
    - car
    - motorcycle

detectors:
  tensorrt:
    type: tensorrt
    device: 0 #This is the default, select the first GPU

model:
  path: /config/model_cache/tensorrt/yolov7-320.trt
  input_tensor: nchw
  input_pixel_format: rgb
  width: 320
  height: 320

snapshots:
  enabled: true
  timestamp: true
  bounding_box: true
  retain:
    default: 30

record:
  enabled: true
  events:
    pre_capture: 5
    post_capture: 5
    retain:
      default: 30
      mode: active_objects
    objects:
      - person
      - bicycle
      - car
      - motorcycle

cameras:
  FrontCam:
    ffmpeg:
      inputs:
        # High Resolution Stream
        - path: rtsp:// #stream1
          roles:
            - record
        # Low Resolution Stream
        - path: rtsp:// #stream2
          roles:
            - detect
    detect:
      width: 720
      height: 576
      fps: 5


    zones: {}
    objects: {}
    motion:
      threshold: 5
      contour_area: 25
      improve_contrast: 'false'
    review:
      alerts: {}
version: 0.14
EOM


cat > docker-compose.yml <<- EOM
services:
  frigate:
    container_name: frigate
    privileged: true
    restart: unless-stopped
    image: ghcr.io/blakeblackshear/frigate:stable-tensorrt
    runtime: nvidia
    shm_size: "128mb" # update for your cameras based on calculation above
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/opt/frigate/config:/config"
      - type: tmpfs # Optional: 1GB of memory, reduces SSD/SD Card wear
        target: /tmp/cache
        tmpfs:
            size: 1000000000
    ports:
      - "5000:5000"
      - "1935:1935" # RTMP feeds
    environment:
      - YOLO_MODELS=yolov7-320
      - USE_FP16=false
      - NVIDIA_VISIBLE_DEVICES=all
EOM

docker compose up -d
