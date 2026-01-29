# TypeScript レビュー

TypeScript の観点でコードをレビューします。

## 使い方

````bash
/review-ts [対象ファイルやコード]
```bash

---

## 確認観点

- 型定義は適切か
  - `any` を避けているか
  - `unknown` の適切な使用
  - 明示的な型定義 vs 型推論のバランス
- 型推論を活用しているか
  - 冗長な型アノテーションを避ける
  - 型推論が効く場面での省略
- ユニオン型・ジェネリクスの使い方は適切か
  - 型の再利用性
  - 型の絞り込み（Type Narrowing）
  - Conditional Types の適切な使用
- null/undefined の扱いは適切か
  - strict null checks 対応
  - Optional Chaining (`?.`)
  - Nullish Coalescing (`??`)
  - 非 null アサーション (`!`) の乱用を避ける
- ESLint/Prettier のルールに従っているか
  - 設定されたルールへの準拠
  - 一貫したコードスタイル
- モジュール構成は適切か
  - 適切なエクスポート
  - 循環参照の回避
  - バレルファイルの使用
- 非同期処理の扱いは適切か
  - async/await の適切な使用
  - Promise のエラーハンドリング
  - 並列実行 vs 逐次実行
  - Promise.all, Promise.race の使い分け

## 出力

問題があれば具体的な改善案を提示すること。
TypeScript のベストプラクティスに基づいた提案を行うこと。
````
