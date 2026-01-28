# AI-Driven Development Kit

AI 駆動開発のためのテンプレートプロジェクト。

## 使い方

新しいプロジェクトを始めるときは、このリポジトリをコピーしてください。

詳細なセットアップ手順は [docs/guides/general/setup.md](docs/guides/general/setup.md) を参照してください。

```bash
# クイックスタート
cp -r ai-driven-develop-kit your-new-project
cd your-new-project
rm -rf .git && git init
devbox shell
devbox run setup
```

## 開発環境

[devbox](https://www.jetify.com/devbox) で開発環境を管理しています。

詳細は [docs/guides/general/setup.md](docs/guides/general/setup.md) を参照してください。

### 利用可能な言語

| 言語       | バージョン   | 備考               |
| ---------- | ------------ | ------------------ |
| TypeScript | Node.js 24.x | Corepack 有効      |
| Dart       | 3.x          | Flutter 開発も可能 |
| Swift      | システム版   | Xcode 付属         |
| Markdown   | -            | ドキュメント用     |

## Lint & Format ツール

| 言語                  | Lint         | Format       |
| --------------------- | ------------ | ------------ |
| TypeScript/JavaScript | oxlint       | oxfmt        |
| JSON/YAML             | -            | oxfmt        |
| Markdown              | markdownlint | oxfmt        |
| Dart                  | dart analyze | dart format  |
| Swift                 | swift-format | swift-format |

## ディレクトリ構成

```txt
.
├── backend/                 # バックエンド（API サーバー等）
├── frontend/                # フロントエンド（Web/モバイルアプリ等）
├── docs/                    # ドキュメント
└── ...                      # 設定ファイル類
```

詳細は [docs/guides/general/structure.md](docs/guides/general/structure.md) を参照してください。

## ライセンス

MIT
