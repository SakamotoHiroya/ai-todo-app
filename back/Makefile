.PHONY: sqlc migrate-up migrate-down migrate-create ogen generate

# データベース接続情報
DB_USER ?= postgres
DB_PASSWORD ?= postgres
DB_NAME ?= todo_app
DB_HOST ?= localhost
DB_PORT ?= 5432
DB_URL = postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable

# SQLCによるコード生成
sqlc:
	sqlc generate

# マイグレーション実行
migrate-up:
	migrate -path migrations -database "$(DB_URL)" up

migrate-down:
	migrate -path migrations -database "$(DB_URL)" down

# 新しいマイグレーションファイルの作成
migrate-create:
	@if [ -z "$(name)" ]; then \
		echo "Usage: make migrate-create name=<migration_name>"; \
		exit 1; \
	fi
	migrate create -ext sql -dir migrations -seq $(name)

# 開発用DBの作成（PostgreSQLが必要）
dev-db-create:
	createdb $(DB_NAME)

# 開発用DBの削除
dev-db-drop:
	dropdb --if-exists $(DB_NAME)

# 開発用DBのリセット
.PHONY: dev-db-reset
dev-db-reset: dev-db-drop dev-db-create migrate-up

# 依存関係の更新
.PHONY: deps
deps:
	go mod tidy

# ビルド
.PHONY: build
build:
	go build -o bin/api cmd/api/main.go

# テスト
.PHONY: test
test:
	go test -v ./...

# OpenAPIコード生成
ogen:
	ogen -target internal/ogen -clean ../api/openapi.yaml

# 全コード生成
generate: sqlc ogen