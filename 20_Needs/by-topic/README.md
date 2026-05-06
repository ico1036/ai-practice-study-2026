# 토픽별 니즈

각 관심 토픽별 참가자 그룹.

```dataview
TABLE WITHOUT ID
  topic AS "토픽",
  length(rows) AS "인원",
  rows.file.link AS "참가자"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN interests AS topic
GROUP BY topic
SORT length(rows) DESC
```
