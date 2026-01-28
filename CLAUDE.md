# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

AI 駆動開発用のテンプレートプロジェクト。複数言語（TypeScript, Dart, Swift, Markdown）に対応した開発環境とコード品質管理の基盤を提供。

**現在のフェーズ**: pre-release（main 直接コミット可、スピード重視）

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
| ワークフロー               | [docs/guides/workflows/index.md](docs/guides/workflows/index.md)         |

## ワークフロー

開発タスクはワークフローファイルに従って進めます。
使用時は「`{ファイルパス}` に従って作業してください。{作業内容}」の形式で指示します。

| ワークフロー     | ファイル                                                                     |
| ---------------- | ---------------------------------------------------------------------------- |
| バグ修正         | [docs/guides/workflows/bug-fix.md](docs/guides/workflows/bug-fix.md)         |
| 機能追加         | [docs/guides/workflows/feature-add.md](docs/guides/workflows/feature-add.md) |
| リファクタリング | [docs/guides/workflows/refactor.md](docs/guides/workflows/refactor.md)       |
| 環境整備         | [docs/guides/workflows/env-setup.md](docs/guides/workflows/env-setup.md)     |

作業ログは `docs/tasks/ai-logs/YYYY-MM-DD_{slug}.md` に保存します。
