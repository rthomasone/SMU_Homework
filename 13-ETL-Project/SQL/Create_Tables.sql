-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "source" (
    "source_id" SERIAL   NOT NULL,
    "source_name" varchar(50)   NOT NULL,
    "source_url" varchar(200)   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_source" PRIMARY KEY (
        "source_id"
     )
);

CREATE TABLE "region" (
    "region_id" SERIAL   NOT NULL,
    "region_name" varchar(50)   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_region" PRIMARY KEY (
        "region_id"
     )
);

CREATE TABLE "chart_type" (
    "chart_id" SERIAL   NOT NULL,
    "chart_name" varchar(50)   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_chart_type" PRIMARY KEY (
        "chart_id"
     )
);

CREATE TABLE "tracks" (
    "track_id" SERIAL   NOT NULL,
    "position" INT   NOT NULL,
    "title" varchar(100)   NOT NULL,
    "artist" varchar(100)   NOT NULL,
    "streams" INT,   NULL,
    "source_id" INT   NOT NULL,
    "region_id" INT   NOT NULL,
    "chart_id" INT   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_tracks" PRIMARY KEY (
        "track_id"
     )
);

ALTER TABLE "tracks" ADD CONSTRAINT "fk_tracks_source_id" FOREIGN KEY("source_id")
REFERENCES "source" ("source_id");

ALTER TABLE "tracks" ADD CONSTRAINT "fk_tracks_region_id" FOREIGN KEY("region_id")
REFERENCES "region" ("region_id");

ALTER TABLE "tracks" ADD CONSTRAINT "fk_tracks_chart_id" FOREIGN KEY("chart_id")
REFERENCES "chart_type" ("chart_id");

