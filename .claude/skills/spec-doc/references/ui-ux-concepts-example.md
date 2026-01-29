# UI/UX 方針例：レシピメモ（仮）

## 0. このドキュメントの目的

- このドキュメントが決めること：画面設計書・機能設計書が参照する UI/UX の共通方針（ターゲット/ペルソナ/トンマナ/状態表示/文言/操作感/A11y/計測/トークン/表示ルール）
- このドキュメントが決めないこと（別資料へ）：個別画面の詳細レイアウト、API 仕様、DB スキーマ、レコメンドアルゴリズム
- 想定読者（自分 / 共同開発者 / AI コーディングエージェント）：個人開発者、AI コーディングエージェント
- 適用範囲：全体
- 更新ルール：原則「原則・方針」を増やしすぎない（重要 3〜5 原則）。変更は必ず履歴に残し、後方互換（既存画面が破綻しない）を意識する。

---

## 1. ターゲットユーザー / セグメント

```yaml
targetUsers:
  primarySegments:
    - name: "忙しい自炊ビギナー"
      summary: "平日の短時間で、迷わず作れるレシピを探して保存したい"
      goals:
        - "今日作るものをすぐ決めたい"
        - "買い物・手順で迷いたくない"
        - "よく作るレシピをすぐ開きたい"
      pains:
        - "レシピが長くて要点がわからない"
        - "材料が多いと面倒"
        - "調理中に画面操作が面倒"
      usageContext:
        device: "phone"
        environment:
          - "home"
          - "oneHanded"
        frequency: "daily"
        sessionLength: "short"
      accessibilityNeeds:
        - "文字サイズを大きめにしたい場合がある"
        - "手順は見やすく区切って欲しい"
  secondarySegments:
    - name: "献立を回したい家庭ユーザー"
      summary: "保存レシピを回して、買い物と調理を効率化したい"
      goals:
        - "レシピを週単位で回したい"
        - "買い物リストを作りたい"
      pains:
        - "同じメニューになりがち"
        - "買い忘れが多い"
```

---

## 2. ペルソナ（代表例）

```yaml
personas:
  - id: "PER-001"
    name: "ユイ"
    ageRange: "20 代後半"
    jobOrRole: "会社員"
    techLiteracy: "mid"
    motivations:
      - "平日でも自炊を続けたい"
      - "健康的な食事にしたい"
    frustrations:
      - "レシピが冗長で、要点がすぐ掴めない"
      - "調理中に画面操作が面倒"
    topTasks:
      - "今日作るレシピを決める"
      - "材料と手順を確認する"
      - "お気に入りを開く"
    constraints:
      - "片手操作が多い"
      - "調理中は視線移動を最小化したい"
    quotes:
      - "いま作れるやつを、すぐ決めたい"
```

---

## 3. プロダクト原則（UX Principles）

```yaml
principles:
  - id: "P-001"
    name: "迷わせない"
    description: "次の一手が常に見えるようにする"
    priority: 1
    do:
      - "主要アクションは 1 画面 1 つに寄せる"
      - "空状態には次の行動を必ず用意する"
      - "手順はステップ単位で分割し、現在地がわかる"
    dont:
      - "同じ重みのボタンを並べない"
      - "専門用語で説明しない"
  - id: "P-002"
    name: "調理中でも使える"
    description: "片手・短時間・汚れた手でも扱える操作感"
    priority: 2
    do:
      - "重要操作は親指で届く位置に"
      - "タップ領域は大きく、間隔も確保する"
    dont:
      - "小さいリンクで重要操作をさせない"
      - "長文を一画面に詰め込みすぎない"
  - id: "P-003"
    name: "信頼できる表示"
    description: "状態（取得中/失敗/空）を正直に見せ、復帰導線を用意する"
    priority: 3
    do:
      - "loading/empty/error を必ず表現する"
      - "失敗時は再試行を必ず提供する"
    dont:
      - "無反応に見える UI にしない"
```

---

## 4. トンマナ / UI 方針（Look & Feel）

```yaml
uiDirection:
  toneAndManner:
    keywords:
      - "calm"
      - "warm"
      - "minimal"
    antiKeywords:
      - "noisy"
      - "cluttered"
  brandImpression:
    wantToFeel:
      - "安心して使える"
      - "手際が良くなる"
    avoidFeeling:
      - "難しそう"
      - "広告っぽい"
  visualStyle:
    density: "standard"
    cornerRadius: "medium"
    elevation: "subtle"
    imagery:
      use: "photo"
      notes:
        - "料理写真がある場合は最優先で見せる"
        - "写真がない場合はフラットなプレースホルダーを使う"
  typography:
    tone: "neutral"
    emphasisRule:
      - "強調は太字が基本。色による強調は状態（成功/警告/エラー）に限定"
  colorUsage:
    primaryRole: "主要アクション（保存/開始/完了）"
    accentRole: "タグ、ピン留め、軽い強調"
    statusColors:
      success: "green"
      warning: "orange"
      error: "red"
      info: "blue"
  iconography:
    style: "outline"
    rule:
      - "同一アイコンセットで統一し、filled は状態表現にのみ使用"
  motion:
    level: "subtle"
    durationMs:
      micro: 120
      normal: 220
```

---

## 5. 情報設計方針（IA / Navigation）

```yaml
informationArchitecture:
  globalNavigation:
    pattern: "tabBar"
    items:
      - name: "ホーム"
        destination: "ホーム"
      - name: "保存"
        destination: "保存一覧"
      - name: "設定"
        destination: "設定"
  hierarchy:
    rules:
      - "検索→一覧→詳細 の 3 段階を基本とする"
      - "詳細は『調理に必要な要点』を上に置く"
  deepLink:
    enabled: true
    policy:
      - "レシピ詳細は deep link 可能"
      - "未ログインならログインへ遷移し、成功後に元のリンクへ戻す"
  backBehavior:
    ios:
      - "swipeBack"
      - "backButton"
    android:
      - "systemBack"
      - "gestureBack"
  emptyToAction:
    policy:
      - "保存 0 件なら『検索する』を主要 CTA として提示する"
      - "検索結果 0 件なら『条件を変える』と『新規作成（任意）』を提示する"
```

---

## 6. コンテンツ設計（Copy / Tone）

```yaml
copyTone:
  voice: "calm"
  pointOfView: "です/ます"
  styleRules:
    - "短く、具体的に。1 文は長くしない"
    - "ユーザーの行動を促す動詞で終える（例：保存する/戻る/再試行）"
  terminology:
    preferred:
      - from: "登録"
        to: "保存"
      - from: "削除"
        to: "削除"
    avoid:
      - "最適化"
      - "パーソナライズ"
  errorMessages:
    template:
      - "何が起きたか（例：取得に失敗しました）"
      - "どうすればよいか（例：再試行してください）"
  i18n:
    enabled: true
    policy:
      - "画面文言はキーで管理する"
      - "ユーザー入力の値は文言に直埋めしない（プレースホルダー使用）"
```

---

## 7. レイアウト・可読性（Layout / Readability）

```yaml
layout:
  safeArea:
    top: true
    bottom: true
  spacing:
    baseUnit: 8
    rhythmRule:
      - "主要セクション間は 16〜24"
      - "要素間は 8〜16"
  thumbReach:
    primaryActionsPlacement: "adaptive"
  lists:
    rules:
      - "一覧は行間を広め（タップしやすさ優先）"
      - "行の右端に状態（保存済み等）を置く場合はアイコン＋補助テキスト"
  responsive:
    breakpoints:
      phone: true
      tablet: true
```

---

## 8. コンポーネント方針（UI Components）

```yaml
components:
  buttons:
    variants:
      - name: "primary"
        usage:
          - "保存"
          - "調理を開始"
          - "完了"
        states:
          - default
          - disabled
          - loading
      - name: "secondary"
        usage:
          - "再試行"
          - "条件を変える"
        states:
          - default
          - disabled
  inputs:
    rules:
      - "入力は最小限（検索/メモ程度）"
      - "調理中の利用を考え、重要フォームは避ける"
    validationTiming:
      - "onSubmit"
  dialogs:
    useWhen:
      - "取り返しがつかない操作（削除）"
    avoidWhen:
      - "軽微な通知（保存完了など）"
  bottomSheet:
    useWhen:
      - "選択肢が 3 つ以上で、文脈を壊したくないとき"
  toastsAndSnackbars:
    policy:
      transientFeedback: "snackbar"
      durationMs: 2500
  loading:
    defaultPattern: "skeleton"
  emptyState:
    mustInclude:
      - "reason"
      - "nextAction"
  errorState:
    mustInclude:
      - "whatHappened"
      - "recoveryAction"
```

---

## 9. 状態の見せ方（State UX）

```yaml
stateUx:
  loading:
    showWithinMs: 150
    blocking:
      allowed: false
      useWhen:
        - "初回表示で必須データがない場合のみ、短時間ブロックを許容"
  empty:
    tone: "encouraging"
    actions:
      - "検索する"
      - "条件を変える"
  error:
    retry:
      enabled: true
      placement: "page"
    offline:
      message: "オフラインです"
      recovery:
        - "オンライン復帰後に再試行できる"
  success:
    confirmation:
      pattern: "snackbar"
```

---

## 10. フィードバック設計（Feedback）

```yaml
feedback:
  haptics:
    enabled: true
    useWhen:
      success:
        - "保存完了"
      error:
        - "削除失敗"
        - "通信失敗"
  animations:
    enabled: true
    durationMs:
      micro: 120
      normal: 220
  prevention:
    doubleSubmit:
      strategy: "disableWhileLoading"
```

---

## 11. アクセシビリティ（A11y）

```yaml
accessibility:
  minimumTapTargetDp: 44
  contrast:
    target: "AA"
  screenReader:
    required: true
    labelsPolicy:
      - "アイコンボタンは必ずラベルを持つ（例：設定）"
      - "一覧の各行は『タイトル + 状態』が読み上げられる"
  focus:
    orderPolicy:
      - "上から下、左から右の自然順"
      - "モーダル表示時はモーダル内にフォーカスを閉じ込める（可能な範囲で）"
  motion:
    reduceMotion:
      supported: true
      policy:
        - "reduce motion 時は大きな移動アニメーションを抑制する"
```

---

## 12. モバイル特有（通知・権限・オフライン）

```yaml
mobile:
  permissions:
    requestTiming:
      - "必要になった瞬間に理由説明→リクエスト"
    denialHandling:
      - "explainReason"
      - "openSettingsOption"
  notifications:
    strategy:
      - "重要度が高いもののみ（例：タイマー完了）"
  offline:
    strategy: "cachedView"
```

---

## 13. 計測（Analytics）方針

```yaml
analyticsPolicy:
  naming:
    convention: "snake_case"
  requiredEvents:
    - name: "screen_view"
      params:
        - "screen_name"
    - name: "tap_primary"
      params:
        - "screen_name"
        - "element_id"
  forbiddenData:
    - "email"
    - "access_token"
    - "raw_user_input"
  sampling:
    enabled: false
    rate: 0.0
```

---

## 14. 品質基準（DoD に入れるチェック）

```yaml
qualityBar:
  uxChecklist:
    - "loading/empty/error/success が破綻していない"
    - "二重送信が起きない"
    - "戻る挙動が OS 標準に沿う"
    - "タップ領域が十分"
    - "文言が統一されている"
  performance:
    targets:
      firstContentfulMs: 800
      interactionResponseMs: 100
  stability:
    crashFreeSessionsTarget: 0.995
```

---

## 15. designTokens

```yaml
designTokens:
  purpose: "見た目と余白の一貫性を保ち、AI 実装のブレを防ぐ"
  tokens:
    color:
      - name: "brand_primary"
        usage: "主要ボタン、強調"
      - name: "text_primary"
        usage: "本文"
      - name: "surface"
        usage: "背景"
      - name: "status_error"
        usage: "エラー"
    spacing:
      baseUnit: 8
      scale:
        - 8
        - 12
        - 16
        - 24
        - 32
    radius:
      - name: "card"
        value: "12"
      - name: "button"
        value: "12"
    typography:
      - name: "title"
        usage: "画面タイトル"
      - name: "body"
        usage: "本文"
      - name: "caption"
        usage: "補助文"
```

---

## 16. contentRules

```yaml
contentRules:
  numbers:
    thousandSeparator: true
    decimalPlaces:
      default: 0
      exceptions:
        - field: "servings"
          places: 0
  dates:
    format: "yyyy/MM/dd"
    timezone: "Asia/Tokyo"
    relativeFormat:
      enabled: true
  units:
    rules:
      - "分量は g/ml/大さじ/小さじ を優先"
      - "所要時間は '分' 表記（例：15 分）"
  sorting:
    defaultOrder:
      - "更新日 desc"
  truncation:
    ellipsis: true
    maxLines:
      title: 1
      body: 2
```

---

## 17. localization

```yaml
localization:
  enabled: true
  defaultLocale: "ja-JP"
  supportedLocales:
    - "ja-JP"
    - "en-US"
  strategy:
    - "useKeys"
  rules:
    - "文言はキー管理し、画面内の直書きを避ける"
    - "単位・日付・数値はロケールに追従する（ただし表示ルールは contentRules 優先）"
  pluralization:
    required: true
  dateNumberLocale:
    followDeviceLocale: true
```

---

## 18. accessibilityChecklist

```yaml
accessibilityChecklist:
  must:
    - "アイコンボタンに読み上げラベルがある"
    - "主要導線のフォーカス順が論理的"
    - "タップ領域が最小 44dp 以上"
    - "色だけで状態を伝えない（テキスト/アイコン併用）"
    - "入力エラーはテキストで説明する"
  should:
    - "コントラスト AA 相当を満たす"
    - "一覧は行ごとに意味が読み上げられる"
  niceToHave:
    - "Reduce Motion に応じて大きな動きを抑制する"
```

---

## 19. 画面設計書・機能設計書との接続ルール

```yaml
integrationRules:
  screenSpec:
    mustReference:
      - "uiDirection"
      - "copyTone"
      - "components.loading.defaultPattern"
      - "stateUx"
      - "feedback.prevention.doubleSubmit.strategy"
      - "designTokens"
      - "contentRules"
      - "localization"
      - "accessibilityChecklist"
  featureSpec:
    mustReference:
      - "principles"
      - "stateUx.error.retry"
      - "analyticsPolicy.requiredEvents"
  overrides:
    allowed: true
    requireReasonField: true
    reasonFieldName: "notes"
```
