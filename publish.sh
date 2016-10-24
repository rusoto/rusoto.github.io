#!/usr/bin/env sh
#
# GitHub Pages deployment script initially from:
# http://www.steveklabnik.com/automatically_update_github_pages_with_travis_example/

set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)

cd _book

git init
git config user.name "Nikita Pekin"
git config user.email "contact@nikitapek.in"

git remote add upstream "https://$GH_TOKEN@github.com/rusoto/rusoto.github.io.git"
git fetch upstream
git reset upstream/master

echo "rusoto.rs" > CNAME

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:master
