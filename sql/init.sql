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
/*
insert into "migraine-app".medication (name, doseage, type)
values 
	('ibuprofen', '800mg', 'as needed'),
	('ibuprofen', '200mg', 'as needed'),
	('ibuprofen', '400mg', 'as needed'),
	('ibuprofen', '600mg', 'as needed'),
	('ibuprofen', '100mg', 'as needed'),
	('rizatriptan', '10mg', 'as needed'),
	('rizatriptan', '5mg', 'as needed'),
	('nurtec', '75mg', 'daily every other day'),
	('nurtec', '75mg', 'as needed'),
	('ondansetron', '4mg', 'as needed'),
	('excedrin', '565mg', 'as needed'),
	('sumatriptan', '25mg', 'as needed'),
	('sumatriptan', '50mg', 'as needed'),
	('sumatriptan', '100mg', 'as needed'),
	('sumatriptan', '5mg', 'as needed'),
	('sumatriptan', '10mg', 'as needed'),
	('sumatriptan', '20mg', 'as needed'),
	('naratriptan', '1mg', 'as needed'),
	('naratriptan', '2.5mg', 'as needed'),
	('frovatriptan', '2.5mg', 'as needed'),
	('eletriptan', '20mg', 'as needed'),
	('eletriptan', '40mg', 'as needed'),
	('almotriptan', '12.5mg', 'as needed'),
	('almotriptan', '6.25mg', 'as needed'),
	('zolmitriptan', '2.5mg', 'as needed'),
	('zolmitriptan', '5mg', 'as needed'),
	('ubrelvy', '50mg', 'as needed'),
	('ubrelvy', '100mg', 'as needed'),
	('dihydroergotamine', '0.725mg', 'as needed'),
	('dihydroergotamine', '4mg/mL', 'as needed'),
	('naproxen', '220mg', 'as needed'),
	('naproxen', '440mg', 'as needed'),
	('naproxen', '550mg', 'as needed'),
	('naproxen', '275mg', 'as needed'),
	('naproxen', '1000mg', 'as needed'),
	('propranolol', '80mg', 'daily'),
	('propranolol', '160mg', 'daily'),
	('propranolol', '240mg', 'daily'),
	('timolol', '10mg', 'daily'),
	('timolol', '20mg', 'daily'),
	('timolol', '30mg', 'daily'),
	('gabapentin', '600mg', 'daily'),
	('amitriptyline', '10mg', 'daily'),
	('amitriptyline', '25mg', 'daily'),
	('amitriptyline', '50mg', 'daily'),
	('amitriptyline', '75mg', 'daily'),
	('amitriptyline', '100mg', 'daily'),
	('amitriptyline', '150mg', 'daily'),
	('venlafaxine', '75mg', 'daily'),
	('venlafaxine', '150mg', 'daily'),
	('venlafaxine', '37.5mg', 'daily'),
	('topiramate', '100mg', 'daily'),
	('topiramate', '25mg', 'daily'),
	('topiramate', '50mg', 'daily'),
	('topiramate', '75mg', 'daily'),
	('valproic acid', '250mg', 'daily');
	*/

	