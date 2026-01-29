# 画面設計書例：ホーム

## 0. 概要

- 目的（この画面でユーザーが達成すること）：おすすめコンテンツを確認し、詳細へ遷移できる
- 想定ユーザー：ログイン済みの一般ユーザー
- 表示条件（ログイン要否 / 権限 / 初回のみ など）：ログイン必須
- 関連機能：おすすめ取得 / タブナビ

## 1. 画面フロー（モバイル前提）

```yaml
navigation:
  from:
    - "スプラッシュ"
  to:
    - "詳細"
    - "設定"
  presentation:
    type: "push"
    canDismiss: true
    dismissMethods:
      - "back"
      - "swipe"
      - "systemBack"
  backBehavior:
    ios:
      - "backButton"
      - "swipeBack"
    android:
      - "systemBack"
      - "gestureBack"
  deepLink:
    enabled: false
    scheme: "app"
    path: "/home"
    params: []
  entryPoints:
    - "inAppNavigation"
```

## 2. レイアウト（情報設計）

```yaml
layout:
  safeArea:
    top: true
    bottom: true
  scaffold:
    hasTopBar: true
    hasBottomBar: true
    hasFloatingAction: false
  areas:
    - id: "topBar"
      role: "topBar"
      content:
        title: "ホーム"
        actions:
          - id: "settingsButton"
            kind: "iconButton"
            label: "設定"
            icon: "settings"
            visibleWhen: "always"
            enabledWhen: "state.status != 'loading'"
    - id: "content"
      role: "content"
      content:
        scroll: true
        sections:
          - id: "recommendations"
            component: "RecommendationList"
            visibleWhen: "state.status == 'success'"
          - id: "empty"
            component: "EmptyState"
            visibleWhen: "state.status == 'empty'"
          - id: "error"
            component: "ErrorState"
            visibleWhen: "state.status == 'error'"
    - id: "bottomBar"
      role: "bottomBar"
      content:
        title: ""
        actions: []
  overlays:
    - id: "globalLoading"
      kind: "loadingOverlay"
      visibleWhen: "state.status == 'loading' && blocking == true"
  notes:
    - "主要 CTA は親指が届く下部に寄せる"
```

## 3. UI 要素（コンポーネント）一覧（再利用想定）

```yaml
uiElements:
  - id: "settingsButton"
    name: "設定ボタン"
    role: "設定画面へ遷移"
    reusable: true
    states:
      - "default"
      - "disabled"
    props: []
    accessibility:
      label: "設定"
      hint: "設定画面を開きます"
  - id: "recommendations"
    name: "おすすめ一覧"
    role: "おすすめコンテンツの一覧表示"
    reusable: true
    states:
      - "default"
      - "loading"
      - "error"
    props:
      - name: "items"
        type: "Recommendation[]"
        required: true
        description: "おすすめ一覧"
    accessibility:
      label: "おすすめ一覧"
      hint: ""
```

## 4. 文言（i18n 前提ならキーも）

```yaml
copy:
  - key: "home.title"
    place: "topBar.title"
    text: "ホーム"
    notes: ""
  - key: "home.empty.title"
    place: "emptyState.title"
    text: "おすすめがありません"
    notes: ""
```

## 5. 入出力（データ契約）

```yaml
dataContract:
  inputs:
    routeParams: []
    entryContext:
      - "inAppNavigation"
  queries:
    - name: "fetchRecommendations"
      source: "remoteApi"
      target: "/recommendations"
      request: []
      response:
        - name: "items"
          type: "Recommendation[]"
          required: true
      cachePolicy:
        strategy: "memory"
        ttlSeconds: 300
      refetchPolicy:
        - "onFirstView"
        - "onPullToRefresh"
  mutations: []
```

## 6. 状態設計（State）

```yaml
state:
  model:
    name: "HomeState"
    fields:
      - name: "status"
        type: "Status"
      - name: "items"
        type: "Recommendation[]"
  views:
    initial:
      description: "初回表示。表示と同時に取得を開始する"
    loading:
      description: "取得中はスケルトン表示。ブロッキングはしない"
      ui:
        - kind: "skeleton"
          target: "content"
    empty:
      description: "items が 0 件のとき"
      condition: "items.length == 0"
      ui:
        component: "EmptyState"
        primaryAction:
          label: "再読み込み"
          interactionId: "pullToRefresh"
    error:
      description: "取得に失敗したとき"
      retryable: true
      ui:
        component: "ErrorState"
        retryAction:
          label: "再試行"
          interactionId: "tapRetryFetch"
    success:
      description: "items が表示されている"
  partialUpdates:
    pagination:
      enabled: false
      mode: "paging"
    optimisticUpdate:
      enabled: false
    pullToRefresh:
      enabled: true
```

## 7. ユーザー操作とイベント

```yaml
interactions:
  - id: "tapSettings"
    trigger:
      type: "tap"
      target: "settingsButton"
    preconditions:
      - "state.status != 'loading'"
    validation: []
    action:
      type: "navigation"
      name: ""
      payloadFrom: ""
    onSuccess:
      - type: "navigation"
        action: "push"
        destination: "設定"
    onFailure: []
  - id: "pullToRefresh"
    trigger:
      type: "swipe"
      target: "content"
    preconditions:
      - "state.status != 'loading'"
    validation: []
    action:
      type: "query"
      name: "fetchRecommendations"
      payloadFrom: ""
    onSuccess:
      - type: "feedback"
        kind: "snackbar"
        message: "更新しました"
    onFailure:
      - type: "feedback"
        kind: "snackbar"
        message: "更新に失敗しました"
```

## 8. バリデーション / 入力制約

```yaml
validation:
  fields: []
  submitEnabledWhen: []
```

## 9. エラーハンドリング（モバイル前提）

```yaml
errorHandling:
  network:
    offline:
      feedback:
        kind: "snackbar"
        message: "オフラインです"
      retry:
        enabled: true
        interactionId: "pullToRefresh"
    timeout:
      feedback:
        kind: "dialog"
        title: "通信エラー"
        message: "時間がかかっています。再試行してください"
  auth:
    expired:
      effects:
        - type: "navigation"
          action: "replace"
          destination: "ログイン"
  permissions: []
  dataInconsistency:
    feedback:
      kind: "inlineError"
      target: "content"
```

## 10. アクセシビリティ / UX（モバイル前提）

```yaml
ux:
  accessibility:
    focusOrder:
      - "settingsButton"
      - "content"
    labels:
      - target: "settingsButton"
        label: "設定"
        hint: "設定画面を開きます"
    tapTargetMinDp: 44
  ergonomics:
    oneHanded:
      primaryActionsPlacement: "adaptive"
  feedback:
    haptics:
      success: true
      error: true
  loading:
    preferSkeleton: true
  messaging:
    transientFeedback: "snackbar"
```

## 11. アナリティクス（任意）

```yaml
analytics:
  screen:
    name: "ホーム"
    onAppearEvent: "screen_view"
  events:
    - name: "tap_settings"
      when: "interaction"
      interactionId: "tapSettings"
      params:
        screenName: "ホーム"
        elementId: "settingsButton"
```

## 12. テスト観点（最低限）

```yaml
tests:
  ui:
    - "セーフエリアで欠けない"
    - "ダークモードで読める"
  states:
    - "initial"
    - "loading"
    - "empty"
    - "error"
    - "success"
  edgeCases:
    - "通信失敗でもクラッシュしない"
    - "オフライン時にスナックバーが出る"
  navigation:
    backBehavior:
      ios:
        - "スワイプ戻るで想定どおり"
      android:
        - "戻るボタンで想定どおり"
  lifecycle:
    - "バックグラウンド→復帰で再取得条件が守られる"
```
