# 기여 가이드

AI 실습 스터디 볼트에 오신 걸 환영합니다. 이 가이드는 60명의 참가자가 충돌 없이 함께 지식베이스를 만드는 방법을 설명합니다.

## 핵심 원칙

1. **내 폴더에서 먼저 작업** — `personal/P###_이름/`은 본인만 씁니다 (git 추적 됨, 모두 읽기 가능)
2. **공유 파일 직접 수정 금지** — `wiki/` 폴더는 스킬이나 Vault Keeper를 통해서만 수정
3. **inbox에 자유롭게 드롭** — 형식 몰라도 됩니다, 주간 트리아지에서 정리됩니다

## 처음 시작하기

### 1. 저장소 클론

```bash
git clone <repo-url>
cd ai-practice-study-2026
```

### 2. 첫 동기화

```
/vault-sync
```

최신 공유 지식베이스와 동기화하고 개인 hot cache를 갱신합니다.

### 3. 내 참가자 프로필 확인

`ops/participants/P###_이름.md` 파일을 찾아 내용을 확인하세요.

## 일상적인 학습 흐름

### 자료 정리 (개인 공간)

논문, 아티클, 강연 노트를 내 개인 공간에 정리:

```
/personal-ingest https://arxiv.org/abs/...
/personal-ingest 내파일.pdf
```

결과물은 `personal/P###_이름/notes/`에 저장됩니다. 공유 파일에 영향을 주지 않으며, git에 올라가므로 다른 참가자도 볼 수 있습니다.

### 공유 지식베이스 검색

```
/wiki-query transformer attention이 뭔가요?
/wiki-query RAG와 Fine-tuning 비교해줘
```

### 기여하기

내 노트가 다른 참가자들에게 도움이 될 것 같다면:

```
/contribute personal/P###_이름/notes/concepts/내개념노트.md
```

자동으로 PR이 생성되고 Vault Keeper가 리뷰 후 머지합니다.

### inbox 드롭

형식 없이 빠르게 공유하고 싶다면 `inbox/` 폴더에 파일을 넣어두세요.
Vault Keeper가 주간 트리아지에서 분류합니다.

## 주간 사이클

| 시점 | 할 일 |
|------|-------|
| 세션 전 | `/vault-sync` 로 최신 동기화 |
| 학습 중 | `/personal-ingest` 로 자료 정리 |
| 세션 후 | `/contribute` 또는 `inbox/` 드롭 |
| 주간 트리아지 (Vault Keeper) | inbox 정리, PR 머지, wiki-fold |

## 자주 묻는 질문

**Q. `wiki/` 폴더를 직접 수정해도 되나요?**
A. 안 됩니다. 충돌 위험이 있습니다. `/contribute` 스킬이나 `inbox/` 드롭을 사용하세요.

**Q. `personal/P###_이름/` 폴더가 없어요.**
A. 처음엔 없는 게 정상입니다. `/vault-sync`를 실행하면 자동 생성됩니다. 참가자 ID를 물어볼 것입니다.

**Q. 내 기여가 반영되는 데 얼마나 걸리나요?**
A. PR 생성 후 Vault Keeper 리뷰 → 머지까지 보통 1-3일입니다.

**Q. 공유하기엔 너무 미완성인 것 같아요.**
A. `inbox/`에 드롭하거나 PR에 `WIP:` 라벨을 달면 됩니다. 완성도와 무관하게 기여를 환영합니다.

## 스킬 목록

| 스킬 | 설명 | 권한 |
|------|------|------|
| `/vault-sync` | 최신 공유 지식 동기화 | 모든 참가자 |
| `/personal-ingest` | 소스를 개인 공간에 정리 | 모든 참가자 |
| `/wiki-query` | 공유 지식베이스 검색 | 모든 참가자 |
| `/contribute` | 개인 노트를 공유 wiki에 PR | 모든 참가자 |
| `/save` | 대화 내용을 개인 노트로 저장 | 모든 참가자 |
| `/wiki-ingest` | .raw/ 소스를 공유 wiki에 처리 | Vault Keeper 전용 |
| `/wiki-fold` | 로그 롤업 | Vault Keeper 전용 |
| `/wiki-lint` | 볼트 품질 검사 | Vault Keeper (auto-fix), 참가자 (dry-run) |
| `/autoresearch` | 토픽 자율 리서치 | Vault Keeper 전용 |
