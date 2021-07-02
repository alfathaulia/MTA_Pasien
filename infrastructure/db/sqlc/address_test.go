package infrastructure

import (
	"context"
	"database/sql"
	"testing"

	"github.com/alfathaulia/MTA_Pasien.git/utils"
	"github.com/google/uuid"
	"github.com/stretchr/testify/require"
)

func createRandomAddress(t *testing.T) UserAddress {
	user1 := createRandomUser(t)
	require.NotEmpty(t, user1)

	arg := CreateUserAddressParams{
		ID:        uuid.New(),
		UserID:    user1.ID,
		Desa:      utils.RandomString(6),
		Dusun:     utils.RandomString(6),
		Kecamatan: utils.RandomString(10),
		Kabupaten: utils.RandomString(10),
		Alamat:    utils.RandomString(100),
		Latitude:  float64(utils.RandomInt(0, 1000)),
		Longitude: float64(utils.RandomInt(0, 100)),
	}

	account, err := testQueries.CreateUserAddress(context.Background(), arg)
	require.NoError(t, err)

	require.NotEmpty(t, account)
	require.NotEmpty(t, account.Desa)
	require.NotEmpty(t, account.Dusun)
	require.NotEmpty(t, arg.Kecamatan)
	require.NotEmpty(t, account.Kabupaten)
	require.NotEmpty(t, account.Alamat)
	require.NotEmpty(t, account.Latitude)
	require.NotEmpty(t, account.Longitude)

	return account
}

func TestCreateAddress(t *testing.T) {
	createRandomAddress(t)
}

func TestGetAddress(t *testing.T) {
	account1 := createRandomAccount(t)
	account2, err := testQueries.GetUserAccount(context.Background(), account1.ID)
	require.NoError(t, err)
	require.Equal(t, account2.FirstName, account1.FirstName)
	require.Equal(t, account2.LastName, account1.LastName)
	require.Equal(t, account2.Latitude, account1.Latitude)
	require.Equal(t, account2.Longitude, account1.Longitude)
	require.Equal(t, account2.PhotoProfile, account1.PhotoProfile)
	require.Equal(t, account2.TglLahir, account2.TglLahir)
}

func TestUpdateAddress(t *testing.T) {
	account1 := createRandomAddress(t)

	arg := UpdateUserAddressParams{
		ID:        account1.ID,
		Desa:      utils.RandomString(6),
		Dusun:     utils.RandomString(6),
		Kecamatan: utils.RandomString(6),
		Kabupaten: utils.RandomString(6),
		Alamat:    utils.RandomString(100),
		Latitude:  float64(utils.RandomInt(0, 1000)),
		Longitude: float64(utils.RandomInt(0, 1000)),
	}

	account2, err := testQueries.UpdateUserAddress(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, account2)
	require.NotEqual(t, account2.Dusun, account1.Dusun)
	require.NotEqual(t, account2.Desa, account1.Desa)
	require.NotEqual(t, account2.Kecamatan, account1.Kecamatan)
	require.NotEqual(t, account2.Kabupaten, account1.Kabupaten)
	require.NotEqual(t, account2.Alamat, account1.Alamat)
	require.NotEqual(t, account2.Latitude, account1.Latitude)
	require.NotEqual(t, account2.Longitude, account1.Longitude)

}

func TestDeleteAddress(t *testing.T) {
	address1 := createRandomAddress(t)
	err := testQueries.DeleteUserAddress(context.Background(), address1.ID)
	require.NoError(t, err)
	address2, err := testQueries.GetUserAddress(context.Background(), address1.ID)
	require.Error(t, err)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, address2)
}
