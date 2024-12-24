-- name: CreateTask :one
INSERT INTO tasks (
    user_id,
    title,
    description,
    due_date,
    priority
) VALUES (
    $1, $2, $3, $4, $5
)
RETURNING *;

-- name: GetTask :one
SELECT * FROM tasks
WHERE id = $1 AND user_id = $2;

-- name: ListTasks :many
SELECT * FROM tasks
WHERE user_id = $1
    AND (CASE WHEN @completed::boolean IS NOT NULL 
         THEN is_completed = @completed 
         ELSE true END)
    AND (CASE WHEN @priority::smallint IS NOT NULL 
         THEN priority = @priority 
         ELSE true END)
ORDER BY
    CASE WHEN @sort::text = 'due_date' THEN due_date END ASC,
    CASE WHEN @sort::text = 'priority' THEN priority END DESC,
    CASE WHEN @sort::text = 'created_at' OR @sort::text IS NULL THEN created_at END DESC
LIMIT $2
OFFSET $3;

-- name: UpdateTask :one
UPDATE tasks
SET
    title = COALESCE(sqlc.narg('title'), title),
    description = COALESCE(sqlc.narg('description'), description),
    due_date = COALESCE(sqlc.narg('due_date'), due_date),
    priority = COALESCE(sqlc.narg('priority'), priority),
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id AND user_id = @user_id
RETURNING *;

-- name: DeleteTask :exec
DELETE FROM tasks
WHERE id = $1 AND user_id = $2;

-- name: ToggleTaskCompletion :one
UPDATE tasks
SET
    is_completed = NOT is_completed,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1 AND user_id = $2
RETURNING *; 