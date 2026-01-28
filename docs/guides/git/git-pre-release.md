# Git ルール（リリース前）

リリース前フェーズにおける Git 運用ルールです。

## 基本方針

- **スピード重視**: 素早く試行錯誤できることを優先
- **軽量な運用**: Issue/PR のオーバーヘッドを避ける
- **main 直接コミット可**: ブランチを切らずに作業できる

## ブランチ戦略

### メインブランチ

- `main`: 開発用ブランチ。直接コミット可

### 作業ブランチ（任意）

大きな変更や試験的な実装を行う場合は、作業ブランチを切ることもできます。

```txt
[type]/[タスクID]-[簡潔な説明]
```

例：

- `feature/001-add-flutter-template`
- `fix/002-pre-commit-error`

## タスク管理

GitHub Issue の代わりに、ローカルの markdown ファイルでタスクを管理します。

- タスク一覧: `docs/tasks/pre-release/index.md`
- タスク詳細: `docs/tasks/pre-release/detail/`

### タスク ID

- 連番で管理（001, 002, ...）
- コミットメッセージにタスク ID を含める（任意）

```txt
feat: Flutter テンプレートを追加 (001) :sparkles:
```

## コミットのルール

- コミットメッセージは共通ルール（`git-common.md`）に従う
- タスク ID を含める場合は末尾に `(ID)` 形式で記載
- 小さな単位でこまめにコミットする

## リリース時の移行

リリース時に以下を行います：

1. 残っているタスクを確認
2. 必要なタスクを GitHub Issue へ移行
3. `docs/pre-release-task/` をアーカイブまたは削除
4. `docs/guides/git/git-index.md` のフェーズを `post-release` に変更
