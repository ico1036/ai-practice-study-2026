#!/usr/bin/env bash
# wiki/hot.md의 특정 섹션을 원자적으로 업데이트
# 사용: ./scripts/hot-cache-merge.sh <section> <content>
# 예시: ./scripts/hot-cache-merge.sh "최근 주요 활동" "- Transformer 개념 페이지 추가\n- RAG 기법 페이지 추가"
#
# 섹션이 없으면 파일 끝에 추가, 있으면 내용 교체.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOT_FILE="$VAULT_ROOT/wiki/hot.md"
LOCK_FILE="$VAULT_ROOT/.wiki-hot.lock"

SECTION="${1:-}"
CONTENT="${2:-}"

if [[ -z "$SECTION" || -z "$CONTENT" ]]; then
  echo "사용법: $0 <섹션명> <내용>" >&2
  exit 1
fi

(
  flock -x 200

  python3 - "$HOT_FILE" "$SECTION" "$CONTENT" <<'PYEOF'
import sys, re
from datetime import date

filepath = sys.argv[1]
section = sys.argv[2]
new_content = sys.argv[3].replace('\\n', '\n')
today = date.today().isoformat()

with open(filepath, 'r', encoding='utf-8') as f:
    text = f.read()

# updated 날짜 갱신
text = re.sub(r'^updated:.*$', f'updated: {today}', text, flags=re.MULTILINE)

# 섹션 찾기: ## <section> 부터 다음 ## 까지
pattern = rf'(## {re.escape(section)}\n)(.*?)(?=\n## |\Z)'
replacement = rf'\g<1>\n{new_content}\n'

if re.search(pattern, text, flags=re.DOTALL):
    text = re.sub(pattern, replacement, text, flags=re.DOTALL)
else:
    text = text.rstrip('\n') + f'\n\n## {section}\n\n{new_content}\n'

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(text)

print(f"hot cache 업데이트: [{section}]")
PYEOF

) 200>"$LOCK_FILE"
