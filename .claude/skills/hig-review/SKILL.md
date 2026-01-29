---
name: hig-review
description: Apple Human Interface Guidelines (HIG) に基づく UI/UX レビューと実装支援。iOS/iPadOS/macOS/watchOS/visionOS アプリの SwiftUI/UIKit コードをレビューする際に使用。「HIG に準拠しているか」「アクセシビリティを確認して」「UI コンポーネントの選択は正しいか」といったリクエスト時にトリガー。
---

# HIG UI/UX レビュー

Apple Human Interface Guidelines に基づいて、Apple プラットフォームアプリの UI/UX をレビューし、改善提案を行う。

## レビューワークフロー

```text
1. 対象コードを確認
2. プラットフォームを特定（iOS/iPadOS/macOS/watchOS/visionOS）
3. チェックリストに沿ってレビュー
4. 結果を出力フォーマットで報告
```

## クイックチェックリスト

### アクセシビリティ

- [ ] Dynamic Type 対応（200% 以上、watchOS: 140% 以上）
- [ ] コントラスト比 WCAG AA 準拠（4.5:1 / 3:1）
- [ ] タップターゲット 44x44pt 以上
- [ ] VoiceOver ラベル設定済み
- [ ] 色だけでなく形状/アイコンでも情報伝達

### レイアウト

- [ ] セーフエリア遵守
- [ ] Size Classes 対応（compact/regular）
- [ ] iPadOS マルチタスク対応
- [ ] 柔軟なレイアウト（固定値回避）

### コンポーネント選択

- [ ] テキストリスト → `List`
- [ ] 画像コレクション → `LazyVGrid`/`LazyHGrid`
- [ ] 階層ナビゲーション → `NavigationSplitView`
- [ ] グラフ → Charts Framework

### パターン

- [ ] セキュア入力に `SecureField` 使用
- [ ] 動的バリデーション実装
- [ ] 非中断的フィードバック（`.overlay`）
- [ ] アラートは重大情報のみ
- [ ] 共有ボタンはツールバーに配置

## 参照ファイル

詳細情報が必要な場合に参照：

- **[foundations.md](references/foundations.md)**: アクセシビリティ、レイアウト、アイコンの詳細基準
- **[components.md](references/components.md)**: コンポーネント選択ガイドと実装ポイント
- **[patterns.md](references/patterns.md)**: データ入力、フィードバック、共有の実装パターン

## 出力フォーマット

```markdown
## HIG レビュー結果

### 適合項目

- [項目]: 実装が HIG に準拠

### 改善が必要な項目

- [項目]: [問題の説明]
  - 推奨: [具体的な修正方法]

### 推奨事項

- [オプションの改善提案]
```

## SwiftUI 実装クイックリファレンス

```swift
// Dynamic Type
Text("Hello").font(.body)

// セマンティックカラー
Text("Label").foregroundStyle(.primary)

// 最小タップターゲット
Button("Tap") { }.frame(minWidth: 44, minHeight: 44)

// アクセシビリティラベル
Image(systemName: "star.fill").accessibilityLabel("お気に入り")

// セキュア入力
SecureField("パスワード", text: $password)

// 共有
ShareLink(item: url)

// 非中断的フィードバック
.overlay(alignment: .bottom) {
    if showToast { Text("完了").padding().background(.regularMaterial) }
}
```
