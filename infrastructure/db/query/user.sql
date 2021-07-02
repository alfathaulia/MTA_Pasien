-- name: Register :one
INSERT INTO user (
    username,
    password hashed_password,
    role
  )
VALUES ($1, $2, $3, $4)
RETURNING *;
-- name: Login :one
SELECT username,
  hashed_password,
  role,
  is_verified
from user
WHERE username = $1;
-- name: GetUser :one
SELECT *
FROM user
WHERE id = $1
LIMIT 1;
-- name: ListUsers :many
SELECT *
FROM user
WHERE role = 'user'
ORDER BY created_at ASC;
-- name: ListUsersWithRole :many
SELECT *
FROM user
WHERE role = $1
ORDER BY created_at ASC;
-- LIMIT $1 OFFSET $2;
-- name: SearchUser :one
SELECT *
FROM user
WHERE username = $1
  and role = 'user';
-- name: ListUsersSearch :one
SELECT *
FROM user
WHERE role = 'user'
  AND username = $2;
-- name: ListUsersSMeter :many
SELECT *
FROM user
WHERE role = $3
ORDER BY username
LIMIT $1 OFFSET $2;
-- name: ListUsersSUsername :many
SELECT *
FROM user
WHERE role = $3
  AND username = $4
ORDER BY username
LIMIT $1 OFFSET $2;
-- name: DeleteUser :exec
DELETE FROM user
WHERE username = $1;
-- name: UpdateUser :one
UPDATE user
SET hashed_password = $2,
  full_name = $4,
  alamat = $5,
  is_verified = $6,
  role = $7,
  password_changed_at = $8,
  updated_at = $9,
  last_login = $10
WHERE username = $1
RETURNING *;
-- name: CreateUser :one
INSERT INTO user (
    username,
    hashed_password,
    password,
    email,
    role
  )
VALUES ($1, $2, $3, $4, $5)
RETURNING *;
-- name: CreateUserNoReturn :exec
INSERT INTO user (
    username,
    password,
    hashed_password,
    is_verified,
    role,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;
-- name: TotalUsers :one
SELECT count(*)
FROM user
WHERE role = 'user';