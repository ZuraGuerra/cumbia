--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audio_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audio_data (
    id bigint NOT NULL,
    danceability double precision,
    energy double precision,
    key character varying(255),
    loudness double precision,
    speechness double precision,
    acousticness double precision,
    tempo double precision,
    liveness double precision,
    duration integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean
);


--
-- Name: audio_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audio_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audio_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audio_data_id_seq OWNED BY audio_data.id;


--
-- Name: audios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audios (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    tags character varying(255)[],
    file bytea,
    duration integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean
);


--
-- Name: audios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audios_id_seq OWNED BY audios.id;


--
-- Name: filtered_audios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE filtered_audios (
    id bigint NOT NULL,
    file bytea,
    filter_params jsonb,
    name character varying(255),
    hearted boolean DEFAULT false NOT NULL,
    notes text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean
);


--
-- Name: filtered_audios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filtered_audios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: filtered_audios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filtered_audios_id_seq OWNED BY filtered_audios.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projects (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    youtube_url character varying(255),
    tags character varying(255)[],
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    fb_id character varying(255),
    avatar character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: audio_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audio_data ALTER COLUMN id SET DEFAULT nextval('audio_data_id_seq'::regclass);


--
-- Name: audios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audios ALTER COLUMN id SET DEFAULT nextval('audios_id_seq'::regclass);


--
-- Name: filtered_audios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY filtered_audios ALTER COLUMN id SET DEFAULT nextval('filtered_audios_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: audio_data audio_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audio_data
    ADD CONSTRAINT audio_data_pkey PRIMARY KEY (id);


--
-- Name: audios audios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audios
    ADD CONSTRAINT audios_pkey PRIMARY KEY (id);


--
-- Name: filtered_audios filtered_audios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filtered_audios
    ADD CONSTRAINT filtered_audios_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20171105000847), (20171105001208), (20171105004141), (20171105004235), (20171105004344), (20171105021241);

