-- FARM --

CREATE TABLE IF NOT EXISTS "FARM_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "FARM_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" JSON
);

CREATE INDEX IF NOT EXISTS "FARM_EVENT_FARM_UID_INDEX" ON "FARM_EVENT" ("FARM_UID");

CREATE TABLE IF NOT EXISTS "FARM_READ" (
    "UID" BLOB PRIMARY KEY,
    "NAME" TEXT,
    "LATITUDE" TEXT,
    "LONGITUDE" TEXT,
    "TYPE" TEXT,
    "COUNTRY_CODE" TEXT,
    "CITY_CODE" TEXT,
    "IS_ACTIVE" INTEGER,
    "CREATED_DATE" TEXT
);

CREATE UNIQUE INDEX IF NOT EXISTS "FARM_READ_UID_UNIQUE_INDEX" ON "FARM_READ" ("UID");

-- AREA --

CREATE TABLE IF NOT EXISTS "AREA_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "AREA_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" JSON
);

CREATE INDEX IF NOT EXISTS "FARM_EVENT_AREA_UID_INDEX" ON "AREA_EVENT" ("AREA_UID");

CREATE TABLE IF NOT EXISTS "AREA_READ" (
    "UID" BLOB PRIMARY KEY,
    "NAME" TEXT,
    "SIZE_UNIT" TEXT,
    "SIZE" REAL,
    "TYPE" TEXT,
    "LOCATION" TEXT,
    "PHOTO_FILENAME" TEXT,
    "PHOTO_MIMETYPE" TEXT,
    "PHOTO_SIZE" INTEGER,
    "PHOTO_WIDTH" INTEGER,
    "PHOTO_HEIGHT" INTEGER,
    "CREATED_DATE" TEXT,
    "RESERVOIR_UID" BLOB,
    "RESERVOIR_NAME" TEXT,
    "FARM_UID" BLOB,
    "FARM_NAME" TEXT
);

CREATE UNIQUE INDEX IF NOT EXISTS "AREA_READ_UID_UNIQUE_INDEX" ON "AREA_READ" ("UID");
CREATE INDEX IF NOT EXISTS "AREA_READ_RESERVOIR_UID_INDEX" ON "AREA_READ" ("RESERVOIR_UID");
CREATE INDEX IF NOT EXISTS "AREA_READ_FARM_UID_INDEX" ON "AREA_READ" ("FARM_UID");

CREATE TABLE IF NOT EXISTS "AREA_READ_NOTES" (
    "UID" BLOB PRIMARY KEY,
    "AREA_UID" BLOB,
    "CONTENT" TEXT,
    "CREATED_DATE" TEXT,
    FOREIGN KEY("AREA_UID") REFERENCES "AREA_READ"("UID")
);

CREATE UNIQUE INDEX IF NOT EXISTS "AREA_READ_NOTES_UID_UNIQUE_INDEX" ON "AREA_READ_NOTES" ("UID");
CREATE INDEX IF NOT EXISTS "AREA_READ_NOTES_AREA_UID_INDEX" ON "AREA_READ_NOTES" ("AREA_UID");

-- RESERVOIR --

CREATE TABLE IF NOT EXISTS "RESERVOIR_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "RESERVOIR_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" BLOB
);

CREATE INDEX IF NOT EXISTS "RESERVOIR_EVENT_RESERVOIR_UID_INDEX" ON "RESERVOIR_EVENT" ("RESERVOIR_UID");

CREATE TABLE IF NOT EXISTS "RESERVOIR_READ" (
    "UID" BLOB PRIMARY KEY,
    "NAME" TEXT,
    "WATERSOURCE_TYPE" TEXT,
    "WATERSOURCE_CAPACITY" REAL,
    "FARM_UID" BLOB,
    "FARM_NAME" TEXT,
    "CREATED_DATE" TEXT
);

CREATE INDEX IF NOT EXISTS "RESERVOIR_READ_UID_UNIQUE_INDEX" ON "RESERVOIR_READ" ("UID");

CREATE TABLE IF NOT EXISTS "RESERVOIR_READ_NOTES" (
    "UID" BLOB PRIMARY KEY,
    "RESERVOIR_UID" BLOB,
    "CONTENT" TEXT,
    "CREATED_DATE" TEXT,
    FOREIGN KEY("RESERVOIR_UID") REFERENCES "RESERVOIR_READ"("UID")
);

CREATE UNIQUE INDEX IF NOT EXISTS "RESERVOIR_READ_NOTES_UID_UNIQUE_INDEX" ON "RESERVOIR_READ_NOTES" ("UID");
CREATE INDEX IF NOT EXISTS "RESERVOIR_READ_NOTES_RESERVOIR_UID_INDEX" ON "RESERVOIR_READ_NOTES" ("RESERVOIR_UID");

-- MATERIAL --

CREATE TABLE IF NOT EXISTS "MATERIAL_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "MATERIAL_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" BLOB
);

CREATE INDEX IF NOT EXISTS "MATERIAL_EVENT_MATERIAL_UID_INDEX" ON "MATERIAL_EVENT" ("MATERIAL_UID");

CREATE TABLE IF NOT EXISTS "MATERIAL_READ" (
    "UID" BLOB PRIMARY KEY,
    "NAME" TEXT,
    "PRICE_PER_UNIT" TEXT,
    "CURRENCY_CODE" TEXT,
    "TYPE" TEXT,
    "TYPE_DATA" TEXT,
    "QUANTITY" REAL,
    "QUANTITY_UNIT" TEXT,
    "EXPIRATION_DATE" TEXT,
    "NOTES" TEXT,
    "PRODUCED_BY" TEXT,
    "CREATED_DATE" TEXT
);

CREATE INDEX IF NOT EXISTS "MATERIAL_READ_UID_UNIQUE_INDEX" ON "MATERIAL_READ" ("UID");

-- CROP --

CREATE TABLE IF NOT EXISTS "CROP_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "CROP_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" BLOB
);

CREATE INDEX IF NOT EXISTS "CROP_EVENT_CROP_UID_INDEX" ON "CROP_EVENT" ("CROP_UID");

CREATE TABLE IF NOT EXISTS "CROP_READ" (
    "UID" BLOB PRIMARY KEY,
    "BATCH_ID" TEXT,
    "STATUS" TEXT,
    "TYPE" TEXT,
    "CONTAINER_QUANTITY" INTEGER,
    "CONTAINER_TYPE" TEXT,
    "CONTAINER_CELL" INTEGER,
    "INVENTORY_UID" BLOB,
    "INVENTORY_TYPE" TEXT,
    "INVENTORY_PLANT_TYPE" TEXT,
    "INVENTORY_NAME" TEXT,
    "AREA_STATUS_SEEDING" INTEGER,
    "AREA_STATUS_GROWING" INTEGER,
    "AREA_STATUS_DUMPED" INTEGER,
    "FARM_UID" BLOB,
    "INITIAL_AREA_UID" BLOB,
    "INITIAL_AREA_NAME" TEXT,
    "INITIAL_AREA_INITIAL_QUANTITY" INTEGER,
    "INITIAL_AREA_CURRENT_QUANTITY" INTEGER,
    "INITIAL_AREA_LAST_WATERED" TEXT,
    "INITIAL_AREA_LAST_FERTILIZED" TEXT,
    "INITIAL_AREA_LAST_PESTICIDED" TEXT,
    "INITIAL_AREA_LAST_PRUNED" TEXT,
    "INITIAL_AREA_CREATED_DATE" TEXT,
    "INITIAL_AREA_LAST_UPDATED" TEXT
);

CREATE TABLE IF NOT EXISTS "CROP_READ_PHOTO" (
    "UID" BLOB PRIMARY KEY,
    "CROP_UID" BLOB,
    "FILENAME" TEXT,
    "MIMETYPE" TEXT,
    "SIZE" INTEGER,
    "WIDTH" INTEGER,
    "HEIGHT" INTEGER,
    "DESCRIPTION" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

CREATE TABLE IF NOT EXISTS "CROP_READ_MOVED_AREA" (
    "ID" INTEGER PRIMARY KEY,
    "CROP_UID" BLOB,
    "AREA_UID" BLOB,
    "NAME" TEXT,
    "INITIAL_QUANTITY" INTEGER,
    "CURRENT_QUANTITY" INTEGER,
    "LAST_WATERED" TEXT,
    "LAST_FERTILIZED" TEXT,
    "LAST_PESTICIDED" TEXT,
    "LAST_PRUNED" TEXT,
    "CREATED_DATE" TEXT,
    "LAST_UPDATED" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

CREATE TABLE IF NOT EXISTS "CROP_READ_HARVESTED_STORAGE" (
    "ID" INTEGER PRIMARY KEY,
    "CROP_UID" BLOB,
    "QUANTITY" INTEGER,
    "PRODUCED_GRAM_QUANTITY" REAL,
    "SOURCE_AREA_UID" BLOB,
    "SOURCE_AREA_NAME" TEXT,
    "CREATED_DATE" TEXT,
    "LAST_UPDATED" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

CREATE TABLE IF NOT EXISTS "CROP_READ_TRASH" (
    "ID" INTEGER PRIMARY KEY,
    "CROP_UID" BLOB,
    "QUANTITY" INTEGER,
    "SOURCE_AREA_UID" BLOB,
    "SOURCE_AREA_NAME" TEXT,
    "CREATED_DATE" TEXT,
    "LAST_UPDATED" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

CREATE TABLE IF NOT EXISTS "CROP_READ_NOTES" (
    "UID" BLOB PRIMARY KEY,
    "CROP_UID" BLOB,
    "CONTENT" TEXT,
    "CREATED_DATE" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

CREATE UNIQUE INDEX IF NOT EXISTS "CROP_READ_NOTES_UID_UNIQUE_INDEX" ON "CROP_READ_NOTES" ("UID");
CREATE INDEX IF NOT EXISTS "CROP_READ_NOTES_CROP_UID_INDEX" ON "CROP_READ_NOTES" ("CROP_UID");


CREATE TABLE IF NOT EXISTS "CROP_ACTIVITY" (
    "ID" INTEGER PRIMARY KEY,
    "CROP_UID" BLOB,
    "BATCH_ID" TEXT,
    "CONTAINER_TYPE" TEXT,
    "ACTIVITY_TYPE" BLOB,
    "ACTIVITY_TYPE_CODE" TEXT,
    "CREATED_DATE" TEXT,
    "DESCRIPTION" TEXT,
    FOREIGN KEY("CROP_UID") REFERENCES "CROP_READ"("UID")
);

-- TASK --

CREATE TABLE IF NOT EXISTS "TASK_EVENT" (
    "ID" INTEGER PRIMARY KEY,
    "TASK_UID" BLOB,
    "VERSION" INTEGER,
    "CREATED_DATE" TEXT,
    "EVENT" BLOB
);

CREATE INDEX IF NOT EXISTS "TASK_EVENT_TASK_UID_INDEX" ON "TASK_EVENT" ("TASK_UID");

CREATE TABLE IF NOT EXISTS "TASK_READ" (
    "UID" BLOB PRIMARY KEY,
    "TITLE" TEXT,
    "DESCRIPTION" TEXT,
    "CREATED_DATE" TEXT,
    "DUE_DATE" TEXT,
    "COMPLETED_DATE" TEXT,
    "CANCELLED_DATE" TEXT,
    "PRIORITY" TEXT,
    "STATUS" TEXT,
    "DOMAIN_CODE" TEXT,
    "DOMAIN_DATA_MATERIAL_ID" TEXT,
    "DOMAIN_DATA_AREA_ID" TEXT,
    "DOMAIN_DATA_CROP_ID" TEXT,
    "CATEGORY" TEXT,
    "IS_DUE" BOOLEAN,
    "ASSET_ID" TEXT
);

CREATE INDEX IF NOT EXISTS "TASK_READ_UID_UNIQUE_INDEX" ON "TASK_READ" ("UID");