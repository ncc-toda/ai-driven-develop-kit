# レイアウトパターン

## 基本レイアウト

### 垂直スタック（最も一般的）

```swift
VStack(alignment: .leading, spacing: 16) {
    Text("タイトル").font(.headline)
    Text("説明文").font(.body)
    Button("アクション") { }
}
.padding()
```

### 水平スタック

```swift
HStack(spacing: 12) {
    Image(systemName: "star.fill")
    Text("ラベル")
    Spacer()
    Text("値").foregroundStyle(.secondary)
}
```

### グリッド（画像コレクション）

```swift
LazyVGrid(columns: [
    GridItem(.adaptive(minimum: 100))
], spacing: 16) {
    ForEach(items) { item in
        ItemView(item: item)
    }
}
```

## ナビゲーション構造

### シンプルなスタックナビゲーション

```swift
NavigationStack {
    List(items) { item in
        NavigationLink(item.title) {
            DetailView(item: item)
        }
    }
    .navigationTitle("リスト")
}
```

### 分割ビュー（iPad/Mac）

```swift
NavigationSplitView {
    // サイドバー
    List(categories, selection: $selectedCategory) { category in
        Label(category.name, systemImage: category.icon)
    }
} content: {
    // コンテンツ
    List(items) { item in
        NavigationLink(item.title) {
            DetailView(item: item)
        }
    }
} detail: {
    // 詳細
    DetailView(item: selectedItem)
}
```

### タブ構造

```swift
TabView {
    HomeView()
        .tabItem { Label("ホーム", systemImage: "house") }
    SearchView()
        .tabItem { Label("検索", systemImage: "magnifyingglass") }
    SettingsView()
        .tabItem { Label("設定", systemImage: "gear") }
}
```

## 適応性パターン

### Size Classes による切替

```swift
@Environment(\.horizontalSizeClass) var sizeClass

var body: some View {
    if sizeClass == .compact {
        TabView { /* タブナビゲーション */ }
    } else {
        NavigationSplitView { /* サイドバー */ }
    }
}
```

### セーフエリア対応

```swift
VStack {
    content
}
.safeAreaInset(edge: .bottom) {
    // 固定フッター
    ActionButton()
}
```

## フォーム設計

### 標準フォーム

```swift
Form {
    Section("アカウント") {
        TextField("名前", text: $name)
        TextField("メール", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
    }

    Section("セキュリティ") {
        SecureField("パスワード", text: $password)
        Toggle("Face ID を使用", isOn: $useFaceID)
    }

    Section {
        Button("保存", action: save)
            .disabled(!isValid)
    }
}
```

### バリデーション付きフォーム

```swift
TextField("メール", text: $email)
    .textContentType(.emailAddress)
    .onChange(of: email) { validateEmail($0) }

if !emailError.isEmpty {
    Text(emailError)
        .font(.caption)
        .foregroundStyle(.red)
}
```

## 共通パターン

### リスト行

```swift
HStack {
    Image(systemName: icon)
        .foregroundStyle(.blue)
        .frame(width: 30)

    VStack(alignment: .leading) {
        Text(title)
        Text(subtitle)
            .font(.caption)
            .foregroundStyle(.secondary)
    }

    Spacer()

    Text(value)
        .foregroundStyle(.secondary)
}
.frame(minHeight: 44) // タップターゲット確保
```

### カード

```swift
VStack(alignment: .leading, spacing: 8) {
    Image(item.image)
        .resizable()
        .aspectRatio(contentMode: .fill)

    Text(item.title)
        .font(.headline)

    Text(item.description)
        .font(.subheadline)
        .foregroundStyle(.secondary)
}
.background(.regularMaterial)
.clipShape(RoundedRectangle(cornerRadius: 12))
```
