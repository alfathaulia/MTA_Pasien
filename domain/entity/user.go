package entity

import (
	"github.com/google/uuid"
)

type User struct {
	ID         uuid.UUID
	Username   string
	Email      string
	Password   string
	created_at string
	updated_at string
}

type UserAccount struct {
	ID           uuid.UUID
	FirstName    string
	LastName     string
	PhotoProfile string
	PlaceOfBirth string
	latitude     float32
	longitude    float32
	DateOfBirth  string
	created_at   string
	updated_at   string
}

type UserAddress struct {
	id         uuid.UUID
	desa       string
	dusun      string
	kecamatan  string
	kabupaten  string
	alamat     string
	latitude   float32
	longitude  float32
	created_at string
	updated_at string
}
