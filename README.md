# executor_sample

> [!NOTE]
>  このプロジェクトのFlutterSDKは **3.29.0** です。

## 概要
このプロジェクトはExecutorパターンを使用したサンプルプロジェクトです。ビジネスロジックとUIの分離を徹底し、テスト容易性と保守性を高めています。

## VScodeの拡張と設定

.vscode/settings.jsonには以下の拡張機能を使う前提で設定が書かれています。
- Code Spell Checker
  - https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
- Better Comments
  - https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments
- Todo Tree
  - https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree

## fvmによるバージョン管理

このプロジェクトにはfvmを使用してFlutterのバージョン管理をしています。

[fvm](https://pub.dev/packages/fvm)

## 使用パッケージ

以下のパッケージを使用しています：
  - riverpodとhooks関連（状態管理）
  - freezedとjson関連（不変オブジェクト）
  - logger（ロギング）
  - gap（UI間隔制御）
  - very_good_analysis（リント）
  - derry（スクリプト実行）
  - go_router（ルーティング）

derryで使うスクリプトも登録済みです。

## analysis_options.yaml

リントはvery_good_analysisをもとに各種設定しています。

## .gitignore

自動生成関連の差分は除外しているので、都度生成が必要です。
derryコマンドを使用して運用してください。

## アーキテクチャ

Riverpodベースのクリーンアーキテクチャを採用し、Executorパターンを組み合わせています。

主要なディレクトリ構造は以下のとおりです：

```
lib/
├── application/         # アプリケーションサービス
│   └── services/        # 各種サービス実装
│
├── core/                # コアモジュール
│   ├── constants/       # 定数定義
│   ├── log/             # ロガー
│   └── router/          # ルーティング設定
│
├── data/                # データ層
│   ├── repositories/    # リポジトリ実装
│   └── sources/         # データソース
│
├── domain/              # ドメイン層
│   ├── entities/        # エンティティ
│   └── models/          # モデル
│
├── main/                # アプリケーションのエントリポイント
│   ├── app_startup/     # 起動時処理
│   ├── main_app/        # メインアプリ
│   └── main.dart        # エントリポイント
│
├── presentation/        # プレゼンテーション層
│   ├── screens/         # 画面
│   ├── shared/          # 共有コンポーネント
│   └── theme/           # テーマ設定
│
└── use_case/            # ユースケース層
　   └── executors/       # エグゼキューター実装
```


## Executorの基本的な役割
ExecutorはUI層とデータ層の橋渡しを担います。UIから実行を命じられると、受け取った入力パラメータをもとにデータ層の処理（リポジトリやサービス）を呼び出し、結果や状態の更新を行います。

### ActionControllerによる実行とエラーハンドリング
presentation層では、Executorの実行とエラーハンドリングをActionControllerが担当します。ActionControllerは以下の役割を持ちます：
- 実行命令の受け取り（UIイベントと紐付け）
- Executor実行後の結果・エラー情報の画面へ伝達

### ActionControllerの定義パターン
ActionControllerは利用範囲によって定義方法や配置場所が異なります：
- 複数画面で再利用する共通Controller：
  - presentation/shared/controllers配下に配置し、複数のScreenでimportして使用
  - 発生する可能性があるExceptionを定義する
  - 各Exceptionのハンドリングは呼び出す画面、Widget側で定義する
- 特定画面専用のController：
  - 該当画面のscreens配下に配置
  - 発生するExceptionとそのハンドリングを定義する

これらを意識してControllerを定義することで、画面ごとの責務を明確にしつつ、共通処理は再利用可能になります。

### サンプルコード

```dart
// -----------------------------
// 1) Executor実装例
// -----------------------------
@riverpod
class ScheduleTodoNotificationExecutor extends _$ScheduleTodoNotificationExecutor {
  @override
  FutureOr<void> build() {}

  // 基本的に実行するメソッドは一つだけのため、メソッド名は`call`で定義する
  Future<void> call({required String todoId}) async {
    // `AsyncValue.guard`でメソッドをラップして、エラーをリッスンできるようにする
    state = await AsyncValue.guard(() async {
      await ref
        .read(notificationServiceProvider)
        .scheduleTodoNotification(todoId: todoId);
    });
  }
}
```

```dart
// -----------------------------
// 2) ActionController 定義例/ 複数画面の場合
// -----------------------------
CreateUserController useCreateUserController(
  WidgetRef ref, {
  required void Function(BuildContext context) onDuplicateUserNameException,
  required void Function(BuildContext context) onServerErrorException,
  required void Function(BuildContext context) onDefaultHandler,
  String? callerPath,
}) {
  // エラー監視対象であるExecutor
  final provider = createUserExecutorProvider;
  // 実行役
  final createUser = ref.read(provider.notifier);
  // 多重実行を防ぐために処理が終わるまでキャッシュする
  final cache = AsyncCache<bool>.ephemeral();

  // 処理の実行
  Future<bool> action(User user) async {
    return cache.fetch(() async {
      await createUser(user);
      if (ref.read(provider).hasError) return false;
      return true;
    });
  }

  // exceptionが流れてきた場合にここでキャッチしてハンドリングする
  // `callerPath`を渡せば、GoRouterで設定したパスによって
  // 呼び出しもとで反応するかどうかを判定できる
  useActionExceptionHandler(
    provider,
    ref,
    callerPath: callerPath,
    onException: (exception, context) {
      // 複数画面で呼ばれる場合はハンドリングを呼び出しもとで行う
      switch (exception) {
        case DuplicateUserNameException():
          onDuplicateUserNameException(context);
        case ServerErrorException():
          onServerErrorException(context);
        default:
          onDefaultHandler(context);
      }
    },
  );

  return (action: action);
}
```

```dart
// -----------------------------
// 3) ActionController 利用例
// -----------------------------
Widget build(BuildContext context, WidgetRef ref) {
  final controller = useCreateUserController(
    ref,
    ScreenRoute.path,
    // ハンドリングをそれぞれ定義する
    onDuplicateUserNameException: (ctx) => showDialog(...),
    onServerErrorException: (ctx) => showSnackBar(...),
    onDefaultHandler: (ctx) => showAlert(...),
  );

  return ElevatedButton(
    onPressed: () async {
      final user = User(...);
      final success = await controller.action(user);
      if (success) {
        // 成功時処理
      }
    },
    child: Text('ユーザー作成'),
  );
}
```
