# Contributing to DaemonQuest

Thanks for your interest. This is a long-running project with a strict design,
so please read this whole file before writing code.

## Language

Everything in this repository is in English: code, comments, docs, ADRs, commit
messages, issues and pull requests.

## Before you start

- **Small fixes** (typos, obvious bugs): open a pull request directly.
- **Anything else**: open an issue first and wait for a reply. A pull request
  for an undiscussed feature will probably be closed, however good the code is.
- **Game design changes** use the *Design proposal* issue template. Design
  decisions are deliberate and connected; a change that looks small often
  breaks a principle somewhere else.

## Branches

| Branch | Role | Accepts pull requests from |
|---|---|---|
| `development` | integration branch, the default | any branch, including forks |
| `main` | released code | only `development` and `hotfix/*` in this repository |

A required check rejects any other pull request into `main`. Nobody pushes
directly to either branch, force pushes are blocked, and neither branch can be
deleted.

## Workflow

1. Branch from `development`. Name it `<type>/<short-description>`, for
   example `feat/seeded-rng` or `fix/replay-drift`.
2. Keep each pull request to one change. Split refactors from behavior changes.
3. Open the pull request against `development`. CI must be green and a code
   owner must approve it. A new push dismisses earlier approvals.
4. Feature pull requests are squash-merged, so **the pull request title becomes
   the commit message** and must follow the convention below.

Releases are a pull request from `development` into `main`, merged with a merge
commit so both histories stay connected.

**Hotfixes** are for maintainers only: branch `hotfix/<short-description>` from
`main`, open the pull request against `main`, then merge `main` back into
`development` with a merge commit.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org):

```
<type>(<scope>): <summary in imperative mood>
```

| Type | Use for |
|---|---|
| `feat` | new behavior |
| `fix` | bug fix |
| `refactor` | code change with no behavior change |
| `perf` | performance |
| `test` | tests only |
| `docs` | documentation only |
| `build` | Cargo, dependencies, toolchain |
| `ci` | workflows and repository checks |
| `chore` | anything else |

The scope is the crate or area: `engine`, `domain`, `protocol`, `server`,
`client`, `content`, `ci`, `docs`. Mark breaking changes with `!`, as in
`feat(protocol)!: rename StartActivity fields`.

## Local checks

CI runs exactly these commands. Run them before you push:

```sh
cargo fmt --all --check
cargo clippy --workspace --all-targets --locked -- -D warnings
cargo test --workspace --locked
tools/check-boundaries.sh
cargo deny check
```

## Rules the code must follow

**The server is authoritative.** The client sends intent (`StartActivity`,
`EquipItem`, ...), never results. No game rule ever lives in the client. A
modified client must not be able to do anything the server would not allow.

**Crate boundaries are enforced** by `tools/check-boundaries.sh`:

- `domain` depends on nothing.
- `engine` depends only on `domain`. No I/O, no async runtime, no database.
- `protocol` does not depend on `domain`. The client sees projections of the
  domain, never the domain itself.
- `apps/*` are adapters and contain no business logic.

**The engine is deterministic.** The same input and seed must produce the same
result on every platform, years from now:

- All randomness comes from an injected, seeded generator. The engine never
  creates one.
- The engine never reads the clock. Time is a parameter.
- No `HashMap`/`HashSet` in the engine. Use `BTreeMap`/`BTreeSet` or explicit
  ordering.
- Integer or fixed-point arithmetic only. No floating point.

Clippy enforces the clock, collection and float rules in `crates/engine`.

**Errors and types:**

- No `unwrap()`, `expect()` or `panic!()` outside tests. The one exception is
  startup, where failing loudly on invalid content is correct; mark it with an
  explicit `#[allow]`.
- Libraries return typed error enums. A domain error is never a string:
  `InsufficientResources { required, available }`, not `"not enough mana"`.
- Identifiers are distinct types (`CharacterId`, `ItemId`), never bare integers.
  The same goes for quantities with units (`Gold`, `Percent`).
- Game enums are stored as stable strings, never as positional integers.

**Tests** describe behavior in their names (`uses_potion_below_30_percent`, not
`test_tactics_1`). The full suite must stay under 60 seconds.

## World content

The canonical world content (drop tables, weaknesses, hidden locations) lives in
a private repository, because discovering it is part of the game. This
repository only carries sample content. Do not submit content mined from the
live game. See
[ADR 0001](docs/decisions/0001-open-monorepo-private-content-agpl.md).

## Architecture decisions

Technical decisions are recorded in `docs/decisions/` as short, numbered ADRs:
`NNNN-short-title.md`, with Context, Decision, Consequences and Alternatives
rejected. If your change reverses or adds a technical decision, add an ADR in the
same pull request.

## License

By contributing, you agree that your contributions are licensed under
[AGPL-3.0-only](LICENSE), the same license as the project.

## Conduct

This project follows the [Code of Conduct](CODE_OF_CONDUCT.md).
