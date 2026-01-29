# 型安全性とコード構造

## 目次

1. [Strict 設定](#strict-設定)
2. [any 型の回避](#any-型の回避)
3. [リテラル型とユニオン型](#リテラル型とユニオン型)
4. [ユーティリティ型](#ユーティリティ型)
5. [コード構造](#コード構造)
6. [命名規則](#命名規則)
7. [変数とスコープ](#変数とスコープ)

---

## Strict 設定

### 推奨 tsconfig.json 設定

```json
{
  "compilerOptions": {
    "forceConsistentCasingInFileNames": true,
    "noImplicitReturns": true,
    "strict": true,
    "noUnusedLocals": true
  }
}
```

`strict` フラグは以下を有効化:

- `noImplicitAny`: 暗黙的 any を禁止
- `noImplicitThis`: 暗黙的 this を禁止
- `alwaysStrict`: 厳格モードを強制
- `strictNullChecks`: null/undefined を厳密にチェック

既存プロジェクトへの段階的導入:

```json
{
  "noImplicitAny": true,
  "strictNullChecks": true
}
```

---

## any 型の回避

### 問題

```typescript
// Bad: any は型安全性を破壊
let data: any = fetchData();
data.nonExistentMethod(); // コンパイルエラーにならない
```

### 解決策

```typescript
// Good: 具体的な型を定義
interface User {
  id: number;
  name: string;
  email: string;
}

const data: User = fetchData();

// Good: unknown を使用して安全に型チェック
function processData(data: unknown): void {
  if (typeof data === "object" && data !== null && "id" in data) {
    // 安全に data.id にアクセス可能
  }
}
```

---

## リテラル型とユニオン型

### 文字列リテラル型

```typescript
// Bad: string では広すぎる
let status: string = "active";

// Good: 許可される値を制限
type Status = "pending" | "active" | "completed" | "cancelled";
let status: Status = "active";

// コンパイル時にエラー検出
status = "invalid"; // Error: Type '"invalid"' is not assignable
```

### 数値リテラル型

```typescript
type DiceValue = 1 | 2 | 3 | 4 | 5 | 6;
type HttpSuccessCode = 200 | 201 | 204;
```

---

## ユーティリティ型

### 主要なユーティリティ型

```typescript
interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

// Partial<T>: 全プロパティをオプショナルに
type PartialUser = Partial<User>;

// Required<T>: 全プロパティを必須に
type RequiredUser = Required<Partial<User>>;

// Readonly<T>: 全プロパティを読み取り専用に
type ReadonlyUser = Readonly<User>;

// Pick<T, K>: 指定したプロパティのみ抽出
type UserBasic = Pick<User, "id" | "name">;

// Omit<T, K>: 指定したプロパティを除外
type UserWithoutEmail = Omit<User, "email">;

// Record<K, T>: キーと値の型を指定したオブジェクト
type UserRoles = Record<string, "admin" | "user" | "guest">;
```

---

## コード構造

### ネストの回避

```typescript
// Bad: 深いネスト
function processUser(user: User | null): string {
  if (user) {
    if (user.age >= 18) {
      if (user.email) {
        return sendEmail(user.email);
      }
    }
  }
  return "failed";
}

// Good: 早期リターン
function processUser(user: User | null): string {
  if (!user) return "failed";
  if (user.age < 18) return "failed";
  if (!user.email) return "failed";

  return sendEmail(user.email);
}
```

### モジュール化

```typescript
// Bad: 1 つの巨大な関数
function processOrder(order: Order): void {
  // 100 行以上のロジック...
}

// Good: 小さな関数に分割
function validateOrder(order: Order): ValidationResult {
  /* ... */
}
function calculateTotal(order: Order): number {
  /* ... */
}
function applyDiscount(total: number, discount: Discount): number {
  /* ... */
}
function sendConfirmation(order: Order): void {
  /* ... */
}

function processOrder(order: Order): void {
  const validation = validateOrder(order);
  if (!validation.isValid) throw new Error(validation.message);

  const total = calculateTotal(order);
  const finalTotal = applyDiscount(total, order.discount);
  sendConfirmation(order);
}
```

---

## 命名規則

### 変数名

```typescript
// Bad: 意味不明な名前
const x1 = getUserList();
const fe2 = filterUsers();

// Good: 意図を明確に
const users = getUserList();
const activeUsers = filterActiveUsers(users);
```

### Boolean 命名

```typescript
// Good: is/has プレフィックス
const isActive = user.status === "active";
const hasPermission = checkPermission(user, "admin");
const canEdit = isActive && hasPermission;

// Good: 汎用的な命名
function isLegalDrinkingAge(age: number): boolean {
  return age >= LEGAL_DRINKING_AGE;
}

// Bad: ハードコードされた値を名前に
function isOverEighteen(age: number): boolean {
  return age >= 18;
}
```

---

## 変数とスコープ

### const と let の使い分け

```typescript
// Good: 再代入しない場合は const
const MAX_RETRIES = 3;
const userConfig = { theme: "dark" };

// Good: 再代入が必要な場合のみ let
let retryCount = 0;
while (retryCount < MAX_RETRIES) {
  retryCount++;
}

// Bad: var は使用しない
var oldStyle = "avoid";
```

### 宣言位置

```typescript
// Good: 宣言は先頭でまとめる
function processData(items: Item[]): Result {
  const maxItems = 100;
  const filteredItems: Item[] = [];
  let totalValue = 0;

  // ロジック...
}
```

### 初期化

```typescript
// Good: 宣言時に初期化
let count = 0;
let items: Item[] = [];
let config = getDefaultConfig();

// Bad: 初期化せずに undefined のリスク
let data;
// ... 後で代入を忘れる可能性
```

---

## グローバル変数の回避

```typescript
// Bad: グローバル変数
let globalUser: User;
let globalConfig: Config;

function init(): void {
  globalUser = fetchUser();
}

// Good: モジュールパターンまたは依存性注入
class UserService {
  private user: User | null = null;

  async init(): Promise<void> {
    this.user = await fetchUser();
  }

  getUser(): User | null {
    return this.user;
  }
}

// Good: 依存性注入
function processUser(user: User, config: Config): void {
  // 明示的に必要なものを受け取る
}
```
