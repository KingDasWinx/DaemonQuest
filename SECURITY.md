# Security policy

## Reporting a vulnerability

**Do not open a public issue.** Report privately through GitHub: open the
repository's **Security** tab and click **Report a vulnerability**.

Include what you found, how to reproduce it and what an attacker gains.

## What counts

DaemonQuest has a single permanent world with no resets, so an exploit can do
lasting damage. Report especially:

- anything that makes the server accept an action it should reject;
- item or Gold duplication, or any value created from nothing;
- ways to bypass rate limits or the game's own automation limits;
- account takeover, session or authentication flaws;
- ways to read another player's private data.

## What does not count

The client is open source and meant to be modifiable. A modified client is not
a vulnerability by itself; it only becomes one if the server accepts something it
should not.
