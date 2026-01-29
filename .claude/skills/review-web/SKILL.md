# Web フロントエンドレビュー

Web フロントエンドの観点でコードをレビューします。

## 使い方

````bash
/review-web [対象ファイルやコード]
```bash

---

## 指示

Task ツールで `frontend` subagent を使用してレビューを実行してください。

## 確認観点

- セマンティック HTML を使用しているか
  - 適切なタグの選択（`header`, `nav`, `main`, `article`, `section`, `aside`, `footer`）
  - 見出しの階層構造
  - `div` / `span` の過剰使用を避ける
- アクセシビリティ（WCAG）に準拠しているか
  - ARIA 属性の適切な使用
  - alt テキスト
  - フォーカス管理
  - キーボード操作
  - 色のコントラスト比
- レスポンシブデザインに対応しているか
  - ブレークポイントの設定
  - フレキシブルレイアウト
  - 画像の最適化
  - モバイルファースト
- パフォーマンス（Core Web Vitals）を考慮しているか
  - LCP（Largest Contentful Paint）
  - FID（First Input Delay）/ INP（Interaction to Next Paint）
  - CLS（Cumulative Layout Shift）
  - バンドルサイズ
  - 遅延読み込み
- SEO に配慮しているか（該当する場合）
  - メタタグ
  - 構造化データ
  - サイトマップ
  - canonical URL
- ブラウザ互換性を考慮しているか
  - サポートブラウザの確認
  - Polyfill の必要性
  - CSS プレフィックス
- CSS の命名規則・設計手法に従っているか
  - BEM, CSS Modules, Styled Components など
  - 一貫した命名規則
  - スタイルの重複を避ける

## 出力

問題があれば具体的な改善案を提示すること。
````
