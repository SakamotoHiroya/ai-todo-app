# TODOリストアプリケーション仕様書

## 1. システム概要

シンプルで使いやすいTODOリスト管理アプリケーション。ユーザーはGoogleアカウントでログインし、タスクの作成・管理が行えます。

## 2. 技術スタック

### フロントエンド

- Next.js (TypeScript)
- TailwindCSS
- React Query

### バックエンド

- Go
- Echo (Webフレームワーク)
- sqlc (SQLクエリジェネレーター)

### データベース

- PostgreSQL

### 認証

- Google OAuth 2.0

## 3. 機能要件

### 3.1 認証機能

- Googleアカウントを使用したログイン/ログアウト
- セッション管理
- 認証状態の永続化

### 3.2 タスク管理機能

- タスクの作成
  - タイトル（必須）
  - 説明（任意）
  - 期限（任意）
  - 優先度（高/中/低）
- タスクの表示
  - リスト表示
  - フィルタリング（完了/未完了、優先度）
  - ソート（作成日、期限日、優先度）
- タスクの編集
- タスクの削除
- タスクの完了/未完了の切り替え

## 4. API仕様

### 4.1 認証関連

- `GET /api/auth/google`: Google認証開始
- `GET /api/auth/google/callback`: Google認証コールバック
- `POST /api/auth/logout`: ログアウト

### 4.2 タスク関連

- `GET /api/tasks`: タスク一覧取得
- `POST /api/tasks`: タスク作成
- `PUT /api/tasks/:id`: タスク更新
- `DELETE /api/tasks/:id`: タスク削除
- `PATCH /api/tasks/:id/toggle`: タスク完了状態切り替え

## 5. データベース設計

### Users テーブル

- id: シリアル主キー
- google_id: Google認証ID（一意）
- email: メールアドレス（一意）
- name: ユーザー名
- created_at: 作成日時
- updated_at: 更新日時

### Tasks テーブル

- id: シリアル主キー
- user_id: ユーザーID（外部キー）
- title: タスクタイトル
- description: タスク説明
- due_date: 期限日
- priority: 優先度（1: 低, 2: 中, 3: 高）
- is_completed: 完了フラグ
- created_at: 作成日時
- updated_at: 更新日時

## 6. セキュリティ要件

- すべてのAPIエンドポイントは認証必須
- HTTPS通信の強制
- CSRFトークンの実装
- SQLインジェクション対策
- XSS対策

## 7. 非機能要件

### パフォーマンス

- ページ初期表示時間: 2秒以内
- API応答時間: 1秒以内

### スケーラビリティ

- 同時接続ユーザー数: 1000人以上
- データ容量: ユーザーあたり最大1000タスク

### 可用性

- サービス稼働率: 99.9%
- バックアップ: 日次

## 8. 開発環境・ツール

- バージョン管理: Git
- CI/CD: GitHub Actions
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

## 9. プロジェクト構成

```plaintext
.
├── api/                   # API仕様書
│   └── openapi.yaml      # OpenAPI仕様
│
├── frontend/             # フロントエンドのソースコード
│   ├── src/             # Next.jsのソースコード
│   │   ├── app/        # アプリケーションのルート
│   │   ├── components/ # 共通コンポーネント
│   │   ├── hooks/     # カスタムフック
│   │   ├── types/     # 型定義
│   │   └── utils/     # ユーティリティ関数
│   ├── public/         # 静的ファイル
│   └── Dockerfile      # フロントエンドのDockerfile
│
├── backend/            # バックエンドのソースコード
│   ├── cmd/           # エントリーポイント
│   │   └── api/      # APIサーバー
│   ├── internal/      # 内部パッケージ
│   │   ├── handler/  # HTTPハンドラー
│   │   ├── service/  # ビジネスロジック
│   │   ├── repository/ # データアクセス層
│   │   └── middleware/ # ミドルウェア
│   ├── db/           # データベース関連
│   │   ├── migrations/ # マイグレーションファイル
│   │   ├── queries/   # SQLクエリ
│   │   └── sqlc/     # 生成されたコード
│   └── Dockerfile    # バックエンドのDockerfile
│
├── docker-compose.yml     # 本番環境用Docker Compose
└── docker-compose.dev.yml # 開発環境用Docker Compose
```
