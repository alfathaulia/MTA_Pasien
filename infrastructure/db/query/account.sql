-- name: GetUserAccount :one
SELECT *
FROM user_account
WHERE username = $1
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
SET username = $1,
  no_ktp = $2,
  nama_ktp = $3,
  alamat = $4,
  kecamatan = $5,
  kodepos = $6,
  kelurahan = $7,
  updated_at = $8
WHERE username = $1
RETURNING *;
-- name: CreateUserAccount :one
INSERT INTO user_account (
    username,
    no_ktp,
    nama_ktp,
    alamat,
    kecamatan,
    kodepos,
    kelurahan,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;
-- name: CreateUserAccountNoReturn :exec
INSERT INTO user_account (username, no_ktp, created_at)
VALUES ($1, $2, $3);