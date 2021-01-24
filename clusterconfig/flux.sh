#!/bin/sh

export GITHUB_USER=addreas

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=homelab \
  --branch=main \
  --path=./resources \
  --personal
