# TODOリストアプリケーション仕様書

## 1. システム概要

シンプルなTodoアプリ。ユーザーはGoogleアカウントでログインし、タスクの作成・管理が行えます。

## 2. 技術スタック

### フロントエンド

- Next.js (TypeScript)

### バックエンド

- Go
- net/http
- sqlc (SQLクエリジェネレーター)
- ogen

### データベース

- PostgreSQL

### デプロイ

- Docker
- Docker Compose

### 認証

- Google OAuth 2.0
