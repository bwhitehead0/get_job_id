# get_job_id

This action returns the GitHub Actions Job ID from the running workflow.

The resulting Job ID can be addressed via the GitHub variable `${{ steps.[YOUR_STEP_ID].outputs.job_id }}`

### Requirements

A token will need to be provided via `env` when calling the action.

## Example

```yaml
on:
  push:

name: "Example action"

jobs:
  test:
    name: Test
    runs-on: [ my-private-runner ]
    steps:
      - uses: actions/checkout@v3
      - name: Get job ID
        id: job_id_test
        uses: bwhitehead0/get_job_id@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: Run ShellCheck
        uses: bwhitehead0/action-shellcheck@master
      - name: Create link to logs
        id: test_workflow_url
        # To post link to workflow logs in external ticketing system, for example
        run: |
          echo "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}/job/${{ steps.job_id_test.outputs.job_id }}"
```
