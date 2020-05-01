# get_last_circleci_build_number plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-get_last_circleci_build_number)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-get_last_circleci_build_number`, add it to your project by running:

```bash
fastlane add_plugin get_last_circleci_build_number
```

Ensure you have the following enviroment variables set:

* `CIRCLECI_TOKEN` - your circleci token you can create one by getting a token from circle ci `Profile > Personal Api Tokens`
* `CIRCLECI_USER_NAME` - the username which owns the project
* `CIRCLECI_REPOSITORY` - the name of the repository

You should be able to find your repository name and user name on circleci when you enter into a project the url will be `https://app.circleci.com/projects/project-setup/github/dawidvdh/some-project` so in this case `dawidvdh` is my username and `some-project` is my project.

## Usage

I typical use it in a project like so:

```
before_all do |options, params|
  Dotenv.overload '.env'
  build_number = params[:build_number] || ENV["CIRCLE_BUILD_NUM"] || get_last_circleci_build_number
end
```

where my `.env` contains `CIRCLECI_TOKEN`, `CIRCLECI_USER_NAME` and `CIRCLECI_REPOSITORY`.

## About get_last_circleci_build_number

Makes user of [circleci gem] to fetch the last build number from circleci.

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

[circleci gem]: https://github.com/mtchavez/circleci
