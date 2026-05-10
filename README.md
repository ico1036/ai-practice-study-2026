# AI 실습 스터디 2026

약 60명의 참가자가 함께 만드는 AI 집단 지식베이스입니다.
개인이 학습한 내용을 공유하면 AI가 정리하고, 정리된 지식이 다시 모두의 학습을 돕는 구조입니다.

---

## 목차

1. [이 볼트가 하는 일](#이-볼트가-하는-일)
2. [처음 시작하기 (필수)](#처음-시작하기-필수)
3. [일상적인 사용법](#일상적인-사용법)
4. [기여하기](#기여하기)
5. [볼트 구조 설명](#볼트-구조-설명)
6. [스킬 전체 목록](#스킬-전체-목록)
7. [자주 묻는 질문](#자주-묻는-질문)

---

## 이 볼트가 하는 일

```
내가 논문 하나를 읽음
  ↓
/personal-ingest 로 내 개인 폴더에 요약 저장
  ↓
/contribute 로 공유 wiki에 PR 생성
  ↓
Vault Keeper 승인 → 공유 wiki에 반영
  ↓
60명 모두가 그 지식을 /wiki-query 로 검색·활용
```

- **개인 학습**은 내 폴더(`personal/P###_이름/`)에 쌓입니다
- **공유 지식**은 `wiki/`에 쌓이고, 모두가 읽고 검색할 수 있습니다
- **충돌 없음**: 각자의 폴더는 본인만 쓰므로 git 충돌이 발생하지 않습니다

---

## 처음 시작하기 (필수)

### 사전 준비물

| 도구 | 설치 방법 | 용도 |
|------|-----------|------|
| **Git** | [git-scm.com](https://git-scm.com) | 버전 관리 |
| **GitHub 계정** | [github.com](https://github.com) | 저장소 접근 |
| **Claude Code** | `npm install -g @anthropic-ai/claude-code` | AI 스킬 실행 |
| **Obsidian** (선택) | [obsidian.md](https://obsidian.md) | 시각적 노트 탐색 |
| **GitHub CLI** (선택) | `brew install gh` | `/contribute` 스킬 사용 시 |

### Step 1: 저장소 클론

```bash
git clone https://github.com/<org>/ai-practice-study-2026.git
cd ai-practice-study-2026
```

### Step 2: Claude Code로 볼트 열기

```bash
claude
```

### Step 3: 동기화 및 초기 설정

Claude Code 안에서 입력:

```
/vault-sync
```

이 명령이 하는 일:
- 최신 공유 지식베이스를 받아옴
- 내 참가자 ID를 묻고, `personal/P###_이름/` 폴더를 자동 생성
- 공유 wiki의 최신 내용을 내 hot cache에 복사

### Step 4: 내 프로필 확인

`ops/participants/P###_이름.md` 파일을 찾아 내 정보를 확인하세요.
구글폼으로 제출한 정보가 이미 입력되어 있습니다.

### Step 5: 볼트 탐색

```
/wiki-query AI 스터디 어떻게 진행되나요?
```

또는 `maps/START-HERE.md`를 열어 전체 지식 지도를 확인하세요.

---

## 일상적인 사용법

### 세션 시작 시 (매번)

```
/vault-sync
```

다른 참가자가 추가한 내용, 새 세션 기록 등을 받아옵니다.

### 논문/아티클 읽고 정리하기

```
/personal-ingest https://arxiv.org/abs/1706.03762
```

또는 PDF 파일이라면:

```
/personal-ingest ./내논문.pdf
```

결과: 내 `personal/P###_이름/notes/sources/` 에 요약 노트가 생성됩니다.

### 지식베이스 검색

```
/wiki-query transformer와 attention이 뭔가요?
/wiki-query RAG를 직접 구현하려면 어디서 시작해야 하나요?
/wiki-query GPT-4와 Claude 차이를 비교해줘
```

검색은 내 개인 노트 + 공유 wiki 두 곳을 동시에 봅니다.

### 좋은 대화 저장하기

Claude와 나눈 대화 중 기억할 만한 내용이 있다면:

```
/save
```

내 개인 노트(`personal/P###_이름/notes/questions/`)에 저장됩니다.

---

## 기여하기

### 방법 1: `/contribute` (권장)

내 노트가 다른 참가자에게도 도움이 될 것 같으면:

```
/contribute personal/P###_이름/notes/concepts/transformer.md
```

자동으로:
1. git 브랜치 생성 (`contrib/P###/날짜-토픽`)
2. 파일을 `wiki/concepts/` 로 복사
3. `wiki/index.md` 업데이트 (충돌 안전)
4. GitHub PR 생성

Vault Keeper가 리뷰 후 머지합니다 (보통 1-3일).

### 방법 2: `inbox/` 드롭 (형식 자유)

형식 몰라도 됩니다. `inbox/` 폴더에 파일을 넣으면 Vault Keeper가 주간 트리아지에서 정리합니다.

```bash
cp 내노트.md inbox/
git add inbox/내노트.md
git commit -m "inbox: 내노트 추가"
git push
```

### 기여 후 머지 확인

```
/vault-sync
```

내 기여가 main에 반영되면 vault-sync 시 업데이트 목록에 표시됩니다.

---

## 볼트 구조 설명

```
ai-practice-study-2026/
│
├── CLAUDE.md              AI(Claude Code)가 읽는 볼트 스키마 및 규칙
├── CONTRIBUTING.md        기여 상세 가이드
├── README.md              지금 읽고 있는 파일
│
├── wiki/                  ★ 집단 지식베이스 (Vault Keeper 관리)
│   ├── index.md           전체 페이지 목록
│   ├── hot.md             최근 500단어 요약 (빠른 검색용)
│   ├── log.md             모든 작업 기록
│   ├── concepts/          AI 개념 (transformer, RAG, attention...)
│   ├── models/            AI 모델 (GPT-4, Llama, Claude...)
│   ├── techniques/        기법 (fine-tuning, PEFT, quantization...)
│   ├── papers/            논문 요약
│   ├── tools/             라이브러리/API (LangChain, LlamaIndex...)
│   ├── questions/         Q&A 및 연구 합성
│   └── meta/              대시보드, 품질 리포트
│
├── personal/              ★ 참가자별 개인 학습 공간 (git 추적)
│   ├── P001_이름/         각자의 폴더 (본인만 쓰기, 모두 읽기 가능)
│   │   ├── hot.md         내 최근 컨텍스트
│   │   ├── log.md         내 학습 로그
│   │   └── notes/
│   │       ├── sources/   내가 읽은 자료 요약
│   │       ├── concepts/  개념 초안
│   │       └── questions/ 내 Q&A
│   └── P002_이름/
│
├── ops/                   스터디 운영 관리
│   ├── participants/      참가자 60명 프로필
│   ├── sessions/          세션 기록
│   ├── curriculum/        커리큘럼 및 일정
│   ├── needs/             수요 분석
│   └── decisions/         의사결정 로그 (ADR)
│
├── maps/                  네비게이션 허브
│   ├── START-HERE.md      볼트 진입점
│   ├── map-llm-foundations.md
│   ├── map-applications.md
│   └── map-tools-infra.md
│
├── inbox/                 기여 드롭존 (형식 자유)
│
├── .raw/                  불변 소스 원본 (Vault Keeper 전용)
│   ├── papers/
│   ├── articles/
│   ├── talks/
│   └── forms/             구글폼 CSV 원본
│
└── scripts/               공유 파일 원자 쓰기 헬퍼
    ├── index-add.sh
    ├── log-add.sh
    └── hot-cache-merge.sh
```

### 핵심 규칙

| 폴더 | 쓸 수 있는 사람 |
|------|----------------|
| `wiki/` | Vault Keeper만 (스킬 경유) |
| `personal/P###_이름/` | 해당 참가자만 |
| `ops/participants/` | Vault Keeper (구글폼 데이터 입력) |
| `ops/sessions/` | Vault Keeper |
| `inbox/` | 모든 참가자 |
| `maps/` | Vault Keeper |

---

## 스킬 전체 목록

Claude Code 안에서 `/` 로 시작하는 명령어입니다.

### 모든 참가자 사용 가능

| 스킬 | 사용법 | 설명 |
|------|--------|------|
| `/vault-sync` | `/vault-sync` | 최신 공유 지식 동기화 + 내 hot cache 갱신 |
| `/personal-ingest` | `/personal-ingest <URL 또는 파일>` | 소스를 내 개인 노트에 정리 |
| `/wiki-query` | `/wiki-query <질문>` | 공유 + 개인 지식 통합 검색 |
| `/contribute` | `/contribute <파일경로>` | 내 노트를 공유 wiki에 PR |
| `/save` | `/save` | 현재 대화 내용을 내 노트에 저장 |
| `/wiki-lint` | `/wiki-lint` | 볼트 품질 검사 (dry-run, 자동 수정 없음) |

### Vault Keeper 전용

| 스킬 | 설명 |
|------|------|
| `/wiki-ingest` | `.raw/` 소스를 공유 `wiki/`에 처리 |
| `/wiki-fold` | 로그 롤업 압축 |
| `/wiki-lint` (auto-fix) | 볼트 자동 수정 |
| `/autoresearch` | 토픽 자율 리서치 |
| `/wiki` | 볼트 구조 설정 |

### 참고용 스킬

| 스킬 | 설명 |
|------|------|
| `/canvas` | 시각적 레퍼런스 보드 생성 |
| `/obsidian-bases` | 동적 테이블 뷰 생성 |

---

## 자주 묻는 질문

**Q. Claude Code가 처음인데 어떻게 설치하나요?**

```bash
npm install -g @anthropic-ai/claude-code
claude login  # Anthropic 계정으로 로그인
```

자세한 설치 안내는 [Claude Code 공식 문서](https://docs.anthropic.com/claude-code)를 참고하세요.

---

**Q. 내 참가자 번호(P###)는 어떻게 확인하나요?**

`ops/participants/` 폴더를 열거나, Claude Code에서:

```
ops/participants/ 폴더에서 내 이름 찾아줘
```

---

**Q. `wiki/`를 직접 수정해도 되나요?**

안 됩니다. 60명이 동시에 수정하면 git 충돌이 발생합니다.
`/contribute` 스킬이나 `inbox/` 드롭을 사용하세요.

---

**Q. 개인 노트(`personal/P###_이름/`)는 다른 사람이 볼 수 있나요?**

네, git에 올라가므로 다른 참가자가 읽을 수 있습니다.
학습 투명성을 위해 공개 설계입니다. 완전히 개인적인 내용은 `private/` 폴더(gitignore)를 사용하세요.

---

**Q. 기여가 반영되는 데 얼마나 걸리나요?**

PR 생성 후 Vault Keeper 리뷰 → 머지까지 보통 1-3일입니다.
급한 경우 스터디 채널에서 Vault Keeper에게 요청하세요.

---

**Q. 논문 PDF를 직접 넣을 수도 있나요?**

네. 로컬 파일 경로를 사용하면 됩니다:

```
/personal-ingest /Users/나/Downloads/attention-is-all-you-need.pdf
```

---

**Q. 이미 정리된 노트가 있는데, 처음부터 다시 해야 하나요?**

아닙니다. 기존 노트를 `personal/P###_이름/notes/` 에 복사한 뒤 `/contribute`로 바로 기여할 수 있습니다.

---

**Q. Obsidian 없이도 사용할 수 있나요?**

네. Claude Code만으로 모든 스킬을 사용할 수 있습니다.
Obsidian은 시각적 그래프 탐색, Dataview 쿼리 등을 위한 선택 사항입니다.

---

## 권장 Obsidian 플러그인

Obsidian을 사용한다면 다음 플러그인을 설치하면 편합니다:

| 플러그인 | 역할 |
|----------|------|
| **Dataview** | 참가자/세션 자동 집계 테이블 |
| **Templater** | 일관된 노트 구조 자동 생성 |
| **Tag Wrangler** | 태그 분류 관리 |
| **Obsidian Git** | 저장 시 자동 커밋/푸시 |
| **Graph Analysis** | 지식 그래프 탐색 |

---

## 연락처

- **Vault Keeper**: [스터디 채널 태그 방법 안내 예정]
- **이슈**: GitHub Issues 탭
- **긴급**: 스터디 단체 채팅방
