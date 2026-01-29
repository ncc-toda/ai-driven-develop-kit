# 画面設計書テンプレ：{画面名}

## 0. 概要

- 目的（この画面でユーザーが達成すること）：
- 想定ユーザー：
- 表示条件（ログイン要否 / 権限 / 初回のみ など）：
- 関連機能：{機能名 / 機能ドキュメントへのリンク}

## 1. 画面フロー（モバイル前提）

```yaml
navigation:
  from:
    - ""
  to:
    - ""
  presentation:
    type: "" # push | modal | sheet | fullScreenModal
    canDismiss: true
    dismissMethods:
      - "" # back | swipe | closeButton | systemBack
  backBehavior:
    ios:
      - "" # backButton | swipeBack
    android:
      - "" # systemBack | gestureBack
  deepLink:
    enabled: false
    scheme: ""
    path: ""
    params:
      - name: ""
        type: ""
        required: false
        description: ""
  entryPoints:
    - "" # inAppNavigation | pushNotification | deepLink | widget | externalIntent
```

## 2. レイアウト（情報設計）

```yaml
layout:
  safeArea:
    top: true
    bottom: true
  scaffold:
    hasTopBar: true
    hasBottomBar: false
    hasFloatingAction: false
  areas:
    - id: ""
      role: "" # topBar | content | bottomBar | overlay | floatingAction
      content:
        title: ""
        actions:
          - id: ""
            kind: "" # button | iconButton | menu
            label: ""
            icon: ""
            visibleWhen: ""
            enabledWhen: ""
    - id: ""
      role: "content"
      content:
        scroll: true
        sections:
          - id: ""
            component: ""
            visibleWhen: ""
  overlays:
    - id: ""
      kind: "" # loadingOverlay | snackbar | toast | dialog | bottomSheet
      visibleWhen: ""
  notes:
    - ""
```

## 3. UI 要素（コンポーネント）一覧（再利用想定）

```yaml
uiElements:
  - id: ""
    name: ""
    role: ""
    reusable: true
    states:
      - "" # default | loading | disabled | error
    props:
      - name: ""
        type: ""
        required: false
        description: ""
    accessibility:
      label: ""
      hint: ""
```

## 4. 文言（i18n 前提ならキーも）

```yaml
copy:
  - key: ""
    place: ""
    text: ""
    notes: ""
```

## 5. 入出力（データ契約）

```yaml
dataContract:
  inputs:
    routeParams:
      - name: ""
        type: ""
        required: true
        description: ""
    entryContext:
      - "" # inAppNavigation | pushNotification | deepLink | widget | externalIntent
  queries:
    - name: ""
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
      refetchPolicy:
        - "" # onFirstView | onPullToRefresh | onResume | periodic
  mutations:
    - name: ""
      source: "" # remoteApi | localDb
      target: ""
      payloadFrom: ""
      request:
        - name: ""
          type: ""
          required: true
      successEffects:
        - kind: "" # toast | snackbar | dialog | inline | bottomSheet
          message: ""
        - kind: "refresh"
          targetQuery: ""
        - kind: "navigation"
          action: "" # pop | push | replace | popToRoot
          destination: ""
      failureEffects:
        - kind: "" # inlineError | dialog
          target: ""
          title: ""
          message: ""
      idempotency:
        enabled: true
        strategy: "" # disableWhileLoading | debounce | idempotencyKey
```

## 6. 状態設計（State）

```yaml
state:
  model:
    name: ""
    fields:
      - name: ""
        type: ""
  views:
    initial:
      description: ""
    loading:
      description: ""
      ui:
        - kind: "" # skeleton | spinner | shimmer
          target: ""
    empty:
      description: ""
      condition: ""
      ui:
        component: ""
        primaryAction:
          label: ""
          interactionId: ""
    error:
      description: ""
      retryable: true
      ui:
        component: ""
        retryAction:
          label: ""
          interactionId: ""
    success:
      description: ""
  partialUpdates:
    pagination:
      enabled: false
      mode: "" # infiniteScroll | paging
    optimisticUpdate:
      enabled: false
    pullToRefresh:
      enabled: false
```

## 7. ユーザー操作とイベント

```yaml
interactions:
  - id: ""
    trigger:
      type: "" # tap | longPress | swipe | submit | scrollEnd | appear
      target: ""
    preconditions:
      - ""
    validation:
      - rule: ""
        message: ""
        target: ""
    action:
      type: "" # navigation | query | mutation | localUpdate
      name: ""
      payloadFrom: ""
    onSuccess:
      - type: "feedback"
        kind: "" # toast | snackbar | dialog | inline
        message: ""
      - type: "navigation"
        action: "" # pop | push | replace | popToRoot
        destination: ""
    onFailure:
      - type: "feedback"
        kind: "" # inlineError | dialog | haptic
        target: ""
        style: "" # error | warning | success
```

## 8. バリデーション / 入力制約

```yaml
validation:
  fields:
    - id: ""
      fieldType: "" # text | number | email | password | date
      constraints:
        required: true
        minLength: 0
        maxLength: 0
        pattern: ""
        range:
          min: 0
          max: 0
        trim: true
        allowEmoji: true
        allowNewline: false
      inputAssist:
        keyboard: "" # default | email | number | phone
        autoCorrect: "" # enabled | disabled
  submitEnabledWhen:
    - ""
```

## 9. エラーハンドリング（モバイル前提）

```yaml
errorHandling:
  network:
    offline:
      feedback:
        kind: "" # snackbar | toast | dialog
        message: ""
      retry:
        enabled: true
        interactionId: ""
    timeout:
      feedback:
        kind: "" # dialog | snackbar
        title: ""
        message: ""
  auth:
    expired:
      effects:
        - type: "navigation"
          action: "" # replace | push
          destination: ""
  permissions:
    - permission: "" # photos | notifications | location | camera | microphone
      whenRequired: ""
      denied:
        feedback:
          kind: "" # dialog | inline
          title: ""
          message: ""
          actions:
            - "" # openSettings | cancel
  dataInconsistency:
    feedback:
      kind: "" # inlineError | dialog
      target: ""
```

## 10. アクセシビリティ / UX（モバイル前提）

```yaml
ux:
  accessibility:
    focusOrder:
      - ""
    labels:
      - target: ""
        label: ""
        hint: ""
    tapTargetMinDp: 44
  ergonomics:
    oneHanded:
      primaryActionsPlacement: "" # bottom | top | adaptive
  feedback:
    haptics:
      success: true
      error: true
  loading:
    preferSkeleton: true
  messaging:
    transientFeedback: "" # toast | snackbar
```

## 11. アナリティクス（任意）

```yaml
analytics:
  screen:
    name: ""
    onAppearEvent: ""
  events:
    - name: ""
      when: "" # interaction | mutationSuccess | mutationFailure | viewAppear
      interactionId: ""
      params:
        screenName: ""
        elementId: ""
```

## 12. テスト観点（最低限）

```yaml
tests:
  ui:
    - ""
  states:
    - "" # initial | loading | empty | error | success
  edgeCases:
    - ""
  navigation:
    backBehavior:
      ios:
        - ""
      android:
        - ""
  lifecycle:
    - ""
```
