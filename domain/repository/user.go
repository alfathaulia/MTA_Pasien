package repository

import (
	"github.com/alfathaulia/MTA_Pasien.git/domain/entity"
	"github.com/google/uuid"
)

type UserRepository interface {
	GetUser(uuid.UUID) (*entity.User, error)
	GetUserAccount(uuid.UUID) (*entity.UserAccount, error)
	GetUserAddress(uuid.UUID) (*entity.UserAddress, error)
	GetListUser() ([]entity.User, error)
	GetListUserAccount() ([]entity.UserAccount, error)
	GetListUserAddress() ([]entity.UserAddress, error)
	Register(*entity.User) (*entity.User, map[string]string)
	Login(*entity.User) (*entity.User, map[string]string)
	UpdateUser(uuid.UUID, *entity.User) (*entity.User, map[string]string)
	DeleteUser(uuid.UUID) error
}
