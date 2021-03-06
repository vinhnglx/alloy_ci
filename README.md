# Alloy CI

![build status](https://alloy-ci.com/projects/1/badge/master)

AlloyCI is a Continuous Integration, Deployment, and Delivery coordinator,
written in Elixir, that takes advantage of the GitLab CI Runner, and its
capabilities as executor.

It aims to bridge the gap between GitLab's CI runner and GitHub. GitLab's
CI runner is tightly coupled with GitLab, so it is not possible to use one of
these runners from a GitHub codebase.

With AlloyCI you will be able to register a GitLab CI runner to the platform,
connect it to one of your GitHub repositories, and have it run your CI and
CD pipelines.

AlloyCI will report the status of your pipelines to your pull requests and
branches, so you can always know their status, just like any other CI service.

## Goals

- To provide a clean bridge between GitHub and the GitLab CI runner
- To provide an alternative to other open source CI services
- To leverage the great open source project that is the GitLab CI runner
- To provide GitHub users with the same top class CI/CD that GitLab has, without
  having to switch to GitLab, or paying insane amounts for inferior services

### Stretch Goals

- To provide all the CI/CD/Pipelines functionality, currently available only to
  GitLab EE, for free
- To create a SaaS based on AlloyCI and provide a more cost effective alternative
  to the current CI service ecosystem

## Features

- [x] Basic CI functionality:
  - [x] Can parse a basic [`.alloy-ci.json`](doc/json/README.md) file correctly, and create build jobs accordingly
  - [x] Can send the required build information to the runner for processing when requested
  - [x] Can receive status updates from runner
  - [x] Can report back to GitHub with the statuses
  - [x] Can send notifications via email with the status of a pipeline
  - [x] Can send notifications to Slack with the status of a pipeline
- [x] Extras
  - [x] Build statistics per project
  - [x] Build statistics per runner
- [ ] Advanced CI functionality
  - [x] Can run jobs on multiple environments (using the [`image` feature](doc/docker/README.md) of the Docker executor.)
  - [x] Can use a local build cache to speed up jobs
  - [ ] Can make use of secret variables stored on a per project basis
  - [ ] Can distinguish between tags and branches
  - [ ] Can receive uploaded artifacts from runners
  - [ ] Can pass artifacts between build jobs
  - [ ] Can make use of `only` and `except` tags for jobs
- [ ] Deployment functionality
  - [ ] Can manually start deployments (manual actions)
  - [x] Can do auto deploys
  - [ ] Can start Review Apps
- [x] [Autoscaling Support](doc/runners/install/autoscaling.md) (supported directly by the runner)
  - [x] Can create runners on demand
  - [x] Can destroy runners when not in use

## Installation

Head over to our [documentation](doc/) for more information.

## Contributing

Pull requests are always welcome!

1. Clone the Repository
1. Run `mix deps.get` to install all dependencies
1. Run `cd assets && npm install` to install all Javascript dependencies
1. Make sure all environment variables are present. See [here](doc/README.md#configuration) for more info
1. Create and migrate database with `mix ecto.setup`
1. Run tests with `mix test`
1. Code & send your PR when ready

Before contributing, please read our [Code of Conduct](CODE_OF_CONDUCT.md) and
make sure you fully understand it. Violations will not be tolerated.

## Copyright

Copyright (c) 2017 Patricio Cano. See [LICENSE](LICENSE) for details.

### Documentation Copyright

Documentation for the GitLab CI Runners and related is Copyright (c) 2011-2017 GitLab B.V.
