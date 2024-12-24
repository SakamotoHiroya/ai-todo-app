# API仕様

## 1. 認証関連

- `GET /api/auth/google`: Google認証開始
- `GET /api/auth/google/callback`: Google認証コールバック
- `POST /api/auth/logout`: ログアウト

## 2. タスク関連

- `GET /api/tasks`: タスク一覧取得
- `POST /api/tasks`: タスク作成
- `PUT /api/tasks/:id`: タスク更新
- `DELETE /api/tasks/:id`: タスク削除
- `PATCH /api/tasks/:id/toggle`: タスク完了状態切り替え
