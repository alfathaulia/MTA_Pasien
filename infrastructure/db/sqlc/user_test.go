package infrastructure

import (
	"context"
	"database/sql"
	"testing"

	"github.com/alfathaulia/MTA_Pasien.git/utils"
	"github.com/google/uuid"
	"github.com/stretchr/testify/require"
)

func createRandomUser(t *testing.T) User {
	password := utils.RandomString(6)
	hashedPassword, err := utils.HashPassword(password)
	require.NoError(t, err)

	arg := CreateUserParams{
		ID:             uuid.New(),
		Username:       utils.RandomString(6),
		HashedPassword: hashedPassword,
		Password:       password,
		Email:          utils.RandomEmail(),
		Role:           "user",
	}

	user, err := testQueries.CreateUser(context.Background(), arg)

	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.NotEmpty(t, user.Email)
	require.NotEmpty(t, user.Password)
	require.NotEmpty(t, arg.HashedPassword)
	require.NotEmpty(t, user.Username)

	return user
}

func TestCreateUser(t *testing.T) {
	createRandomUser(t)
}

func TestGetUser(t *testing.T) {
	user1 := createRandomUser(t)
	testuser, err := testQueries.GetUser(context.Background(), user1.ID)
	require.NoError(t, err)
	require.Equal(t, testuser.ID, user1.ID)
	require.Equal(t, testuser.Email, user1.Email)
	require.Equal(t, testuser.Username, user1.Username)
	require.Equal(t, testuser.Password, user1.Password)
	require.Equal(t, testuser.HashedPassword, user1.HashedPassword)
	require.Equal(t, testuser.Role, user1.Role)
	require.Equal(t, testuser.CreatedAt, user1.CreatedAt)
}

func TestUpdateUser(t *testing.T) {
	user1 := createRandomUser(t)
	arg := UpdateUserParams{
		ID:         user1.ID,
		Username:   utils.RandomString(6),
		Email:      utils.RandomEmail(),
		Role:       user1.Role,
		IsVerified: user1.IsVerified,
	}
	user2, err := testQueries.UpdateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user2)
	require.NotEqual(t, user1.Username, user2.Username)
	require.NotEqual(t, user1.Email, user2.Email)
	require.Equal(t, user1.Role, user2.Role)
	require.Equal(t, user1.IsVerified, user2.IsVerified)
	// require.WithinDuration(t, user1.CreatedAt, user2.CreatedAt, time.Second)
}

func TestDeleteuser(t *testing.T) {
	user1 := createRandomUser(t)
	err := testQueries.DeleteUser(context.Background(), user1.ID)
	require.NoError(t, err)
	user2, err := testQueries.GetUser(context.Background(), user1.ID)
	require.Error(t, err)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, user2)
}
