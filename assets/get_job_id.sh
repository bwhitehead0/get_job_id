#!/bin/bash

response=$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  "${GITHUB_SERVER_URL}/api/v3/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs")

if [ "$(echo "$response" | jq '.jobs')" != "null" ]; then
  echo "$response" | jq --arg name "${GITHUB_JOB}" '.jobs[] | select(.name | ascii_downcase == ($name | ascii_downcase)) | .id'
else
  echo "Error: Unable to retrieve jobs. Please check your inputs and try again."
fi
# TK=${GITHUB_TOKEN}
# echo "DEBUG OUTPUT::::"
# echo "URL: ${GITHUB_SERVER_URL}"
# echo "REPOSITORY: ${GITHUB_REPOSITORY}"
# echo "RUN_ID: ${GITHUB_RUN_ID}"
# echo "JOB: ${GITHUB_JOB}"
# echo "TOKEN: ${TK}"
# echo "TOKEN: ${GITHUB_TOKEN}"

# echo "ENV:::::"
# env | sort
# echo "==================================="
# echo "RESPONSE::::"
# echo "${response}"