#!/bin/bash

DEBUG="false"

while getopts "D:" opt; do
  case $opt in
    D)
      DEBUG="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

response=$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  "${GITHUB_SERVER_URL}/api/v3/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs")


if [ "$DEBUG" = "true" ]; then
  echo "GITHUB_JOB: $GITHUB_JOB"
  echo echo "Raw response: $response"
fi

if [ "$(echo "$response" | jq '.jobs')" != "null" ]; then
  VALUE=$(echo "$response" | jq --arg name "${GITHUB_JOB}" '.jobs[] | select(.name | ascii_downcase == ($name | ascii_downcase)) | .id')
else
  echo "Error: Unable to retrieve jobs. Please check your inputs and try again."
  exit 1
fi

echo $VALUE
# set to github output
echo "job_id=$VALUE" >> $GITHUB_OUTPUT