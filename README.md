# Getting Captain working with RSpec

Starting from a [simple workflow that runs rspec][workflow-before-captain], we want to

1. 🧪 Ensure rspec produces json output

`rspec --format json --out tmp/rspec.json` will produce Captain-compatible json output in `tmp/rspec.json`.
For GitHub logs to continue to have test output, also include a stdout-friendly formatter (`--format progress` for dots
`--format documentation` for full test names)

```sh
bundle exec rspec \
  --format json --out tmp/rspec.json \
  --format progress
```

2. 🔐 Create an Access Token

Create an Access Token for your organization within [Captain][captain] ([more documentation here][create-access-token]).

Add the new token as an action secret to your repository. Conventionally, we call this secret `RWX_ACCESS_TOKEN`.

3. 💌 Install the Captain CLI, and then call it when running tests

See the [full documentation on test suite integration][test-suite-integration].

```yaml
- uses: rwx-research/setup-captain@v1
- run: |
    captain run \
      --suite-id captain-examples-rspec \
      --test-results tmp/rspec.json \
      -- \
      bundle exec rspec \
        --format json --out tmp/rspec.json \
        --format progress
  env:
    RWX_ACCESS_TOKEN: ${{ secrets.RWX_ACCESS_TOKEN }}
```

4. 🎉 See your test results in Captain!

Take a look at the [final workflow!][workflow-with-captain]

[workflow-before-captain]: https://github.com/captain-examples/rspec/blob/basic-workflow/.github/workflows/ci.yml
[captain]: https://account.rwx.com/deep_link/manage/access_tokens
[create-access-token]: https://www.rwx.com/docs/access-tokens
[workflow-with-captain]: https://github.com/captain-examples/rspec/blob/main/.github/workflows/ci.yml
[test-suite-integration]: https://www.rwx.com/captain/docs/test-suite-integration
