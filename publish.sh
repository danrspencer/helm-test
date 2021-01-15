#!/usr/bin/env bash

IFS=' '
read -ra VERSION <<< $(cat Chart.yaml | grep version)
VERSION="${VERSION[1]}"

echo Publishing $VERSION

git add .
git commit -m "Publishing $VERSION"

helm package .

git stash
git checkout gh-pages
git stash pop

helm repo index .

git add *.tgz
git add index.yaml
git commit -m "Publishing $VERSION"
git push
git checkout main