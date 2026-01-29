# TDD サイクル詳細

## フェーズ 0: テストリスト作成

TDD の最も重要なフェーズ。Red-Green-Refactor より先に行う。

### テストリストの書き方

```markdown
## テストリスト: FizzBuzz

### 正常系

- [ ] 1 を渡すと "1" を返す
- [ ] 2 を渡すと "2" を返す
- [ ] 3 を渡すと "Fizz" を返す
- [ ] 5 を渡すと "Buzz" を返す
- [ ] 15 を渡すと "FizzBuzz" を返す
- [ ] 6 を渡すと "Fizz" を返す（3 の倍数）
- [ ] 10 を渡すと "Buzz" を返す（5 の倍数）
- [ ] 30 を渡すと "FizzBuzz" を返す（15 の倍数）

### 境界値

- [ ] 0 を渡した場合の挙動
- [ ] 負の数を渡した場合の挙動
- [ ] 非常に大きな数を渡した場合

### 異常系

- [ ] null を渡すと例外
- [ ] 小数を渡すと例外
```

### テストリストの更新

- 実装中に気づいた新しいケースを追加
- 不要になったケースを削除
- 完了したケースにチェック

## フェーズ 1: Red（テストを書く）

**目的:** テストが失敗することを確認し、「テストが正しく動作すること」を検証する

**手順:**

1. テストリストから 1 つ選ぶ（最も簡単なものから）
2. テストコードを書く
3. テストを実行し、**失敗することを確認**

### Red フェーズの例（TypeScript + Vitest）

```typescript
// fizzbuzz.test.ts
import { describe, it, expect } from "vitest";
import { fizzBuzz } from "./fizzbuzz";

describe("FizzBuzz", () => {
  it("1を渡すと文字列1を返す", () => {
    expect(fizzBuzz(1)).toBe("1");
  });
});
```

```typescript
// fizzbuzz.ts（まだ空）
export function fizzBuzz(n: number): string {
  throw new Error("Not implemented");
}
```

### Red で確認すること

- [ ] テストが失敗している
- [ ] 失敗理由が期待通り（「実装されていない」など）
- [ ] テスト自体にバグがない

### Red フェーズのアンチパターン

```typescript
// ❌ 複数のテストを一度に書く
it("3の倍数はFizz、5の倍数はBuzz、両方の倍数はFizzBuzz", () => {
  expect(fizzBuzz(3)).toBe("Fizz");
  expect(fizzBuzz(5)).toBe("Buzz");
  expect(fizzBuzz(15)).toBe("FizzBuzz");
});

// ✅ 1つずつ書く
it("3を渡すとFizzを返す", () => {
  expect(fizzBuzz(3)).toBe("Fizz");
});
```

## フェーズ 2: Green（テストを通す）

**目的:** テストを通す最小限の実装を行い、「動く」ことだけを追求する

### 3 つの戦略

詳細は [implementation-patterns.md](implementation-patterns.md) を参照。

#### 仮実装（Fake It）

```typescript
// 最初のテスト: 1を渡すと"1"を返す
export function fizzBuzz(n: number): string {
  return "1"; // ハードコード！
}
```

#### 三角測量（Triangulation）

```typescript
// テスト追加: 2を渡すと"2"を返す
it("2を渡すと文字列2を返す", () => {
  expect(fizzBuzz(2)).toBe("2");
});

// 2つのテストを通すには一般化が必要
export function fizzBuzz(n: number): string {
  return String(n);
}
```

#### 明白な実装（Obvious Implementation）

```typescript
// 自明な場合は直接書く
export function fizzBuzz(n: number): string {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}
```

### Green で守ること

- [ ] テストが通っている
- [ ] 既存のテストも全て通っている
- [ ] コードの「きれいさ」は追求しない

## フェーズ 3: Refactor（設計改善）

**目的:** 「きれいなコード」を追求し、重複の除去と可読性の向上を行う

**手順:**

1. テストが全て通っていることを確認
2. コードの改善点を見つける
3. 小さな変更を加える
4. テストを実行（通ることを確認）
5. 2-4 を繰り返す

### リファクタリングの対象

- **重複の除去**: DRY 原則
- **命名の改善**: 意図が伝わる名前
- **構造の改善**: 責務の分離、凝集度向上
- **可読性の向上**: 早期リターン、ガード節

### Refactor フェーズの例

```typescript
// Before: 重複がある
export function fizzBuzz(n: number): string {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}

// After: 意図を明確に
export function fizzBuzz(n: number): string {
  const divisibleBy3 = n % 3 === 0;
  const divisibleBy5 = n % 5 === 0;

  if (divisibleBy3 && divisibleBy5) return "FizzBuzz";
  if (divisibleBy3) return "Fizz";
  if (divisibleBy5) return "Buzz";
  return String(n);
}
```

### Refactor で守ること

- [ ] 新機能を追加しない
- [ ] テストが全て通り続けている
- [ ] 小さな変更を積み重ねる

## サイクルの回し方

### 歩幅の調整

```text
不安・複雑 → 小さなステップ
  - 仮実装から始める
  - 1テストずつ進める
  - 頻繁にテスト実行

自信・単純 → 大きなステップ
  - 明白な実装を使う
  - 複数の関連テストをまとめて通す
```

### 行き詰まった時

1. 歩幅を小さくする
2. 直前の Green 状態に戻る
3. テストリストを見直す
4. より簡単なケースから攻める

## TDD セッションの流れ

```text
1. [準備] テストリスト作成（5-10分）
2. [Red] テスト 1 つ書く（2-5分）
3. [Green] 最小実装（2-10分）
4. [Refactor] 必要なら改善（2-5分）
5. [確認] テストリスト更新
6. リストが空になるまで 2 へ
```

## よくある失敗パターン

| パターン            | 問題                 | 対策             |
| ------------------- | -------------------- | ---------------- |
| テストリストなし    | 行き当たりばったり   | 最初にリスト作成 |
| 複数テスト同時      | どれが失敗か不明     | 1 つずつ         |
| Green でリファクタ  | 2 つの目標を同時追求 | フェーズを分離   |
| Refactor で機能追加 | テストがない変更     | 次のサイクルで   |
| Red をスキップ      | テストの信頼性低下   | 必ず失敗を確認   |
