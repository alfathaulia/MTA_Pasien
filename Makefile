postgres:
	docker run --name postgres13 -p 4577:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=secret -d postgres:13-alpine

mysql:
	docker run --name mysql8 -p 3306:3306  -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

createdb:
	docker exec -it postgres13 createdb --username=postgres --owner=postgres mta_patient

dropdb:
	docker exec -it postgres13  dropdb mta_patient --username=postgres 

migrate:
	migrate create -ext sql -dir infrastructure/db/migration -seq init_schema


migrateup:
	migrate -path infrastructure/db/migration -database "postgresql://postgres:secret@localhost:4577/mta_patient?sslmode=disable" -verbose up

migrateup1:
	migrate -path infrastructure/db/migration -database "postgresql://postgres:secret@localhost:4577/mta_patient?sslmode=disable" -verbose up 1

migratedown:
	migrate -path infrastructure/db/migration -database "postgresql://postgres:secret@localhost:4577/mta_patient?sslmode=disable" -verbose down

migratedown1:
	migrate -path infrastructure/db/migration -database "postgresql://postgres:secret@localhost:4577/mta_patient?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination infrastructure/db/mock/store.go github.com/alfathaulia/MTA_Pasien/infrastructure/db/sqlc Store

docs:
	swag init --parseDependency --parseInternal --parseDepth 1 -g main.go

.PHONY: postgres createdb createdb dropdb migrate migrateup migrateup1 migratedown migratedown1 sqlc server test mock docs


.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock