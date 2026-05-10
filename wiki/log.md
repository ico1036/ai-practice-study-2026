---
type: log
sort: descending
---

# 작업 로그

> append-only. `scripts/log-add.sh`를 통해서만 추가. 최신 항목이 상단.

---

## 2026-05-10 | vault-setup | 볼트 재설계 완료

- 구조: 기존 번호 prefix → ops/ + wiki/ + .raw/ 분리
- 멀티-에이전트 안전 설계 적용 (개인 공간 분리, flock 스크립트)
- 신규 스킬 3개 추가: personal-ingest, contribute, vault-sync
- 기존 스킬 3개 수정: wiki-query, wiki-fold, wiki-lint
