# データベース設計

## Users テーブル

- id: シリアル主キー
- google_id: Google認証ID（一意）
- name: ユーザー名
- created_at: 作成日時
- updated_at: 更新日時

## Tasks テーブル

- id: シリアル主キー
- user_id: ユーザーID（外部キー）
- title: タスクタイトル
- description: タスク説明
- due_date: 期限日
- priority: 優先度（1: 低, 2: 中, 3: 高）
- is_completed: 完了フラグ
- created_at: 作成日時
- updated_at: 更新日時
