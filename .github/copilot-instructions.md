# Copilot instructions

All commits made by Copilot in this workspace must use `.github\scripts\commit-with-trailers.ps1`.
Do not invoke `git commit` directly.

The script owns the required commit trailer block. Pass a one-line summary as the first argument and an
optional explanatory body as the remaining argument text.
