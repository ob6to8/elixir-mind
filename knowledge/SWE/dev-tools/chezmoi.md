---
id: em:8f8a6b
type: reference
title: "chezmoi — dotfile manager"
description: A single-binary dotfile manager that lets you maintain, template, and securely apply personal configuration files consistently across multiple machines and operating systems.
resource: https://www.chezmoi.io/
provenance: "chezmoi.io, fetched 2026-08-18"
tags: [dotfiles, developer-tools, configuration-management, cli]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# chezmoi

chezmoi (pronounced "shay-mwa"), created by **Tom Payne**, is a dotfile
manager distributed as a single statically-linked binary with no runtime
dependencies and no root access required. It targets the problem of keeping
personal configuration consistent across many machines while still allowing
per-machine variation.

## Key features

- **Templating** to express differences between machines (OS, hostname, work
  vs. personal) from one source-of-truth dotfiles repo.
- **Password-manager integration** for pulling secrets at apply-time instead
  of storing them in the repo.
- **File encryption**: age, gpg, git-crypt, or transcrypt for anything that
  must be committed encrypted.
- **Archive import** and **script execution** for more advanced bootstrap
  automation (e.g. installing packages as part of applying dotfiles).
- Runs on all major operating systems.

## Install

```
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

Also available via most package managers.

# Citations

- chezmoi.io — <https://www.chezmoi.io/>
