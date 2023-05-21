#!/bin/sh

{ echo "${1}=${2}"; cat releases.txt; } >releases.txt.new
mv releases.txt.new releases.txt

exit 0
