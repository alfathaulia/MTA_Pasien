-- name: Register :one
INSERT INTO "user" (
    id,
    username,
    email,
    password,
    hashed_password,
    role,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING *;
-- name: CreateUser :one
INSERT INTO "user" (
    id,
    username,
    email,
    hashed_password,
    password,
    role,
    is_verified,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;
-- name: Login :one
SELECT username,
  hashed_password,
  email
from "user"
WHERE email = $1;
-- name: GetUser :one
SELECT *
FROM "user"
WHERE id = $1
LIMIT 1;
-- name: DeleteUser :exec
DELETE FROM "user"
WHERE id = $1;
-- name: UpdateUser :one
UPDATE "user"
SET username = $2,
  email = $3,
  is_verified = $4,
  role = $5,
  updated_at = $6
WHERE id = $1
RETURNING *;