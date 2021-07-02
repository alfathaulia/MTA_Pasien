CREATE TABLE "user" (
  "id" uuid PRIMARY KEY,
  "username" varchar UNIQUE,
  "email" varchar UNIQUE,
  "password" varchar,
  "hashed_password" varchar,
  "role" varchar,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "user_account" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "firstName" varchar,
  "lastName" varchar,
  "photo_profile" varchar,
  "tempat_lahir" varchar,
  "latitude" numeric,
  "longitude" numeric,
  "tgl_lahir" timestamptz,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "user_address" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "desa" varchar,
  "dusun" varchar,
  "kecamatan" varchar,
  "kabupaten" varchar,
  "alamat" varchar,
  "latitude" numeric,
  "longitude" numeric,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "health_agency" (
  "code" NUMERIC PRIMARY KEY,
  "name" varchar,
  "admin_id" uuid,
  "photo_profile" varchar,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "health_agency_address" (
  "id" uuid PRIMARY KEY,
  "ha_id" NUMERIC,
  "alamat" varchar,
  "latitude" numeric,
  "longitude" numeric,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "check_up" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "complaint" varchar,
  "symptoms_start" timestamptz,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "patient_queue" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "no_queue" numeric,
  "start_queue" timestamptz,
  "end_queue" timestamptz,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
CREATE TABLE "patient_result" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "description" varchar,
  "created_at" timestamptz,
  "updated_at" timestamptz
);
ALTER TABLE "user_account"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_address"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "health_agency"
ADD FOREIGN KEY ("admin_id") REFERENCES "user" ("id");