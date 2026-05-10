# AI 실습 스터디 2026 — 볼트 스키마

## 볼트 목적

약 60명의 AI 실습 스터디 참가자들이 함께 관리하는 집단 지식베이스.
개인 학습 → 공유 기여 파이프라인을 통해 AI 지식이 복리로 쌓이는 구조를 지향한다.

## 역할 정의

- **참가자 (60명)**: `personal/P###_이름/`에서 개인 작업. `personal-ingest`, `vault-sync`, `contribute`, `wiki-query` 스킬 사용.
- **Vault Keeper (1-2명)**: 공유 `wiki/` 관리. 추가로 `wiki-ingest`, `wiki-fold`, `wiki-lint` (auto-fix) 사용 가능.

## 폴더 구조

```
.raw/              불변 소스 원본 (Vault Keeper 관리)
wiki/              합성된 집단 지식베이스 (Vault Keeper 관리)
ops/               스터디 운영 관리 (참가자 프로필, 세션 기록 등)
personal/          참가자별 개인 학습 공간 (git 추적, 본인만 쓰기)
  P001_이름/       각자의 개인 폴더
maps/              MOC 네비게이션 허브
inbox/             기여 드롭존 (낮은 진입장벽)
scripts/           공유 파일 원자 쓰기 헬퍼 스크립트
```

## wiki/ 핵심 파일

- `wiki/index.md` — 마스터 카탈로그 (항상 최신 상태 유지)
- `wiki/hot.md` — 500단어 recency cache (Vault Keeper가 업데이트)
- `wiki/log.md` — append-only 작업 로그 (날짜 내림차순)
- `wiki/overview.md` — 볼트 현황 요약

## wiki/ 하위 폴더 역할

| 폴더 | 내용 |
|------|------|
| `concepts/` | AI 개념 (1개념 = 1페이지, Wikipedia 단위) |
| `models/` | AI 모델 (GPT-4, Llama, Gemini 등) |
| `techniques/` | 기법 (RAG, Fine-tuning, PEFT, Quantization 등) |
| `papers/` | 논문 요약 (1논문 = 1페이지) |
| `people/` | 연구자/실무자 |
| `tools/` | 라이브러리/프레임워크/API |
| `sources/` | 처리된 소스 요약 |
| `questions/` | Q&A 및 연구 합성 |
| `comparisons/` | 비교 분석 |
| `folds/` | 로그 롤업 아카이브 |
| `canvases/` | 시각적 레퍼런스 보드 |
| `meta/` | 리포트, 대시보드, .base 파일 |

## 프론트매터 표준

### 공유 wiki 페이지 (필수 필드)

```yaml
---
type: concept | model | technique | paper | person | tool | source | question | comparison
status: stub | draft | evergreen
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: []
sources: []
author: "P001_이름"  # 최초 기여자
contributors: []     # 이후 기여자
---
```

### ops/participants/ 참가자 프로필

```yaml
---
type: participant
id: P001
name: ""
joined: YYYY-MM-DD
level: 입문 | 중급 | 고급
background: []
goals: []
interests: []
needs_priority: []
availability: ""
status: active | inactive | dropped
---
```

### ops/sessions/ 세션 기록

```yaml
---
type: session
session_no: 1
date: YYYY-MM-DD
topic: ""
attendees: []
materials: []
---
```

## 태그 분류체계

```
#level/intro   #level/mid   #level/adv
#topic/llm     #topic/rag   #topic/agent   #topic/finetune
#topic/eval    #topic/infra  #topic/prompt  #topic/multimodal
#goal/career   #goal/side   #goal/research  #goal/biz
#status/stub   #status/draft  #status/evergreen
#type/concept  #type/paper  #type/technique  #type/tool
```

## 링크 규칙

- **wikilink 우선**: `[[파일명]]` (경로 없이 파일명만)
- **표시명 사용**: `[[Transformer Architecture|트랜스포머 구조]]`
- **섹션 링크**: `[[파일명#섹션명]]`
- **소스 인용**: 프론트매터 `sources:` 필드에 wikilink 목록

## 기여 워크플로 요약

```
1. /vault-sync          → 최신 공유 지식 동기화
2. /personal-ingest     → 내 자료를 personal/P###_이름/에 정리
3. /wiki-query          → 공유 + 개인 지식 통합 검색
4. /contribute          → 준비된 노트를 공유 wiki에 PR로 기여
```

## Vault Keeper 전용 스킬

다음 스킬은 Vault Keeper만 실행:
- `wiki-ingest` (공유 .raw/ → wiki/)
- `wiki-fold` (로그 롤업)
- `wiki-lint` (auto-fix 모드)

참가자가 `wiki-lint`를 실행하면 **dry-run 전용** (자동 수정 없음).

## 멀티-에이전트 안전 규칙

공유 파일 (`wiki/index.md`, `wiki/log.md`, `wiki/hot.md`) 직접 수정 금지.
반드시 `scripts/index-add.sh`, `scripts/log-add.sh`, `scripts/hot-cache-merge.sh` 경유.
