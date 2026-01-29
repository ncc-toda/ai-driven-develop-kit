# 関数とモダン機能

## 目次

1. [関数設計](#関数設計)
2. [引数の設計](#引数の設計)
3. [純粋関数とイミュータビリティ](#純粋関数とイミュータビリティ)
4. [非同期処理](#非同期処理)
5. [エラーハンドリング](#エラーハンドリング)
6. [モダン JavaScript 機能](#モダン-javascript-機能)
7. [配列操作](#配列操作)
8. [条件分岐の改善](#条件分岐の改善)

---

## 関数設計

### 短い関数

```typescript
// Bad: 長すぎる関数（10 行以上）
function processOrder(order: Order): void {
  // バリデーション
  if (!order.items) throw new Error("No items");
  if (!order.user) throw new Error("No user");
  // 計算
  let total = 0;
  for (const item of order.items) {
    total += item.price * item.quantity;
  }
  // 割引適用
  if (order.coupon) {
    total = total * (1 - order.coupon.discount);
  }
  // 税金計算
  const tax = total * 0.1;
  // メール送信
  // ... さらに続く
}

// Good: 5-10 行の小さな関数に分割
function validateOrder(order: Order): void {
  if (!order.items) throw new Error("No items");
  if (!order.user) throw new Error("No user");
}

function calculateSubtotal(items: OrderItem[]): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

function applyDiscount(total: number, coupon?: Coupon): number {
  return coupon ? total * (1 - coupon.discount) : total;
}
```

### 単一責任

```typescript
// Bad: 複数の責任を持つ関数
function createUserAndSendEmail(userData: UserData): User {
  const user = createUser(userData);
  sendWelcomeEmail(user);
  logUserCreation(user);
  return user;
}

// Good: 責任を分離
function createUser(userData: UserData): User {
  /* ... */
}
function sendWelcomeEmail(user: User): void {
  /* ... */
}
function logUserCreation(user: User): void {
  /* ... */
}

// オーケストレーション関数で組み合わせ
async function onboardNewUser(userData: UserData): Promise<User> {
  const user = createUser(userData);
  await sendWelcomeEmail(user);
  logUserCreation(user);
  return user;
}
```

---

## 引数の設計

### 引数は 2 つまで

```typescript
// Bad: 引数が多すぎる
function createUser(name: string, email: string, age: number, country: string, role: string): User {
  /* ... */
}

// Good: オブジェクト引数を使用
interface CreateUserParams {
  name: string;
  email: string;
  age: number;
  country: string;
  role: string;
}

function createUser(params: CreateUserParams): User {
  /* ... */
}
```

### Boolean 引数の回避

```typescript
// Bad: フラグ引数
function createFile(name: string, temp: boolean): void {
  if (temp) {
    // 一時ファイル作成
  } else {
    // 通常ファイル作成
  }
}

// Good: 関数を分割
function createFile(name: string): void {
  /* ... */
}
function createTempFile(name: string): void {
  /* ... */
}
```

### デフォルト引数

```typescript
// Good: デフォルト値を使用
function fetchUsers(limit = 10, offset = 0): Promise<User[]> {
  return api.get(`/users?limit=${limit}&offset=${offset}`);
}

// Good: オブジェクト引数とデフォルト値
interface FetchOptions {
  limit?: number;
  offset?: number;
  sortBy?: string;
}

function fetchUsers(options: FetchOptions = {}): Promise<User[]> {
  const { limit = 10, offset = 0, sortBy = "createdAt" } = options;
  // ...
}
```

---

## 純粋関数とイミュータビリティ

### 純粋関数

```typescript
// Bad: 副作用を持つ関数
let total = 0;
function addToTotal(value: number): void {
  total += value; // 外部状態を変更
}

// Good: 純粋関数
function add(a: number, b: number): number {
  return a + b; // 入力のみに依存、副作用なし
}

// Good: 副作用を明確に分離
function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

function saveTotal(total: number): void {
  // 副作用は明示的に分離
  localStorage.setItem("total", String(total));
}
```

### イミュータビリティ

```typescript
// Bad: オブジェクトを直接変更
function updateUser(user: User, name: string): User {
  user.name = name; // ミューテーション
  return user;
}

// Good: 新しいオブジェクトを返す
function updateUser(user: User, name: string): User {
  return { ...user, name };
}

// Bad: 配列を直接変更
function addItem(items: Item[], newItem: Item): void {
  items.push(newItem);
}

// Good: 新しい配列を返す
function addItem(items: Item[], newItem: Item): Item[] {
  return [...items, newItem];
}
```

---

## 非同期処理

### Promise over Callbacks

```typescript
// Bad: コールバック地獄
function fetchData(callback: (err: Error | null, data: Data) => void): void {
  fetch("/api/users", (err, users) => {
    if (err) return callback(err, null);
    fetch("/api/posts", (err, posts) => {
      if (err) return callback(err, null);
      callback(null, { users, posts });
    });
  });
}

// Good: Promise チェーン
function fetchData(): Promise<Data> {
  return fetchUsers().then((users) => fetchPosts().then((posts) => ({ users, posts })));
}

// Better: async/await
async function fetchData(): Promise<Data> {
  const users = await fetchUsers();
  const posts = await fetchPosts();
  return { users, posts };
}

// Best: 並列実行
async function fetchData(): Promise<Data> {
  const [users, posts] = await Promise.all([fetchUsers(), fetchPosts()]);
  return { users, posts };
}
```

---

## エラーハンドリング

### Error 型を使用

```typescript
// Bad: 文字列を throw
throw "Something went wrong";

// Good: Error オブジェクトを throw
throw new Error("User not found");

// Better: カスタムエラー
class ValidationError extends Error {
  constructor(
    message: string,
    public readonly field: string,
  ) {
    super(message);
    this.name = "ValidationError";
  }
}

throw new ValidationError("Invalid email format", "email");
```

### 適切な catch

```typescript
// Bad: エラーを握りつぶす
try {
  await doSomething();
} catch (e) {
  // 何もしない
}

// Good: 適切に処理
try {
  await doSomething();
} catch (error) {
  if (error instanceof ValidationError) {
    showFieldError(error.field, error.message);
  } else if (error instanceof NetworkError) {
    showRetryDialog();
  } else {
    throw error; // 未知のエラーは再 throw
  }
}
```

---

## モダン JavaScript 機能

### スプレッド構文

```typescript
// 配列のコピーと結合
const arr1 = [1, 2, 3];
const arr2 = [...arr1, 4, 5]; // [1, 2, 3, 4, 5]

// オブジェクトのマージ
const defaults = { theme: "light", lang: "en" };
const userPrefs = { theme: "dark" };
const config = { ...defaults, ...userPrefs }; // { theme: 'dark', lang: 'en' }
```

### 分割代入

```typescript
// オブジェクトの分割代入
const { name, email, age = 0 } = user;

// 配列の分割代入
const [first, second, ...rest] = items;

// 関数パラメータでの分割代入
function greet({ name, greeting = "Hello" }: GreetParams): string {
  return `${greeting}, ${name}!`;
}
```

### テンプレートリテラル

```typescript
// Bad: 文字列連結
const message = "Hello, " + name + "! You have " + count + " messages.";

// Good: テンプレートリテラル
const message = `Hello, ${name}! You have ${count} messages.`;

// 複数行
const html = `
  <div class="user">
    <h1>${user.name}</h1>
    <p>${user.bio}</p>
  </div>
`;
```

---

## 配列操作

### 関数型メソッド

```typescript
const users: User[] = [...];

// filter: 条件に合う要素を抽出
const activeUsers = users.filter(user => user.isActive);

// map: 各要素を変換
const userNames = users.map(user => user.name);

// find: 条件に合う最初の要素
const admin = users.find(user => user.role === 'admin');

// some/every: 条件を満たす要素の存在チェック
const hasAdmin = users.some(user => user.role === 'admin');
const allActive = users.every(user => user.isActive);

// reduce: 集約
const totalAge = users.reduce((sum, user) => sum + user.age, 0);
```

### パフォーマンス考慮

```typescript
// サーバーサイド・大量データ: for ループが高速
for (let i = 0; i < items.length; i++) {
  process(items[i]);
}

// クライアントサイド・可読性重視: 配列メソッド
const result = items.filter((item) => item.isValid).map((item) => transform(item));
```

---

## 条件分岐の改善

### switch の default

```typescript
// Good: default を含める
function getEmoji(key: string): string {
  switch (key) {
    case "dog":
      return "🐶";
    case "cat":
      return "😺";
    default:
      return "🙂";
  }
}
```

### ポリモーフィズムで条件分岐を削減

```typescript
// Bad: 条件分岐の連鎖
function calculatePay(employee: Employee): number {
  if (employee.type === "hourly") {
    return employee.hours * employee.rate;
  } else if (employee.type === "salary") {
    return employee.salary / 12;
  } else if (employee.type === "commission") {
    return employee.sales * employee.commission;
  }
  throw new Error("Unknown employee type");
}

// Good: ポリモーフィズム
interface Employee {
  calculatePay(): number;
}

class HourlyEmployee implements Employee {
  constructor(
    private hours: number,
    private rate: number,
  ) {}
  calculatePay(): number {
    return this.hours * this.rate;
  }
}

class SalaryEmployee implements Employee {
  constructor(private salary: number) {}
  calculatePay(): number {
    return this.salary / 12;
  }
}
```

### マジックナンバーの回避

```typescript
// Bad: マジックナンバー
if (age >= 18) {
  /* ... */
}
if (retryCount < 3) {
  /* ... */
}

// Good: 定数として定義
const LEGAL_ADULT_AGE = 18;
const MAX_RETRIES = 3;

if (age >= LEGAL_ADULT_AGE) {
  /* ... */
}
if (retryCount < MAX_RETRIES) {
  /* ... */
}
```
