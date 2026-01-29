# コンポーネント選択ガイド

## コンテンツ表示

### テキスト主体のリスト

```text
用途: 設定、メニュー、連絡先など
├─ SwiftUI: List + NavigationLink
├─ UIKit: UITableView
└─ 実装ポイント:
   - 階層移動 → NavigationLink / DisclosureIndicator
   - 詳細情報 → detailButton（階層移動には使わない）
   - セクション分け → Section
```

### 画像/ビジュアル主体

```text
用途: フォトギャラリー、商品一覧など
├─ SwiftUI: LazyVGrid / LazyHGrid
├─ UIKit: UICollectionView + Compositional Layout
└─ 実装ポイント:
   - 変更時アニメーション → withAnimation
   - 可変サイズ → adaptive(minimum:)
```

### 階層ナビゲーション

```text
用途: メール、ファイル管理など
├─ SwiftUI: NavigationSplitView
├─ UIKit: UISplitViewController
└─ 実装ポイント:
   - preferredDisplayMode で初期表示制御
   - Size Classes で compact/regular 切替
   - 選択状態を常に強調表示
```

### データ可視化

```text
用途: 統計、ヘルスデータなど
├─ SwiftUI/UIKit: Charts Framework (iOS 16+)
└─ 実装ポイント:
   - アクセシビリティ自動対応
   - オーディオグラフ対応
   - Dynamic Type 対応
```

## 入力コンポーネント

| 用途           | SwiftUI               | UIKit                           |
| :------------- | :-------------------- | :------------------------------ |
| 単一行テキスト | `TextField`           | `UITextField`                   |
| 複数行テキスト | `TextEditor`          | `UITextView`                    |
| パスワード     | `SecureField`         | `UITextField` (secureTextEntry) |
| 選択（少数）   | `Picker`              | `UISegmentedControl`            |
| 選択（多数）   | `Picker` (wheel/menu) | `UIPickerView`                  |
| 日付           | `DatePicker`          | `UIDatePicker`                  |
| ON/OFF         | `Toggle`              | `UISwitch`                      |
| スライダー     | `Slider`              | `UISlider`                      |
| ステッパー     | `Stepper`             | `UIStepper`                     |

## アクション

| 用途             | SwiftUI                       | UIKit                              |
| :--------------- | :---------------------------- | :--------------------------------- |
| 主要アクション   | `Button` (.borderedProminent) | `UIButton`                         |
| 副次アクション   | `Button` (.bordered)          | `UIButton`                         |
| 破壊的アクション | `Button` (role: .destructive) | `UIButton` (tintColor: .systemRed) |
| 共有             | `ShareLink`                   | `UIActivityViewController`         |
| メニュー         | `Menu`                        | `UIMenu`                           |

## フィードバック

| 重要度             | SwiftUI                   | UIKit                            |
| :----------------- | :------------------------ | :------------------------------- |
| 重大（データ損失） | `.alert`                  | `UIAlertController`              |
| 中程度（操作結果） | `.overlay` (Toast)        | カスタム HUD                     |
| 軽微（状態変化）   | インライン + ハプティクス | インライン + UIFeedbackGenerator |
| 進捗               | `ProgressView`            | `UIProgressView`                 |
