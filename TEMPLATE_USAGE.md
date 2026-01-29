# テンプレートの使い方

このリポジトリは AI 駆動開発のためのテンプレートプロジェクトです。

## はじめに読むドキュメント

テンプレートを使う前に、以下のドキュメントを確認してください。

| ドキュメント                                                         | 内容             |
| -------------------------------------------------------------------- | ---------------- |
| [docs/guides/general/structure.md](docs/guides/general/structure.md) | ディレクトリ構成 |
| [docs/guides/general/setup.md](docs/guides/general/setup.md)         | セットアップ手順 |

## 新しいプロジェクトを始める

```bash
# リポジトリをコピー
cp -r ai-driven-develop-kit your-new-project
cd your-new-project

# Git を初期化
rm -rf .git && git init

# 開発環境をセットアップ
devbox shell
devbox run setup
```

## コピー後の作業

1. `README.md` をプロジェクトに合わせて編集
2. `TEMPLATE_USAGE.md`（このファイル）を削除
3. `docs/tasks/` 配下の不要なファイルを整理

## 設計方針

### MCP（Model Context Protocol）について

本テンプレートでは **MCP をむやみに使用しない方針** です。

**理由**:

- 環境依存を減らし、シンプルな構成を維持するため
- 標準ツール（git, gh CLI, devbox 等）で十分な機能を提供できるため
- MCP サーバーの設定・管理コストを避けるため

参考用の設定テンプレートは [mcp.json](mcp.json) を参照してください。

## 詳細

セットアップの詳細は [docs/guides/general/setup.md](docs/guides/general/setup.md) を参照してください。
