# e7nt Homebrew tap

Homebrew formulae for [e7nt](https://github.com/e7nt) tools.

## Rapid Reminder

Terminal-native natural language reminders — see
[e7nt/rapid-reminder](https://github.com/e7nt/rapid-reminder).

```sh
brew install e7nt/tap/rapid-reminder
```

Or tap first, then install:

```sh
brew tap e7nt/tap
brew install rapid-reminder
```

Then:

```sh
rr in 15 mins check build
rr daemon   # run in the background so reminders fire
```

Installing via Homebrew builds from source (a Rust toolchain is pulled in as a
build dependency) and installs the `rr` binary — no Gatekeeper quarantine step
needed.
