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

if [[ -z ${PUSH_REPOS} && "${PUSH_IMAGE}" == "True" ]]; then
  echo -e "\n# Push single repo: ${BUILD_REPO}"
  docker push ${BUILD_OUTPUT}
  
  if [[ ! -z $BUILD_LATEST && "${BUILD_LATEST}" == "True" ]]; then
    docker push ${IMAGE_PATH}:latest
  fi
elif [[ ! -z ${PUSH_REPOS} && "${PUSH_IMAGE}" == "True" ]]; then
  echo -e "\n# Push multi repo:"
  echo ${PUSH_REPOS} | tr ',' '\n' | xargs -I {} echo " - {}"

  for DST_REPO in $(echo $PUSH_REPOS | tr ',' ' '); do
    echo -e "\n# Push to repo: ${DST_REPO}"
    docker tag ${BUILD_OUTPUT} ${DST_REPO}/${BUILD_PATH}:${BUILD_TAG}
    docker push ${DST_REPO}/${BUILD_PATH}:${BUILD_TAG}
    
    if [[ ! -z $BUILD_LATEST && "${BUILD_LATEST}" == "True" ]]; then
      docker tag ${BUILD_OUTPUT} ${DST_REPO}/${BUILD_PATH}:latest
      docker push ${DST_REPO}/${BUILD_PATH}:latest
    fi
  done
fi