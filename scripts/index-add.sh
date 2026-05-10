#!/usr/bin/env bash
# wiki/index.md에 항목을 원자적으로 추가
# 사용: ./scripts/index-add.sh <type> <title> <description> <link>
# 예시: ./scripts/index-add.sh "Concepts" "Transformer" "자기 주의 메커니즘 기반 신경망" "[[transformer]]"
#
# <type>은 index.md의 섹션 헤더 (## Concepts, ## Models 등)와 일치해야 함.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INDEX_FILE="$VAULT_ROOT/wiki/index.md"
LOCK_FILE="$VAULT_ROOT/.wiki-index.lock"

SECTION="${1:-}"
TITLE="${2:-}"
DESCRIPTION="${3:-}"
LINK="${4:-}"

if [[ -z "$SECTION" || -z "$TITLE" || -z "$DESCRIPTION" || -z "$LINK" ]]; then
  echo "사용법: $0 <섹션> <제목> <설명> <링크>" >&2
  echo "예시: $0 Concepts Transformer '자기 주의 메커니즘' '[[transformer]]'" >&2
  exit 1
fi

ENTRY="- $LINK — $DESCRIPTION"

# flock으로 전체 read-modify-write 직렬화
(
  flock -x 200

  # 이미 존재하는 항목이면 스킵
  if grep -qF "$LINK" "$INDEX_FILE" 2>/dev/null; then
    echo "이미 존재: $LINK (스킵)"
    exit 0
  fi

  # ## <섹션> 헤더 바로 다음 빈 줄 이후에 항목 삽입
  # macOS/Linux 호환을 위해 Python 사용
  python3 - "$INDEX_FILE" "$SECTION" "$ENTRY" <<'PYEOF'
import sys, re

filepath = sys.argv[1]
section = sys.argv[2]
entry = sys.argv[3]

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# 섹션 헤더 찾기 (## Section 또는 ## Section\n)
pattern = rf'(## {re.escape(section)}\n)'
match = re.search(pattern, content)

if not match:
    # 섹션이 없으면 파일 끝에 새 섹션과 항목 추가
    content = content.rstrip('\n') + f'\n\n## {section}\n\n{entry}\n'
else:
    insert_pos = match.end()
    # 빈 줄 건너뛰기
    while insert_pos < len(content) and content[insert_pos] == '\n':
        insert_pos += 1
    content = content[:insert_pos] + entry + '\n' + content[insert_pos:]

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"추가 완료: {entry}")
PYEOF

) 200>"$LOCK_FILE"
