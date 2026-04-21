# Repo Rules

- Follow the shared workspace rules in `/home/shawn/Development/AGENTS.md`.

## Version Source Of Truth

- Keep one repo-wide version for `homebrew-tailwindcss`.
- The canonical hard-coded version source is `VERSION` at the repo root.
- Formula release versions are upstream TailwindCSS release metadata and are not the tap repository version line.
- Every commit that changes tracked content in this repo must bump the patch version in `VERSION` in the same commit.
