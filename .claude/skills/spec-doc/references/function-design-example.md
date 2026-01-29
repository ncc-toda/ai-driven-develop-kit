# 機能設計書例：おすすめ一覧取得（ホーム）

## 0. 概要

- 目的（この機能でユーザーが達成すること）：ホーム画面でおすすめコンテンツを取得して閲覧できる
- 対象画面：
  - "ホーム"
- 非対象（やらないこと）：
  - レコメンドロジック自体の実装（サーバー側の責務）
  - オフライン時のローカルキャッシュ生成（表示のみは行うが学習・生成はしない）
- 前提条件（ログイン要否 / 権限 / 外部連携 など）：ログイン必須
- 依存（他機能 / 外部サービス / OS 機能）：
  - 認証（アクセストークン取得/更新）
  - バックエンド API（おすすめ取得）
  - ネットワーク接続

## 1. スコープ

```yaml
scope:
  in:
    - "ホーム表示時におすすめ一覧を取得する"
    - "Pull-to-Refresh で再取得できる"
    - "取得結果に応じて loading/empty/error/success を出し分ける"
    - "メモリキャッシュ（TTL あり）で短時間の再取得を抑制する"
  out:
    - "おすすめ生成（ランキング/パーソナライズ）のアルゴリズム"
    - "既読・お気に入りなどのユーザー行動のサーバー反映"
  assumptions:
    - "おすすめはサーバーが返す順序をそのまま表示する"
    - "レスポンスはページングなし（最大 N 件）"
  constraints:
    - "画面操作に対して二重取得が起きないよう抑制する"
```

## 2. 用語・データ定義（ドメイン）

```yaml
domain:
  terms:
    - term: "Recommendation"
      description: "ユーザーに提示するおすすめコンテンツ（記事/動画/商品など抽象）"
    - term: "TTL"
      description: "キャッシュ有効期限（Seconds）"
  entities:
    - name: "Recommendation"
      identity:
        primaryKey: "id"
      fields:
        - name: "id"
          type: "string"
          required: true
          description: "一意な ID"
        - name: "title"
          type: "string"
          required: true
          description: "表示タイトル"
        - name: "thumbnailUrl"
          type: "string"
          required: false
          description: "サムネイル URL"
        - name: "detailRoute"
          type: "string"
          required: true
          description: "詳細画面への遷移先（ルート/識別子）"
  valueObjects:
    - name: "Status"
      rules:
        - "initial | loading | empty | error | success のいずれか"
```

## 3. ユースケース（振る舞い）

```yaml
useCases:
  - name: "おすすめを表示する"
    goal: "ユーザーがホームでおすすめ一覧を見て詳細へ進める"
    primaryActor: "ログイン済みユーザー"
    preconditions:
      - "ログイン済み"
      - "ネットワーク接続がある（ない場合はオフライン扱い）"
    trigger:
      - "ホーム画面を開く"
    mainFlow:
      - step: 1
        user: "ホームを開く"
        system: "状態を loading にし、fetchRecommendations を開始する"
      - step: 2
        user: "待つ"
        system: "レスポンス受信後、items を更新する"
      - step: 3
        user: "おすすめ一覧を閲覧する"
        system: "items が 1 件以上なら success 表示、0 件なら empty 表示にする"
      - step: 4
        user: "おすすめ項目をタップする"
        system: "詳細画面へ遷移する"
    alternativeFlows:
      - name: "Pull-to-Refresh で再取得"
        condition: "ユーザーが一覧を下に引っ張る"
        flow:
          - step: 1
            system: "fetchRecommendations を再実行し、結果で一覧を更新する"
    errorFlows:
      - name: "通信失敗"
        condition: "API 呼び出しが失敗（timeout/5xx など）"
        userFacing:
          feedback: "snackbar"
          message: "取得に失敗しました"
        recovery:
          - "再試行ボタンまたは Pull-to-Refresh で再取得できる"
      - name: "オフライン"
        condition: "ネットワーク未接続"
        userFacing:
          feedback: "snackbar"
          message: "オフラインです"
        recovery:
          - "オンライン復帰後に再試行できる"
    postconditions:
      - "おすすめが表示されている、または empty/error 状態がユーザーに伝わっている"
```

## 4. 画面との対応（画面設計書とのリンク）

```yaml
uiMapping:
  relatedScreens:
    - screenName: "ホーム"
      interactions:
        - interactionId: "pullToRefresh"
          description: "ユーザーがスワイプして再取得する"
        - interactionId: "tapRecommendationItem"
          description: "おすすめ項目をタップして詳細へ"
      dataContract:
        queries:
          - "fetchRecommendations"
        mutations: []
      state:
        - "initial"
        - "loading"
        - "empty"
        - "error"
        - "success"
```

## 5. 入出力（データ契約）

```yaml
dataContract:
  inputs:
    params: []
    context:
      - "inAppNavigation"
  outputs:
    uiState:
      - name: "status"
        type: "Status"
  queries:
    - name: "fetchRecommendations"
      purpose: "ホーム表示用のおすすめ一覧を取得する"
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
      retryPolicy:
        enabled: true
        maxAttempts: 2
        backoff: "exponential"
  mutations: []
```

## 6. 状態設計（State）

```yaml
state:
  stateModel:
    name: "HomeState"
    fields:
      - name: "status"
        type: "Status"
      - name: "items"
        type: "Recommendation[]"
      - name: "lastFetchedAt"
        type: "DateTime"
  transitions:
    - from: "initial"
      to: "loading"
      when: "画面表示開始（onAppear）"
    - from: "loading"
      to: "success"
      when: "items.length > 0"
    - from: "loading"
      to: "empty"
      when: "items.length == 0"
    - from: "loading"
      to: "error"
      when: "API 失敗（offline/timeout/5xx）"
  invariants:
    - "status == success のとき items.length > 0"
    - "status == empty のとき items.length == 0"
```

## 7. エラー・例外設計（モバイル前提）

```yaml
errorHandling:
  network:
    offline:
      classification: "recoverable"
      userFeedback:
        kind: "snackbar"
        message: "オフラインです"
      recovery:
        - "Pull-to-Refresh で再試行"
    timeout:
      classification: "recoverable"
      userFeedback:
        kind: "dialog"
        title: "通信エラー"
        message: "時間がかかっています。再試行してください"
  auth:
    expired:
      classification: "recoverable"
      effects:
        - type: "navigation"
          action: "replace"
          destination: "ログイン"
  permissions: []
  data:
    inconsistency:
      classification: "recoverable"
      userFeedback:
        kind: "inline"
        target: "content"
        message: "データの取得に失敗しました"
```

## 8. 非機能要件（品質）

```yaml
quality:
  performance:
    targets:
      initialLoadMs: 800
      interactionResponseMs: 100
    strategy:
      - "スケルトン表示で体感待ちを軽減する"
      - "TTL 内はメモリキャッシュを優先する"
  reliability:
    strategy:
      - "一時失敗は最大 2 回までリトライする"
      - "例外は握りつぶさず UI に反映する（error 状態）"
  securityPrivacy:
    dataSensitivity:
      - "Recommendation は個人情報を含まない想定"
    loggingPolicy:
      allow:
        - "status 遷移"
        - "API 成功/失敗（エラー種別）"
      deny:
        - "アクセストークン"
        - "ユーザー識別子（必要なら匿名化）"
  accessibility:
    tapTargetMinDp: 44
    screenReader:
      required: true
```

## 9. ログ / アナリティクス

```yaml
analytics:
  events:
    - name: "screen_view"
      when: "viewAppear"
      params:
        - key: "screenName"
          value: "ホーム"
    - name: "fetch_recommendations_success"
      when: "querySuccess"
      params:
        - key: "count"
          value: "{items.length}"
    - name: "fetch_recommendations_failure"
      when: "queryFailure"
      params:
        - key: "reason"
          value: "{offline|timeout|serverError}"
logging:
  level: "info"
  redact:
    - "accessToken"
    - "userId"
```

## 10. テスト設計

```yaml
tests:
  unit:
    - "items.length に応じて status が success/empty に分岐する"
    - "API 失敗時に status が error へ遷移する"
    - "TTL 内は再取得を抑制する（キャッシュ優先）"
  integration:
    - "fetchRecommendations が成功したら RecommendationList に反映される"
    - "pullToRefresh で再取得し、表示が更新される"
  e2e:
    - "ホーム→おすすめタップ→詳細へ遷移できる"
  scenarios:
    - name: "初回表示で成功"
      given:
        - "ログイン済み"
        - "API が items を返す"
      when:
        - "ホームを開く"
      then:
        - "loading が表示される"
        - "success になり一覧が表示される"
    - name: "初回表示で空"
      given:
        - "ログイン済み"
        - "API が空配列を返す"
      when:
        - "ホームを開く"
      then:
        - "empty が表示される"
    - name: "オフラインで失敗"
      given:
        - "ログイン済み"
        - "オフライン"
      when:
        - "ホームを開く"
      then:
        - "snackbar に『オフラインです』が出る"
        - "error 状態に遷移する"
```

## 11. 受け入れ基準（Acceptance Criteria）

```yaml
acceptanceCriteria:
  - id: "AC-001"
    description: "ホーム表示時におすすめが取得され、件数>0 なら一覧が表示される"
  - id: "AC-002"
    description: "取得結果が 0 件なら EmptyState が表示される"
  - id: "AC-003"
    description: "取得に失敗した場合、ErrorState が表示され、再試行できる"
  - id: "AC-004"
    description: "Pull-to-Refresh でおすすめを再取得できる"
  - id: "AC-005"
    description: "TTL 内の再表示では過剰な再取得が起きない"
```
