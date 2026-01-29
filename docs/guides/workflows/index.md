# ワークフロー

開発タスクの種類に応じたワークフローは **Commands** と **Skills** として提供されています。

## ワークフロー（Commands）

ユーザーが明示的に呼び出すワークフローです。`/command-name` の形式で呼び出してください。

### pre-release（新規開発）

| Command            | 用途               |
| ------------------ | ------------------ |
| `/wf-requirements` | 要件定義           |
| `/wf-design`       | 初期設計           |
| `/wf-setup`        | プロジェクト構築   |
| `/wf-design-doc`   | 設計書作成         |
| `/wf-design-impl`  | 設計書に基づく実装 |

### post-release（運用）

| Command        | 用途             |
| -------------- | ---------------- |
| `/wf-bugfix`   | バグ修正（TDD）  |
| `/wf-feature`  | 機能追加（TDD）  |
| `/wf-refactor` | リファクタリング |

### 共通

| Command     | 用途                 |
| ----------- | -------------------- |
| `/wf-env`   | 環境整備             |
| `/qa-check` | 静的解析・テスト実行 |

## レビュー（Skills）

Claude が自動的に使用するか、`/skill-name` で呼び出せます。

### 共通の観点

| Skill                | 用途                                 |
| -------------------- | ------------------------------------ |
| `/self-review`       | セルフレビュー（複数観点を自動選択） |
| `/review-security`   | セキュリティレビュー                 |
| `/review-senior`     | シニアエンジニアレビュー             |
| `/review-qa`         | QA レビュー                          |
| `/review-minimalist` | ミニマリストレビュー                 |
| `/review-ux`         | UI/UX レビュー                       |

### 言語・FW 別

| Skill           | 用途                  |
| --------------- | --------------------- |
| `/review-ts`    | TypeScript レビュー   |
| `/review-dart`  | Dart/Flutter レビュー |
| `/review-swift` | Swift/iOS レビュー    |

### プラットフォーム別

| Skill            | 用途                       |
| ---------------- | -------------------------- |
| `/review-web`    | Web フロントエンドレビュー |
| `/review-mobile` | モバイルレビュー           |

## ドキュメント保存場所

| 種類           | 保存先                |
| -------------- | --------------------- |
| 仕様書・設計書 | `docs/specs/`         |
| 規約・ガイド   | `docs/guides/`        |
| 作業ログ       | `docs/tasks/ai-logs/` |

## Git 操作

[Git 運用ルール](../git/git-index.md) に従ってください。
