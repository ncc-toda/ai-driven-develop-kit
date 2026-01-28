# ワークフロー一覧

開発タスクの種類に応じたワークフローファイルです。
使用時は「`{ファイルパス}` に従って作業してください。{作業内容}」の形式で指示します。

## ワークフロー

| ファイル                           | 用途             |
| ---------------------------------- | ---------------- |
| [bug-fix.md](./bug-fix.md)         | バグ修正         |
| [feature-add.md](./feature-add.md) | 機能追加         |
| [refactor.md](./refactor.md)       | リファクタリング |
| [env-setup.md](./env-setup.md)     | 環境整備         |

## 共通手順

各ワークフローから参照される共通手順です。

| ファイル                                  | 内容             |
| ----------------------------------------- | ---------------- |
| [\_common/log.md](./_common/log.md)       | 作業ログ         |
| [\_common/review.md](./_common/review.md) | セルフレビュー   |
| [\_common/qa.md](./_common/qa.md)         | 静的解析・テスト |

## レビュー役割

セルフレビュー時に参照する役割です。詳細は [\_common/review.md](./_common/review.md) を参照。

## Git 操作

Git 操作は [Git 運用ルール](../git/git-index.md) に従ってください。
