#!/usr/bin/env bash

set -e

if [ $# -ne 1 ]; then
    echo "usage: $0 <path>" >&2
    exit 1
fi

FORMAT=rvz
INPUT="$1"
OUTPUT="${INPUT%.*}.$FORMAT"
ISO_SIZE="$(du "$INPUT" | awk '{print $1}')"
EST_SIZE="$(printf "%.2f\n" $(jq -n "$ISO_SIZE*.85/1000"))"

echo -e "🟡 compressing \033[32m$INPUT\033[m"
echo "🔴 raw: $(du -h "$INPUT" | awk '{print $1}')"
echo "🟢 estimated compression ratio: 15% (${EST_SIZE}MB)"
echo -e "📂 output file: \033[94m$OUTPUT\033[m"
echo -e "🕖 [$(date +%H:%M:%S)] This will take about \033[93m8m\033[m..."

time dolphin-tool convert -i "$INPUT" -o "$OUTPUT" -f "$FORMAT" -b 131072 -c zstd -l 5

echo
echo "✅ done"

RVZ_SIZE="$(du "$OUTPUT" | awk '{print $1}')"
ACTUAL_SIZE="$(printf "%.2f\n" $(jq -n "$RVZ_SIZE/1000"))"
COMPRESSION_RATIO="$(printf "%.2f\n" $(jq -n "(1-$RVZ_SIZE/$ISO_SIZE)*100"))"

echo -e "🍤 actual compression ratio: \033[32m${COMPRESSION_RATIO}%\033[m (\033[32m${ACTUAL_SIZE}MB\033[m)"
