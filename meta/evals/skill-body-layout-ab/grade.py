#!/usr/bin/env python3
"""Grade the scope-unit-of-work form A/B by mechanical assertions.

Reads iteration-1/<eval>/<variant>/{run.json,outputs/} and scores each run
against the assertions its eval defines. Assertions are checked against the
COPIED OUTPUT FILES where possible, falling back to the agent's run.json only
for facts the files cannot show (e.g. "register untouched" when no register
copy exists). Self-report is the weaker evidence and is marked as such.
"""
import json
import os
import re
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "iteration-1")

ROSTER = {"Claude Fable 5", "Claude Opus 5", "Claude Sonnet 5",
          "Claude Haiku 4.5", "undetermined"}

REQUIRED_FM = ["type", "title", "description", "status", "model",
               "provenance", "tags", "timestamp", "attribution"]


def read(p):
    with open(p, encoding="utf-8") as f:
        return f.read()


def frontmatter(text):
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        return None
    fm, body = {}, m.group(1)
    for line in body.split("\n"):
        km = re.match(r"^([a-z_]+):\s*(.*)$", line)
        if km:
            fm[km.group(1)] = km.group(2).strip()
    return fm


def matter_files(outdir):
    d = os.path.join(outdir, "outputs", "meta", "matters")
    if not os.path.isdir(d):
        return []
    return [os.path.join(d, f) for f in sorted(os.listdir(d))
            if f.endswith(".md") and f != "index.md"]


def plan_files(outdir):
    d = os.path.join(outdir, "outputs", "meta", "plans")
    if not os.path.isdir(d):
        return []
    return [os.path.join(d, f) for f in sorted(os.listdir(d))
            if f.endswith(".md") and f != "index.md"]


def register_copy(outdir):
    p = os.path.join(outdir, "outputs", "meta", "matters.md")
    return p if os.path.isfile(p) else None


def grade(evalname, variant, outdir):
    """Return list of (assertion, passed, evidence)."""
    rj = os.path.join(outdir, "run.json")
    run = json.load(open(rj, encoding="utf-8")) if os.path.isfile(rj) else {}
    ms, ps = matter_files(outdir), plan_files(outdir)
    a = []

    def add(name, ok, ev):
        a.append((name, bool(ok), ev))

    # --- universal assertions -------------------------------------------
    for m in ms:
        t = read(m)
        fm = frontmatter(t) or {}
        base = os.path.basename(m)
        missing = [k for k in REQUIRED_FM if k not in fm]
        add(f"frontmatter complete [{base}]", not missing,
            "all present" if not missing else f"missing {missing}")
        add(f"type is matter [{base}]", fm.get("type") == "matter",
            f"type={fm.get('type')!r}")
        add(f"model in roster vocabulary [{base}]", fm.get("model") in ROSTER,
            f"model={fm.get('model')!r}")
        add(f"## Model section present [{base}]",
            re.search(r"^##+\s+Model\b", t, re.M) is not None,
            "found" if re.search(r"^##+\s+Model\b", t, re.M) else "absent")
        add(f"no em: id minted [{base}]", "id:" not in fm,
            f"id={fm.get('id')!r}" if "id" in fm else "none")
        add(f"status open [{base}]", fm.get("status") == "open",
            f"status={fm.get('status')!r}")

    # --- per-eval shape assertions ---------------------------------------
    if evalname == "eval1-single-matter":
        add("exactly one matter", len(ms) == 1, f"{len(ms)} matter file(s)")
        add("no plan emitted", len(ps) == 0, f"{len(ps)} plan file(s)")
        for m in ms:
            fm = frontmatter(read(m)) or {}
            add(f"no plan/order keys [{os.path.basename(m)}]",
                "plan" not in fm and "order" not in fm,
                f"plan={fm.get('plan')!r} order={fm.get('order')!r}")
        add("register untouched (self-report)",
            run.get("register_modified") is False,
            f"register_modified={run.get('register_modified')!r}")

    if evalname in ("eval2-plan-shaped", "eval3-sequence"):
        add("plan emitted", len(ps) >= 1, f"{len(ps)} plan file(s)")
        add("multiple matters emitted", len(ms) >= 2, f"{len(ms)} matter(s)")
        orders = []
        for m in ms:
            fm = frontmatter(read(m)) or {}
            b = os.path.basename(m)
            add(f"carries plan key [{b}]", bool(fm.get("plan")),
                f"plan={fm.get('plan')!r}")
            add(f"carries order key [{b}]", bool(fm.get("order")),
                f"order={fm.get('order')!r}")
            if fm.get("order", "").isdigit():
                orders.append(int(fm["order"]))
        add("orders are a contiguous 1..N set", bool(orders) and
            sorted(orders) == list(range(1, len(orders) + 1)),
            f"orders={sorted(orders)}")

    if evalname == "eval2-plan-shaped":
        add("register untouched without `sequence` (self-report)",
            run.get("register_modified") is False,
            f"register_modified={run.get('register_modified')!r}")

    if evalname == "eval3-sequence":
        add("register modified with `sequence`",
            run.get("register_modified") is True,
            f"register_modified={run.get('register_modified')!r}")
        add("inserted at HEAD, not tail",
            run.get("register_insert_point") == "head",
            f"insert_point={run.get('register_insert_point')!r}")
        reg = register_copy(outdir)
        if reg:
            rows = [l for l in read(reg).split("\n")
                    if l.strip().startswith("|") and re.match(r"^\|\s*\d+", l.strip())]
            widths = {len([c for c in r.strip().strip("|").split("|")])
                      for r in rows}
            add("register rows are exactly 4 cells", widths == {4},
                f"cell counts seen: {sorted(widths)} over {len(rows)} row(s)")
        else:
            add("register copy captured for checking", False,
                "no outputs/meta/matters.md copied")

    if evalname == "eval4-collision":
        add("recognized the existing artifact",
            run.get("extended_existing") is True,
            f"extended_existing={run.get('extended_existing')!r}")
        add("did not file a duplicate matter", len(ms) == 0,
            f"{len(ms)} new matter file(s) in outputs")
        add("did not emit a plan", len(ps) == 0, f"{len(ps)} plan file(s)")

    return a


def main():
    if not os.path.isdir(ROOT):
        print("no iteration-1 directory yet")
        return 1
    results, summary = {}, {}
    for ev in sorted(os.listdir(ROOT)):
        evdir = os.path.join(ROOT, ev)
        if not os.path.isdir(evdir):
            continue
        for var in sorted(os.listdir(evdir)):
            outdir = os.path.join(evdir, var)
            if not os.path.isdir(outdir):
                continue
            a = grade(ev, var, outdir)
            results[(ev, var)] = a
            p = sum(1 for _, ok, _ in a if ok)
            summary.setdefault(var, [0, 0])
            summary[var][0] += p
            summary[var][1] += len(a)

    for (ev, var), a in sorted(results.items()):
        p = sum(1 for _, ok, _ in a if ok)
        print(f"\n=== {ev} / {var} — {p}/{len(a)} ===")
        for name, ok, ev_ in a:
            print(f"  [{'PASS' if ok else 'FAIL'}] {name}  ({ev_})")

    print("\n=== TOTALS ===")
    for var, (p, t) in sorted(summary.items()):
        pct = (100.0 * p / t) if t else 0.0
        print(f"  {var}: {p}/{t} = {pct:.1f}%")
    json.dump({f"{e}|{v}": [[n, o, x] for n, o, x in a]
               for (e, v), a in results.items()},
              open(os.path.join(ROOT, "grading.json"), "w"), indent=2)
    return 0


if __name__ == "__main__":
    sys.exit(main())
