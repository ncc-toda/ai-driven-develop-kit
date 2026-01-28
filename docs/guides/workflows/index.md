# ワークフロー一覧

開発タスクの種類に応じたワークフローファイルです。
使用時は「`{ファイルパス}` に従って作業してください。{作業内容}」の形式で指示します。

## pre-release（新規開発）

| ファイル                                                 | 用途             |
| -------------------------------------------------------- | ---------------- |
| [requirements.md](./pre-release/requirements.md)         | 要件定義         |
| [initial-design.md](./pre-release/initial-design.md)     | 初期設計         |
| [project-setup.md](./pre-release/project-setup.md)       | プロジェクト構築 |
| [design-doc.md](./pre-release/design-doc.md)             | 設計書作成       |
| [impl-from-design.md](./pre-release/impl-from-design.md) | 設計に基づく実装 |

## post-release（運用）

| ファイル                                        | 用途             |
| ----------------------------------------------- | ---------------- |
| [bug-fix.md](./post-release/bug-fix.md)         | バグ修正         |
| [feature-add.md](./post-release/feature-add.md) | 機能追加         |
| [refactor.md](./post-release/refactor.md)       | リファクタリング |

## 共通

| ファイル                              | 用途     |
| ------------------------------------- | -------- |
| [env-setup.md](./common/env-setup.md) | 環境整備 |

## 共通手順（\_parts）

各ワークフローから参照される共通手順です。

| ファイル                                | 内容             |
| --------------------------------------- | ---------------- |
| [\_parts/log.md](./_parts/log.md)       | 作業ログ         |
| [\_parts/review.md](./_parts/review.md) | セルフレビュー   |
| [\_parts/qa.md](./_parts/qa.md)         | 静的解析・テスト |

## レビュー役割

セルフレビュー時に参照する役割です。詳細は [\_parts/review.md](./_parts/review.md) を参照。

## Git 操作

Git 操作は [Git 運用ルール](../git/git-index.md) に従ってください。
