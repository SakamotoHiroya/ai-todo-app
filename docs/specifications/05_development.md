# 開発環境・ツール

## 1. 開発ツール

- バージョン管理: Git
- コンテナ化: Docker
  - マルチステージビルド
  - Docker Compose による開発環境構築
- コード品質管理:
  - ESLint (フロントエンド)
  - golangci-lint (バックエンド)
- データベース:
  - sqlc (SQLクエリの型安全な生成)
  - golang-migrate (マイグレーション管理)
- テスト:
  - Jest (フロントエンド)
  - Go testing (バックエンド)

## 2. プロジェクト構成

```plaintext
.
├── api/                    # API仕様書
│   └── openapi.yaml       # OpenAPI仕様
│
├── front/                 # フロントエンドのソースコード
│   ├── src/              # Next.jsのソースコード
│   │   ├── app/         # アプリケーションのルート
│   │   ├── components/  # 共通コンポーネント
│   │   ├── hooks/      # カスタムフック
│   │   ├── types/      # 型定義
│   │   └── utils/      # ユーティリティ関数
│   ├── public/          # 静的ファイル
│   └── Dockerfile       # フロントエンドのDockerfile
│
├── back/                 # バックエンドのソースコード
│   ├── cmd/             # エントリーポイント
│   │   └── api/        # APIサーバー
│   ├── internal/        # 内部パッケージ
│   │   ├── ogen/       # ogen生成コード
│   │   │   ├── api/   # API実装
│   │   │   └── types/ # 生成された型定義
│   │   ├── service/   # ビジネスロジック
│   │   ├── store/     # データアクセス層
│   │   │   ├── db/    # データベース関連
│   │   │   └── sqlc/  # sqlc生成コード
│   │   └── auth/      # 認証関連
│   ├── migrations/     # マイグレーションファイル
│   ├── sqlc.yaml      # sqlc設定
│   └── Dockerfile     # バックエンドのDockerfile
│
├── docker-compose.yml     # 本番環境用Docker Compose
└── docker-compose.dev.yml # 開発環境用Docker Compose
```
