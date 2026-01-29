# HIG パターン (Patterns)

## 1. データ入力

| 項目              | 推奨                             | 実装                                                   |
| :---------------- | :------------------------------- | :----------------------------------------------------- |
| 入力最小化        | システムから自動取得             | Core Data, UserDefaults, Contacts Framework, HealthKit |
| 入力方法多様化    | キーボード/ピッカー/D&D/ペースト | Drag and Drop API, UIPasteboard                        |
| セキュア入力      | 機密データは隠す                 | `SecureField`, `isSecureTextEntry`, Keychain           |
| 動的検証          | 入力直後にフィードバック         | Combine, `@State`でリアルタイム検証                    |
| 必須データ明確化  | 未入力時は進行不可               | ボタン非活性化 + ツールチップ                          |
| visionOS セキュア | 装着者のみに表示                 | 標準テキスト入力コンポーネント                         |

### SwiftUI 実装例

```swift
// セキュア入力
SecureField("パスワード", text: $password)

// 動的検証
TextField("メール", text: $email)
    .onChange(of: email) { validateEmail($0) }

// 必須フィールド
Button("次へ") { submit() }
    .disabled(email.isEmpty || !isValidEmail)
```

## 2. フィードバック

| 項目                 | 推奨                      | 実装                                        |
| :------------------- | :------------------------ | :------------------------------------------ |
| 多角的フィードバック | 色+テキスト+サウンド+触覚 | Core Haptics, SystemSoundID, AVAudioPlayer  |
| 状況フィードバック   | 対象近くで非中断的に      | Toast/Snackbar→`.overlay`、`.alert`は避ける |
| アラート             | 重大情報のみ              | データ損失/セキュリティ問題時のみ`alert`    |
| watchOS プログレス   | 不確定インジケータ禁止    | バックグラウンド処理 + WKUserNotification   |

### フィードバック選択基準

```text
重要度は？
├─ 重大（データ損失/セキュリティ） → .alert / UIAlertController
├─ 中程度（操作結果） → Toast/Snackbar（.overlay で実装）
└─ 軽微（状態変化） → インライン表示 + ハプティクス
```

### フィードバック SwiftUI 実装例

```swift
// 非中断的フィードバック（Toast）
.overlay(alignment: .bottom) {
    if showToast {
        Text("保存しました")
            .padding()
            .background(.regularMaterial)
            .cornerRadius(8)
    }
}

// 重大な情報のみアラート
.alert("データを削除しますか？", isPresented: $showDeleteAlert) {
    Button("削除", role: .destructive) { delete() }
    Button("キャンセル", role: .cancel) { }
}
```

## 3. 共同作業と共有

| 項目       | 推奨             | 実装                                         |
| :--------- | :--------------- | :------------------------------------------- |
| 共有ボタン | ツールバーに配置 | `ShareLink`, `square.and.arrow.up`アイコン   |
| 共有シート | カスタマイズ可能 | UIActivityItemSource, カスタム UIActivity    |
| 共同作業   | リアルタイム同期 | CloudKit, Core Data with CloudKit, SharePlay |
| 通知統合   | メッセージに投稿 | Messages Framework, User Notifications       |
| watchOS    | 非対応           | 共有 UI 非表示/無効化                        |

### 共有 SwiftUI 実装例

```swift
// 共有機能
ShareLink(item: url) {
    Label("共有", systemImage: "square.and.arrow.up")
}

// ツールバーに配置
.toolbar {
    ToolbarItem(placement: .primaryAction) {
        ShareLink(item: document.url)
    }
}
```

## 4. プラットフォーム固有の制約

| プラットフォーム | 制約                                                              |
| :--------------- | :---------------------------------------------------------------- |
| watchOS          | 共有/共同作業非対応、不確定プログレス禁止、Dynamic Type 140% 以上 |
| visionOS         | セキュア入力は装着者のみ表示、マテリアルでコントロール区別        |
| iPadOS           | マルチタスク必須、D&D 対応推奨                                    |
| macOS            | キーボードショートカット対応、カラム表示/タブビュー利用可         |
