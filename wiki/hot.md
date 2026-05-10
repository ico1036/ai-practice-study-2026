---
type: hot-cache
updated: 2026-05-10
---

# Hot Cache

> 최근 활동의 500단어 요약. Vault Keeper가 주간 트리아지 후 업데이트.
> `wiki-query` 스킬이 세션 시작 시 가장 먼저 읽는 파일.

## 현재 상태

볼트 초기 구성 완료 (2026-05-10). 아직 공유 wiki 페이지 없음.

## 최근 주요 활동

- 볼트 구조 재설계: 단일-작성자 구조 → 멀티-에이전트 안전 구조
- 개인 공간(`_personal/`) + 기여 파이프라인(`/contribute`) 도입
- 신규 스킬: `personal-ingest`, `contribute`, `vault-sync`

## 다음 할 일 (Vault Keeper)

- 구글폼 CSV 수신 후 `.raw/forms/`에 저장
- 배치 스크립트로 `ops/participants/P001-P060` 생성
- 첫 세션 기록 작성
