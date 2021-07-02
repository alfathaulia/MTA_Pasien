package infrastructure

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"github.com/alfathaulia/MTA_Pasien.git/utils"
	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

// Test fungsi koneksi ke database
func TestMain(m *testing.M) {
	config, err := utils.LoadConfig("../../..")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	testDB, err = sql.Open(config.DBDriver, config.DB_SOURCE)
	if err != nil {
		log.Fatal("Cannot connect to database: ", err)

	}
	testQueries = New(testDB)
	os.Exit(m.Run())
}
