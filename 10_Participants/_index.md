# 참가자 명단

전체 60명 참가자 인덱스 (Dataview 자동 생성).

## 전체 명단

```dataview
TABLE
  id AS "ID",
  level AS "수준",
  goals AS "목표",
  interests AS "관심",
  status AS "상태"
FROM "10_Participants"
WHERE type = "participant"
SORT id ASC
```

## 수준별 분포

```dataview
TABLE length(rows) AS "인원"
FROM "10_Participants"
WHERE type = "participant"
GROUP BY level
```

## 상태별 분포

```dataview
TABLE length(rows) AS "인원"
FROM "10_Participants"
WHERE type = "participant"
GROUP BY status
```

## 가용시간대 분포

```dataview
TABLE length(rows) AS "인원"
FROM "10_Participants"
WHERE type = "participant"
GROUP BY availability
```
