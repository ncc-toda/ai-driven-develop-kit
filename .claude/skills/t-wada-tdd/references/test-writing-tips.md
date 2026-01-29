# テスト記述の Tips

t_wada 式 TDD におけるテストの書き方ガイド。

## テスト名の付け方

### 日本語でテストの意図を書く

```typescript
// ✅ 良い例: 意図が明確
describe("FizzBuzz", () => {
  it("1を渡すと文字列1を返す", () => {});
  it("3の倍数を渡すとFizzを返す", () => {});
  it("5の倍数を渡すとBuzzを返す", () => {});
  it("15の倍数を渡すとFizzBuzzを返す", () => {});
});

// ❌ 悪い例: 何をテストしているかわからない
describe("FizzBuzz", () => {
  it("test1", () => {});
  it("should work", () => {});
  it("returns correct value", () => {});
});
```

### 命名パターン

| パターン           | 例                               |
| ------------------ | -------------------------------- |
| 「〜すると〜する」 | 「3を渡すとFizzを返す」          |
| 「〜の場合、〜」   | 「引数が負の場合、例外を投げる」 |
| 「〜できる」       | 「ユーザーを作成できる」         |

## テストの構造: AAA パターン

### Arrange-Act-Assert

```typescript
it("ユーザーの年齢を計算できる", () => {
  // Arrange（準備）
  const birthDate = new Date("1990-01-15");
  const today = new Date("2024-01-15");
  const user = new User(birthDate);

  // Act（実行）
  const age = user.calculateAge(today);

  // Assert（検証）
  expect(age).toBe(34);
});
```

### Given-When-Then（BDD スタイル）

```typescript
describe("ショッピングカート", () => {
  describe("商品を追加した場合", () => {
    it("合計金額が更新される", () => {
      // Given
      const cart = new ShoppingCart();
      const item = new Item("本", 1000);

      // When
      cart.add(item);

      // Then
      expect(cart.total).toBe(1000);
    });
  });
});
```

## テストの独立性

### 各テストは独立して実行できること

```typescript
// ✅ 良い例: 各テストが独立
describe("Counter", () => {
  it("初期値は0", () => {
    const counter = new Counter();
    expect(counter.value).toBe(0);
  });

  it("incrementで1増える", () => {
    const counter = new Counter();
    counter.increment();
    expect(counter.value).toBe(1);
  });
});

// ❌ 悪い例: テストが依存している
describe("Counter", () => {
  const counter = new Counter(); // 共有インスタンス

  it("初期値は0", () => {
    expect(counter.value).toBe(0);
  });

  it("incrementで1増える", () => {
    counter.increment();
    expect(counter.value).toBe(1); // 前のテストに依存
  });
});
```

### beforeEach でセットアップ

```typescript
describe("UserService", () => {
  let userService: UserService;
  let mockRepository: MockUserRepository;

  beforeEach(() => {
    mockRepository = new MockUserRepository();
    userService = new UserService(mockRepository);
  });

  it("ユーザーを作成できる", () => {
    // 各テストで新しいインスタンス
  });
});
```

## 1 テスト 1 アサーション

### 原則: 1 つのテストで 1 つのことを検証

```typescript
// ✅ 良い例: 1テスト1アサーション
it("3を渡すとFizzを返す", () => {
  expect(fizzBuzz(3)).toBe("Fizz");
});

it("6を渡すとFizzを返す", () => {
  expect(fizzBuzz(6)).toBe("Fizz");
});

// ❌ 避けたい例: 複数のことをテスト
it("3の倍数はFizzを返す", () => {
  expect(fizzBuzz(3)).toBe("Fizz");
  expect(fizzBuzz(6)).toBe("Fizz");
  expect(fizzBuzz(9)).toBe("Fizz");
  expect(fizzBuzz(12)).toBe("Fizz");
});
```

### 例外: 論理的に 1 つの概念

```typescript
// ✅ OK: 1つの操作の複数の側面
it("ユーザーを作成すると名前とメールが設定される", () => {
  const user = createUser("田中", "tanaka@example.com");

  expect(user.name).toBe("田中");
  expect(user.email).toBe("tanaka@example.com");
});
```

## テストデータの作成

### ファクトリー関数を使う

```typescript
// テストヘルパー
function createUser(overrides: Partial<User> = {}): User {
  return {
    id: "test-id",
    name: "テストユーザー",
    email: "test@example.com",
    age: 30,
    ...overrides,
  };
}

// テストで使用
it("成人ユーザーを判定できる", () => {
  const adult = createUser({ age: 20 });
  const minor = createUser({ age: 17 });

  expect(isAdult(adult)).toBe(true);
  expect(isAdult(minor)).toBe(false);
});
```

### マジックナンバーを避ける

```typescript
// ✅ 良い例: 意図が明確
const LEGAL_DRINKING_AGE = 20;
const UNDERAGE = 19;

it("飲酒可能年齢を判定できる", () => {
  expect(canDrink(LEGAL_DRINKING_AGE)).toBe(true);
  expect(canDrink(UNDERAGE)).toBe(false);
});

// ❌ 悪い例: なぜこの数値？
it("飲酒可能年齢を判定できる", () => {
  expect(canDrink(20)).toBe(true);
  expect(canDrink(19)).toBe(false);
});
```

## 境界値テスト

### 境界値を明示的にテスト

```typescript
describe("isAdult", () => {
  // 境界値
  it("20歳は成人", () => {
    expect(isAdult(20)).toBe(true);
  });

  it("19歳は未成年", () => {
    expect(isAdult(19)).toBe(false);
  });

  // 代表値
  it("30歳は成人", () => {
    expect(isAdult(30)).toBe(true);
  });

  it("10歳は未成年", () => {
    expect(isAdult(10)).toBe(false);
  });
});
```

### 境界値テストのパターン

| 境界   | テストする値         |
| ------ | -------------------- |
| 最小値 | 最小値、最小値-1     |
| 最大値 | 最大値、最大値+1     |
| 閾値   | 閾値、閾値-1、閾値+1 |
| 空     | 空、1件、複数件      |

## エラーケースのテスト

### 例外のテスト

```typescript
it("nullを渡すと例外を投げる", () => {
  expect(() => fizzBuzz(null as any)).toThrow();
});

it("負の数を渡すとArgumentErrorを投げる", () => {
  expect(() => fizzBuzz(-1)).toThrow(ArgumentError);
});

it("エラーメッセージを確認", () => {
  expect(() => fizzBuzz(-1)).toThrow("引数は0以上である必要があります");
});
```

### 非同期エラーのテスト

```typescript
it("存在しないユーザーを取得するとエラー", async () => {
  await expect(userService.findById("invalid-id")).rejects.toThrow(UserNotFoundError);
});
```

## モックの使い方

### 外部依存はモック化

```typescript
describe("UserService", () => {
  it("ユーザーを保存できる", async () => {
    // モックの作成
    const mockRepository = {
      save: vi.fn().mockResolvedValue({ id: "1", name: "田中" }),
    };

    const service = new UserService(mockRepository);
    const result = await service.createUser("田中");

    // モックが呼ばれたことを検証
    expect(mockRepository.save).toHaveBeenCalledWith({ name: "田中" });
    expect(result.id).toBe("1");
  });
});
```

### モックしすぎない

```typescript
// ❌ モックしすぎ
it("ユーザーを作成できる", () => {
  const mockDate = vi.fn(() => new Date("2024-01-01"));
  const mockUuid = vi.fn(() => "test-id");
  const mockValidator = vi.fn(() => true);
  // ...すべてをモック
});

// ✅ 必要最小限のモック
it("ユーザーを作成できる", () => {
  const mockRepository = createMockRepository();
  // 外部依存のみモック
});
```

## describe のネスト

### 論理的なグループ化

```typescript
describe("ShoppingCart", () => {
  describe("空のカート", () => {
    it("合計は0円", () => {});
    it("商品数は0", () => {});
  });

  describe("商品が1つのカート", () => {
    it("合計は商品価格と同じ", () => {});
    it("商品を削除すると空になる", () => {});
  });

  describe("複数商品のカート", () => {
    it("合計は全商品の合計", () => {});
    describe("割引適用時", () => {
      it("10%オフが適用される", () => {});
    });
  });
});
```

## テストのメンテナンス

### テストも DRY に

```typescript
// テスト用のヘルパー関数
function expectFizz(n: number): void {
  expect(fizzBuzz(n)).toBe("Fizz");
}

function expectBuzz(n: number): void {
  expect(fizzBuzz(n)).toBe("Buzz");
}

it("3の倍数はFizz", () => {
  expectFizz(3);
  expectFizz(6);
  expectFizz(9);
});
```

### パラメータ化テスト

```typescript
describe.each([
  [1, "1"],
  [2, "2"],
  [3, "Fizz"],
  [5, "Buzz"],
  [15, "FizzBuzz"],
])("fizzBuzz(%i)", (input, expected) => {
  it(`returns ${expected}`, () => {
    expect(fizzBuzz(input)).toBe(expected);
  });
});
```

## テストの FIRST 原則

| 原則                | 説明                         |
| ------------------- | ---------------------------- |
| **F**ast            | 高速に実行できる             |
| **I**solated        | 他のテストに依存しない       |
| **R**epeatable      | 何度実行しても同じ結果       |
| **S**elf-validating | 成功/失敗が自動判定される    |
| **T**imely          | プロダクトコードより先に書く |
