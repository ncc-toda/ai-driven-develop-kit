# 実装パターン（Green にする 3 つの戦略）

TDD の Green フェーズでテストを通すための 3 つの戦略。状況に応じて使い分ける。

## 1. 仮実装（Fake It）

テストを通すために、ハードコードされた値を返す。

**いつ使うか:**

- TDD の最初の一歩
- 実装方法がわからない時
- 不安な時
- 小さなステップで進みたい時

**例:**

```typescript
// テスト
it("1を渡すと文字列1を返す", () => {
  expect(fizzBuzz(1)).toBe("1");
});

// 仮実装: ハードコード
export function fizzBuzz(n: number): string {
  return "1"; // テストを通すための最小限
}
```

**次のステップ:**

- 別のテストを追加して、一般化を強制する（三角測量へ）
- または、自信があれば明白な実装に進む

**メリット:**

- 確実にテストが通る
- 小さなステップで進める
- 「とりあえず動く」状態を作れる

**注意点:**

- 仮実装のままにしない
- 次のテストで一般化する

## 2. 三角測量（Triangulation）

複数のテストケースを追加し、一般化を「強制」する。

**いつ使うか:**

- 一般化の方向がわからない時
- 仮実装の次のステップ
- アルゴリズムの正しさを確認したい時

**基本例:**

```typescript
// テスト 1: 1を渡すと"1"
it("1を渡すと文字列1を返す", () => {
  expect(fizzBuzz(1)).toBe("1");
});

// テスト 2: 2を渡すと"2"
it("2を渡すと文字列2を返す", () => {
  expect(fizzBuzz(2)).toBe("2");
});

// 2つのテストを通すには一般化が必要
export function fizzBuzz(n: number): string {
  return String(n); // ハードコードでは通らない
}
```

**三角測量のプロセス:**

```text
1. 最初のテスト → 仮実装で通す
2. 2つ目のテスト追加 → 仮実装では通らない
3. 一般化して両方通す
4. 必要なら3つ目のテストで確認
```

**FizzBuzz での適用例:**

```typescript
// テスト 1: 3はFizz
it("3を渡すとFizzを返す", () => {
  expect(fizzBuzz(3)).toBe("Fizz");
});

// 仮実装
function fizzBuzz(n: number): string {
  if (n === 3) return "Fizz";
  return String(n);
}

// テスト 2: 6もFizz（三角測量）
it("6を渡すとFizzを返す", () => {
  expect(fizzBuzz(6)).toBe("Fizz");
});

// 一般化が必要
function fizzBuzz(n: number): string {
  if (n % 3 === 0) return "Fizz"; // 3の倍数に一般化
  return String(n);
}
```

**メリット:**

- 正しい一般化の方向を発見できる
- 過度な一般化を防げる
- テストケースが仕様になる

**注意点:**

- テストケースの選び方が重要
- 似すぎたケースは意味がない

## 3. 明白な実装（Obvious Implementation）

自明な場合は、直接正しい実装を書く。

**いつ使うか:**

- 実装が明らかな時
- 自信がある時
- シンプルな機能

**例:**

```typescript
// テスト
it("空配列の長さは0", () => {
  expect([].length).toBe(0);
});

// 明白な実装（直接書く）
function getLength<T>(arr: T[]): number {
  return arr.length;
}
```

**判断基準:**

```text
問いかけ: 「この実装、間違える可能性ある？」

Yes → 仮実装 or 三角測量
No  → 明白な実装
```

**メリット:**

- 速い
- コードがシンプル

**注意点:**

- 自信過剰に注意
- 失敗したら歩幅を小さく

## 戦略の選択フローチャート

```text
テストを書いた後:

Q: 実装方法は自明か？
├─ Yes → 明白な実装
└─ No
    Q: 一般化の方向はわかるか？
    ├─ Yes → 仮実装 → 三角測量
    └─ No  → 仮実装 → 三角測量（複数ケース）
```

## パターンの組み合わせ

実際の開発では、これらを組み合わせて使う。

### FizzBuzz の実装プロセス

```typescript
// Step 1: 仮実装（1 → "1"）
function fizzBuzz(n: number): string {
  return "1";
}

// Step 2: 三角測量（2 → "2" を追加）
function fizzBuzz(n: number): string {
  return String(n); // 一般化
}

// Step 3: 仮実装（3 → "Fizz"）
function fizzBuzz(n: number): string {
  if (n === 3) return "Fizz";
  return String(n);
}

// Step 4: 三角測量（6 → "Fizz" を追加）
function fizzBuzz(n: number): string {
  if (n % 3 === 0) return "Fizz"; // 一般化
  return String(n);
}

// Step 5: 明白な実装（5, 15 のケースは自明）
function fizzBuzz(n: number): string {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}
```

## 歩幅の調整

| 状態               | 戦略                | 歩幅 |
| ------------------ | ------------------- | ---- |
| 不安、複雑、初めて | 仮実装 → 三角測量   | 小   |
| まあまあ自信       | 仮実装 → 明白な実装 | 中   |
| 完全に自信         | 明白な実装          | 大   |
| テスト失敗         | 戻って仮実装        | 縮小 |

## アンチパターン

### 早すぎる一般化

```typescript
// ❌ 1つのテストで過度に一般化
it("1を渡すと1を返す", () => {
  expect(fizzBuzz(1)).toBe("1");
});

function fizzBuzz(n: number): string {
  // いきなり全パターン実装
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}
```

### 仮実装のまま放置

```typescript
// ❌ 次のテストを書かない
function fizzBuzz(n: number): string {
  return "1"; // これで終わり...？
}
```

### 自信過剰な明白な実装

```typescript
// ❌ 複雑なロジックを「自明」と判断
function calculateTax(income: number, deductions: Deduction[]): number {
  // 自信があるからテストなしで全実装...
  // → バグの温床
}
```
