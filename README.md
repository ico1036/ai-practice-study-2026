# AI 실습 스터디 2026 — Operations Vault

60명 규모 AI 실습 스터디의 참가자 니즈 분석 및 운영을 위한 Obsidian Vault.

## 사용법

1. Obsidian에서 이 디렉토리를 Vault로 열기
2. 권장 플러그인: **Dataview**, **Templater**, **Tag Wrangler**
3. 새 참가자 추가: `00_Meta/templates/participant.md` 사용

## 구조

| 디렉토리 | 용도 |
|---|---|
| `00_Meta/` | 스키마, 태그 체계, 템플릿 |
| `10_Participants/` | 참가자 60명 개별 노트 |
| `20_Needs/` | 니즈 분석 (주제/수준/목표별) |
| `30_Curriculum/` | 커리큘럼 및 세션 설계 |
| `40_Sessions/` | 세션 회차별 기록 |
| `50_Operations/` | 운영진 의사결정·작업 로그 |
| `90_Archive/` | 종료/보관 노트 |
| `_queries/` | 재사용 가능한 Dataview 쿼리 |

## 구조 변경 가이드

이 Vault는 **유연한 진화**를 전제로 합니다.

- 디렉토리 추가/이동 자유. 단, 번호 prefix(00_, 10_, ...)로 정렬 유지
- 프론트매터 스키마 변경 시 → `00_Meta/schema.md` 먼저 업데이트 후 일괄 마이그레이션
- 새 분류축 필요 시 → `20_Needs/by-{축}/` 디렉토리 추가
- Dataview 쿼리는 `_queries/`에 분리 보관, 노트에서 임포트

## 운영 원칙

- **단일 소스**: 참가자 정보는 `10_Participants/` 한 곳에서만 관리
- **링크 우선**: 태그보다 `[[wikilink]]` 권장 (그래프 활용)
- **개인정보**: Public repo이므로 민감정보 마스킹 필수 (실명 → ID/이니셜)

## 라이선스

운영 자료. 외부 인용 시 운영진 협의.
