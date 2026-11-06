FROM ghcr.io/paperless-ngx/paperless-ngx:3.4.2

RUN apt-get update && apt-get install -y --no-install-recommends \
  tesseract-ocr-swe \
  && rm -rf /var/lib/apt/lists/*
