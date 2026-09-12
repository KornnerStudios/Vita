# Copilot instructions

## Source of truth

Source, tests, manifests, and Git history are authoritative. Read them before reviving a plan; do not maintain parallel inventories, completed-work summaries, validation logs, or version/project counts in planning docs. Keep external plans transient and limited to unresolved decisions; remove resolved entries.

Keep documentation concise, with one physical line per prose paragraph or list item; use editor word wrap. Put implementation-specific rationale in nearby comments or XML docs, durable decision rules here, and substantial repeatable procedures in project skills only when needed.

## Change boundaries

Vita integrates component repositories through submodules. Keep each component change and its Vita pointer update separately reviewable, with affected-consumer validation and a clear rollback boundary. Package consumption, consolidation, or a monorepo requires an explicit decision, not incidental cleanup.

Preserve persisted binary/XML/string/hash/compression contracts, native ABI, and user-visible tool/UI behavior unless an intentional change is approved with compatibility evidence. Repo-family source APIs may evolve when consumers move together; retain shims only for a demonstrated transition need. Unsupported formats need a consumer, specified behavior, and legal specimens before implementation.

Keep unrelated API, SDK/TFM, package/feed/lock, native, generator, and analyzer changes separate. For an intentional build/dependency change, reconcile affected manifests, locked restore, CI, output conventions, and source/package consumers. Record compatibility breaks, release-note needs, and rollback in the change review, not a second backlog.

## Evidence

Validate the changed contract and affected consumers; use the CI workflow for integration requirements. Prefer small synthetic fixtures with independently justified expected bytes, XML, digests, errors, and notification sequences, including malformed input, endian/boundary cases, framing, and short reads as relevant. Fixtures need an owning test, stable scenario, provenance, and rationale for changes; unexplained golden drift or output copied solely from the implementation is not evidence. Do not commit game captures, proprietary binaries, or machine-specific paths.

For changes to native interop signatures, layout, loading, or ownership, exercise the affected calls with a compatible library on its supported architecture and check unavailable-library or release behavior as relevant. Managed compilation alone does not validate an ABI.

Use BenchmarkDotNet for performance claims or allocation-sensitive decisions, not routine cleanup. Compare behavior-equivalent baseline and candidate on the current target in Release x64 with allocation diagnostics; record environment/data and distinguish first-use from steady state where relevant. Treat noisy differences as parity, never trade correctness for a timing result.

## Generation and analyzers

Prefer ordinary shared code unless deterministic incremental generation materially reduces stable repeated C# contracts. Keep opt-in declarations/descriptors independent of runtime loading, reject member collisions, and cover generated API/behavior plus consumers. Use a deterministic dedicated tool for checked-in or non-C# output.

For notification changes, characterize equality, assignment, side effects, notification order/count, reentrancy, and framework dispatch/override behavior before replacing handwritten code. Keep custom behavior handwritten unless a small reusable contract emerges; use Windows smoke coverage where UI behavior changes.

Enable opt-in analyzers only with an explicit subsystem owner, rule intent, behavior impact, and enforcement decision.

## Git workflow

Commit only when explicitly requested. All commits made by Copilot in this workspace must use `.github\scripts\commit-with-trailers.ps1`; do not invoke `git commit` directly. The script owns the required commit trailer block. Pass a one-line summary as the first argument and an optional explanatory body as the remaining argument text.

Pushing requires explicit user permission in the current conversation. Do not run `git push` or otherwise update remote refs based on implied intent, prior context, or a general request to finish work.

Annotated git tags created by Copilot must use simple lowercase kebab-case names. Pushing tags also requires explicit user permission in the current conversation. When a user approves pushing a branch with a local annotated tag, push the branch and tag ref explicitly rather than assuming a normal branch push or GitHub Desktop will publish the tag.
