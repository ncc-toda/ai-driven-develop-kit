# Git 共通ルール

このドキュメントでは、フェーズに関わらず適用される Git の共通ルールを定義します。

## コミットメッセージのルール

### フォーマット

```txt
[type]: [内容] [emoji]
```

- **内容は日本語で記載する**
- type と emoji は英語（規定のもの）を使用

### type の種類

| type       | 説明                                     |
| ---------- | ---------------------------------------- |
| `feat`     | 新機能                                   |
| `fix`      | バグ修正                                 |
| `docs`     | ドキュメント関連                         |
| `style`    | コードスタイルの修正（フォーマットなど） |
| `refactor` | リファクタリング                         |
| `test`     | テスト関連                               |
| `chore`    | ビルドプロセスやツール関連               |
| `build`    | ビルド関連の変更                         |
| `ci`       | CI 関連の変更                            |

### 絵文字の例

| 絵文字コード       | 表示 | 用途                   |
| ------------------ | ---- | ---------------------- |
| `:sparkles:`       | ✨   | 新機能                 |
| `:bug:`            | 🐛   | バグ修正               |
| `:memo:`           | 📝   | ドキュメント           |
| `:hammer:`         | 🔨   | リファクタリング       |
| `:package:`        | 📦   | パッケージ関連         |
| `:test_tube:`      | 🧪   | テスト                 |
| `:lipstick:`       | 💄   | UI/スタイル関連        |
| `:rotating_light:` | 🚨   | Lint 警告対応          |
| `:green_heart:`    | 💚   | CI 修正                |
| `:recycle:`        | ♻️   | コードリファクタリング |
| `:technologist:`   | 👨‍💻   | 開発者ツール関連       |
| `:wrench:`         | 🔧   | 設定ファイル関連       |

### コミットメッセージの例

```txt
docs: README にセットアップ手順を追加 :memo:
chore: devbox.json に Dart を追加 :wrench:
feat: TypeScript の lint 設定を追加 :sparkles:
fix: pre-commit フックの実行エラーを修正 :bug:
```

## pre-commit フック

本プロジェクトでは pre-commit を使用してコミット前に自動でコード品質チェックを行います。

### セットアップ

[setup.md](../general/setup.md) を参照してください。

### 実行されるフック

コミット時に以下のチェックが自動実行されます：

| フック名            | 対象ファイル                                | 内容                          |
| ------------------- | ------------------------------------------- | ----------------------------- |
| `oxlint`            | `.js`, `.jsx`, `.ts`, `.tsx`, etc.          | TypeScript/JavaScript の lint |
| `oxfmt`             | `.js`, `.ts`, `.json`, `.yaml`, `.md`, etc. | フォーマット                  |
| `markdownlint`      | `.md`                                       | Markdown の lint              |
| `dart-format`       | `.dart`                                     | Dart のフォーマット           |
| `dart-analyze`      | `.dart`                                     | Dart の静的解析               |
| `swift-format`      | `.swift`                                    | Swift のフォーマット          |
| `swift-format-lint` | `.swift`                                    | Swift の lint                 |

### フックが失敗した場合

1. エラーメッセージを確認する
2. 指摘された箇所を修正する（フォーマットは自動修正される場合もある）
3. 修正したファイルを `git add` で再ステージング
4. 再度 `git commit` を実行

### フックのスキップは原則禁止

`--no-verify` オプションによるフックのスキップは **原則禁止** です。

```bash
# これは原則禁止
git commit --no-verify -m "message"
```

フックが失敗する場合は、必ずコードを修正して対応してください。

**どうしてもスキップが必要な場合:**

- 必ずユーザーの承認を得てから実行すること
- 理由を明確にし、承認を得た上で実行すること
