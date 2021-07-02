-- name: GetUserAccount :one
SELECT *
FROM user_account
WHERE id = $1
LIMIT 1;
-- name: ListUserAccount :many
SELECT *
FROM user_account
ORDER BY created_at
LIMIT $1 OFFSET $2;
-- name: DeleteUserAccount :exec
DELETE FROM user_account
WHERE id = $1;
-- name: UpdateUserAccount :one
UPDATE user_account
SET id = $1,
  first_name = $2,
  last_name = $3,
  photo_profile = $4,
  tempat_lahir = $5,
  latitude = $6,
  longitude = $7,
  tgl_lahir = $8,
  updated_at = $9
WHERE id = $1
RETURNING *;
-- name: CreateUserAccount :one
INSERT INTO user_account (
    id,
    user_id,
    first_name,
    last_name,
    photo_profile,
    tempat_lahir,
    latitude,
    longitude,
    tgl_lahir,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
RETURNING *;