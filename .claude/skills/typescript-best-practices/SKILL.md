---
name: typescript-best-practices
description: |
  TypeScript/JavaScript ベストプラクティスガイド。コードレビュー、リファクタリング、新規コード作成時に活用。
  Use when: (1) TypeScript/JavaScript コードのレビュー・改善、(2) 型安全性の向上、(3) コード品質・可読性の改善、
  (4) パフォーマンス最適化、(5) クリーンコード原則の適用、(6) 非同期処理・エラーハンドリングの実装。
---

# TypeScript Best Practices

TypeScript/JavaScript プロジェクトに適用できるベストプラクティス集。

## 核心原則

### 1. 型安全性を最優先

```json
// tsconfig.json 推奨設定
{
  "strict": true,
  "noImplicitAny": true,
  "strictNullChecks": true,
  "noImplicitReturns": true,
  "noUnusedLocals": true
}
```

- `any` を避け、常に具体的な型を使用
- ユニオン型でリテラル値を制限: `type Status = 'pending' | 'active' | 'done'`
- `Partial<T>`, `Readonly<T>`, `Pick<T, K>` 等のユーティリティ型を活用

### 2. 関数設計

- **単一責任**: 1 関数 1 責務、5-10 行が理想
- **引数は 2 つまで**: 3 つ以上ならオブジェクト引数に
- **Boolean 引数禁止**: 関数分割で対応
- **純粋関数を優先**: 副作用を最小化

```typescript
// Bad: フラグ引数
function createFile(name: string, temp: boolean): void {}

// Good: 関数分割
function createFile(name: string): void {}
function createTempFile(name: string): void {}
```

### 3. 命名規則

- 変数名は意図を明確に（`x1` ではなく `userCount`）
- Boolean は `is`/`has` プレフィックス: `isActive`, `hasPermission`
- 関数名は汎用的に: `isLegalDrinkingAge()` > `isOverEighteen()`

### 4. イミュータビリティと副作用

- `const` を優先、`let` は必要時のみ、`var` は使用禁止
- オブジェクト/配列の直接変更を避け、スプレッド構文で新規作成
- 副作用は一箇所に集中

### 5. エラーハンドリング

```typescript
// Good: Error 型を throw
throw new Error("User not found");

// Good: async/await + try-catch
try {
  const result = await fetchData();
} catch (error) {
  if (error instanceof NetworkError) {
    // 具体的なエラー処理
  }
}
```

- コールバックより Promise、Promise より async/await
- 外部データは常にバリデーション

## クイックリファレンス

| カテゴリ         | ベストプラクティス                                   |
| ---------------- | ---------------------------------------------------- |
| 比較             | `===` を使用（`==` は使用禁止）                      |
| ループ           | パフォーマンス重視なら `for`、可読性なら配列メソッド |
| switch           | 必ず `default` ケースを含める                        |
| マジックナンバー | 定数として宣言                                       |
| ネスト           | 深いネストは早期リターンで解消                       |
| 条件分岐         | 複雑な if 文はポリモーフィズムで置換検討             |

## 詳細リファレンス

詳細なガイドラインと例:

- **型安全性とコード構造**: [references/type-safety-and-structure.md](references/type-safety-and-structure.md)
- **関数とモダン機能**: [references/functions-and-modern-features.md](references/functions-and-modern-features.md)
- **パフォーマンスとブラウザ**: [references/performance-and-browser.md](references/performance-and-browser.md)

## コードレビューチェックリスト

レビュー時に確認すべき項目:

1. [ ] `any` 型が使われていないか
2. [ ] `===` で比較しているか
3. [ ] 関数が 10 行以内か、引数が 3 つ以内か
4. [ ] マジックナンバーが定数化されているか
5. [ ] エラーが適切に処理されているか
6. [ ] 未使用のインポート/変数がないか
