# Swift/iOS レビュー

Swift/iOS の観点でコードをレビューします。

## 使い方

````bash
/review-swift [対象ファイルやコード]
```bash

---

## 確認観点

- Swift API Design Guidelines に従っているか
  - 明確で簡潔な命名
  - 流暢な使用感（Fluency）
  - 慣用的な表現
- Optional の扱いは適切か
  - 強制アンラップ (`!`) を避けているか
  - Optional Binding (`if let`, `guard let`)
  - Optional Chaining
  - Nil-Coalescing Operator (`??`)
- メモリ管理は適切か
  - ARC の理解
  - `weak` と `unowned` の使い分け
  - クロージャでの循環参照回避（`[weak self]`）
  - deinit での適切なクリーンアップ
- Protocol 指向の設計になっているか
  - Protocol を使った抽象化
  - Protocol Extension の活用
  - 継承より合成
- iOS Human Interface Guidelines に準拠しているか
  - 標準的な UI パターン
  - ナビゲーション構造
  - アクセシビリティ
- Concurrency の扱いは適切か
  - async/await の適切な使用
  - Actor の活用
  - Task と TaskGroup
  - MainActor でのUI更新
- SwiftLint のルールに従っているか
  - 設定されたルールへの準拠
  - 一貫したコードスタイル

## 出力

問題があれば具体的な改善案を提示すること。
Swift のベストプラクティスに基づいた提案を行うこと。
````
