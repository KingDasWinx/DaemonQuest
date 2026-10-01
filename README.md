# DaemonQuest

An ambient MMORPG for the terminal.

You set the strategy; your character lives in the world on its own while you
work, study or sleep. You come back to read what happened, collect the results
and refine your setup. A *daemon* is a process that runs in the background, and
so is your adventurer.

Everything cooperative is asynchronous by design: a five-person party whose
members were never online at the same time, a world boss defeated by
contributions spread over days, a market that works across time zones.

> **Status: pre-alpha.** Milestone M0 (foundation) is in progress. Nothing is
> playable yet.

## Layout

```
apps/
  server/     HTTP + WebSocket adapter (dq-server)
  client/     CLI + TUI (the `dq` binary)
crates/
  domain/     game vocabulary, no I/O, no dependencies
  engine/     pure deterministic simulation
  protocol/   wire types shared by client and server
docs/
  decisions/  architecture decision records
tools/        repository checks
```

More crates are added as the code that needs them lands.

## Building

You need [rustup](https://rustup.rs). The toolchain version is pinned in
`rust-toolchain.toml` and installed automatically.

```sh
cargo run -p dq-client
cargo test --workspace
```

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request. To report
a vulnerability, see [SECURITY.md](SECURITY.md).

## License

[AGPL-3.0-only](LICENSE). If you run a modified server for other people, you must
publish your changes. See [ADR 0001](docs/decisions/0001-open-monorepo-private-content-agpl.md)
for why.
