# contribute

개인 공간의 노트를 공유 wiki에 기여합니다.
git 브랜치를 생성하고 PR을 만들어 Vault Keeper의 리뷰를 받습니다.

## 트리거

- `/contribute [파일경로 ...]`
- "내 정리한 내용 공유할게"
- "이걸 공유 위키에 올려줘"
- "contribute `personal/P###_이름/notes/concepts/transformer.md`"

## 동작 순서

### Phase 1: 기여 파일 확인

1. 인수로 받은 파일 경로 확인 (없으면 `personal/P###_이름/notes/` 목록 보여주고 선택 요청)
2. 각 파일의 status 확인: `stub` / `draft` / `evergreen`
3. `stub`이면 경고: "아직 내용이 적습니다. 계속하시겠어요?"

### Phase 2: 대상 폴더 결정

파일의 `type` 프론트매터를 읽어 wiki 하위 폴더 결정:

| type | 대상 폴더 |
|------|-----------|
| concept | `wiki/concepts/` |
| model | `wiki/models/` |
| technique | `wiki/techniques/` |
| paper | `wiki/papers/` |
| person | `wiki/people/` |
| tool | `wiki/tools/` |
| source | `wiki/sources/` |
| question | `wiki/questions/` |
| comparison | `wiki/comparisons/` |

### Phase 3: 중복 검사

`wiki/index.md`를 읽어 동명 파일이 이미 있는지 확인.
있으면: "이미 [[기존파일]]이 있습니다. 기존 파일을 업데이트하시겠어요, 아니면 새 파일로 추가하시겠어요?"

### Phase 4: git 브랜치 생성

```bash
# 참가자 ID는 git config user.name 또는 CLAUDE.md에서 추출
BRANCH="contrib/<participant-id>/<YYYY-MM-DD>-<topic-slug>"
git checkout -b "$BRANCH"
```

### Phase 5: 파일 복사 및 프론트매터 업데이트

1. `personal/P###_이름/notes/<type>/<file>.md` → `wiki/<folder>/<file>.md` 복사
2. 복사한 파일의 프론트매터 업데이트:
   - `status: draft` 유지 (Vault Keeper가 evergreen으로 변경)
   - `author`: git config user.name (없으면 묻기)
   - `updated`: 오늘 날짜

### Phase 6: 공유 파일 업데이트 (flock 보호)

```bash
./scripts/index-add.sh "<Section>" "<Title>" "<Description>" "[[<slug>]]"
./scripts/log-add.sh "contribute" "<Title>" "- <파일명> 추가 (by <author>)"
```

### Phase 7: 커밋 및 PR 생성

```bash
git add wiki/<folder>/<file>.md wiki/index.md wiki/log.md
git commit -m "contribute: <title> (by <author>)"
gh pr create \
  --title "contribute: <title>" \
  --body "## 기여 내용\n\n- 파일: \`wiki/<folder>/<file>.md\`\n- 유형: <type>\n- 기여자: <author>\n\n## 원본\n\n<_personal 파일 경로>\n\n## 리뷰 포인트\n\n<!-- Vault Keeper가 확인할 사항 -->"
```

### Phase 8: 완료 안내

```
PR 생성 완료: <PR URL>

Vault Keeper 리뷰 후 main에 머지됩니다.
머지되면 /vault-sync 로 반영을 확인하세요.
```

## 중요 제약

- `wiki/index.md`, `wiki/log.md`는 반드시 `scripts/index-add.sh`, `scripts/log-add.sh` 경유
- `wiki/hot.md`는 직접 수정하지 않음 (Vault Keeper 역할)
- 브랜치 이름 중복 방지: 날짜 + 토픽 슬러그 조합

## 에러 처리

- git 미설치: "git이 필요합니다. `brew install git`"
- gh 미설치: "GitHub CLI가 필요합니다. `brew install gh`"
- 미로그인: "gh auth login 을 먼저 실행하세요"
- 더티 워킹트리: "커밋되지 않은 변경사항이 있습니다. 먼저 정리해주세요."
