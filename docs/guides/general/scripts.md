# スクリプト一覧

開発で使用するスクリプトの一覧です。
スクリプトは [devbox.json](/devbox.json) の `shell.scripts` セクションで定義されています。

```bash
# 利用可能なスクリプト一覧を確認
devbox run --list
```

## 基本コマンド

| コマンド              | 説明                            |
| --------------------- | ------------------------------- |
| `devbox run setup`    | pre-commit フックをインストール |
| `devbox run versions` | バージョン確認                  |
| `devbox run lint`     | 全ファイルの lint を実行        |
| `devbox run format`   | 全ファイルをフォーマット        |

## 言語別コマンド

### TypeScript/JavaScript

| コマンド               | ツール   | 説明         |
| ---------------------- | -------- | ------------ |
| `devbox run lint:ts`   | oxlint   | lint 実行    |
| `devbox run format:ts` | oxfmt    | フォーマット |
| `devbox run test:ts`   | npm test | テスト実行   |

### Markdown

| コマンド             | ツール            | 説明      |
| -------------------- | ----------------- | --------- |
| `devbox run lint:md` | markdownlint-cli2 | lint 実行 |

### Dart

| コマンド                 | ツール       | 説明         |
| ------------------------ | ------------ | ------------ |
| `devbox run lint:dart`   | dart analyze | 静的解析     |
| `devbox run format:dart` | dart format  | フォーマット |
| `devbox run test:dart`   | dart test    | テスト実行   |

### Swift

| コマンド                  | ツール       | 説明         |
| ------------------------- | ------------ | ------------ |
| `devbox run lint:swift`   | swift-format | lint 実行    |
| `devbox run format:swift` | swift-format | フォーマット |

## インフラ関連

| コマンド                      | 説明                  |
| ----------------------------- | --------------------- |
| `devbox run github:configure` | GitHub リポジトリ設定 |
