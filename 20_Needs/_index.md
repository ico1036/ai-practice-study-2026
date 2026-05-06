# 니즈 분석 인덱스

참가자 니즈를 다축으로 집계.

## 관심 토픽 TOP

```dataview
TABLE length(rows) AS "관심자수"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN interests AS topic
GROUP BY topic
SORT length(rows) DESC
```

## 학습 목표 분포

```dataview
TABLE length(rows) AS "인원"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN goals AS goal
GROUP BY goal
SORT length(rows) DESC
```

## 우선순위 니즈 TOP

```dataview
TABLE length(rows) AS "요청자수"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN needs_priority AS need
GROUP BY need
SORT length(rows) DESC
```

## 수준 × 관심 매트릭스

```dataview
TABLE length(rows) AS "인원"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN interests AS topic
GROUP BY level + " / " + topic
SORT length(rows) DESC
```

## 하위 분류

- [[by-topic|토픽별]]
- [[by-level|수준별]]
- [[by-goal|목표별]]
- [[clusters|클러스터링 결과]]
