#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Available commands:"
echo "```"
ls -1 $DIR | sed 's/.sh//g' | awk '{print "/" $0}'
echo "```"
