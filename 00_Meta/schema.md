# Frontmatter Schema

이 Vault의 모든 노트 프론트매터 표준 스키마. 변경 시 전체 노트 마이그레이션 필요.

## Participant (`10_Participants/P###_*.md`)

```yaml
---
type: participant
id: P001                       # 고유 ID (P001 ~ P060)
name: 익명_홍길동              # 표시명 (실명 마스킹)
joined: 2026-05-06             # 가입일
level: 중급                    # 입문 | 중급 | 고급
background:                    # 자유 태그
  - 개발자
  - 5년차
goals:                         # 학습 목표
  - LLM활용
  - 사이드프로젝트
interests:                     # 관심 토픽
  - RAG
  - Agent
  - Fine-tuning
needs_priority:                # 니즈 우선순위 (정렬됨)
  - 실습중심
  - 코드리뷰
availability: 주말             # 평일저녁 | 주말 | 자율
status: active                 # active | inactive | dropped
---
```

## Need (`20_Needs/**`)

```yaml
---
type: need
topic: RAG                     # 주제 키워드
level: 중급
demand_count: 0                # 해당 니즈를 가진 참가자 수 (Dataview 자동 집계)
priority: high                 # high | mid | low
related_participants: []       # [[P001_*]] 링크 배열
---
```

## Session (`40_Sessions/S##_*.md`)

```yaml
---
type: session
session_no: 1
date: 2026-05-15
topic: LLM 기초
attendees: 0                   # Dataview 자동 집계
materials: []
---
```

## Decision (`50_Operations/decisions.md` 항목)

```yaml
---
type: decision
date: 2026-05-06
status: approved               # proposed | approved | rejected | reverted
owners: [운영진A]
---
```

## 공통 규칙

- `type` 필드 필수 (Dataview 필터링용)
- 날짜는 ISO 8601 (YYYY-MM-DD)
- 배열은 YAML 시퀀스로 명시
- 자유 태그는 `tags: [...]` 사용 가능 (Obsidian 표준)
