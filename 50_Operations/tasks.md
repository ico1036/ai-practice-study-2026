# 운영 TODO

전체 운영진 공유 작업 목록.

## 진행 중
- [ ] 참가자 모집 폼 설계
- [ ] 60명 신청서 수합 → `10_Participants/` 일괄 생성 스크립트
- [ ] 1차 니즈 클러스터링 (모집 마감 후)
- [ ] 트랙 분반 결정

## 백로그
- [ ] Discord/Slack 채널 개설
- [ ] OT 자료 준비
- [ ] 멘토 매칭 정책

## 완료
- [x] GitHub repo 생성 (2026-05-06)
- [x] Vault 뼈대 구축 (2026-05-06)

## Dataview: 전체 미완료 작업

```dataview
TASK
FROM "50_Operations" OR "00_Meta" OR "30_Curriculum"
WHERE !completed
GROUP BY file.link
```
