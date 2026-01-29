# HIG コンポーネント (Components)

## 1. レイアウトと編成

| コンポーネント   | 用途                        | SwiftUI                   | UIKit/AppKit            |
| :--------------- | :-------------------------- | :------------------------ | :---------------------- |
| 分割ビュー       | 複数階層を一度に表示        | `NavigationSplitView`     | `UISplitViewController` |
| リスト           | テキストベース表示          | `List` + `NavigationLink` | `UITableView`           |
| コレクション     | 画像ベース表示              | `LazyVGrid`/`LazyHGrid`   | `UICollectionView`      |
| カラム表示       | 深い階層移動（macOS）       | `NavigationSplitView`     | `NSBrowser`             |
| タブビュー       | 相互排他コンテンツ（macOS） | `TabView`                 | `NSTabView`             |
| 開閉コントロール | 詳細を非表示                | `DisclosureGroup`         | `NSButton` (Disclosure) |

### レイアウト実装ポイント

- **分割ビュー**: `preferredDisplayMode`でデフォルト表示制御、Size Classes で表示切替
- **リスト**: 階層移動 →`NavigationLink`、詳細情報 →`detailButton`（混同しない）
- **コレクション**: Compositional Layout、`withAnimation`で挿入/削除アニメーション
- **タブビュー**: 最大 5 個まで、iOS/iPadOS では`Picker`を代替使用

## 2. コンテンツ

| コンポーネント | 用途                           | SwiftUI                    | UIKit            |
| :------------- | :----------------------------- | :------------------------- | :--------------- |
| グラフ         | データ可視化                   | Charts Framework (iOS 16+) | Charts Framework |
| 画像ビュー     | 画像表示（非インタラクティブ） | `Image`                    | `UIImageView`    |
| テキストビュー | 複数行編集                     | `TextEditor`               | `UITextView`     |
| Web ビュー     | 簡潔な Web 閲覧                | WKWebView                  | WKWebView        |
| ラベル         | 少量テキスト表示               | `Text`                     | `UILabel`        |

### コンテンツ実装ポイント

- **グラフ**: Charts Framework でアクセシビリティ自動対応、カスタム時はオーディオグラフ実装
- **画像ビュー**: インタラクティブにするなら`Button`に画像表示、tvOS はレイヤード画像
- **テキストビュー**: `adjustsFontForContentSizeCategory = true`で Dynamic Type 対応
- **Web ビュー**: ブラウザ構築禁止、認証 →`ASWebAuthenticationSession`
- **ラベル**: `.label`→`.secondaryLabel`→`.tertiaryLabel`→`.quaternaryLabel`で重要度表現

## 3. コンポーネント選択フローチャート

```text
コンテンツの種類は？
├─ テキスト主体 → List
├─ 画像/ビジュアル主体 → LazyVGrid/LazyHGrid
├─ 階層ナビゲーション
│   ├─ 複数階層同時表示 → NavigationSplitView
│   └─ 深い階層移動（macOS） → NSBrowser
├─ データ可視化 → Charts Framework
└─ 詳細の表示/非表示 → DisclosureGroup
```
