# executor_sample

<img src="thumbnail/base_sample_thumbnail.png" width="300">

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
  - utility_widgets（UI部品）

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

## Executorパターンについて

このプロジェクトでは、ユースケースの実装にExecutorパターンを採用しています。
Executorは以下の特徴を持ちます：

- ビジネスロジックをUIから分離
- 結果と状態管理の一元化
- エラーハンドリングの標準化
- テスト容易性の向上

各Executorは以下の要素で構成されています：
- 入力パラメータ
- 処理状態
- 出力結果
- エラー情報
