CREATE TABLE "user" (
  "id" uuid PRIMARY KEY,
  "username" varchar UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "hashed_password" varchar NOT NULL,
  "role" varchar NOT NULL DEFAULT 'user',
  "is_verified" boolean DEFAULT 'false',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz DEFAULT '1901-01-01 00:00:00Z',
  "verified_at" timestamptz DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "user_account" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "first_name" varchar NOT NULL DEFAULT '',
  "last_name" varchar NOT NULL DEFAULT '',
  "photo_profile" varchar NOT NULL DEFAULT '',
  "tempat_lahir" varchar NOT NULL DEFAULT '1901-01-01 00:00:00Z',
  "latitude" float NOT NULL DEFAULT (-7.472638),
  "longitude" float NOT NULL DEFAULT (112.434084),
  "tgl_lahir" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "user_address" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "desa" varchar NOT NULL DEFAULT '',
  "dusun" varchar NOT NULL DEFAULT '',
  "kecamatan" varchar NOT NULL DEFAULT '',
  "kabupaten" varchar NOT NULL DEFAULT '',
  "alamat" varchar NOT NULL DEFAULT '',
  "latitude" float NOT NULL DEFAULT (-7.472638),
  "longitude" float NOT NULL DEFAULT (112.434084),
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "user_complaint" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "complaint" varchar NOT NULL DEFAULT '',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "health_agency" (
  "code" NUMERIC PRIMARY KEY,
  "name" varchar NOT NULL DEFAULT '',
  "admin_id" uuid,
  "photo_profile" varchar NOT NULL DEFAULT '',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "health_agency_address" (
  "id" uuid PRIMARY KEY,
  "ha_id" NUMERIC NOT NULL,
  "alamat" varchar NOT NULL,
  "latitude" float NOT NULL,
  "longitude" float NOT NULL,
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "check_up" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "complaint" varchar NOT NULL DEFAULT '',
  "symptoms_start" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z',
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "patient_queue" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "no_queue" numeric NOT NULL DEFAULT 0,
  "start_queue" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z',
  "end_queue" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
CREATE TABLE "patient_result" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "description" varchar NOT NULL DEFAULT '',
  "created_at" timestamptz DEFAULT 'now()',
  "updated_at" timestamptz NOT NULL DEFAULT '1901-01-01 00:00:00Z'
);
-- CREATE TABLE "image_file" (
--   "id" uuid PRIMARY KEY,
--   "filename" varchar NOT NULL DEFAULT '',
--   "size" bigint NOT NULL DEFAULT 0,
--   "ext" varchar NOT NULL DEFAULT '',
--   "created_at" timestamptz NOT NULL DEFAULT 'now()'
-- );
-- CREATE TABLE "profile_image" (
--   "id" uuid PRIMARY KEY,
--   "image_id" uuid NOT NULL,
--   "created_at" timestamptz NOT NULL DEFAULT 'now()'
-- );
ALTER TABLE "user_account"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_address"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_complaint"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "health_agency"
ADD FOREIGN KEY ("admin_id") REFERENCES "user" ("id");
ALTER TABLE "health_agency_address"
ADD FOREIGN KEY ("ha_id") REFERENCES "health_agency" ("code");
ALTER TABLE "check_up"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "patient_queue"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "patient_result"
ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
-- ALTER TABLE "image_file"
-- ADD FOREIGN KEY ("id") REFERENCES "profile_image" ("image_id");