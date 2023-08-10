#!/bin/bash

export $(cat env) > /dev/null 2>&1;

if [[ -z ${BUILD_NS} ]]; then
  BUILD_PATH="${BASE_IMAGE}"
else
  BUILD_PATH="${BUILD_NS}/${BUILD_IMAGE}"
fi

if [[ -z ${BUILD_REPO} ]]; then
  IMAGE_PATH="${BUILD_PATH}"
else
  IMAGE_PATH="${BUILD_REPO}/${BUILD_PATH}"
fi

BUILD_OUTPUT="${IMAGE_PATH}:${BUILD_TAG}"

echo "Build from ${BASE_REPO}/${BASE_IMAGE}:${BASE_TAG}"
echo "Build to ${IMAGE_PATH}:${BUILD_TAG}"

docker build -t ${IMAGE_PATH}:${BUILD_TAG} .

if [[ ! -z $BUILD_LATEST && "${BUILD_LATEST}" == "True" ]]; then
  docker tag ${BUILD_OUTPUT} ${IMAGE_PATH}:latest
fi