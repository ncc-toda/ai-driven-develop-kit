# パフォーマンスとブラウザ

## 目次

1. [コーディングプラクティス](#コーディングプラクティス)
2. [DOM 操作](#dom-操作)
3. [バンドル最適化](#バンドル最適化)
4. [測定とツール](#測定とツール)
5. [Web Workers](#web-workers)
6. [ブラウザ互換性](#ブラウザ互換性)
7. [プログレッシブエンハンスメント](#プログレッシブエンハンスメント)

---

## コーディングプラクティス

### 技術の分離

```typescript
// Bad: JavaScript 内に CSS/HTML を混在
element.style.cssText = "color: red; font-size: 16px; margin: 10px;";
element.innerHTML = '<div class="user"><span>Name</span></div>';

// Good: 関心の分離
element.classList.add("error-message");
// CSS で .error-message のスタイルを定義

// Good: テンプレートを使用
const template = document.getElementById("user-template") as HTMLTemplateElement;
const clone = template.content.cloneNode(true);
```

### 短縮記法の注意

```typescript
// Bad: 波括弧を省略
if (someVariableExists) x = false;

// Good: 常に波括弧を使用
if (someVariableExists) {
  x = false;
}

// OK: ワンライナーは場合により許容
if (isError) return null;
```

### 入力データの検証

```typescript
// Bad: 入力を信用
function processFormData(data: FormData): void {
  const email = data.get("email") as string;
  sendEmail(email); // 未検証の入力を使用
}

// Good: 常に検証
function processFormData(data: FormData): void {
  const email = data.get("email");
  if (typeof email !== "string" || !isValidEmail(email)) {
    throw new ValidationError("Invalid email");
  }
  sendEmail(email);
}

// Good: URL パラメータの検証
function getQueryParam(name: string): string | null {
  const params = new URLSearchParams(window.location.search);
  const value = params.get(name);

  // サニタイズしてから使用
  return value ? sanitize(value) : null;
}
```

---

## DOM 操作

### DOM アクセスの最小化

```typescript
// Bad: 頻繁な DOM アクセス
for (const item of items) {
  document.getElementById("list")!.innerHTML += `<li>${item.name}</li>`;
}

// Good: 一括更新
const listElement = document.getElementById("list")!;
const html = items.map((item) => `<li>${item.name}</li>`).join("");
listElement.innerHTML = html;

// Better: DocumentFragment を使用
const fragment = document.createDocumentFragment();
for (const item of items) {
  const li = document.createElement("li");
  li.textContent = item.name;
  fragment.appendChild(li);
}
document.getElementById("list")!.appendChild(fragment);
```

### 要素の参照をキャッシュ

```typescript
// Bad: 毎回 DOM を検索
function updateUI(): void {
  document.getElementById("count")!.textContent = String(count);
  document.getElementById("total")!.textContent = String(total);
  document.getElementById("status")!.textContent = status;
}

// Good: 参照をキャッシュ
const elements = {
  count: document.getElementById("count")!,
  total: document.getElementById("total")!,
  status: document.getElementById("status")!,
};

function updateUI(): void {
  elements.count.textContent = String(count);
  elements.total.textContent = String(total);
  elements.status.textContent = status;
}
```

### スクリプトの配置

```html
<!-- Bad: head 内で読み込み（レンダリングをブロック） -->
<head>
  <script src="app.js"></script>
</head>

<!-- Good: body の最後に配置 -->
<body>
  <!-- コンテンツ -->
  <script src="app.js"></script>
</body>

<!-- Better: defer 属性を使用 -->
<head>
  <script src="app.js" defer></script>
</head>
```

---

## バンドル最適化

### 遅延読み込み（Lazy Loading）

```typescript
// 動的インポート
const loadModule = async (): Promise<void> => {
  const module = await import("./heavy-module");
  module.initialize();
};

// React での遅延読み込み
const HeavyComponent = React.lazy(() => import("./HeavyComponent"));

// Angular での遅延読み込み
const routes: Routes = [
  {
    path: "admin",
    loadChildren: () => import("./admin/admin.module").then((m) => m.AdminModule),
  },
];
```

### インポートの整理

```typescript
// Good: 未使用インポートを削除
import { usedFunction } from "./utils";

// Good: グループ化と整列
// 1. 外部ライブラリ
import React from "react";
import { useQuery } from "@tanstack/react-query";

// 2. 内部モジュール
import { UserService } from "@/services/user";
import { Button } from "@/components/Button";

// 3. 型のみ
import type { User } from "@/types";
```

### 圧縮

**Gzip/Brotli 圧縮**:

- ファイルサイズを最大 70% 削減
- サーバー側で設定（nginx, Apache 等）

**コード最小化**:

- 空白、コメント、長い変数名を削除
- Terser, esbuild 等のツールを使用

```typescript
// ビルド設定例（webpack）
module.exports = {
  optimization: {
    minimize: true,
    minimizer: [new TerserPlugin()],
  },
};
```

---

## 測定とツール

### Google Lighthouse

- Chrome DevTools または CLI で実行
- パフォーマンス、アクセシビリティ、SEO を監査
- 具体的な改善提案を提供

```bash
# CLI での実行
npx lighthouse https://example.com --output html --output-path ./report.html
```

### Core Web Vitals

- **LCP (Largest Contentful Paint)**: メインコンテンツの読み込み時間
- **FID (First Input Delay)**: 初回インタラクションへの応答時間
- **CLS (Cumulative Layout Shift)**: レイアウトの安定性

### パフォーマンス API

```typescript
// 処理時間の計測
const start = performance.now();
await heavyOperation();
const duration = performance.now() - start;
console.log(`Operation took ${duration}ms`);

// マークとメジャー
performance.mark("start-render");
// ... レンダリング処理
performance.mark("end-render");
performance.measure("render-time", "start-render", "end-render");
```

---

## Web Workers

### 重い処理のオフロード

```typescript
// main.ts
const worker = new Worker("./worker.ts");

worker.postMessage({ data: largeDataset });

worker.onmessage = (event) => {
  const result = event.data;
  updateUI(result);
};

// worker.ts
self.onmessage = (event) => {
  const { data } = event.data;

  // 重い計算（UI をブロックしない）
  const result = processData(data);

  self.postMessage(result);
};
```

### 使用場面

- 大量データの処理
- 画像/動画の処理
- 暗号化/復号化
- 複雑な計算

---

## ブラウザ互換性

### ブラウザ固有コードの回避

```typescript
// Bad: ブラウザ固有のコード
if (navigator.userAgent.includes("Chrome")) {
  // Chrome 専用処理
}

// Good: 機能検出
if ("IntersectionObserver" in window) {
  // IntersectionObserver を使用
} else {
  // フォールバック
}

// Good: 標準 API を使用
const isSupported = "fetch" in window;
```

### ポリフィル

```typescript
// 必要な場合のみポリフィルを読み込み
if (!Array.prototype.flat) {
  await import("array-flat-polyfill");
}
```

---

## プログレッシブエンハンスメント

### JavaScript なしでも動作

```html
<!-- Bad: JavaScript 必須のナビゲーション -->
<a href="javascript:void(0)" onclick="navigate('about')">About</a>

<!-- Good: JavaScript なしでも動作 -->
<a href="/about">About</a>
```

### 段階的な機能追加

```typescript
// 基本機能は HTML で提供
// JavaScript で強化
const links = document.querySelectorAll("a[data-spa]");

links.forEach((link) => {
  link.addEventListener("click", (e) => {
    e.preventDefault();
    // SPA ナビゲーション
    history.pushState(null, "", link.href);
    loadPage(link.href);
  });
});
```

### フォームの例

```html
<!-- JavaScript なしでも送信可能 -->
<form action="/submit" method="POST">
  <input type="email" name="email" required />
  <button type="submit">送信</button>
</form>

<script>
  // JavaScript で Ajax 送信に強化
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    await submitViaAjax(new FormData(form));
  });
</script>
```

---

## ライブラリ vs 生 JavaScript

### パフォーマンス考慮

```typescript
// jQuery
$(".item").each(function () {
  $(this).addClass("active");
});

// 生 JavaScript（より高速）
document.querySelectorAll(".item").forEach((el) => {
  el.classList.add("active");
});
```

### 判断基準

- **ライブラリを使用**: 開発効率が重要、複雑な機能、チームの習熟度
- **生 JavaScript**: パフォーマンスクリティカル、バンドルサイズ削減、シンプルな機能

---

## 設定と翻訳の分離

```typescript
// Good: 設定を分離
const config = {
  apiUrl: process.env.API_URL,
  maxRetries: 3,
  timeout: 5000,
};

// Good: 翻訳を分離
const i18n = {
  en: {
    greeting: "Hello",
    farewell: "Goodbye",
  },
  ja: {
    greeting: "こんにちは",
    farewell: "さようなら",
  },
};

function getMessage(key: string, lang: string): string {
  return i18n[lang]?.[key] ?? i18n.en[key];
}
```
