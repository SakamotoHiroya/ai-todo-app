-- name: CreateUser :one
INSERT INTO users (
    google_id,
    name
) VALUES (
    $1, $2
)
RETURNING *;

-- name: GetUserByGoogleID :one
SELECT * FROM users
WHERE google_id = $1;

-- name: UpdateUser :one
UPDATE users
SET
    name = COALESCE(sqlc.narg('name'), name),
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *; 