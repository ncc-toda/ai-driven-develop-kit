# Dart/Flutter レビュー

Dart/Flutter の観点でコードをレビューします。

## 使い方

````bash
/review-dart [対象ファイルやコード]
```bash

---

## 確認観点

- Dart の命名規則に従っているか
  - `lowerCamelCase`: 変数、関数、パラメータ
  - `UpperCamelCase`: クラス、enum、typedef
  - `lowercase_with_underscores`: ファイル名、パッケージ名
  - プライベートメンバーの `_` プレフィックス
- null safety を適切に活用しているか
  - Nullable 型の明示（`?`）
  - late 変数の適切な使用
  - `!` 演算子の乱用を避ける
  - null チェックと型昇格
- Widget の分割粒度は適切か
  - 再利用可能な粒度
  - build メソッドの複雑さ
  - const コンストラクタの活用
- StatelessWidget と StatefulWidget の使い分けは適切か
  - 状態が必要な場合のみ StatefulWidget
  - State のライフサイクルの理解
- 状態管理の方法は適切か
  - 適切な状態管理ライブラリの選択
  - ローカル状態 vs グローバル状態
  - 状態の不変性
- パフォーマンスを考慮しているか
  - rebuild の最小化
  - const Widget の活用
  - ListView.builder の使用
  - 画像のキャッシュ
- dart analyze でエラー・警告がないか
  - lint ルールへの準拠
  - 非推奨 API の使用回避

## 出力

問題があれば具体的な改善案を提示すること。
Dart/Flutter のベストプラクティスに基づいた提案を行うこと。
````
