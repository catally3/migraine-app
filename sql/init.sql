-- SCHEMA: migraine-app

-- DROP SCHEMA IF EXISTS "migraine-app" ;

CREATE SCHEMA IF NOT EXISTS "migraine-app";
	
-- Table: migraine-app.event

-- DROP TABLE IF EXISTS "migraine-app".event;

CREATE TABLE IF NOT EXISTS "migraine-app".event
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    event_date timestamp with time zone,
    light_sensitivity boolean,
    sound_sensitivity boolean,
    fatigue_level integer,
    dizziness_level integer,
    stress_level integer,
    menstrual_cycle_stage integer,
    headache_level integer,
    nausea_level integer,
    aura boolean,
    vomiting boolean,
    sleep_hours integer,
    other_event jsonb,
    CONSTRAINT event_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: migraine-app.medication

-- DROP TABLE IF EXISTS "migraine-app".medication;

CREATE TABLE IF NOT EXISTS "migraine-app".medication
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(100) COLLATE pg_catalog."default",
    doseage character(10) COLLATE pg_catalog."default",
    type character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT medication_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: migraine-app.migraine

-- DROP TABLE IF EXISTS "migraine-app".migraine;

CREATE TABLE IF NOT EXISTS "migraine-app".migraine
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    severity integer,
    CONSTRAINT migraine_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: migraine-app.trigger

-- DROP TABLE IF EXISTS "migraine-app".trigger;

CREATE TABLE IF NOT EXISTS "migraine-app".trigger
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(50) COLLATE pg_catalog."default",
    description character varying(250) COLLATE pg_catalog."default",
    is_food boolean,
    CONSTRAINT trigger_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

-- Table: migraine-app.migraine_trigger

-- DROP TABLE IF EXISTS "migraine-app".migraine_trigger;

CREATE TABLE IF NOT EXISTS "migraine-app".migraine_trigger
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    migraine_id integer NOT NULL,
    trigger_id integer NOT NULL,
    trigger_quantity integer,
    CONSTRAINT migraine_trigger_pkey PRIMARY KEY (id),
    CONSTRAINT fk_migraine_id FOREIGN KEY (migraine_id)
        REFERENCES "migraine-app".migraine (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_trigger_id FOREIGN KEY (trigger_id)
        REFERENCES "migraine-app".trigger (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

	
-- Table: migraine-app.migraine_medication

-- DROP TABLE IF EXISTS "migraine-app".migraine_medication;

CREATE TABLE IF NOT EXISTS "migraine-app".migraine_medication
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    migraine_id integer NOT NULL,
    medication_id integer NOT NULL,
    medication_efficacy integer,
    medication_quantity integer,
    CONSTRAINT migraine_medication_pkey PRIMARY KEY (id),
    CONSTRAINT fk_medication_id FOREIGN KEY (medication_id)
        REFERENCES "migraine-app".medication (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_migraine_id FOREIGN KEY (migraine_id)
        REFERENCES "migraine-app".migraine (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

	
-- Table: migraine-app.event_medication

-- DROP TABLE IF EXISTS "migraine-app".event_medication;

CREATE TABLE IF NOT EXISTS "migraine-app".event_medication
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    event_id integer NOT NULL,
    medication_id integer NOT NULL,
    medication_quantity integer,
    CONSTRAINT event_medication_pkey PRIMARY KEY (id),
    CONSTRAINT fk_event_id FOREIGN KEY (event_id)
        REFERENCES "migraine-app".event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_medication_id FOREIGN KEY (medication_id)
        REFERENCES "migraine-app".medication (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

	