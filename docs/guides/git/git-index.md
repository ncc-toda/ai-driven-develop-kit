# Git 運用ルール

このドキュメントでは、本プロジェクトにおける Git 運用のルールを定義します。

---

## 現在のフェーズ: **pre-release**

---

## ルールファイル

| ファイル                                   | 内容                                   |
| ------------------------------------------ | -------------------------------------- |
| [git-common.md](git-common.md)             | 共通ルール（コミット形式、pre-commit） |
| [git-pre-release.md](git-pre-release.md)   | リリース前ルール（現在適用中）         |
| [git-post-release.md](git-post-release.md) | リリース後ルール                       |

## 適用ルール

- 共通: [git-common.md](git-common.md)
- 現在: [git-pre-release.md](git-pre-release.md)

## フェーズ変更時

リリース時に以下を更新してください：

1. このファイルの「現在のフェーズ」を `post-release` に変更
2. 「現在」のリンクを `git-post-release.md` に変更
