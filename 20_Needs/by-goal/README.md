# 목표별 니즈

```dataview
TABLE WITHOUT ID
  goal AS "목표",
  length(rows) AS "인원",
  rows.file.link AS "참가자"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN goals AS goal
GROUP BY goal
SORT length(rows) DESC
```
