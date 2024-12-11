#!/bin/bash

# this uses the builtin github variable github.job that identifies the job name, and uses that to filter the response to get the corresponding job id. we must normalize the job name to lowercase to ensure the filter works as expected, as github returns the job name in sentence case.
echo "$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${INPUT_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "${INPUT_SERVER_URL}/api/v3/repos/${INPUT_REPOSITORY}/actions/runs/${INPUT_RUN_ID}/jobs" | jq --arg name "${INPUT_JOB}" '.jobs[] | select(.name | ascii_downcase == ($name | ascii_downcase)) | .id')"

echo "DEBUG OUTPUT::::"
echo "URL: ${INPUT_SERVER_URL}"
echo "REPOSITORY: ${INPUT_REPOSITORY}"
echo "RUN_ID: ${INPUT_RUN_ID}"
echo "JOB: ${INPUT_JOB}"

echo "ENV:::::"
env