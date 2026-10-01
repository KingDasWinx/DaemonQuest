# 0001. Open monorepo, private world content, AGPL-3.0, English only

- Status: accepted
- Date: 2026-09-30

## Context

The client is open source by premise and trivially modifiable, so the server is
fully authoritative: the client sends intent, never results. Security comes from
that authority, not from hiding server code.

The design separates two kinds of knowledge. System rules are transparent and
auditable. World secrets (drop tables, enemy weaknesses, hidden locations) are
meant to be discovered by players and recorded collectively in the Codex.
Publishing the world content would spoil that on day one.

DaemonQuest runs a single canonical world. Closed forks of the server would
compete with it without giving anything back.

## Decision

1. One public monorepo holds all code: client, server, worker, engine, protocol
   and tooling. Client and server share the `protocol` crate.
2. The canonical world content lives in a separate private repository. The
   server loads it from a path at runtime; it is never compiled into a binary.
   The public repository carries only sample content, enough to develop and test
   every feature.
3. All code is licensed `AGPL-3.0-only`.
4. English is the only language of the repository: code, comments, docs, ADRs,
   commits, issues and pull requests.

## Consequences

- Anyone running a modified server for other people must publish their changes
  (AGPL section 13).
- Contributors never see real content. Every feature must work, and be tested,
  against the sample content.
- The content tooling (`content-check`) is public; the content is not.
- Without a CLA, accepted outside contributions make relicensing practically
  impossible. Decide on a CLA before merging the first external pull request if
  relicensing may ever matter.

## Alternatives rejected

- **Public client, private server, two repositories.** Server privacy adds no
  security on top of server authority, and it splits `protocol` across repos.
- **Everything public, content included.** Spoils the world's secrets.
- **MIT OR Apache-2.0.** Allows closed forks of the server.
- **GPL-3.0.** Does not cover use over a network, so a modified server could
  stay closed.
