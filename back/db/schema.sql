-- Users テーブル: ユーザー情報を管理
CREATE TABLE users (
    id         BIGSERIAL PRIMARY KEY,
    google_id  VARCHAR(255) NOT NULL UNIQUE,
    name       VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tasks テーブル: TODOタスク情報を管理
CREATE TABLE tasks (
    id           BIGSERIAL PRIMARY KEY,
    user_id      BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title        VARCHAR(255) NOT NULL,
    description  TEXT,
    due_date     TIMESTAMP WITH TIME ZONE,
    priority     SMALLINT NOT NULL CHECK (priority IN (1, 2, 3)), -- 1: 低, 2: 中, 3: 高
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- インデックス
CREATE INDEX tasks_user_id_idx ON tasks(user_id);
CREATE INDEX tasks_due_date_idx ON tasks(due_date);
CREATE INDEX tasks_created_at_idx ON tasks(created_at); 