# AI-Driven Development Kit

AI 駆動開発のためのプロジェクト基盤。**個人開発者向け**のテンプレートです。

1人で開発するプロジェクトに最適化されています。チーム開発向けの機能（リスク管理、詳細な進捗管理等）は意図的に省略し、スピードと柔軟性を重視しています。

> **Note**: このリポジトリをテンプレートとして使用する場合は [TEMPLATE_USAGE.md](TEMPLATE_USAGE.md) を参照してください。

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
