package infrastructure

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/alfathaulia/MTA_Pasien.git/utils"
	"github.com/google/uuid"
	"github.com/stretchr/testify/require"
)

func createRandomAccount(t *testing.T) UserAccount {
	user1 := createRandomUser(t)
	require.NotEmpty(t, user1)

	arg := CreateUserAccountParams{
		ID:           uuid.New(),
		UserID:       user1.ID,
		FirstName:    utils.RandomString(6),
		LastName:     utils.RandomString(6),
		PhotoProfile: utils.RandomString(100),
		TempatLahir:  utils.RandomString(10),
		TglLahir:     time.Now(),
		Latitude:     float64(utils.RandomInt(0, 1000)),
		Longitude:    float64(utils.RandomInt(0, 100)),
	}

	account, err := testQueries.CreateUserAccount(context.Background(), arg)
	require.NoError(t, err)

	require.NotEmpty(t, account)
	require.NotEmpty(t, account.FirstName)
	require.NotEmpty(t, account.LastName)
	require.NotEmpty(t, arg.PhotoProfile)
	require.NotEmpty(t, account.TempatLahir)
	require.NotEmpty(t, account.TglLahir)
	require.NotEmpty(t, account.Latitude)
	require.NotEmpty(t, account.Longitude)

	return account
}

func TestCreateAccount(t *testing.T) {
	createRandomAccount(t)
}

func TestGetAccount(t *testing.T) {
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

func TestUpdateAccount(t *testing.T) {
	account1 := createRandomAccount(t)

	arg := UpdateUserAccountParams{
		ID:          account1.ID,
		FirstName:   utils.RandomString(6),
		LastName:    utils.RandomString(6),
		TempatLahir: utils.RandomString(6),
		TglLahir:    time.Now().AddDate(-15, 0, 0),
		Latitude:    float64(utils.RandomInt(0, 1000)),
		Longitude:   float64(utils.RandomInt(0, 1000)),
	}

	account2, err := testQueries.UpdateUserAccount(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, account2)
	require.NotEqual(t, account2.FirstName, account1.FirstName)
	require.NotEqual(t, account2.LastName, account1.LastName)
	require.NotEqual(t, account2.TempatLahir, account1.TempatLahir)
	require.NotEqual(t, account2.TglLahir, account1.TglLahir)
	require.NotEqual(t, account2.PhotoProfile, account1.PhotoProfile)
	require.NotEqual(t, account2.Latitude, account1.Latitude)
	require.NotEqual(t, account2.Longitude, account1.Longitude)

}

func TestDeleteAccount(t *testing.T) {
	account1 := createRandomAccount(t)
	err := testQueries.DeleteUserAccount(context.Background(), account1.ID)
	require.NoError(t, err)
	account2, err := testQueries.GetUserAccount(context.Background(), account1.ID)
	require.Error(t, err)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, account2)
}
