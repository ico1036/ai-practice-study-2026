# personal-ingest

내 개인 학습 공간(`personal/P###_이름/`)에 소스를 처리하고 저장합니다.
공유 wiki 파일을 일절 건드리지 않으므로 60명이 동시에 실행해도 충돌이 없습니다.
다른 참가자가 내 노트를 읽을 수 있어 학습 투명성이 생깁니다.

## 트리거

- `/personal-ingest <URL 또는 파일경로>`
- "내 자료 정리해줘"
- "이 논문 요약해서 내 노트에 저장해줘"
- "이 아티클 읽어서 개인 위키에 추가해줘"

## 동작 순서

### Phase 1: 소스 읽기

1. URL이면 WebFetch로 가져온 뒤 가능하면 defuddle로 정제 (설치 시)
2. 파일이면 직접 Read
3. 소스 유형 판단: paper / article / talk / video / code

### Phase 2: 내 개인 공간 확인

`personal/` 아래 본인의 폴더를 찾는다.
CLAUDE.md의 참가자 ID, 또는 git config user.name으로 매칭.
없으면: "본인의 참가자 ID를 알려주세요 (예: P012_홍길동)"

폴더 구조가 없으면 생성:

```
personal/P###_이름/
├── hot.md
├── log.md
├── inbox/
└── notes/
    ├── sources/
    ├── concepts/
    └── questions/
```

### Phase 3: 소스 요약 페이지 생성

`personal/P###_이름/notes/sources/<slug>-<YYYY-MM-DD>.md` 생성:

```markdown
---
type: source
status: draft
created: YYYY-MM-DD
source_url: <원본 URL 또는 파일명>
source_type: paper | article | talk | code
tags: []
---

# <제목>

## 핵심 요약 (3-5문장)

## 주요 개념

- [[concept-slug]] — 한줄 설명

## 인상 깊은 부분

## 내 생각 / 질문
```

### Phase 4: 개념 초안 페이지 생성 (선택)

소스에서 새로운 핵심 개념이 발견되면 `personal/P###_이름/notes/concepts/<concept>.md` 생성:

```markdown
---
type: concept
status: draft
created: YYYY-MM-DD
sources: ["[[<source-slug>]]"]
tags: []
---

# <개념명>

## 한줄 정의

## 상세 설명

## 관련 개념

## 질문 / 불확실한 부분
```

### Phase 5: 개인 hot cache 업데이트

`personal/P###_이름/hot.md`의 "최근 처리 소스" 섹션에 추가:

```markdown
## 최근 처리 소스

- [[source-slug]] — 한줄 요약 (YYYY-MM-DD)
```

### Phase 6: 개인 로그 업데이트

`personal/P###_이름/log.md`에 항목 추가:

```
## YYYY-MM-DD | personal-ingest | <소스 제목>

- personal/P###_이름/notes/sources/<slug>.md 생성
- 추출 개념: <개념1>, <개념2>
```

## 중요 제약

- `wiki/` 폴더는 **절대 수정하지 않음**
- `wiki/index.md`, `wiki/log.md`, `wiki/hot.md` **절대 수정하지 않음**
- `.raw/` 폴더는 **절대 수정하지 않음**
- 모든 출력은 `personal/P###_이름/` 하위에만

## 완료 메시지 형식

```
개인 노트 저장 완료:
- 소스: personal/P###_이름/notes/sources/<slug>.md
- 개념: personal/P###_이름/notes/concepts/<concept>.md (해당 시)

공유하려면: /contribute personal/P###_이름/notes/sources/<slug>.md
```
