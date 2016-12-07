# rusoto.github.io

GitBook documentation for the [rusoto](https://github.com/rusoto) project.

# Requirements

* npm

# Preparation

First, install GitBook's CLI with the following commands:

1. `npm install`
2. `npm run docs:prepare`

# Development

A local development server can be started with `npm run docs:watch`. This server
will watch for local changes and reflect them in the build directory. The
development server also hosts the website at `localhost:4000`.

Alternatively, a static site can be built by running `npm run docs:build`.

# Publishing

Any changes made to the documentation will automatically get published to GitHub
Pages via Travis CI once the changes are merged onto master.

# Branch Explanation

This repo has a slightly unconventional branching setup. Most GitHub Pages-based
repos tend to use `master` for the source, and `gh-pages` for the rendered
website. Because this repo is intended to host an organization webpage, then per
[GitHub's requirements](https://help.github.com/articles/user-organization-and-project-pages/)
the rendered website MUST appear on the `master` branch. Since the `master`
branch can no longer be used to hold the source, a separate branch must be made
for that, which in this case is called `source`.
