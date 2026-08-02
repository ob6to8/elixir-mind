# Matters

The review-quantized delivery units — each doc one coherent intent a reviewer
can approve or reject as a whole, filed as a self-contained handoff packet
(`type: matter`, `status` `open` · `done` · `cancelled`, plus `plan`/`order`
when a plan's build order emits it). Queue order is not stored here: an open
matter is committed and globally ordered only by its row in
[the matter register](/meta/matters.md); an open matter absent from the
register is backlog. Listings below are alphabetical. See the
[matter-docs plan](/meta/plans/matter-docs-architecture.md) and the
[atomic-pull-requests policy](/meta/policy/git-atomic-pull-requests.md).

## Open

- [/create-pull-request scoping edit](/meta/matters/create-pull-request-scoping-edit.md) — scope the skill's commit step to the finished matter and define its repeat-invocation behavior in a continued session. `status: open`.
- [dev-history recommit + regeneration fold-in](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md) — recommit the derived `meta/dev-history.md` and fold its regeneration into the `/create-pull-request` motion, with an unshallow guard. `status: open`.
- [The /matter skill](/meta/matters/matter-skill.md) — a subcommand-dispatched `/matter` skill: bare invocation consumes the top queued matter under the approval-gated protocol, `list` renders the register, `create` files a matter. `status: open`.
- [mix brain.matters verifier](/meta/matters/mix-brain-matters-verifier.md) — a verifier for pointer-ref resolution, order-inversion, and row↔doc agreement, after which the register's Consumed section retires. `status: open`.
- [response-resource-links / Pages-sunset revision](/meta/matters/response-resource-links-pages-sunset-revision.md) — blocked on the operator firming the sunset decision; then revise the policy's canonical-URL rule, `mix brain.url --pages`, and the site machinery's disposition. `status: open`.
- [TDD bookmark promotions](/meta/matters/tdd-bookmark-promotions.md) — promote the three surveyed TDD-with-agents bookmarks into filed references and intake arXiv 2602.07900, the counter-study. `status: open`.
- [Todo fold](/meta/matters/todo-fold.md) — migrate `meta/todos/` into `meta/matters/`, retire `type: todo` from the vocabulary with a contract recompile, and repoint the reading surfaces. `status: open`.
- [Two-sided bias taxonomy implementation](/meta/matters/two-sided-bias-taxonomy-implementation.md) — implement the bias-taxonomy plan end to end: agent-side path ratification, literature-name pass, both registers, the einstellung refile, backfill tagging, and the derive-don't-recall doctrine capstone. `status: open`.
- [Vendor-block pilot](/meta/matters/vendor-block-pilot.md) — blocked on an active consuming repo existing; then paste the vendorable methodology block into its `CLAUDE.md` and add the repo's specifics beneath. `status: open`.

## Done

- [Stand up meta/matters/ and thin the register](/meta/matters/stand-up-meta-matters-and-thin-the-register.md) — migrated the queued register rows to matter docs, thinned `meta/matters.md` to the order-only pointer view, revised its protocol prose, and added this index. `status: done`.
