# Rust

References about the Rust language: its ecosystem tooling conventions,
learning resources, and essays from its practitioner community.

## Contents

- [cargo-xtask: build automation without a build system](/knowledge/SWE/rust/cargo-xtask-build-automation-pattern.md) — a workspace-member binary crate invoked via a cargo alias, avoiding `make`/shell scripts; rust-analyzer's `xtask/` directory is a real-world consumer of the pattern.
- [Delete Cargo Integration Tests (matklad)](/knowledge/SWE/rust/delete-cargo-integration-tests.md) — Cargo compiles and links each `tests/*.rs` file as its own binary, so consolidating them into one entry point cuts test-compile time and artifact size.
- [Reflections on a Decade of Coding (Jamie Brandon)](/knowledge/SWE/rust/reflections-on-a-decade-of-coding.md) — a decade of programming growth attributed to habits and process changes largely absent from, or contradicting, popular advice.
- [rust-lang.org — Learn Rust](/knowledge/SWE/rust/rust-lang-org-learn.md) — the official Rust learning hub: the book, Rust by Example, Rustlings, and the reference-documentation layer.
- [Rustlings](/knowledge/SWE/rust/rustlings.md) — the official CLI-driven exercise course for learning to read and write Rust, worked alongside the book.
- [The Rust Programming Language — Brown University edition](/knowledge/SWE/rust/rust-book-brown-university.md) — an experimental fork of the official book adding quizzes, annotation tools, and Aquascope ownership visualizations, backed by learning-science research.
- [Command-Line Rust (Ken Youens-Clark)](/knowledge/SWE/rust/command-line-rust.md) — learn Rust by rebuilding classic Unix command-line tools (cat, grep, wc, and more) as small, tested programs.
- [Rewriting in Rust (JetBrains)](/knowledge/SWE/rust/jetbrains-rewriting-in-rust.md) — JetBrains' account of an incremental Rust rewrite, read through its Hacker News discussion including pushback on its benchmark methodology.
