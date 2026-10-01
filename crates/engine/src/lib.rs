//! Pure, deterministic simulation: `simulate(input, rng) -> outcome`.
//!
//! No I/O, no clock, no unordered collections, no floating point: a combat from
//! today must replay identically years from now. `clippy.toml` in this crate
//! enforces the clock and collection rules; the attribute below enforces integer math.
#![deny(clippy::float_arithmetic)]
