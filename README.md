# Getting Captain working with RSpec

Starting from a [simple workflow that runs rspec][workflow-before-captain], we want to

1. 🧪 Ensure rspec produces json output

`rspec --format json --out tmp/rspec.json` will produce captain-compatible json output in `tmp/rspec.json`.
For github logs to continue to have test output, also include a stdout-friendly formatter (`--format progess` for dots
`--format documentation` for full test names)

```sh
bundle exec rspec \
  --format json --out tmp/rspec.json \
  --format documentation
```

2. 🔐 Create an API token

Create an API token for your organization within [captain][captain], ([more documentation here][create-api-token]).
The token needs write access.

Add the new token as an action secret to your repository. Conventionally, we call this secret `CAPTAIN_API_TOKEN`.

3. 💌 Add a step to upload to captain

```yaml
- name: Upload test results to Captain # optional, shows in github action results
  uses: rwx-research/upload-captain-artifact@v1
  if: always() # run even if build fails
  continue-on-error: true # if upload to captain fails, don't fail the build
  with:
    artifacts: |
      [
        {
          "name": "RSpec",
          "path": "tmp/rspec.json",
          "kind": "test_results",
          "parser": "rspec_json"
        }
      ]
    captain-token: '${{ secrets.CAPTAIN_API_TOKEN }}'
```

4. 🎉 See your test results in Captain!

Take a look at the [final workflow!][workflow-with-captain]

For more information on the github action, see [its readme][action-readme].

[workflow-before-captain]: https://github.com/captain-examples/rspec/blob/basic-workflow/.github/workflows/ci.yml
[captain]: https://captain.build/_/organizations
[create-api-token]: https://www.rwx.com/captain/docs/api-tokens#generating-an-api-token
[workflow-with-captain]: https://github.com/captain-examples/rspec/blob/main/.github/workflows/ci.yml
[action-readme]: https://github.com/rwx-research/upload-captain-artifact/#readme
