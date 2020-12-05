#!/bin/bash

set -euf -o pipefail

ids="$( (echo "ibase=2;" && < "${1:-sample}" tr 'FLBR' '0011' | sort) | bc )"
min=$(echo "$ids" | head -n1)
max=$(echo "$ids" | tail -n1)

echo "part 1: $max"
echo "part 2:"
diff <(seq "$min" "$max") <(echo "$ids")
