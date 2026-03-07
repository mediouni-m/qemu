#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

test=$(basename "$*" .py)

show_log()
{
    test_dir=$(find tests/functional -name "$test"'.*')
    for log in "$test_dir"/*.log; do
        cat >&2 << EOF
-----------------------------------------------------
$(echo $log)
$(tail -n 200 $log)
EOF
    done
    cat >&2 << EOF
EOF
}

trap show_log SIGTERM

err=0
"$@" || err=$?
[ $err -eq 0 ] || show_log
exit $err
