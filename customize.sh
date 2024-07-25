#!/bin/bash

ATLANTIS_VERSION="${ATLANTIS_VERSION:-0.27.3}"
TG_VERSION="${TG_VERSION:-0.57.9}"
TG_DOWNLOAD_LINK="https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_amd64"

IMAGE_NAME="${IMAGE_NAME:-ghcr.io/vitagroupag/atlantis-custom}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

TARGET_FILE="terragrunt"

rm -f $TARGET_FILE

wget -q $TG_DOWNLOAD_LINK --output-document $TARGET_FILE

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
