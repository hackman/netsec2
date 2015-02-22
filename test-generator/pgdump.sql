--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: 2014-2015; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "2015";

SET search_path = "2015", pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: results; Type: TABLE; Schema: 2014-2015; Owner: postgres; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    fn integer NOT NULL,
    exam1 integer,
    exam2 integer,
    variant1 integer,
    variant2 integer,
    paper integer,
    gender boolean DEFAULT true NOT NULL,
    kurs integer,
    homeworks integer
);

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE results_id_seq OWNED BY results.id;
ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);
ALTER TABLE ONLY results ADD CONSTRAINT results_id_key UNIQUE (id);
ALTER TABLE ONLY results ADD CONSTRAINT results_pkey PRIMARY KEY (fn);

--
-- Some views to help list the data 
--

CREATE VIEW exam1 AS
    SELECT results.fn, CASE WHEN (results.exam1 IS NULL) THEN 0 ELSE results.exam1 END AS points, results.variant1 FROM results ORDER BY results.fn;

CREATE VIEW exam2 AS
    SELECT results.fn, CASE WHEN (results.exam2 IS NULL) THEN 0 ELSE results.exam2 END AS points, results.variant2 FROM results ORDER BY results.fn;

CREATE VIEW homeworks AS
    SELECT results.fn, CASE WHEN (results.homeworks IS NULL) THEN 0 ELSE results.homeworks END AS points FROM results ORDER BY results.fn;

--
-- Simplify the calculation for the final results
--

CREATE VIEW final_results AS
    SELECT results.fn, results.exam1, results.exam2, results.paper, results.homeworks, CASE WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 90) THEN 6 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 80) THEN 5 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 70) THEN 4 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 60) THEN 3 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) < 60) THEN 2 ELSE NULL::integer END AS grade FROM results WHERE ((results.exam1 > 0) AND (results.exam2 > 0)) ORDER BY results.fn, CASE WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 90) THEN 6 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 80) THEN 5 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 70) THEN 4 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) >= 60) THEN 3 WHEN ((((results.exam1 + results.exam2) + results.paper) + results.homeworks) < 60) THEN 2 ELSE NULL::integer END;


SET search_path = public, pg_catalog;

CREATE TABLE questions (
    id integer NOT NULL,
    date_added timestamp without time zone DEFAULT now() NOT NULL,
    question text NOT NULL,
    first_test boolean DEFAULT true NOT NULL
);

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE questions_id_seq OWNED BY questions.id;
ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);
ALTER TABLE ONLY questions ADD CONSTRAINT questions_pkey PRIMARY KEY (id);

CREATE TABLE right_answers (
    id integer NOT NULL,
    q_id integer NOT NULL,
    date_added timestamp without time zone DEFAULT now() NOT NULL,
    answer text NOT NULL
);

CREATE SEQUENCE right_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE right_answers_id_seq OWNED BY right_answers.id;
ALTER TABLE ONLY right_answers ALTER COLUMN id SET DEFAULT nextval('right_answers_id_seq'::regclass);
ALTER TABLE ONLY right_answers ADD CONSTRAINT right_answers_pkey PRIMARY KEY (id);
ALTER TABLE ONLY right_answers ADD CONSTRAINT right_answers_q_id_fkey FOREIGN KEY (q_id) REFERENCES questions(id) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE wrong_answers (
    id integer NOT NULL,
    q_id integer NOT NULL,
    date_added timestamp without time zone DEFAULT now() NOT NULL,
    answer text NOT NULL
);

CREATE SEQUENCE wrong_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE wrong_answers_id_seq OWNED BY wrong_answers.id;
ALTER TABLE ONLY wrong_answers ALTER COLUMN id SET DEFAULT nextval('wrong_answers_id_seq'::regclass);
ALTER TABLE ONLY wrong_answers ADD CONSTRAINT wrong_answers_pkey PRIMARY KEY (id);
ALTER TABLE ONLY wrong_answers ADD CONSTRAINT wrong_answers_q_id_fkey FOREIGN KEY (q_id) REFERENCES questions(id) ON UPDATE CASCADE ON DELETE CASCADE;




--
-- PostgreSQL database dump complete
--
