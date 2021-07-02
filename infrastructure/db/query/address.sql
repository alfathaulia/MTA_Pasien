-- name: GetUserAddress :one
SELECT *
FROM user_address
WHERE id = $1
LIMIT 1;
-- name: ListUserAddress :many
SELECT *
FROM user_address
ORDER BY created_at
LIMIT $1 OFFSET $2;
-- name: DeleteUserAddress :exec
DELETE FROM user_address
WHERE id = $1;
-- name: UpdateUserAddress :one
UPDATE user_address
SET id = $1,
  desa = $2,
  dusun = $3,
  kecamatan = $4,
  kabupaten = $5,
  alamat = $6,
  latitude = $7,
  longitude = $8,
  updated_at = $9
WHERE id = $1
RETURNING *;
-- name: CreateUserAddress :one
INSERT INTO user_address (
    id,
    user_id,
    desa,
    dusun,
    kecamatan,
    kabupaten,
    alamat,
    latitude,
    longitude,
    created_at
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
RETURNING *;