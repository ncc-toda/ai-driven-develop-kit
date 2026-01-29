# アクセシビリティ設計

## 必須チェック項目

### 視覚

| 項目           | 基準                         | 実装                 |
| :------------- | :--------------------------- | :------------------- |
| Dynamic Type   | 200% 拡大対応                | システムフォント使用 |
| コントラスト比 | 4.5:1（通常）/ 3:1（大文字） | セマンティックカラー |
| 色以外の識別   | 形状/アイコン併用            | アイコン + テキスト  |

### 操作

| 項目             | 基準           | 実装                                 |
| :--------------- | :------------- | :----------------------------------- |
| タップターゲット | 44x44pt 以上   | `frame(minWidth: 44, minHeight: 44)` |
| VoiceOver        | 全要素にラベル | `accessibilityLabel`                 |

## SwiftUI アクセシビリティ実装

### テキスト

```swift
// システムフォント（Dynamic Type 自動対応）
Text("見出し").font(.headline)
Text("本文").font(.body)

// カスタムフォント（スケーリング対応）
Text("カスタム")
    .font(.custom("MyFont", size: 16, relativeTo: .body))
```

### カラー

```swift
// セマンティックカラー（推奨）
Text("主要").foregroundStyle(.primary)
Text("補助").foregroundStyle(.secondary)

// ハイコントラスト対応
@Environment(\.colorSchemeContrast) var contrast
let color = contrast == .increased ? .black : .gray
```

### ラベル

```swift
// 画像にラベル
Image(systemName: "star.fill")
    .accessibilityLabel("お気に入り")

// 装飾的要素は非表示
Image("decoration")
    .accessibilityHidden(true)

// カスタムアクション
Button { } label: { Image(systemName: "trash") }
    .accessibilityLabel("削除")
    .accessibilityHint("この項目を削除します")
```

### 複合要素

```swift
// グループ化
HStack {
    Image(systemName: "person")
    Text("田中太郎")
}
.accessibilityElement(children: .combine)

// カスタム読み上げ
VStack {
    Text("¥1,000")
    Text("税込")
}
.accessibilityElement(children: .ignore)
.accessibilityLabel("税込 1,000 円")
```

### 動的コンテンツ

```swift
// 状態変化の通知
Text(status)
    .accessibilityValue(status)

// ライブリージョン（重要な更新）
Text(notification)
    .accessibilityAddTraits(.updatesFrequently)
```

## 色覚多様性対応

### 色だけに頼らない

```swift
// 悪い例
Circle().fill(isError ? .red : .green)

// 良い例
HStack {
    Image(systemName: isError ? "xmark.circle" : "checkmark.circle")
    Text(isError ? "エラー" : "成功")
}
.foregroundStyle(isError ? .red : .green)
```

### アイコンの活用

```swift
// 状態を形状で表現
Image(systemName: status.icon)
    .symbolVariant(status.variant)
    .foregroundStyle(status.color)
```

## モーション軽減対応

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation? {
    reduceMotion ? nil : .spring()
}

withAnimation(animation) {
    // アニメーション
}
```

## タップターゲット確保

```swift
// 小さいアイコンでもタップ領域確保
Button { } label: {
    Image(systemName: "info.circle")
        .font(.caption)
}
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle())
```
