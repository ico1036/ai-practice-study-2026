# vault-sync

최신 공유 지식베이스를 받아오고 내 개인 hot cache를 갱신합니다.
세션 시작 시 가장 먼저 실행하는 스킬.

## 트리거

- `/vault-sync`
- "동기화해줘"
- "최신 업데이트 받아와"
- "wiki 최신 버전으로 업데이트"

## 동작 순서

### Phase 1: git pull

```bash
git pull origin main --rebase
```

충돌 발생 시:
- `wiki/index.md` 또는 `wiki/log.md` 충돌: git merge strategy가 `union`으로 설정되어 있어 자동 해결
- 그 외 충돌: 사용자에게 알리고 중단

### Phase 2: 변경 사항 요약

`git diff HEAD~1 --name-only` 또는 `git log --oneline -10`으로 변경 내용 파악:

```
최근 업데이트 (main):
- [추가] wiki/concepts/rag.md — RAG 개념 페이지
- [추가] wiki/papers/attention-is-all-you-need.md
- [수정] wiki/hot.md
- [추가] ops/participants/P002_홍길동.md
- [추가] personal/P003_이름/notes/sources/gpt4-paper.md  ← 다른 참가자 학습 내용
```

### Phase 3: 내 개인 hot cache 갱신

본인의 `personal/P###_이름/` 폴더를 찾아 hot.md의 "공유 위키 현황" 섹션 업데이트:

```markdown
## 공유 위키 현황

<wiki/hot.md 전체 내용 복사>
_(동기화: YYYY-MM-DD)_
```

`personal/P###_이름/` 폴더가 없으면 초기 구조 생성 후 계속:

```
personal/P###_이름/
├── hot.md       (생성)
├── log.md       (생성)
├── inbox/       (생성)
└── notes/
    ├── sources/
    ├── concepts/
    └── questions/
```

### Phase 4: 완료 보고

```
동기화 완료 (2026-05-10)

새로 추가된 wiki 페이지: 3개
- [[rag]] — RAG 개념
- [[attention-is-all-you-need]] — 논문 요약
- (ops) P002_홍길동 프로필

다른 참가자 학습 활동:
- P003_이름: gpt4-paper 소스 노트 추가

내 hot cache 갱신됨 (personal/P###_이름/hot.md)

다음 할 일:
- /wiki-query [궁금한 주제] — 새 내용 검색
- /personal-ingest [URL] — 내 자료 정리
```

## 에러 처리

- git pull 실패 (네트워크): "git pull 실패. 네트워크를 확인하세요."
- rebase 충돌 (wiki 외 파일): 충돌 파일 목록 표시 후 중단
- 본인 폴더 찾기 실패: "본인의 참가자 ID를 알려주세요 (예: P012_홍길동)"
