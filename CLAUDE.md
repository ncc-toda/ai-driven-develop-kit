# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

AI 駆動開発用のテンプレートプロジェクト。複数言語（TypeScript, Dart, Swift, Markdown）に対応した開発環境とコード品質管理の基盤を提供。

**対象**: 個人開発者（1人で開発するプロジェクト向け）

**現在のフェーズ**: pre-release（main 直接コミット可、スピード重視）

## 設計方針

このテンプレートは**個人開発**を前提としています。

| 方針                 | 理由                             |
| -------------------- | -------------------------------- |
| オーバーヘッド最小化 | 1人なのでプロセスより結果重視    |
| ドキュメントは最小限 | 自分が分かればいい               |
| 柔軟な運用           | 厳格なルールより状況に応じた判断 |
| スピード重視         | 個人開発の強みを活かす           |

**チーム開発向けの機能（リスク管理、詳細な進捗管理、フォーマルなレビュープロセス等）は意図的に省略しています。**

## クイックリファレンス

```bash
# 開発環境（direnv 未設定の場合）
devbox shell

# Lint & Format
devbox run lint
devbox run format
```

全スクリプトは [docs/guides/general/scripts.md](docs/guides/general/scripts.md) を参照。

## ドキュメント参照

| 内容                       | ドキュメント                                                             |
| -------------------------- | ------------------------------------------------------------------------ |
| セットアップ手順           | [docs/guides/general/setup.md](docs/guides/general/setup.md)             |
| スクリプト一覧             | [docs/guides/general/scripts.md](docs/guides/general/scripts.md)         |
| プロジェクト構造           | [docs/guides/general/structure.md](docs/guides/general/structure.md)     |
| コミットルール・pre-commit | [docs/guides/git/git-common.md](docs/guides/git/git-common.md)           |
| 現フェーズの Git 運用      | [docs/guides/git/git-pre-release.md](docs/guides/git/git-pre-release.md) |
| タスク管理                 | [docs/tasks/pre-release/index.md](docs/tasks/pre-release/index.md)       |

## ワークフロー（Commands）

開発タスクは **Commands** として提供されています。`/command-name` の形式で呼び出してください。

### テンプレート初期化

| Command         | 用途                                         |
| --------------- | -------------------------------------------- |
| `/init-project` | テンプレートを自分のプロジェクトとして初期化 |

### pre-release（新規開発）

| Command         | 用途               |
| --------------- | ------------------ |
| `/requirements` | 要件定義           |
| `/design`       | 初期設計           |
| `/setup`        | プロジェクト構築   |
| `/design-doc`   | 設計書作成         |
| `/design-impl`  | 設計書に基づく実装 |

### post-release（運用）

| Command     | 用途             |
| ----------- | ---------------- |
| `/bugfix`   | バグ修正（TDD）  |
| `/feature`  | 機能追加（TDD）  |
| `/refactor` | リファクタリング |

### 共通

| Command | 用途     |
| ------- | -------- |
| `/env`  | 環境整備 |

## 作業ログ・報告

作業ログは `docs/tasks/ai-logs/YYYY-MM-DD_{slug}.md` に保存します。

対応完了時の報告では、使用した Command・Skill を明記してください。
