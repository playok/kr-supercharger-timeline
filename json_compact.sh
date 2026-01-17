#!/bin/bash

# supercharger.json을 경량화된 버전으로 변환
# 필요한 필드만 추출: id, name, dateOpened, dateClosed, gps, stallCount, stalls, status, powerKilowatt

INPUT_FILE="supercharger.json"
OUTPUT_FILE="supercharger.minimal.json"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found"
    exit 1
fi

# jq가 설치되어 있는지 확인
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

# 필요한 필드만 추출하여 compact JSON 생성
jq -c '[.results[] | {
    id,
    name,
    dateOpened,
    dateClosed,
    gps: {latitude: .gps.latitude, longitude: .gps.longitude},
    stallCount,
    stalls,
    status,
    powerKilowatt
}]' "$INPUT_FILE" > "$OUTPUT_FILE"

# 결과 출력
ORIGINAL_SIZE=$(wc -c < "$INPUT_FILE" | tr -d ' ')
COMPACT_SIZE=$(wc -c < "$OUTPUT_FILE" | tr -d ' ')
RECORD_COUNT=$(jq 'length' "$OUTPUT_FILE")

echo "✓ Compact JSON created: $OUTPUT_FILE"
echo "  - Records: $RECORD_COUNT"
echo "  - Original: $(numfmt --to=iec $ORIGINAL_SIZE 2>/dev/null || echo "$ORIGINAL_SIZE bytes")"
echo "  - Compact:  $(numfmt --to=iec $COMPACT_SIZE 2>/dev/null || echo "$COMPACT_SIZE bytes")"
echo "  - Reduction: $(echo "scale=1; (1 - $COMPACT_SIZE / $ORIGINAL_SIZE) * 100" | bc)%"
