#!/bin/bash

ATLANTIS_VERSION="${ATLANTIS_VERSION:-0.33.0}"
TG_VERSION="${TG_VERSION:-0.73.6}"
TG_DOWNLOAD_LINK="https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_amd64"
KC_DOWNLOAD_LINK="https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl"

IMAGE_NAME="${IMAGE_NAME:-ghcr.io/vitagroupag/atlantis-custom}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

TG_TARGET_FILE="terragrunt"
rm -f $TG_TARGET_FILE
echo "Download Terragrunt from $TG_DOWNLOAD_LINK"
wget -q $TG_DOWNLOAD_LINK --output-document $TG_TARGET_FILE

KC_TARGET_FILE="kubectl"
rm -rf $KC_TARGET_FILE
echo "Download kubectl from $KC_DOWNLOAD_LINK"
wget -q $KC_DOWNLOAD_LINK --output-document $KC_TARGET_FILE

if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' -e "1s/ATLANTIS_VERSION/$ATLANTIS_VERSION/g" Dockerfile
else
  sed -i -e "1s/ATLANTIS_VERSION/$ATLANTIS_VERSION/g" Dockerfile
fi

echo "customized Dockerfile ..."
cat Dockerfile

echo "Name: $IMAGE_NAME"
echo "Tag: $IMAGE_TAG"

docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo "Build custom atlantis image : $IMAGE_TAG"
