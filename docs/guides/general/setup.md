# セットアップ

本プロジェクトの開発環境セットアップ手順です。

## 1. devbox のインストール

[devbox](https://www.jetify.com/devbox) で開発環境を管理しています。

```bash
# devbox のインストール（未インストールの場合）
curl -fsSL https://get.jetify.com/devbox | bash
```

## 2. direnv の設定（推奨）

direnv を使うと、ディレクトリに入るだけで自動的に開発環境がロードされます。

シェルの設定ファイルに以下を追加:

```bash
# fish (~/.config/fish/config.fish)
direnv hook fish | source

# zsh (~/.zshrc)
eval "$(direnv hook zsh)"

# bash (~/.bashrc)
eval "$(direnv hook bash)"
```

初回のみ許可が必要:

```bash
cd ai-driven-develop-kit
direnv allow
```

## 3. 開発環境の起動

```bash
# direnv 設定済みの場合: cd するだけで自動ロード
cd ai-driven-develop-kit

# direnv 未設定の場合: 手動でシェルに入る
devbox shell
```

これにより、以下の言語・ツールが利用可能になります：

| 言語       | バージョン   | 備考               |
| ---------- | ------------ | ------------------ |
| TypeScript | Node.js 24.x | Corepack 有効      |
| Dart       | 3.x          | Flutter 開発も可能 |
| Swift      | システム版   | Xcode 付属         |
| Markdown   | -            | ドキュメント用     |

## 4. pre-commit フックのインストール

```bash
devbox run setup
```

これにより、コミット前に自動で lint/format が実行されるようになります。

## スクリプト一覧

利用可能なスクリプトは [スクリプト一覧](./scripts.md) を参照してください。

## テンプレートからの新規プロジェクト作成

このリポジトリをテンプレートとして使用する場合：

```bash
# コピー
cp -r ai-driven-develop-kit your-new-project
cd your-new-project

# 初期化
rm -rf .git
git init

# direnv を許可（direnv 設定済みの場合）
direnv allow

# または手動でシェルに入る
devbox shell

# pre-commit フックをインストール
devbox run setup
```
