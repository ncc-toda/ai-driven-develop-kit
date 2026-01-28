# プロジェクト構造

このドキュメントでは、プロジェクトのディレクトリ構成と各ディレクトリの役割を説明します。

## ディレクトリ構成

```txt
.
├── backend/                 # バックエンド
├── frontend/                # フロントエンド
├── docs/                    # ドキュメント
│   ├── rules/               # 開発ルール・ガイドライン
│   │   ├── general/         # 全般（セットアップ、構造など）
│   │   ├── git/             # Git 運用ルール
│   │   └── workflows/       # AI 向けワークフロー定義
│   │       └── _common/     # 共通手順
│   └── tasks/               # タスク管理
│       ├── pre-release/     # pre-release フェーズのタスク
│       └── ai-logs/         # 作業ログ
├── .github/                 # GitHub 設定（Issue/PR テンプレート等）
├── .pre-commit-config.yaml  # pre-commit 設定
├── .prettierrc.json         # oxfmt 設定 (Prettier 互換)
├── .markdownlint.json       # markdownlint 設定
├── devbox.json              # 開発環境設定
├── CLAUDE.md                # Claude Code 用ガイダンス
└── README.md                # プロジェクト概要
```

## 各ディレクトリの役割

### backend/

バックエンドのプログラムを配置するディレクトリ。

**配置するもの：**

- API サーバー
- バッチ処理・スケジュールジョブ
- データベース関連モジュール
- 外部サービス連携

### frontend/

フロントエンドのプログラムを配置するディレクトリ。

**配置するもの：**

- Web アプリケーション
- モバイルアプリ（Flutter 等）
- CLI ツール
- デスクトップアプリ

### docs/

プロジェクトのドキュメントを配置するディレクトリ。

| サブディレクトリ     | 内容                               |
| -------------------- | ---------------------------------- |
| `rules/general/`     | セットアップ、プロジェクト構造など |
| `rules/git/`         | Git 運用ルール                     |
| `rules/workflows/`   | AI 向けワークフロー定義            |
| `tasks/pre-release/` | pre-release フェーズのタスク管理   |
| `tasks/ai-logs/`     | 作業ログ                           |
