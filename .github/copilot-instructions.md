# Copilot instructions

All commits made by Copilot in this workspace must use `.github\scripts\commit-with-trailers.ps1`.
Do not invoke `git commit` directly.

The script owns the required commit trailer block. Pass a one-line summary as the first argument and an
optional explanatory body as the remaining argument text.

Pushing requires explicit user permission in the current conversation.
Do not run `git push` or otherwise update remote refs based on implied intent, prior context, or a general request to
finish work.

Annotated git tags created by Copilot must use simple lowercase kebab-case names.
Pushing tags also requires explicit user permission in the current conversation.
When a user approves pushing a branch with a local annotated tag, push the branch and tag ref explicitly rather than
assuming a normal branch push or GitHub Desktop will publish the tag.
