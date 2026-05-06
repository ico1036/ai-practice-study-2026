# 재사용 Dataview 쿼리: 니즈 트렌드

다른 노트에 임포트하거나 복사해서 사용.

## 관심 토픽 누적 분포
```dataview
TABLE length(rows) AS "n"
FROM "10_Participants"
WHERE type = "participant"
FLATTEN interests AS t
GROUP BY t
SORT length(rows) DESC
```

## 신규 가입 추이
```dataview
TABLE length(rows) AS "신규"
FROM "10_Participants"
WHERE type = "participant"
GROUP BY joined
SORT joined DESC
```

## 이탈자
```dataview
LIST
FROM "10_Participants"
WHERE type = "participant" AND status = "dropped"
```
