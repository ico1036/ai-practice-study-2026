# 수준별 니즈

```dataview
TABLE WITHOUT ID
  level AS "수준",
  length(rows) AS "인원",
  rows.file.link AS "참가자"
FROM "10_Participants"
WHERE type = "participant"
GROUP BY level
SORT level ASC
```
