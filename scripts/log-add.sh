#!/usr/bin/env bash
# wiki/log.md에 항목을 원자적으로 추가 (최신 항목이 상단)
# 사용: ./scripts/log-add.sh <operation> <title> [<bullet1>] [<bullet2>] ...
# 예시: ./scripts/log-add.sh "wiki-ingest" "Attention Is All You Need 논문 처리" \
#         "- wiki/papers/attention-is-all-you-need.md 생성" \
#         "- wiki/concepts/transformer.md 업데이트"

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="$VAULT_ROOT/wiki/log.md"
LOCK_FILE="$VAULT_ROOT/.wiki-log.lock"

OPERATION="${1:-}"
TITLE="${2:-}"
shift 2 || true
BULLETS=("$@")

if [[ -z "$OPERATION" || -z "$TITLE" ]]; then
  echo "사용법: $0 <operation> <title> [bullet...]" >&2
  exit 1
fi

DATE="$(date +%Y-%m-%d)"

# 항목 블록 생성
ENTRY="## $DATE | $OPERATION | $TITLE\n\n"
for bullet in "${BULLETS[@]}"; do
  ENTRY+="$bullet\n"
done

(
  flock -x 200

  # 현재 로그 읽기
  CURRENT="$(cat "$LOG_FILE")"

  # 프론트매터와 헤더 분리 후 새 항목을 첫 번째 --- 구분선 뒤에 삽입
  python3 - "$LOG_FILE" "$DATE" "$OPERATION" "$TITLE" "${BULLETS[@]}" <<'PYEOF'
import sys, re
from datetime import date

filepath = sys.argv[1]
log_date = sys.argv[2]
operation = sys.argv[3]
title = sys.argv[4]
bullets = sys.argv[5:]

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# 새 항목 블록
bullet_lines = '\n'.join(bullets)
new_entry = f"\n---\n\n## {log_date} | {operation} | {title}\n\n{bullet_lines}\n"

# 첫 번째 '---' 구분선(프론트매터 끝) 다음 위치 찾기
# 그 이후의 첫 '---' 구분선 (로그 항목 구분선) 앞에 삽입
parts = content.split('---')
if len(parts) >= 3:
    # parts[0]: 프론트매터 앞, parts[1]: 프론트매터, parts[2+]: 본문
    # 본문의 첫 구분선 앞(= 가장 최근 항목 앞)에 삽입
    header_end = content.find('---', content.find('---') + 3) + 3
    # 헤더 섹션 이후 첫 줄 찾기
    rest_start = header_end
    while rest_start < len(content) and content[rest_start] == '\n':
        rest_start += 1

    # 본문 시작 부분에 새 항목 삽입
    new_content = content[:rest_start] + new_entry.lstrip('\n') + '\n' + content[rest_start:]
else:
    new_content = content.rstrip('\n') + new_entry

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(new_content)

print(f"로그 추가: {log_date} | {operation} | {title}")
PYEOF

) 200>"$LOCK_FILE"
