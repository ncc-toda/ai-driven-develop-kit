# HIG 基本要素 (Foundations)

## 1. アクセシビリティ

### 視覚的アクセシビリティ

| 項目           | 基準                                      | 実装                                                |
| :------------- | :---------------------------------------- | :-------------------------------------------------- |
| Dynamic Type   | 200% 以上拡大（watchOS: 140%）            | `UIFontMetrics`, `Font.body.scaled(to:)`            |
| コントラスト比 | WCAG AA: 17pt 以下 →4.5:1、18pt 以上 →3:1 | セマンティックカラー（`.label`, `.secondaryLabel`） |
| カラー使用     | 色+形状+アイコンで情報伝達                | エラー時は赤+`xmark.circle.fill`+テキスト           |
| VoiceOver      | 全要素にラベル設定                        | `accessibilityLabel`, `accessibilityHint`           |

### 身体機能のアクセシビリティ

| 項目             | 基準                   | 実装                                        |
| :--------------- | :--------------------- | :------------------------------------------ |
| ターゲットサイズ | 最小 44x44pt           | `frame(minWidth: 44, minHeight: 44)`        |
| 入力方法         | 音声/Siri/スイッチ対応 | 標準コントロール使用、`accessibilityAction` |

## 2. レイアウト

### 適応性

| 項目             | 推奨                   | 実装                                             |
| :--------------- | :--------------------- | :----------------------------------------------- |
| 柔軟なレイアウト | 固定値を避ける         | `VStack`, `HStack`, `Grid`, `GeometryReader`     |
| セーフエリア     | システム UI 回避       | Safe Area Layout Guide, `containerRelativeFrame` |
| マルチタスク     | iPadOS Split View 対応 | Size Classes（`compact`/`regular`）で切替        |
| Dynamic Island   | 周囲にコンテンツ配置   | セーフエリア遵守で自動回避                       |

### 視覚的階層

| 項目             | 推奨                     | 実装                                         |
| :--------------- | :----------------------- | :------------------------------------------- |
| グループ分け     | 余白/背景/区切り線で分離 | `Group`, `Section`, `ContainerRelativeShape` |
| コントロール区別 | マテリアルで明確化       | visionOS: `.regularMaterial`                 |

## 3. アイコン

| 項目         | 推奨                 | 実装                                  |
| :----------- | :------------------- | :------------------------------------ |
| SF Symbols   | システムシンボル優先 | Dynamic Type/アクセシビリティ自動対応 |
| フォーマット | ベクター（PDF/SVG）  | Asset Catalog に Vector Data 登録     |
| 一貫性       | サイズ/太さ/視点統一 | ウェイト/スケール統一                 |
| ラベル       | 代替テキスト必須     | `accessibilityLabel`                  |
