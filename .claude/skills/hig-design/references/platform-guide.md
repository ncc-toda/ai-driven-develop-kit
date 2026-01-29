# プラットフォーム別設計ガイド

## iOS

### iOS 必須対応

- Dynamic Type（200% 以上拡大）
- セーフエリア（ノッチ、ホームインジケータ）
- タップターゲット 44x44pt 以上
- VoiceOver ラベル

### iOS ナビゲーション

```text
画面数が少ない → NavigationStack
画面数が多い → TabView (最大 5 タブ)
```

### iOS 推奨パターン

```swift
// 標準的な iOS アプリ構造
TabView {
    NavigationStack {
        ContentView()
    }
    .tabItem { Label("ホーム", systemImage: "house") }
    // ...
}
```

## iPadOS

### iPadOS 必須対応

- マルチタスク（Split View, Slide Over）
- Size Classes 対応
- ドラッグ＆ドロップ
- キーボードショートカット

### iPadOS ナビゲーション

```text
compact → TabView または NavigationStack
regular → NavigationSplitView（2 列または 3 列）
```

### iPadOS 推奨パターン

```swift
@Environment(\.horizontalSizeClass) var sizeClass

var body: some View {
    if sizeClass == .compact {
        // iPhone ライクなレイアウト
        TabView { /* ... */ }
    } else {
        // iPad 向けサイドバー
        NavigationSplitView { /* ... */ }
    }
}
```

## macOS

### macOS 必須対応

- キーボードナビゲーション
- メニューバー統合
- ウィンドウリサイズ対応
- Touch Bar（対応機種）

### macOS ナビゲーション

```text
シンプル → NavigationSplitView (2 列)
複雑 → NavigationSplitView (3 列) または NSBrowser
設定 → Settings シーン
```

### macOS 推奨パターン

```swift
// macOS アプリ構造
NavigationSplitView {
    List(selection: $selection) { /* サイドバー */ }
        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
} detail: {
    DetailView()
}
.commands {
    CommandGroup(after: .newItem) {
        Button("新規作成") { }.keyboardShortcut("n")
    }
}
```

## watchOS

### watchOS 制約

- 共有/共同作業機能なし
- 不確定プログレスインジケータ禁止
- Dynamic Type 140% 以上

### watchOS ナビゲーション

```text
リスト → List + NavigationLink
ページ → TabView (PageTabViewStyle)
```

### watchOS 推奨パターン

```swift
// watchOS アプリ構造
NavigationStack {
    List {
        NavigationLink("項目 1") { DetailView() }
        NavigationLink("項目 2") { DetailView() }
    }
    .navigationTitle("アプリ名")
}
```

## visionOS

### visionOS 必須対応

- 空間コンピューティング考慮
- マテリアルでコントロール区別
- セキュア入力（装着者のみ表示）

### visionOS レイアウト

```text
ウィンドウ → 標準ウィンドウスタイル
ボリューム → 3D コンテンツ
フルスペース → イマーシブ体験
```

### visionOS 推奨パターン

```swift
// visionOS コントロール
Button("アクション") { }
    .buttonStyle(.borderedProminent)
    .background(.regularMaterial)

// Ornament（ウィンドウ外 UI）
.ornament(attachmentAnchor: .scene(.bottom)) {
    HStack { /* ツールバー */ }
}
```

## クロスプラットフォーム設計

### 共通化のポイント

```swift
// 共通のビジネスロジック
class ViewModel: ObservableObject { /* ... */ }

// プラットフォーム別 View
#if os(iOS)
struct ContentView: View { /* iOS 版 */ }
#elseif os(macOS)
struct ContentView: View { /* macOS 版 */ }
#endif
```

### 条件付きコンパイル

```swift
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif

#if os(macOS)
    .frame(minWidth: 400, minHeight: 300)
#endif
```
