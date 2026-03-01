FROM ghcr.io/paperless-ngx/paperless-ngx:v2.20.8

RUN apt-get update && apt-get install -y --no-install-recommends \
  tesseract-ocr-swe \
  && rm -rf /var/lib/apt/lists/*
