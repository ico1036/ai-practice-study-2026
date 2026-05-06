# 출석 기록

## 회차별 출석률

```dataview
TABLE
  session_no AS "회차",
  date AS "날짜",
  topic AS "주제",
  attendees AS "출석"
FROM "40_Sessions"
WHERE type = "session"
SORT session_no ASC
```

## 참가자별 출석 (수동 갱신 또는 inline field 활용)

각 세션 노트에서 `attended:: [[P001_*]]` 형식으로 inline field 기록 시 자동 집계 가능.
