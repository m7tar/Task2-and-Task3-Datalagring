--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ensembles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ensembles (
    lesson_id integer NOT NULL,
    genre character varying(100) NOT NULL,
    max_amount_of_students character varying(10) NOT NULL,
    min_amount_of_students character varying(10) NOT NULL,
    cost character varying(10) NOT NULL,
    student_amount character varying(50)
);


ALTER TABLE public.ensembles OWNER TO postgres;

--
-- Name: ensembles_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ensembles_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ensembles_lesson_id_seq OWNER TO postgres;

--
-- Name: ensembles_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ensembles_lesson_id_seq OWNED BY public.ensembles.lesson_id;


--
-- Name: group_lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_lesson (
    lesson_id integer NOT NULL,
    mini_number_of_students character varying(10) NOT NULL,
    groups character varying(100) NOT NULL
);


ALTER TABLE public.group_lesson OWNER TO postgres;

--
-- Name: group_lesson_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_lesson_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_lesson_lesson_id_seq OWNER TO postgres;

--
-- Name: group_lesson_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_lesson_lesson_id_seq OWNED BY public.group_lesson.lesson_id;


--
-- Name: instructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor (
    id integer NOT NULL,
    assigned_lesson character varying(10) NOT NULL,
    instruments_tought character varying(100) NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.instructor OWNER TO postgres;

--
-- Name: instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instructor_id_seq OWNER TO postgres;

--
-- Name: instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_id_seq OWNED BY public.instructor.id;


--
-- Name: instructor_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instructor_person_id_seq OWNER TO postgres;

--
-- Name: instructor_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_person_id_seq OWNED BY public.instructor.person_id;


--
-- Name: instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrument (
    id integer NOT NULL,
    instrument_id character varying(50) NOT NULL,
    quantity_available character varying(10) NOT NULL,
    rent_fee character varying(10),
    rent_period timestamp(6) without time zone,
    student_id integer NOT NULL
);


ALTER TABLE public.instrument OWNER TO postgres;

--
-- Name: instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instrument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrument_id_seq OWNER TO postgres;

--
-- Name: instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instrument_id_seq OWNED BY public.instrument.id;


--
-- Name: instrument_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instrument_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrument_student_id_seq OWNER TO postgres;

--
-- Name: instrument_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instrument_student_id_seq OWNED BY public.instrument.student_id;


--
-- Name: lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson (
    id integer NOT NULL,
    place character varying(50) NOT NULL,
    instrument character varying(50),
    student_id integer NOT NULL,
    instructor_id integer NOT NULL
);


ALTER TABLE public.lesson OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_id_seq OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_id_seq OWNED BY public.lesson.id;


--
-- Name: lesson_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_instructor_id_seq OWNER TO postgres;

--
-- Name: lesson_instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_instructor_id_seq OWNED BY public.lesson.instructor_id;


--
-- Name: timeslot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timeslot (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


ALTER TABLE public.timeslot OWNER TO postgres;

--
-- Name: lesson_per_month_per_year; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.lesson_per_month_per_year AS
 SELECT EXTRACT(month FROM timeslot.start_time) AS month,
    count(*) AS count
   FROM public.timeslot
  WHERE (EXTRACT(year FROM timeslot.start_time) = '2021'::numeric)
  GROUP BY (EXTRACT(month FROM timeslot.start_time))
  ORDER BY (EXTRACT(month FROM timeslot.start_time));


ALTER TABLE public.lesson_per_month_per_year OWNER TO postgres;

--
-- Name: lesson_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_student_id_seq OWNER TO postgres;

--
-- Name: lesson_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_student_id_seq OWNED BY public.lesson.student_id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    student_payment character varying(10) NOT NULL,
    instructor_salary character varying(10) NOT NULL,
    student_id integer NOT NULL,
    instructor_id integer NOT NULL
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_id_seq OWNER TO postgres;

--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: payment_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_instructor_id_seq OWNER TO postgres;

--
-- Name: payment_instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_instructor_id_seq OWNED BY public.payment.instructor_id;


--
-- Name: payment_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_student_id_seq OWNER TO postgres;

--
-- Name: payment_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_student_id_seq OWNED BY public.payment.student_id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    email character varying(50) NOT NULL,
    address character varying(500) NOT NULL,
    person_number character varying(12) NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;


--
-- Name: person_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person_phone (
    person_id integer NOT NULL,
    phone_id integer NOT NULL
);


ALTER TABLE public.person_phone OWNER TO postgres;

--
-- Name: person_phone_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_phone_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_phone_person_id_seq OWNER TO postgres;

--
-- Name: person_phone_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_phone_person_id_seq OWNED BY public.person_phone.person_id;


--
-- Name: person_phone_phone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_phone_phone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_phone_phone_id_seq OWNER TO postgres;

--
-- Name: person_phone_phone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_phone_phone_id_seq OWNED BY public.person_phone.phone_id;


--
-- Name: phone_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone_number (
    id integer NOT NULL,
    number character varying(10)
);


ALTER TABLE public.phone_number OWNER TO postgres;

--
-- Name: phone_number_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phone_number_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phone_number_id_seq OWNER TO postgres;

--
-- Name: phone_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phone_number_id_seq OWNED BY public.phone_number.id;


--
-- Name: pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pricing (
    id character varying(10) NOT NULL,
    skill_level character varying(50) NOT NULL,
    lesson_type character varying(50) NOT NULL,
    price character varying(10) NOT NULL,
    lesson_id integer NOT NULL
);


ALTER TABLE public.pricing OWNER TO postgres;

--
-- Name: pricing_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pricing_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_lesson_id_seq OWNER TO postgres;

--
-- Name: pricing_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pricing_lesson_id_seq OWNED BY public.pricing.lesson_id;


--
-- Name: sibling; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sibling (
    sibling_id integer NOT NULL,
    sibling_student_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100)
);


ALTER TABLE public.sibling OWNER TO postgres;

--
-- Name: sibling_sibling_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sibling ALTER COLUMN sibling_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sibling_sibling_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    contact_person character varying(200) NOT NULL,
    present_skill character varying(50) NOT NULL,
    number_of_lessons_taken character varying(10) NOT NULL,
    instrument_to_learn character varying(50) NOT NULL,
    rented_instrument character varying(50),
    person_id integer NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_id_seq OWNER TO postgres;

--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- Name: student_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_person_id_seq OWNER TO postgres;

--
-- Name: student_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_person_id_seq OWNED BY public.student.person_id;


--
-- Name: timeslot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timeslot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.timeslot_id_seq OWNER TO postgres;

--
-- Name: timeslot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timeslot_id_seq OWNED BY public.timeslot.id;


--
-- Name: timeslot_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timeslot_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.timeslot_lesson_id_seq OWNER TO postgres;

--
-- Name: timeslot_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timeslot_lesson_id_seq OWNED BY public.timeslot.lesson_id;


--
-- Name: ensembles lesson_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensembles ALTER COLUMN lesson_id SET DEFAULT nextval('public.ensembles_lesson_id_seq'::regclass);


--
-- Name: group_lesson lesson_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_lesson ALTER COLUMN lesson_id SET DEFAULT nextval('public.group_lesson_lesson_id_seq'::regclass);


--
-- Name: instructor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor ALTER COLUMN id SET DEFAULT nextval('public.instructor_id_seq'::regclass);


--
-- Name: instructor person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor ALTER COLUMN person_id SET DEFAULT nextval('public.instructor_person_id_seq'::regclass);


--
-- Name: instrument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument ALTER COLUMN id SET DEFAULT nextval('public.instrument_id_seq'::regclass);


--
-- Name: instrument student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument ALTER COLUMN student_id SET DEFAULT nextval('public.instrument_student_id_seq'::regclass);


--
-- Name: lesson id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson ALTER COLUMN id SET DEFAULT nextval('public.lesson_id_seq'::regclass);


--
-- Name: lesson student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson ALTER COLUMN student_id SET DEFAULT nextval('public.lesson_student_id_seq'::regclass);


--
-- Name: lesson instructor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson ALTER COLUMN instructor_id SET DEFAULT nextval('public.lesson_instructor_id_seq'::regclass);


--
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: payment student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN student_id SET DEFAULT nextval('public.payment_student_id_seq'::regclass);


--
-- Name: payment instructor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN instructor_id SET DEFAULT nextval('public.payment_instructor_id_seq'::regclass);


--
-- Name: person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- Name: person_phone person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone ALTER COLUMN person_id SET DEFAULT nextval('public.person_phone_person_id_seq'::regclass);


--
-- Name: person_phone phone_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone ALTER COLUMN phone_id SET DEFAULT nextval('public.person_phone_phone_id_seq'::regclass);


--
-- Name: phone_number id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_number ALTER COLUMN id SET DEFAULT nextval('public.phone_number_id_seq'::regclass);


--
-- Name: pricing lesson_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing ALTER COLUMN lesson_id SET DEFAULT nextval('public.pricing_lesson_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- Name: student person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN person_id SET DEFAULT nextval('public.student_person_id_seq'::regclass);


--
-- Name: timeslot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeslot ALTER COLUMN id SET DEFAULT nextval('public.timeslot_id_seq'::regclass);


--
-- Name: timeslot lesson_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeslot ALTER COLUMN lesson_id SET DEFAULT nextval('public.timeslot_lesson_id_seq'::regclass);


--
-- Data for Name: ensembles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ensembles (lesson_id, genre, max_amount_of_students, min_amount_of_students, cost, student_amount) FROM stdin;
65	rock	10	2	20	10
63	classical	20	10	40	15
62	jazz	7	3	15	6
61	rock	9	2	60	3
\.


--
-- Data for Name: group_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_lesson (lesson_id, mini_number_of_students, groups) FROM stdin;
13	10	4
\.


--
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor (id, assigned_lesson, instruments_tought, person_id) FROM stdin;
519	bz80	5	653
492	nk46	1	620
261	jr27	7	470
84	wa70	8	2
804	oa85	6	193
\.


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (id, instrument_id, quantity_available, rent_fee, rent_period, student_id) FROM stdin;
95	443	7	48	\N	14
79	718	6	16	\N	16
70	643	5	29	\N	17
54	663	4	19	\N	18
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson (id, place, instrument, student_id, instructor_id) FROM stdin;
8	r20	guitar	14	519
10	r58	guitar	16	261
11	r20	piano	17	84
12	r13	guitar	18	84
13	r2	drums	19	84
65	r30	guitar	14	519
63	r59	guitar	16	261
62	r22	piano	17	261
61	r18	guitar	18	84
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, student_payment, instructor_salary, student_id, instructor_id) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, first_name, last_name, email, address, person_number) FROM stdin;
653	Hersch	Haswell	hhaswell0@chron.com	1 Carey Crossing	649076-0353
620	Berget	Daughtry	bdaughtry1@exblog.jp	71507 Summerview Point	330264-6007
470	Ellswerth	Meecher	emeecher2@nydailynews.com	31450 Dwight Circle	505655-2266
781	Thain	Reeks	treeks3@unicef.org	6 Golf View Parkway	471774-5785
2	Larry	Bickmore	lbickmore4@networkadvertising.org	1769 Southridge Park	600089-9497
825	Gabbey	Lalor	glalor5@meetup.com	578 Bluejay Point	420858-8339
729	Brander	Dickin	bdickin6@weather.com	3622 Artisan Trail	164689-6907
150	Evita	Eixenberger	eeixenberger7@imageshack.us	32 Mendota Junction	847356-2948
119	Brandon	Skoof	bskoof8@macromedia.com	0 Autumn Leaf Junction	643251-7362
193	Hyacinthia	Shoute	hshoute9@xrea.com	93040 Sunbrook Avenue	790968-1339
\.


--
-- Data for Name: person_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_phone (person_id, phone_id) FROM stdin;
\.


--
-- Data for Name: phone_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone_number (id, number) FROM stdin;
\.


--
-- Data for Name: pricing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pricing (id, skill_level, lesson_type, price, lesson_id) FROM stdin;
\.


--
-- Data for Name: sibling; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sibling (sibling_id, sibling_student_id, first_name, last_name) FROM stdin;
1	14	george	malki
2	14	ahmad	haaadi
3	16	abbas	moukhtar
4	18	youssef	albuid
5	18	celine	careue
6	19	ismail	lojiken
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, contact_person, present_skill, number_of_lessons_taken, instrument_to_learn, rented_instrument, person_id) FROM stdin;
14	Paulie Binstead	beginner	18	violin	guitar	781
16	Marsh Grimmolby	advanced	6	violin	piano	825
17	Merwin Di Franceschi	advanced	10	violin	guitar	729
18	Devi Aleso	advanced	23	guitar	violin	150
19	Mikey Dymoke	intermediate	19	guitar	\N	119
\.


--
-- Data for Name: timeslot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timeslot (id, lesson_id, start_time, end_time) FROM stdin;
1	8	2017-03-30 09:30:20	2017-03-31 09:30:20
2	10	2022-07-11 15:00:00	2017-07-10 16:00:00
3	11	2022-07-12 17:00:00	2017-07-10 18:00:00
4	12	2022-07-12 19:00:00	2017-07-10 20:00:00
5	13	2022-08-13 09:00:00	2017-07-10 10:00:00
7	65	2022-12-13 15:00:00	2017-07-10 16:00:00
8	63	2022-12-10 15:00:00	2017-07-10 16:00:00
9	62	2022-12-15 17:00:00	2017-07-10 18:00:00
10	61	2022-12-09 19:00:00	2017-07-10 20:00:00
\.


--
-- Name: ensembles_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ensembles_lesson_id_seq', 5, true);


--
-- Name: group_lesson_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_lesson_lesson_id_seq', 1, false);


--
-- Name: instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_id_seq', 1, false);


--
-- Name: instructor_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_person_id_seq', 1, false);


--
-- Name: instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_id_seq', 1, false);


--
-- Name: instrument_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_student_id_seq', 1, false);


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_id_seq', 1, false);


--
-- Name: lesson_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_instructor_id_seq', 1, false);


--
-- Name: lesson_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_student_id_seq', 1, false);


--
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_id_seq', 1, false);


--
-- Name: payment_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_instructor_id_seq', 1, false);


--
-- Name: payment_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_student_id_seq', 1, false);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 1, false);


--
-- Name: person_phone_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_phone_person_id_seq', 1, false);


--
-- Name: person_phone_phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_phone_phone_id_seq', 1, false);


--
-- Name: phone_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phone_number_id_seq', 1, false);


--
-- Name: pricing_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pricing_lesson_id_seq', 1, false);


--
-- Name: sibling_sibling_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sibling_sibling_id_seq', 6, true);


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 20, true);


--
-- Name: student_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_person_id_seq', 1, false);


--
-- Name: timeslot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timeslot_id_seq', 1, false);


--
-- Name: timeslot_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timeslot_lesson_id_seq', 1, false);


--
-- Name: ensembles pk_ensembles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensembles
    ADD CONSTRAINT pk_ensembles PRIMARY KEY (lesson_id);


--
-- Name: group_lesson pk_group_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT pk_group_lesson PRIMARY KEY (lesson_id);


--
-- Name: instructor pk_instructor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT pk_instructor PRIMARY KEY (id);


--
-- Name: instrument pk_instrument; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT pk_instrument PRIMARY KEY (id);


--
-- Name: lesson pk_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT pk_lesson PRIMARY KEY (id);


--
-- Name: payment pk_payment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT pk_payment PRIMARY KEY (id);


--
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT pk_person PRIMARY KEY (id);


--
-- Name: person_phone pk_person_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT pk_person_phone PRIMARY KEY (person_id, phone_id);


--
-- Name: phone_number pk_phone_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_number
    ADD CONSTRAINT pk_phone_number PRIMARY KEY (id);


--
-- Name: pricing pk_pricing; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pk_pricing PRIMARY KEY (id);


--
-- Name: student pk_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT pk_student PRIMARY KEY (id);


--
-- Name: timeslot pk_timeslot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeslot
    ADD CONSTRAINT pk_timeslot PRIMARY KEY (id);


--
-- Name: sibling sibling_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sibling
    ADD CONSTRAINT sibling_pkey PRIMARY KEY (sibling_id);


--
-- Name: ensembles fk_ensembles_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensembles
    ADD CONSTRAINT fk_ensembles_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: group_lesson fk_group_lesson_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT fk_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: instructor fk_instructor_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT fk_instructor_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: instrument fk_instrument_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT fk_instrument_0 FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: lesson fk_lesson_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT fk_lesson_0 FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: lesson fk_lesson_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT fk_lesson_1 FOREIGN KEY (instructor_id) REFERENCES public.instructor(id);


--
-- Name: payment fk_payment_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_0 FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: payment fk_payment_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_1 FOREIGN KEY (instructor_id) REFERENCES public.instructor(id);


--
-- Name: person_phone fk_person_phone_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT fk_person_phone_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: person_phone fk_person_phone_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT fk_person_phone_1 FOREIGN KEY (phone_id) REFERENCES public.phone_number(id);


--
-- Name: pricing fk_pricing_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT fk_pricing_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: student fk_student_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_student_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: timeslot fk_timeslot_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeslot
    ADD CONSTRAINT fk_timeslot_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: sibling sibling_sibling_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sibling
    ADD CONSTRAINT sibling_sibling_student_id_fkey FOREIGN KEY (sibling_student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

