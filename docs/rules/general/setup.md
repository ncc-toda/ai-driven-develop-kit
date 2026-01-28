# セットアップ

本プロジェクトの開発環境セットアップ手順です。

## 1. devbox のインストール

[devbox](https://www.jetify.com/devbox) で開発環境を管理しています。

```bash
# devbox のインストール（未インストールの場合）
curl -fsSL https://get.jetify.com/devbox | bash
```

## 2. 開発シェルに入る

```bash
devbox shell
```

これにより、以下の言語・ツールが利用可能になります：

| 言語       | バージョン   | 備考               |
| ---------- | ------------ | ------------------ |
| TypeScript | Node.js 24.x | Corepack 有効      |
| Dart       | 3.x          | Flutter 開発も可能 |
| Swift      | システム版   | Xcode 付属         |
| Markdown   | -            | ドキュメント用     |

## 3. pre-commit フックのインストール

```bash
devbox run setup
```

これにより、コミット前に自動で lint/format が実行されるようになります。

## スクリプト一覧

### 基本コマンド

```bash
devbox run setup     # pre-commit フックをインストール
devbox run versions  # バージョン確認
devbox run lint      # 全ファイルの lint を実行
devbox run format    # 全ファイルをフォーマット
```

### 言語別コマンド

```bash
# TypeScript/JavaScript
devbox run lint:ts     # oxlint
devbox run format:ts   # oxfmt

# Markdown
devbox run lint:md     # markdownlint

# Dart
devbox run lint:dart   # dart analyze
devbox run format:dart # dart format

# Swift
devbox run lint:swift   # swift-format lint
devbox run format:swift # swift-format
```

## テンプレートからの新規プロジェクト作成

このリポジトリをテンプレートとして使用する場合：

```bash
# コピー
cp -r ai-driven-develop-kit your-new-project
cd your-new-project

# 初期化
rm -rf .git
git init
devbox shell

# pre-commit フックをインストール
devbox run setup
```
