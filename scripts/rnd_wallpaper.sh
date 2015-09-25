#! /usr/bin/env bash

feh --bg-fill "$(ls -d $1/* | sort -R | tail -1)"

