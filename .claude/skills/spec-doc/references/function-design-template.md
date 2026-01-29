# 機能設計書テンプレ：{機能名}

## 0. 概要

- 目的（この機能でユーザーが達成すること）：
- 対象画面：
  - "{画面名}"
- 非対象（やらないこと）：
- 前提条件（ログイン要否 / 権限 / 外部連携 など）：
- 依存（他機能 / 外部サービス / OS 機能）：

## 1. スコープ

```yaml
scope:
  in:
    - ""
  out:
    - ""
  assumptions:
    - ""
  constraints:
    - ""
```

## 2. 用語・データ定義（ドメイン）

```yaml
domain:
  terms:
    - term: ""
      description: ""
  entities:
    - name: ""
      identity:
        primaryKey: ""
      fields:
        - name: ""
          type: ""
          required: true
          description: ""
  valueObjects:
    - name: ""
      rules:
        - ""
```

## 3. ユースケース（振る舞い）

```yaml
useCases:
  - name: ""
    goal: ""
    primaryActor: ""
    preconditions:
      - ""
    trigger:
      - ""
    mainFlow:
      - step: 1
        user: ""
        system: ""
      - step: 2
        user: ""
        system: ""
    alternativeFlows:
      - name: ""
        condition: ""
        flow:
          - step: 1
            system: ""
    errorFlows:
      - name: ""
        condition: ""
        userFacing:
          feedback: "" # toast | snackbar | dialog | inline | bottomSheet
          message: ""
        recovery:
          - ""
    postconditions:
      - ""
```

## 4. 画面との対応（画面設計書とのリンク）

```yaml
uiMapping:
  relatedScreens:
    - screenName: ""
      interactions:
        - interactionId: ""
          description: ""
      dataContract:
        queries:
          - ""
        mutations:
          - ""
      state:
        - "" # initial | loading | empty | error | success
```

## 5. 入出力（データ契約）

```yaml
dataContract:
  inputs:
    params:
      - name: ""
        type: ""
        required: true
        description: ""
    context:
      - "" # inAppNavigation | pushNotification | deepLink | widget | externalIntent
  outputs:
    uiState:
      - name: "status"
        type: "Status" # initial | loading | empty | error | success
  queries:
    - name: ""
      purpose: ""
      source: "" # remoteApi | localDb | cache
      target: ""
      request:
        - name: ""
          type: ""
          required: false
      response:
        - name: ""
          type: ""
          required: true
      cachePolicy:
        strategy: "" # none | memory | persistent
        ttlSeconds: 0
      retryPolicy:
        enabled: true
        maxAttempts: 0
        backoff: "" # none | linear | exponential
  mutations:
    - name: ""
      purpose: ""
      source: "" # remoteApi | localDb
      target: ""
      request:
        - name: ""
          type: ""
          required: true
      successEffects:
        - kind: "" # toast | snackbar | dialog | inline | bottomSheet | refresh | navigation
          message: ""
          targetQuery: ""
          navigation:
            action: "" # pop | push | replace | popToRoot
            destination: ""
      failureEffects:
        - kind: "" # inlineError | dialog | toast | snackbar
          message: ""
          target: ""
      idempotency:
        enabled: true
        strategy: "" # disableWhileLoading | debounce | idempotencyKey
```

## 6. 状態設計（State）

```yaml
state:
  stateModel:
    name: ""
    fields:
      - name: "status"
        type: "Status"
      - name: ""
        type: ""
  transitions:
    - from: "initial"
      to: "loading"
      when: ""
    - from: "loading"
      to: "success"
      when: ""
    - from: "loading"
      to: "empty"
      when: ""
    - from: "loading"
      to: "error"
      when: ""
  invariants:
    - ""
```

## 7. エラー・例外設計（モバイル前提）

```yaml
errorHandling:
  network:
    offline:
      classification: "recoverable"
      userFeedback:
        kind: "" # snackbar | toast | dialog
        message: ""
      recovery:
        - ""
    timeout:
      classification: "recoverable"
      userFeedback:
        kind: "dialog"
        title: ""
        message: ""
  auth:
    expired:
      classification: "recoverable"
      effects:
        - type: "navigation"
          action: "replace"
          destination: ""
  permissions:
    - permission: "" # photos | notifications | location | camera | microphone
      whenRequired: ""
      denied:
        classification: "recoverable"
        userFeedback:
          kind: "dialog"
          title: ""
          message: ""
          actions:
            - "openSettings"
            - "cancel"
  data:
    inconsistency:
      classification: "recoverable"
      userFeedback:
        kind: "inline"
        target: ""
        message: ""
```

## 8. 非機能要件（品質）

```yaml
quality:
  performance:
    targets:
      initialLoadMs: 0
      interactionResponseMs: 0
    strategy:
      - ""
  reliability:
    strategy:
      - ""
  securityPrivacy:
    dataSensitivity:
      - ""
    loggingPolicy:
      allow:
        - ""
      deny:
        - ""
  accessibility:
    tapTargetMinDp: 44
    screenReader:
      required: true
```

## 9. ログ / アナリティクス

```yaml
analytics:
  events:
    - name: ""
      when: "" # viewAppear | interaction | querySuccess | queryFailure | mutationSuccess | mutationFailure
      params:
        - key: ""
          value: ""
logging:
  level: "" # debug | info | warn | error
  redact:
    - "" # 秘匿すべきキー名や項目
```

## 10. テスト設計

```yaml
tests:
  unit:
    - ""
  integration:
    - ""
  e2e:
    - ""
  scenarios:
    - name: ""
      given:
        - ""
      when:
        - ""
      then:
        - ""
```

## 11. 受け入れ基準（Acceptance Criteria）

```yaml
acceptanceCriteria:
  - id: "AC-001"
    description: ""
  - id: "AC-002"
    description: ""
```
