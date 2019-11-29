# rusoto.github.io

[![Build Status](https://travis-ci.org/rusoto/rusoto.github.io.svg?branch=source)](https://travis-ci.org/rusoto/rusoto.github.io)

`mdBook` documentation for the [rusoto](https://github.com/rusoto) project.

# Publishing

Any changes made to the documentation will automatically get published to [rusoto.org](http://rusoto.org) 
via Travis CI once the changes are merged into the `source` branch.

# Requirements

* [mdbook](https://github.com/rust-lang-nursery/mdBook)

# Development

Install with `cargo install mdbook --vers "0.3.5"`.

`mdbook watch` will regenerate the static output HTML whenever a source file is changed. Use `mdbook watch --open` to open the files in your browser.

# Branch Explanation

This repo has a slightly unconventional branching setup.  This is leftover from when 
it was hosted on GitHub Pages:

> Most GitHub Pages-based repos tend to use `master` for the source, and `gh-pages` for the rendered
> website. Because this repo is intended to host an organization webpage, then per
> [GitHub's requirements](https://help.github.com/articles/user-organization-and-project-pages/)
> the rendered website MUST appear on the `master` branch. Since the `master`
> branch can no longer be used to hold the source, a separate branch must be made
> for that, which in this case is called `source`.
