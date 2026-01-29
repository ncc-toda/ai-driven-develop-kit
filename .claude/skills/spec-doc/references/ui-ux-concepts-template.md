# UI/UX 方針テンプレート：{プロダクト名}

## 0. このドキュメントの目的

- このドキュメントが決めること：
- このドキュメントが決めないこと（別資料へ）：
- 想定読者（自分 / 共同開発者 / AI コーディングエージェント）：
- 適用範囲：全体 / 特定機能（{機能名}）/ 特定画面群（{画面名...}）
- 更新ルール：更新者 / 更新タイミング / バージョン付け（任意）

---

## 1. ターゲットユーザー / セグメント

```yaml
targetUsers:
  primarySegments:
    - name: ""
      summary: ""
      goals:
        - ""
      pains:
        - ""
      usageContext:
        device: "" # phone | tablet
        environment:
          - "" # commuting | home | work | outdoor | oneHanded
        frequency: "" # daily | weekly | occasional
        sessionLength: "" # short | medium | long
      accessibilityNeeds:
        - ""
  secondarySegments:
    - name: ""
      summary: ""
      goals:
        - ""
      pains:
        - ""
```

---

## 2. ペルソナ（代表例）

```yaml
personas:
  - id: "PER-001"
    name: ""
    ageRange: ""
    jobOrRole: ""
    techLiteracy: "" # low | mid | high
    motivations:
      - ""
    frustrations:
      - ""
    topTasks:
      - ""
    constraints:
      - ""
    quotes:
      - ""
```

---

## 3. プロダクト原則（UX Principles）

```yaml
principles:
  - id: "P-001"
    name: ""
    description: ""
    priority: 1
    do:
      - ""
    dont:
      - ""
```

---

## 4. トンマナ / UI 方針（Look & Feel）

```yaml
uiDirection:
  toneAndManner:
    keywords:
      - ""
    antiKeywords:
      - ""
  brandImpression:
    wantToFeel:
      - ""
    avoidFeeling:
      - ""
  visualStyle:
    density: "" # compact | standard | comfortable
    cornerRadius: "" # small | medium | large
    elevation: "" # flat | subtle | strong
    imagery:
      use: "" # illustration | photo | none | mixed
      notes:
        - ""
  typography:
    tone: "" # friendly | formal | neutral
    emphasisRule:
      - ""
  colorUsage:
    primaryRole: ""
    accentRole: ""
    statusColors:
      success: ""
      warning: ""
      error: ""
      info: ""
  iconography:
    style: "" # outline | filled | mixed
    rule:
      - ""
  motion:
    level: "" # none | subtle | standard | expressive
    durationMs:
      micro: 0
      normal: 0
```

---

## 5. 情報設計方針（IA / Navigation）

```yaml
informationArchitecture:
  globalNavigation:
    pattern: "" # tabBar | bottomNavigation | drawer | none
    items:
      - name: ""
        destination: ""
  hierarchy:
    rules:
      - ""
  deepLink:
    enabled: false
    policy:
      - ""
  backBehavior:
    ios:
      - "" # swipeBack | backButton
    android:
      - "" # systemBack | gestureBack
  emptyToAction:
    policy:
      - ""
```

---

## 6. コンテンツ設計（Copy / Tone）

```yaml
copyTone:
  voice: "" # friendly | professional | playful | calm
  pointOfView: "" # 例: "です/ます" など
  styleRules:
    - ""
  terminology:
    preferred:
      - from: ""
        to: ""
    avoid:
      - ""
  errorMessages:
    template:
      - "何が起きたか"
      - "どうすればよいか"
  i18n:
    enabled: false
    policy:
      - ""
```

---

## 7. レイアウト・可読性（Layout / Readability）

```yaml
layout:
  safeArea:
    top: true
    bottom: true
  spacing:
    baseUnit: 4 # 4 or 8
    rhythmRule:
      - ""
  thumbReach:
    primaryActionsPlacement: "" # bottom | adaptive
  lists:
    rules:
      - ""
  responsive:
    breakpoints:
      phone: true
      tablet: false
```

---

## 8. コンポーネント方針（UI Components）

```yaml
components:
  buttons:
    variants:
      - name: "" # primary | secondary | tertiary | destructive
        usage:
          - ""
        states:
          - default
          - disabled
          - loading
  inputs:
    rules:
      - ""
    validationTiming:
      - "" # onBlur | onSubmit | realtime
  dialogs:
    useWhen:
      - ""
    avoidWhen:
      - ""
  bottomSheet:
    useWhen:
      - ""
  toastsAndSnackbars:
    policy:
      transientFeedback: "" # toast | snackbar
      durationMs: 0
  loading:
    defaultPattern: "" # skeleton | spinner | shimmer
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
    showWithinMs: 0
    blocking:
      allowed: false
      useWhen:
        - ""
  empty:
    tone: "" # encouraging | neutral
    actions:
      - ""
  error:
    retry:
      enabled: true
      placement: "" # inline | page | dialog
    offline:
      message: ""
      recovery:
        - ""
  success:
    confirmation:
      pattern: "" # toast | inline | haptic
```

---

## 10. フィードバック設計（Feedback）

```yaml
feedback:
  haptics:
    enabled: true
    useWhen:
      success:
        - ""
      error:
        - ""
  animations:
    enabled: true
    durationMs:
      micro: 0
      normal: 0
  prevention:
    doubleSubmit:
      strategy: "" # disableWhileLoading | debounce | idempotencyKey
```

---

## 11. アクセシビリティ（A11y）

```yaml
accessibility:
  minimumTapTargetDp: 44
  contrast:
    target: "" # AA | AAA | notSpecified
  screenReader:
    required: true
    labelsPolicy:
      - ""
  focus:
    orderPolicy:
      - ""
  motion:
    reduceMotion:
      supported: true
      policy:
        - ""
```

---

## 12. モバイル特有（通知・権限・オフライン）

```yaml
mobile:
  permissions:
    requestTiming:
      - ""
    denialHandling:
      - "explainReason"
      - "openSettingsOption"
  notifications:
    strategy:
      - ""
  offline:
    strategy: "" # readOnly | cachedView | block
```

---

## 13. 計測（Analytics）方針

```yaml
analyticsPolicy:
  naming:
    convention: "" # snake_case 等
  requiredEvents:
    - name: "screen_view"
      params:
        - "screenName"
    - name: ""
      params:
        - ""
  forbiddenData:
    - ""
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
      firstContentfulMs: 0
      interactionResponseMs: 0
  stability:
    crashFreeSessionsTarget: 0.0
```

---

## 15. designTokens

```yaml
designTokens:
  purpose: ""
  tokens:
    color:
      - name: ""
        usage: ""
    spacing:
      baseUnit: 4
      scale:
        - 4
        - 8
        - 12
        - 16
    radius:
      - name: ""
        value: ""
    typography:
      - name: ""
        usage: ""
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
        - field: ""
          places: 0
  dates:
    format: "" # 例: "yyyy/MM/dd"
    timezone: "" # 例: "Asia/Tokyo"
    relativeFormat:
      enabled: false
  units:
    rules:
      - ""
  sorting:
    defaultOrder:
      - ""
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
  enabled: false
  defaultLocale: "" # 例: "ja-JP"
  supportedLocales:
    - ""
  strategy:
    - "useKeys" # useKeys | hardcode
  rules:
    - ""
  pluralization:
    required: false
  dateNumberLocale:
    followDeviceLocale: true
```

---

## 18. accessibilityChecklist

```yaml
accessibilityChecklist:
  must:
    - "主要ボタンに読み上げラベルがある"
    - "フォーカス順が論理的"
    - "タップ領域が最小 44dp 以上"
    - "色だけで状態を伝えない"
    - "動きは Reduce Motion に対応（可能なら）"
  should:
    - "コントラスト目標を満たす"
    - "入力エラーはテキストでも説明する"
  niceToHave:
    - "音声操作を阻害しない"
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
