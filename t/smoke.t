#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/tzzzz"
echo 1..2
tmpdir=$(mktemp -d -t tzzzz.test.XXXXXX)
mkdir -p "$tmpdir/tzzzz"
echo America/New_York Europe/Warsaw Australia/Perth > "$tmpdir/tzzzz/config"
out=$(XDG_CONFIG_HOME="$tmpdir" "$prog")
sed -e 's/^/# /' <<< "$out"
if [ "${#out}" -eq 64 ]
then
    echo 'ok 1'
else
    echo 'not ok 1'
fi
out=$(XDG_CONFIG_HOME="$tmpdir" "$prog" -d)
sed -e 's/^/# /' <<< "$out"
if [ "${#out}" -eq 97 ]
then
    echo 'ok 2'
else
    echo 'not ok 2'
fi
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
