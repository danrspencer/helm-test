#!/usr/bin/env bash

IFS=' '
read -ra VERSION <<< $(cat Chart.yaml | grep version)
VERSION="${VERSION[1]}"

echo Publishing $VERSION

helm publish .
git add *.tgz
git stash
git checkout gh-pages
git stash pop
helm repo index .
git add .
git commit -m "Publishing $VERSION"
git push
git checkout main
