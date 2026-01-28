# pre-release ワークフロー

新規開発フェーズで使用するワークフローです。
プロジェクトの立ち上げから初回リリースまでの流れをカバーします。

## ワークフロー一覧

| ファイル                                     | 用途             |
| -------------------------------------------- | ---------------- |
| [requirements.md](./requirements.md)         | 要件定義         |
| [initial-design.md](./initial-design.md)     | 初期設計         |
| [project-setup.md](./project-setup.md)       | プロジェクト構築 |
| [design-doc.md](./design-doc.md)             | 設計書作成       |
| [impl-from-design.md](./impl-from-design.md) | 設計に基づく実装 |

## 推奨フロー

新規プロジェクトを立ち上げる場合、以下の順序で進めることを推奨します。

```text
┌─────────────────┐
│  requirements   │  1. 要件定義
│  （要件定義）    │     何を作るか、なぜ作るかを明確にする
└────────┬────────┘
         ▼
┌─────────────────┐
│ initial-design  │  2. 初期設計
│  （初期設計）    │     技術スタック、アーキテクチャ、規約を決定
└────────┬────────┘
         ▼
┌─────────────────┐
│ project-setup   │  3. プロジェクト構築
│（プロジェクト構築）│     リポジトリ、開発環境、ツールを構築
└────────┬────────┘
         ▼
┌─────────────────┐
│  design-doc     │  4. 設計書作成（機能ごとに繰り返し）
│  （設計書作成）   │     API、DB、画面などの詳細設計
└────────┬────────┘
         ▼
┌─────────────────┐
│ impl-from-design│  5. 設計に基づく実装（機能ごとに繰り返し）
│（設計に基づく実装）│     TDD で設計書どおりに実装
└─────────────────┘
```

## 使用パターン

### パターン 1: ゼロからプロジェクトを立ち上げる

すべてのワークフローを順番に実行します。

```text
requirements → initial-design → project-setup → design-doc → impl-from-design
```

### パターン 2: 本プロジェクトをテンプレートとして使用

初期設計・プロジェクト構築は本プロジェクトの設定を踏襲し、要件定義から開始します。

```text
requirements → initial-design（踏襲確認） → project-setup（踏襲確認） → design-doc → impl-from-design
```

### パターン 3: 機能を追加実装する

設計書作成と実装を繰り返します。

```text
design-doc → impl-from-design → design-doc → impl-from-design → ...
```

## 各ワークフローの概要

### requirements.md（要件定義）

**目的**: プロジェクトの背景、目的、機能要件、非機能要件を明確にする

**主な成果物**:

- 要件定義書（`docs/specs/` に保存）

**次のステップ**: initial-design.md

---

### initial-design.md（初期設計）

**目的**: 技術スタック、アーキテクチャ、ディレクトリ構造、開発規約を決定する

**主な成果物**:

- 初期設計書（`docs/specs/` に保存）
- 開発規約（`docs/guides/` に保存）

**次のステップ**: project-setup.md

---

### project-setup.md（プロジェクト構築）

**目的**: 設計に基づいてリポジトリ、開発環境、ツールを構築する

**主な成果物**:

- 動作する開発環境
- README.md、CLAUDE.md

**次のステップ**: design-doc.md

---

### design-doc.md（設計書作成）

**目的**: 実装する機能の詳細設計（API、DB、画面など）を行う

**主な成果物**:

- 各種設計書（`docs/specs/` に保存）

**次のステップ**: impl-from-design.md

---

### impl-from-design.md（設計に基づく実装）

**目的**: 設計書に基づき TDD で実装する

**主な成果物**:

- 実装コード
- テストコード

**次のステップ**: 次の機能の design-doc.md、または運用フェーズへ移行
