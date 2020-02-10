#!/usr/bin/env bash
set -x
git config --global user.email "noreply@github.com"
git config --global user.name "GitHub"
git commit --allow-empty -m "retest build"
git push origin
