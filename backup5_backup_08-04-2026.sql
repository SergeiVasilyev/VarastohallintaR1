--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Ubuntu 17.4-1.pgdg20.04+2)
-- Dumped by pg_dump version 17.4 (Ubuntu 17.4-1.pgdg20.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_group_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer DEFAULT nextval('public.auth_group_id_seq'::regclass) NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: goods_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods_audit (
    id integer NOT NULL,
    staff_id bigint,
    item_id bigint,
    date_event timestamp with time zone
);


ALTER TABLE public.goods_audit OWNER TO postgres;

--
-- Name: goods_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goods_audit_id_seq OWNER TO postgres;

--
-- Name: goods_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_audit_id_seq OWNED BY public.goods_audit.id;


--
-- Name: rental_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rental_audit (
    id bigint NOT NULL,
    staff_id character varying(30),
    item_id integer,
    start_date date,
    estimated_date date,
    renter_id integer,
    datestamp timestamp with time zone
);


ALTER TABLE public.rental_audit OWNER TO postgres;

--
-- Name: rental_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rental_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rental_audit_id_seq OWNER TO postgres;

--
-- Name: rental_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rental_audit_id_seq OWNED BY public.rental_audit.id;


--
-- Name: varasto_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_category_id_seq OWNER TO postgres;

--
-- Name: varasto_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_category (
    id bigint DEFAULT nextval('public.varasto_category_id_seq'::regclass) NOT NULL,
    cat_name character varying(100) NOT NULL
);


ALTER TABLE public.varasto_category OWNER TO postgres;

--
-- Name: varasto_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_customuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_customuser_id_seq OWNER TO postgres;

--
-- Name: varasto_customuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_customuser (
    id bigint DEFAULT nextval('public.varasto_customuser_id_seq'::regclass) NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    phone character varying(15),
    code character varying(10),
    photo character varying(100),
    role character varying(255) NOT NULL,
    responsible_teacher_id bigint,
    "group" character varying(15),
    storage_id bigint,
    is_storage_staff boolean NOT NULL
);


ALTER TABLE public.varasto_customuser OWNER TO postgres;

--
-- Name: varasto_customuser_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_customuser_groups (
    id bigint NOT NULL,
    customuser_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.varasto_customuser_groups OWNER TO postgres;

--
-- Name: varasto_customuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_customuser_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_customuser_groups_id_seq OWNER TO postgres;

--
-- Name: varasto_customuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.varasto_customuser_groups_id_seq OWNED BY public.varasto_customuser_groups.id;


--
-- Name: varasto_customuser_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_customuser_user_permissions (
    id bigint NOT NULL,
    customuser_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.varasto_customuser_user_permissions OWNER TO postgres;

--
-- Name: varasto_customuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_customuser_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_customuser_user_permissions_id_seq OWNER TO postgres;

--
-- Name: varasto_customuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.varasto_customuser_user_permissions_id_seq OWNED BY public.varasto_customuser_user_permissions.id;


--
-- Name: varasto_goods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_goods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_goods_id_seq OWNER TO postgres;

--
-- Name: varasto_goods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_goods (
    id bigint DEFAULT nextval('public.varasto_goods_id_seq'::regclass) NOT NULL,
    item_name character varying(150),
    brand character varying(150),
    model character varying(150),
    item_type character varying(100),
    size character varying(50),
    parameters character varying(100),
    contents numeric(11,4),
    picture character varying(100),
    item_description text,
    cost_centre character varying(100),
    purchase_data date,
    purchase_price numeric(6,2),
    purchase_place character varying(50),
    invoice_number character varying(50),
    cat_name_id bigint,
    storage_id bigint,
    ean character varying(13),
    amount integer,
    storage_place character varying(5),
    unit_id bigint,
    amount_x_contents numeric(11,4)
);


ALTER TABLE public.varasto_goods OWNER TO postgres;

--
-- Name: varasto_rental_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_rental_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_rental_event_id_seq OWNER TO postgres;

--
-- Name: varasto_rental_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_rental_event (
    id bigint DEFAULT nextval('public.varasto_rental_event_id_seq'::regclass) NOT NULL,
    remarks character varying(255),
    item_id bigint,
    renter_id bigint,
    staff_id bigint,
    storage_id bigint,
    estimated_date timestamp with time zone,
    returned_date timestamp with time zone,
    start_date timestamp with time zone,
    amount integer,
    contents numeric(11,4),
    units_id bigint,
    returned numeric(11,4)
);


ALTER TABLE public.varasto_rental_event OWNER TO postgres;

--
-- Name: varasto_varasto_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_varasto_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_varasto_settings_id_seq OWNER TO postgres;

--
-- Name: varasto_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_settings (
    id bigint DEFAULT nextval('public.varasto_varasto_settings_id_seq'::regclass) NOT NULL,
    set_name character varying(150),
    set_value character varying(300),
    label character varying(300)
);


ALTER TABLE public.varasto_settings OWNER TO postgres;

--
-- Name: varasto_settings_customuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_settings_customuser (
    id bigint NOT NULL,
    set_value character varying(300),
    setting_name_id bigint NOT NULL,
    user_id bigint,
    storage_id bigint
);


ALTER TABLE public.varasto_settings_customuser OWNER TO postgres;

--
-- Name: varasto_settings_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_settings_customuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_settings_customuser_id_seq OWNER TO postgres;

--
-- Name: varasto_settings_customuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.varasto_settings_customuser_id_seq OWNED BY public.varasto_settings_customuser.id;


--
-- Name: varasto_staff_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_staff_audit (
    id bigint NOT NULL,
    event_process character varying(100),
    event_date timestamp with time zone,
    remarks character varying(300),
    from_storage character varying(100),
    item character varying(500),
    person character varying(300),
    staff character varying(300),
    to_storage character varying(100)
);


ALTER TABLE public.varasto_staff_audit OWNER TO postgres;

--
-- Name: varasto_staff_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_staff_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_staff_audit_id_seq OWNER TO postgres;

--
-- Name: varasto_staff_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.varasto_staff_audit_id_seq OWNED BY public.varasto_staff_audit.id;


--
-- Name: varasto_storage_name_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_storage_name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_storage_name_id_seq OWNER TO postgres;

--
-- Name: varasto_storage_name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_storage_name (
    id bigint DEFAULT nextval('public.varasto_storage_name_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    storage_code character varying(5)
);


ALTER TABLE public.varasto_storage_name OWNER TO postgres;

--
-- Name: varasto_storage_place_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_storage_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_storage_place_id_seq OWNER TO postgres;

--
-- Name: varasto_storage_place; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_storage_place (
    id bigint DEFAULT nextval('public.varasto_storage_place_id_seq'::regclass) NOT NULL,
    rack character varying(20),
    shelf character varying(20),
    place character varying(20)
);


ALTER TABLE public.varasto_storage_place OWNER TO postgres;

--
-- Name: varasto_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.varasto_units (
    id bigint NOT NULL,
    unit_name character varying(25)
);


ALTER TABLE public.varasto_units OWNER TO postgres;

--
-- Name: varasto_units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.varasto_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varasto_units_id_seq OWNER TO postgres;

--
-- Name: varasto_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.varasto_units_id_seq OWNED BY public.varasto_units.id;


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: goods_audit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_audit ALTER COLUMN id SET DEFAULT nextval('public.goods_audit_id_seq'::regclass);


--
-- Name: rental_audit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_audit ALTER COLUMN id SET DEFAULT nextval('public.rental_audit_id_seq'::regclass);


--
-- Name: varasto_customuser_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_groups ALTER COLUMN id SET DEFAULT nextval('public.varasto_customuser_groups_id_seq'::regclass);


--
-- Name: varasto_customuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.varasto_customuser_user_permissions_id_seq'::regclass);


--
-- Name: varasto_settings_customuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings_customuser ALTER COLUMN id SET DEFAULT nextval('public.varasto_settings_customuser_id_seq'::regclass);


--
-- Name: varasto_staff_audit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_staff_audit ALTER COLUMN id SET DEFAULT nextval('public.varasto_staff_audit_id_seq'::regclass);


--
-- Name: varasto_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_units ALTER COLUMN id SET DEFAULT nextval('public.varasto_units_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
3	student
6	teacher
1	Administrator
5	storage_employee
2	management
4	student_ext
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
45	1	45
46	1	46
47	1	47
48	1	48
49	2	4
50	2	8
51	2	12
52	2	16
53	2	20
54	2	24
55	2	25
56	2	26
58	2	28
59	2	29
60	2	30
61	2	31
62	2	32
63	2	33
64	2	34
65	2	35
66	2	36
67	2	37
68	2	38
69	2	39
70	2	40
72	2	48
112	5	48
113	5	45
114	5	46
115	5	47
116	5	32
117	5	56
118	5	4
119	5	36
120	5	37
121	5	38
122	5	8
123	5	39
124	5	40
125	5	12
126	5	52
127	5	24
128	5	25
129	5	26
130	5	27
131	5	28
132	3	32
133	4	32
134	4	48
135	4	45
136	4	46
137	6	32
138	6	36
139	6	40
140	6	48
141	6	24
142	5	5
143	5	6
144	5	7
148	2	5
149	2	6
150	2	7
151	2	9
152	2	10
153	2	11
154	1	49
155	1	50
156	1	51
157	1	52
158	1	53
159	1	54
160	1	55
161	1	56
162	5	29
163	5	30
164	4	24
165	5	64
166	5	33
167	5	34
168	5	35
171	5	57
172	5	58
173	5	59
174	5	60
175	2	64
179	2	49
180	2	50
181	2	21
182	2	22
183	2	23
184	2	57
185	2	58
186	2	59
187	2	60
188	2	61
189	2	62
190	2	63
191	5	49
192	5	50
193	1	64
194	1	57
195	1	58
196	1	59
197	1	60
198	1	61
199	1	62
200	1	63
201	5	22
202	5	31
203	5	21
204	5	23
205	5	10
206	5	65
207	5	66
208	5	67
209	5	68
210	5	13
211	5	14
212	5	15
213	5	16
214	2	65
215	2	66
216	2	67
217	2	68
218	2	13
219	2	14
220	2	15
221	2	52
222	2	53
223	2	54
224	2	56
225	4	29
226	4	30
227	4	31
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_customuser
22	Can change user	6	change_customuser
23	Can delete user	6	delete_customuser
24	Can view user	6	view_customuser
25	Can add category	7	add_category
26	Can change category	7	change_category
27	Can delete category	7	delete_category
28	Can view category	7	view_category
29	Can add goods	8	add_goods
30	Can change goods	8	change_goods
31	Can delete goods	8	delete_goods
32	Can view goods	8	view_goods
33	Can add storage_name	9	add_storage_name
34	Can change storage_name	9	change_storage_name
35	Can delete storage_name	9	delete_storage_name
36	Can view storage_name	9	view_storage_name
37	Can add storage_place	10	add_storage_place
38	Can change storage_place	10	change_storage_place
39	Can delete storage_place	10	delete_storage_place
40	Can view storage_place	10	view_storage_place
45	Can add rental_event	12	add_rental_event
46	Can change rental_event	12	change_rental_event
47	Can delete rental_event	12	delete_rental_event
48	Can view rental_event	12	view_rental_event
49	Can add varasto_ settings	13	add_varasto_settings
50	Can change varasto_ settings	13	change_varasto_settings
51	Can delete varasto_ settings	13	delete_varasto_settings
52	Can view varasto_ settings	13	view_varasto_settings
53	Can add settings	13	add_settings
54	Can change settings	13	change_settings
55	Can delete settings	13	delete_settings
56	Can view settings	13	view_settings
57	Can add units	14	add_units
58	Can change units	14	change_units
59	Can delete units	14	delete_units
60	Can view units	14	view_units
61	Can add staff_audit	15	add_staff_audit
62	Can change staff_audit	15	change_staff_audit
63	Can delete staff_audit	15	delete_staff_audit
64	Can view staff_audit	15	view_staff_audit
65	Can add settings_ custom user	16	add_settings_customuser
66	Can change settings_ custom user	16	change_settings_customuser
67	Can delete settings_ custom user	16	delete_settings_customuser
68	Can view settings_ custom user	16	view_settings_customuser
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
230	2023-03-22 08:11:01.389404+01	25	user32	1	[{"added": {}}]	6	1
231	2023-03-22 08:41:43.893127+01	26	user33	1	[{"added": {}}]	6	1
232	2023-03-22 08:43:06.409126+01	26	user33	3		6	1
233	2023-06-05 15:29:17.810996+02	6	user5	2	[{"changed": {"fields": ["password"]}}]	6	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	varasto	customuser
7	varasto	category
8	varasto	goods
9	varasto	storage_name
10	varasto	storage_place
12	varasto	rental_event
13	varasto	settings
14	varasto	units
15	varasto	staff_audit
16	varasto	settings_customuser
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-04-17 16:06:37.88269+02
2	contenttypes	0002_remove_content_type_name	2022-04-17 16:06:37.893006+02
3	auth	0001_initial	2022-04-17 16:06:37.971426+02
4	auth	0002_alter_permission_name_max_length	2022-04-17 16:06:37.976427+02
5	auth	0003_alter_user_email_max_length	2022-04-17 16:06:37.981428+02
6	auth	0004_alter_user_username_opts	2022-04-17 16:06:37.987109+02
7	auth	0005_alter_user_last_login_null	2022-04-17 16:06:37.992092+02
8	auth	0006_require_contenttypes_0002	2022-04-17 16:06:37.994093+02
9	auth	0007_alter_validators_add_error_messages	2022-04-17 16:06:37.999125+02
10	auth	0008_alter_user_username_max_length	2022-04-17 16:06:38.004089+02
11	auth	0009_alter_user_last_name_max_length	2022-04-17 16:06:38.00809+02
12	auth	0010_alter_group_name_max_length	2022-04-17 16:06:38.015091+02
13	auth	0011_update_proxy_permissions	2022-04-17 16:06:38.02009+02
14	auth	0012_alter_user_first_name_max_length	2022-04-17 16:06:38.025424+02
15	varasto	0001_initial	2022-04-17 16:06:38.245458+02
16	admin	0001_initial	2022-04-17 16:06:38.284818+02
17	admin	0002_logentry_remove_auto_add	2022-04-17 16:06:38.294807+02
18	admin	0003_logentry_add_action_flag_choices	2022-04-17 16:06:38.302793+02
19	sessions	0001_initial	2022-04-17 16:06:38.331787+02
20	varasto	0002_alter_customuser_role	2022-04-17 16:06:38.339786+02
21	varasto	0003_staff_event_amount_alter_customuser_photo_and_more	2022-04-17 16:06:38.483786+02
22	varasto	0004_alter_customuser_role	2022-04-17 16:06:38.498787+02
23	varasto	0005_customuser_group	2022-04-17 16:06:38.506828+02
24	varasto	0006_rental_event_estimated_date_and_more	2022-04-17 16:06:38.542788+02
25	varasto	0007_alter_rental_event_start_date	2022-04-17 16:06:38.552788+02
26	varasto	0008_alter_customuser_role_alter_goods_brand_and_more	2022-04-17 16:24:17.001494+02
27	varasto	0009_alter_goods_cost_centre_alter_goods_invoice_number_and_more	2022-05-03 17:56:06.763281+02
28	varasto	0010_alter_rental_event_start_date	2022-05-03 17:56:06.778281+02
29	varasto	0011_staff_event_event_date_alter_rental_event_start_date	2022-05-09 12:01:37.812975+02
30	varasto	0012_alter_rental_event_start_date_and_more	2022-05-09 16:17:24.407449+02
31	varasto	0013_remove_storage_place_storage_name_and_more	2022-05-09 16:47:17.122174+02
32	varasto	0014_remove_storage_place_amount_and_more	2022-05-09 16:52:25.943232+02
33	varasto	0015_goods_ean_alter_rental_event_start_date	2022-05-10 09:53:27.162678+02
34	varasto	0016_goods_amount_goods_units_and_more	2022-05-10 09:59:45.716679+02
35	varasto	0017_alter_goods_ean_alter_rental_event_start_date	2022-05-10 10:00:37.189681+02
36	varasto	0018_alter_goods_ean_alter_rental_event_start_date	2022-05-10 10:23:13.449083+02
37	varasto	0019_alter_goods_amount_alter_goods_ean_alter_goods_units_and_more	2022-05-10 11:03:45.495206+02
38	varasto	0020_alter_rental_event_start_date	2022-05-10 11:27:59.865868+02
39	varasto	0021_rename_package_goods_pack_and_more	2022-05-10 12:09:29.732702+02
40	varasto	0022_alter_goods_ean_alter_rental_event_start_date	2022-05-10 12:16:09.581671+02
41	varasto	0023_remove_staff_event_amount_and_more	2022-05-10 12:45:44.668471+02
42	varasto	0024_alter_rental_event_start_date_alter_staff_event_item_and_more	2022-05-10 13:05:11.665731+02
43	varasto	0025_alter_goods_amount_alter_goods_units_and_more	2022-05-11 07:35:10.148212+02
44	varasto	0026_alter_category_cat_name_and_more	2022-05-11 10:46:51.085178+02
45	varasto	0027_goods_item_status_alter_rental_event_start_date	2022-05-16 07:44:37.738512+02
46	varasto	0028_alter_customuser_role_alter_rental_event_start_date	2022-05-18 10:06:50.310074+02
47	varasto	0029_storage_name_storage_code_and_more	2022-06-21 10:49:50.118369+02
48	varasto	0030_customuser_storge_alter_rental_event_start_date	2022-06-21 11:05:06.999638+02
49	varasto	0031_alter_customuser_storge_and_more	2022-06-21 11:10:35.924507+02
50	varasto	0032_rename_storge_customuser_storage_and_more	2022-06-21 11:37:42.522453+02
51	varasto	0033_goods_storage_place_alter_rental_event_start_date	2022-09-13 09:36:10.384943+02
52	varasto	0034_alter_goods_item_description_and_more	2022-09-19 10:52:48.145788+02
53	varasto	0035_varasto_settings_alter_rental_event_start_date	2022-09-19 19:26:44.488171+02
54	varasto	0036_rename_varasto_settings_settings_and_more	2022-09-19 19:27:50.810393+02
55	varasto	0037_rental_event_amount_alter_rental_event_start_date	2022-09-25 10:02:32.563194+02
56	varasto	0038_alter_rental_event_start_date	2022-09-25 10:06:19.370192+02
57	varasto	0039_alter_rental_event_storage	2022-09-29 09:29:42.857944+02
58	varasto	0040_alter_goods_picture	2022-10-13 11:12:19.63854+02
59	varasto	0041_alter_goods_brand_alter_goods_picture	2022-10-27 14:57:06.362058+02
60	varasto	0042_alter_goods_amount_alter_goods_ean_alter_goods_units	2022-11-03 09:36:23.597469+01
61	varasto	0043_alter_goods_pack	2022-11-03 10:05:35.427637+01
62	varasto	0044_rename_pack_goods_contents	2022-11-19 20:20:50.692805+01
63	varasto	0045_units	2022-11-19 20:20:50.720786+01
64	varasto	0046_rental_event_contents_rental_event_units_and_more	2022-11-19 20:39:29.781804+01
65	varasto	0047_alter_units_unit	2022-11-19 20:45:56.45688+01
66	varasto	0048_goods_unit	2022-11-24 12:28:59.083555+01
67	varasto	0049_alter_goods_unit	2022-11-24 12:34:04.100076+01
68	varasto	0050_rename_unit_units_unit_name_alter_goods_unit	2022-11-24 12:38:48.344458+01
69	varasto	0051_alter_goods_unit	2022-11-24 12:44:07.030774+01
70	varasto	0052_alter_goods_unit	2022-11-24 12:45:05.657964+01
71	varasto	0053_alter_rental_event_units_alter_units_unit_name	2022-11-24 13:23:59.345001+01
72	varasto	0054_goods_amount_x_units	2022-11-25 11:06:34.076039+01
73	varasto	0055_rename_amount_x_units_goods_amount_x_contents	2022-11-25 11:12:28.478365+01
74	varasto	0056_alter_goods_cost_centre_alter_goods_ean	2022-11-25 19:23:39.930249+01
75	varasto	0057_alter_goods_brand	2022-11-25 19:31:27.088066+01
76	varasto	0058_alter_goods_cost_centre	2022-11-25 19:33:14.811598+01
77	varasto	0059_rental_event_returned	2022-11-30 13:44:07.967898+01
78	varasto	0060_alter_rental_event_returned	2022-11-30 14:24:54.993481+01
79	varasto	0061_remove_goods_units	2022-12-15 10:44:59.262238+01
80	varasto	0062_staff_audit_delete_staff_event	2023-01-21 11:02:49.359296+01
81	varasto	0063_alter_staff_audit_from_storage_and_more	2023-01-21 19:45:19.072933+01
82	varasto	0064_alter_staff_audit_staff	2023-01-21 20:02:19.707202+01
83	varasto	0065_alter_staff_audit_item_alter_staff_audit_person_and_more	2023-01-21 20:05:17.745642+01
84	varasto	0066_alter_settings_set_name_alter_settings_set_value	2023-01-27 10:53:44.047424+01
85	varasto	0067_alter_customuser_photo	2023-01-29 11:21:57.541533+01
86	varasto	0068_remove_storage_name_storage_place	2023-01-29 19:37:13.135023+01
87	varasto	0069_settings_customuser	2023-01-30 19:16:09.494043+01
88	varasto	0070_settings_label_and_more	2023-02-09 08:53:18.266519+01
89	varasto	0071_settings_customuser_storage	2023-02-09 19:29:38.348973+01
90	varasto	0072_alter_settings_customuser_user	2023-02-09 19:38:15.916184+01
91	varasto	0073_alter_customuser_phone	2023-02-17 12:01:36.757302+01
92	varasto	0074_customuser_is_storage_staff	2023-03-03 08:22:48.695975+01
93	varasto	0075_remove_goods_item_status_remove_goods_reg_number	2023-03-06 12:11:34.469811+01
94	varasto	0076_alter_rental_event_item_alter_rental_event_renter_and_more	2023-03-10 13:39:04.267289+01
95	varasto	0077_alter_storage_name_storage_code	2023-03-21 20:23:29.759576+01
96	varasto	0078_alter_goods_storage_alter_goods_unit	2023-03-21 20:23:29.782684+01
97	varasto	0079_alter_customuser_storage	2023-03-21 20:23:29.793988+01
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
an1aw8ehbe447klaqawsxiefrrb13fwq	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1ndCKa:rgAgq2FKNhz1BFXmamA5M9wigyMaSnBDB-5rWzFjm9Y	2022-04-23 13:44:52.490145+02
nbyfnv0cq093iyq0vahr48p87bs8xw62	e30:1ndpzb:4Ty7DjyxMK-jqNfB6IH1Aji-5aISneaKZaOyzuj65yY	2022-04-25 08:05:51.269606+02
i83fymnw2krdh37odlp9adh1kdlp6261	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndrPA:js_Wb8xuZRoq0DzBqTr1uV6zWk3mdEsSZGzo60CwcFk	2022-04-25 09:36:20.249+02
qswxsxxe7cd95y1cwiwt9mjia80g8b8f	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndsEL:1MszunbYieaWehqqZHmuqFWtiBx2ofwd6UVKLAGul_8	2022-04-25 10:29:13.013971+02
dumhzwxagfmjeycquopki6t867jnm709	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndsNU:1mYzQoUQyZZiOxJngjNHA0ejjVPAguvmVINbK5S4lSU	2022-04-25 10:38:40.650759+02
nvitm8r76wodpk9hcnrkxtcdsbxmdfd5	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndsf5:YycJ1SVn5xRpAhQLbj-LIUiIhWTKH2cts5KhfJ1hf0g	2022-04-25 10:56:51.619246+02
qzce3iqgxmqk4kzdj0gqd6q6dru4r7do	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nduaK:koh67xCxk7l2O0quqyKIoJcvF7K8Z19FWW2iFEcBRLY	2022-04-25 13:00:04.52989+02
yz5cwx758k2tbpektfuhl5xs2y1b9vpc	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndulz:Dm5du8Gl0tnJgDCQnpNjWEvg3ANKuU3m-p5ZcSsce9Q	2022-04-25 13:12:07.944885+02
4f23rzb4ghbqy6rd5mu3jvdb3y7irqyd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ndw4x:9CQNEw0YR9czcrYpiseSF75odp6Vl7phxpbYx5kqaDg	2022-04-25 14:35:47.269094+02
vsocbrmeswmfdikp0njnqun5ci26weh2	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1ndyAc:KIag2WJeq1kymZjujql1qFmxXYtOo0A_Q2LIdhT2a_I	2022-04-25 16:49:46.884001+02
7e4n3fzzkfeeos7f6xxbt7m62agtx3k7	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1ndyBN:m4o5uK08y6sH2YFXEaaQLb8wN0DQ3TaYzS2msC8CL4Y	2022-04-25 16:50:33.29629+02
z2b90z2izpw3s3c6qp7uddivx3cmnrml	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neAT8:aCN2MGyc0hP4DVfYU5boTIwqtknburq8DlMlr0PHXGA	2022-04-26 05:57:42.831482+02
w7t8oq2zvuiw78g7avm5po3qofk9qdje	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neAt8:Ocx-6WPFWLdQsfDwJ5qJJdpFVD9T50AR4iBD0wKEAOI	2022-04-26 06:24:34.9298+02
trld4ur43izfd87jb218e1ofabgqra6z	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neBiV:6zPEu-EfwcG4MaGOAJBpgF1_fSmKoA8LgNYAmS-ql6M	2022-04-26 07:17:39.003185+02
oz0tbk17fbrzfcxsq29bzeeni1uheuy8	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neBj8:87TVBFmfz-Ez72vaE011cPnj6uISIuGtrXN3ZBj2xyQ	2022-04-26 07:18:18.760181+02
2dl4d4a2q1oz4eu4hdetgt6t3oyl5rmx	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neDDT:NMSEW9QXlBYwVcZyd9pC5d0mby6AyUpYdgNGrcK5pmk	2022-04-26 08:53:43.616672+02
uuooy3jrt3diu3g0hwcid3h4j4tmfieu	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neDPo:VvClTcBqkLJKvOeyUdRcRDgURUQfKB9z8N1xYDW02S4	2022-04-26 09:06:28.704531+02
dosk3zf0dm6pkha0wecu2m2eltezvcox	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neVi4:uLknYyIGPKzUNpyPbhzqKZkEdlor738cLB__jzkX8tg	2022-04-27 04:38:32.567774+02
93h1pr7tidajr8zm37yr59g8dtapy6b5	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neeln:31sZFk1XKCGLFkL7sRKN-gUXYGd7PzxxaDWIDPpr0XM	2022-04-27 14:18:59.27174+02
vlm9473cnk4v5alc2xlhrc060d89yo3g	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1negqK:1FROnahuLloJ-nBl8illuMdNp6O1AQ8cazW5kpZgyEA	2022-04-27 16:31:48.407033+02
tspyc8p1xnym3g1ymebho7oasuajj00v	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nehIY:AbrFvYnNDK_quGcuDovAfOvdly0A5nyDRdqXAPn77RE	2022-04-27 17:00:58.743391+02
8qw8cl4ae323sporxphm0mf8xqc0yvvp	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nesj4:WowXuWKBv8m6Wyk5WJsmb7GlP7hpDGvQnpfQ7IG0ScA	2022-04-28 05:13:06.481133+02
ts1k1t134agxemclnxlnj9zk0i4fr0bg	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1neuDb:CFVC3skg_siYCH_41XNAKy7V7crcza0qrs0TYxWUt68	2022-04-28 06:48:43.74701+02
48kky3hrl08wcoxhwtbq9pemjyy7dtas	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ng5qX:-wl_Rb0OKyRuF6VD0-_V-Y2YfOFFEvmIbOjak2TqcA4	2022-05-01 16:25:49.497895+02
1i98aemfo3x3ytvnlx7nrbczcxaysmi9	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ngh8U:5pr3QcAEbbBRkh1Aydo_7ZUuKzYVz8zwy384HiFBC6Y	2022-05-03 08:14:50.100748+02
j1wkvlbhghemfvz131ww8mm6s1k3lagx	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nghtw:zvM_B6Sp-mNyg32XxVry-19-VmCnJcUeeYQ85kA0AUs	2022-05-03 09:03:52.202993+02
qza3p09n6zn5ccx8mhyn8r24fa6huab1	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ngonQ:UhUwW4sh5O2AyC3Bm51SJXNvsjqg6sJquVqdx37aWZw	2022-05-03 16:25:36.756376+02
y1kda51jk5m1ns0gbc92ndc54ae6b39m	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ngoqx:qLVrhT-rmIvqlANypLAPJRYy7cghc_cOoZMCeVFNNmo	2022-05-03 16:29:15.139813+02
2r9i0bllaoziueteq9ln341t81d6veul	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ngosR:v_iSVrLH-ipF4Kb6lghtqTetdMXrdwoXDOgnfLCpt3Q	2022-05-03 16:30:47.84017+02
r27j5tshyztem0qofa7ulam8dz05zghs	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ngpH6:PUldudtkUhmkRLha4-IqCTQXjZNC7_YxX31x_BVTH7Y	2022-05-03 16:56:16.139013+02
hrluiazluujocvifkfs7ihj9jo986tx4	e30:1nh3Oc:SEgzwObvOO3Y8XSVG1QLpQS6j80b0fvDMGRVASwsMt0	2022-05-04 08:00:58.901555+02
km3h8eil8bbxd6o8zvqg3s6d1d28gjob	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nh3P0:uPiqJV5aam1APa3KNCL0AF0zmDZnUe_-UBcbDV6xAFc	2022-05-04 08:01:22.410086+02
ig3f0j50ddt2gmkwvz2ix6cf57g4scar	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nh8G7:82VbQx6k9g2CftN_r4RtON19lOfeV9z_5MXHh2vKUgw	2022-05-04 13:12:31.094971+02
xvuwaobo7g0eyecqf36pqz4wr7bdtxsv	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nhEQX:RcKRbp-q127ppc6qn0ZfGiZKrTsW_03ezXhPMZikCig	2022-05-04 19:47:41.744217+02
o6kdrxmriin9uxria6uaswheua8n2fzu	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nhETc:Kv0vfrK9EXtgN0z5nzLDZc9Y9pL_xhlkW-4g6jIc57U	2022-05-04 19:50:52.937235+02
ydpau5hqane9dcb91bkvotec3cqidz7k	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nhUkl:r0E9mam-xMGNA_FDkViNQ9ISdkZuhBw-c-_ElrLzVOI	2022-05-05 13:13:39.520096+02
ktvpsh0h85tkndixbwx5f3fqtgko99l1	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nhZyB:uxUKLmuhNa033n36YQ1I2zDFvbh5KQgLBOu_q6nPZ0E	2022-05-05 18:47:51.089657+02
uqs6iiyyf3irsx0jmmjb6x5wa2l85czk	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nj1y4:strtzOP24ztol2TG3LRB3MdmUYdcs4iV3Dq-4l6na3s	2022-05-09 18:53:44.205354+02
b2eny89kros3jsav1dewg8yx26o7yw2l	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njDjR:lcDaDewX9sSdkyGzWctmWNmVDudlVHvJbvyTLp5EqAs	2022-05-10 07:27:25.43422+02
qs9zufh1pg7so4jgbc893hjx5srwe58n	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njILz:pfiiwJHXLvLdrP4McbRhpXZ2015uP90fKRqB_nWWMUY	2022-05-10 12:23:31.757562+02
6t1lpzuxxe22f904rfeal5mbcz1enpqi	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njJ9I:0DgB0KAtX47G_oiwoiNR7ZvOI7Wl_WwNOwz0gGL9cn4	2022-05-10 13:14:28.587427+02
p8jbjkf576bbkwrvh5tt9h46xpqz1cfr	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njb0C:aFpJBJkEMJ-uUXR9q1T_ZxtTrGVkLQ3NM_W_VtfnWnc	2022-05-11 08:18:16.4324+02
nw2ie1s28o4v69yolzhxjkiwxeaqrgql	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njbHg:CtsOMtIf0pnPEBPQIbQmnKrtDLkigUz_utlqQ6FSLwg	2022-05-11 08:36:20.202479+02
kkn02blctqf3sw61yh5v4aygfpaztgxv	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njdTC:3GkIRdeJweEJnQ-0Xt52LQlmMa_cKKKeOIpw0BDJjsk	2022-05-11 10:56:22.745806+02
2gufgfutugm8dwfxmyp3fk2nilxlf0rc	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njdcX:rIssWp5XNbNXgSjmihLHAkqgSEQJEy6sY7HBB2KIW4g	2022-05-11 11:06:01.90042+02
9w6asvrgd2p1bo8prp6es41ok16tlp73	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njeMv:qi9XntfsKe7h1dJSwa-plvOaJXNZ4XRmBtL4L8d5_XQ	2022-05-11 11:53:57.966071+02
0az0bxxa3r65fsax4jgcpiv1t6ohe1e3	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njekN:gaiXiDRY9szsbvDRfaxy44W-FTtA8MchibqvVi_z1zo	2022-05-11 12:18:11.417032+02
dmrkjet00cy30whxby4u4peh9gb4t4my	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njfXF:ERA36y-sL0Y9UcVbnL5V7dm9HU3DOKFrDB7Dj0EeX_8	2022-05-11 13:08:41.499048+02
6hv3o75rf9s0ifyyg9xjjaqlgub54aws	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njfsZ:uTPO0qzW4azGpAo_ak9h6ITB6sKbFFUxItVT2lvnFf8	2022-05-11 13:30:43.839732+02
po7l106759vmhfjexvlwwgxutn8bz8f4	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njxAO:odFbHzFnOeKBiE3n9FFpGEdnt1F8uThvx4oZxw4rsa0	2022-05-12 07:58:16.760138+02
j0e25w84v1fjj1mycl91v5whqqck4ivq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1njxDC:HVGx9eTx4rzLazc4juRnVl-fLZthd9roFsw23eorIwM	2022-05-12 08:01:10.866466+02
851dyodxjm7yu06vbggs8dqxjoqbkghl	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nk2eC:DJBg5jj8PtpC8ts14Z0fqa7pLsEBhTvzOsmDH98zJZA	2022-05-12 13:49:24.228992+02
mp2v4wcmnvjwhccns7qarf0mphpmehix	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nk3Eo:Mbfma5HQ8HTp8FgTTmt0DKHJ2AmPibO2MPBwHt_fS2Q	2022-05-12 14:27:14.568+02
smoz5ow4osjik1arbpt2skgu53a9tqtq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nlaG9:zpt00mJ9MX_4bQKwk5MJlb83ddgrlEmmvWnBDsFdUAw	2022-05-16 19:54:57.618242+02
hze4k3vxyysb3c99ki6dzoxedlpk7gxq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nlm7b:XKnM2PLcj64Z9ssG4wr4x3iB5gFKyM6vX9-zBI29TWE	2022-05-17 08:34:55.594323+02
sqf75zpti19ssqzkvl3cuwbqnom22t80	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1noLwB:p8AADDKoMGG5lm1xvqBpi8tDvGz24R8iLW-gC3fyct8	2022-05-24 11:13:47.743205+02
tls0w3ufzgumnx77cm0x4ehb6kz4hylz	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1noSlT:N_WTjBFLAFv0MCGpFx1YCWJlWu1rwnxDTAM9TkzTNuk	2022-05-24 18:31:11.281718+02
quk9tt8yojp9tsoq1ftstwh369yafftd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1noUpV:JqEiTdLt1-wGf0RaA6FDJkMCqWC2b1p-zgMDenqLCWc	2022-05-24 20:43:29.707466+02
tjl8abn4xo4zqmbhhbwl9l4ayy0j5xpp	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nofMO:T_si2FXVtVVXCRKw6zo35bSuLcJQLgK1u98LOrdf1FA	2022-05-25 07:58:08.746543+02
bckdu5rcjsunebzozc7izny2woa8dc2l	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nogAh:2_EpcyEwFaR0QG_pz0WF9FhgYRqzZV7gpEB-GpckWdE	2022-05-25 08:50:07.047698+02
o2hja6ii0t8t4ob6cew1tn6x971iwqts	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nogEs:3G-3-ETQvV2NWPnrJp44d9Y0zYDX_P2930-16uM2h5k	2022-05-25 08:54:26.798509+02
lglur0tru9fenq6wgqfjlu95ux7kb7e7	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nohkq:IE5LgLce4U-Vljzx1FFS2cxb6vzNSHEqlcsJpGTg5co	2022-05-25 10:31:32.166219+02
b5h1r1jz2ctuit98x5hxujlnvv4bfrxy	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nohwI:4tXuixHsRZmJG6yoJLGobccclunrb-7Rv5JLUrWqasE	2022-05-25 10:43:22.729769+02
tucyzn78p2azcrn2kn4suv9pqzextt0o	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1noq9c:xYpJ2pSB8p-DgVmy4-W9t07513zzb712i7GKqMe1Yqo	2022-05-25 19:29:40.454705+02
eqdknsvmt8fakd7o0xbqwqd17ddbjetj	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1np5uR:DjP6twVagXiK_FJfF1JrGmGG7O63cdIUE8jyP-uatKY	2022-05-26 12:19:03.515337+02
zzrz9pf7vgt3fl9iw4f61b4imtpqqj3k	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqqYb:nlJfwskvXb9Fos84SUjcrcOroGhVEkBYLhbqtX73eaM	2022-05-31 08:19:45.015423+02
q07t6f6mbke39ndf07ix9mc004kc6thz	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqsJo:h8rH35Kse79DJZYmBZNGNIfToCq1NKkmrojslsVsWmg	2022-05-31 10:12:36.889194+02
6hs58s2wos8jxgronlugxwjdph7ccp6u	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqsK4:1gPRM1UBvPCWhElUga-Llq1Zh5oWSUAHpMWZrblAH30	2022-05-31 10:12:52.632497+02
43ktnxi16txuztszf9j4r0lz7750b4ay	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqsOW:sjKTXyo9TpzOABy23bDa71KhazDUrWfrxFSAwBKc-Rk	2022-05-31 10:17:28.650656+02
p7honf8jp6loeh8x4vyg6ghrbeaophhl	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqseB:bBhrR3goX_TtLbqPw8Fh3J4EKwN0NcPznsYh0zCIz9Y	2022-05-31 10:33:39.654919+02
671sve9s2z8ctyziuflooimykalme25l	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqshh:vR_Hra0IpeqmSoUTCexpSYSlLoszQ0aKauZmXy5y5uM	2022-05-31 10:37:17.097302+02
s74wlq79iiswtqp7xqyislap5udwxixj	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nquhz:RpicaoROpTUni-afr_CPDRZNJi-aH-xbbnZQw_Lvzt8	2022-05-31 12:45:43.370537+02
z9un6yeovur0xhpl4egzlzn65s56x0p5	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nqvkS:4zhGXinryS0pN-u4RQxLykcbp_KaPo0KXNdpB0c9MAY	2022-05-31 13:52:20.645385+02
5k9g8gh3ulk3wil04v9rlvrf1fgoodws	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nr06d:dqsnkPlvJs8W9gCa43zsDHIZHxPCyMqvox6Pfa7S6YA	2022-05-31 18:31:31.598091+02
qaocc6k00j40si8275iawcehd6f5azbl	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nr0fg:v_UrVyoc7hTJncCEigdVNesYsvMp3OHukeGawVtaEDo	2022-05-31 19:07:44.342483+02
zhhdethfryiu1p8kxbt3dk99q52bp6rw	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nr0mx:7ws1mgAd-BgVujd_SVtsVQxCaaMjCoCnT1Kj5WZX-js	2022-05-31 19:15:15.832224+02
wsr7d8jkz9csoi384lqsmnqy2tzglwnb	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrEoW:-DPgwgbHRGWti4OZCMUpoTyvNOTRzln0Et0ODvhF-hg	2022-06-01 10:13:48.817144+02
wdwkvoe2369bpmcqbwnld0thqtdjov1y	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrFpf:a0JllYJPphv7hIZ3UQVYCroMHBFTQj6IzT8tvSUIXi0	2022-06-01 11:19:03.626863+02
sk5xk7408636pnodb5tjsh64l8fmwfnv	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrFt9:AKTmSISkH8Hr1i71Gz4Q1kUTb4Dk5653MLlmVg6NFrQ	2022-06-01 11:22:39.955749+02
618ehafhvlltal3omh07d2ja56vqijxj	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrFw5:RBVXNvzKLF54Mzfw4NKmVCYHw4JeH75kK838m8Ijy-c	2022-06-01 11:25:41.862527+02
cuywkb76ldrads0wd8h1unrgghznfxtx	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pZ6Ho:I_JRab8gAxAZQlKK0uKIqoj5bP-rCvY_LNnmPWpLH2M	2023-03-20 09:33:36.377782+01
y04fin8z1378zytunjlsiyogmbta8xpx	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrFyj:xug_Ci_ZrO8qU8Evbvj314mF44IfBuANnnufJ8IBauQ	2022-06-01 11:28:25.431768+02
bbpq61mpxiyd5ukhjwc908044j2f4l59	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrG3e:nH6GThCKGjjGoGKip1tdzNE5p-BGX5WDOoRi_uAljuc	2022-06-01 11:33:30.829504+02
gidvqi5pvg5iydqhouq4cpmkb9p6h0g4	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrGIR:nHW6hz8bahazgCx2XX24IvU__ptp4kh5dJNbT5-aBk0	2022-06-01 11:48:47.650045+02
7gp3gul8za7f7ol848z3v5nbtf2f84df	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrGMN:BNj-aS4szLstefq7zgmijFmNT-xySarDHyNcSnDPjeI	2022-06-01 11:52:51.573283+02
5s8xlkw3478yod4nr3f2kbwjxaorxucq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrHqc:IA0hPKA4rlPoE0mkPpvSliUVbpqcOzY97DtaPHy-y2E	2022-06-01 13:28:10.062263+02
hniavvw389hrkdg9b1pmrvodyvrrctxh	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrZaX:ml3AVsyRueSNPCd3_PqeYJ_CVF9X0ktpxGYmeyyWGb4	2022-06-02 08:24:45.30044+02
hhbcr7u1fi3erzxii7z5e34gpx6cx160	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nrawW:eI-M3KtV6bQgoxlrkfbmEfETAi2m9LTdKzrgoGOsD-Y	2022-06-02 09:51:32.188592+02
l0koh9r4vggrxh2ryrv85gn3mlj9n019	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1nzBZU:fA2Y87uqdk6Nkxalp0DS-InKzTKkv8mCgTNA_woszro	2022-06-23 08:23:08.683157+02
hey4mgkhhv2nfbstagyj7qpzapp5jjcr	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1o3aKs:r6rc0xMhSbhUS0cZIQq1M845AJbp9s4Bc4qQ43yGZQY	2022-07-05 11:38:14.758292+02
xyuv6swaynq846gfmwv0gxycwu7ndp04	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1o3u4Q:CVYJjLg__aADsi7_JV1WV-i6qm7Q0n2Fd6ocCEe-E-Y	2022-07-06 08:42:34.270418+02
15ykuo9z4res1geclhiogpgxh3ygjy2x	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1o8l1b:BF4l9CsjMtQt2S28Evh0Q5TPp8X_JYjRf0O5ErKI_4s	2022-07-19 18:03:43.462629+02
2r17scqp9otddfrss1smdmwj9pwn72oo	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1o8M88:NpS0ODPWQctzbN4Xj5uKw2MCR9yrzPQ8iN28Pp5inCc	2022-07-18 15:28:48.173471+02
p39ws6uvdmznof3hdx2bja5swmh1dv0e	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1o8MFa:InKH6qaoHnrxpIajvIviJv7MVNqMESbC229_qlmSoZw	2022-07-18 15:36:30.503173+02
yeyd7ngtp66e09xbwlnjm1amvc05yb1p	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oEP4w:vFieTHssJVpVCfR2Z34wmq46va0kCs9pnAZIE7HiV88	2022-08-04 07:50:30.132124+02
6fdmdv2hl0uvoq6r8a6pxhd00wrwxcq4	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oERKN:dtsxRuMvelTR8TqP3HGceb4k8GILBcMLAXS-7IC8qvY	2022-08-04 10:14:35.31339+02
2k7ibxsr6q3al46jen85yjvrq1ii8vcy	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oTHhw:ef7Alu5N2sk1qXj4zhyo-HG37_8jRieJyXnqshBM8B0	2022-09-14 09:00:16.576524+02
yhbrsywi8k0upztnju33na9hwdckd5qd	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYMdf:8yTvBhEfrWLZrhuLumJSvI6LlVPWACKZhus57hewWME	2022-09-28 09:16:51.751627+02
7o0ad53sm8plqlx3axfil6vm1kmrvmoj	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYNj1:PLDNVSiLmCtQyucMFtsTGBrmKV-2blSOlprjsW9TUpo	2022-09-28 10:26:27.135937+02
qsvd9f0prfhzmuzthkkjklilauaiitd8	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1oYO45:xGvQZhNDIEunzCcl3B5D1gczcLElRX9DdRjFOuvb-nU	2022-09-28 10:48:13.480193+02
s80uob0ovr3gvp09ryo5rvm0lkxhtxab	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYPCp:XIXOaa7HzVAD-ASO9ijlWq0Qa7Zo2wk0voACdSAppKw	2022-09-28 12:01:19.884452+02
b868bi2b86isueq9gwmdyfhxv49g7gpa	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYPUZ:JJ0deKEtqh5PXWz6mNXhhtqzSLZnDvgdmYzXnbWryec	2022-09-28 12:19:39.035215+02
a4rah0pkwmgl9olm5xzg7wzdu6wt99y2	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYPc2:j-yZwz_0Boj6IivRAe4Px98ytFvFb9fos_jGks89Vc8	2022-09-28 12:27:22.045468+02
0dktodlqmfy6txn0f7ol6csqw4hjqvkc	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYPvc:Ua8DY3aFgBkeFPJsAS9pUp76HJcTnuxG9N1rR7i7Dec	2022-09-28 12:47:36.863875+02
to9vrjfazfdo86mqjm4kzreqcqw9zunq	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYQMV:eYU8fmRy7Kqmg0uI1wgOLUzPoVtFDRrPQpa-VRFZUwo	2022-09-28 13:15:23.095733+02
v99dvk6zcymlp7ywrmd65ffghjgvlvyo	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1oYj7H:4dUkk4rJ6wsBgGywrlaXhrY_cMlGtJVYJdGR5xaTlxM	2022-09-29 09:16:55.465305+02
vkkl0letsruxlkadclphqlbjvj5p8t0h	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1odCgr:DGfxjxFIAVvHenF6apvP8tJcumC-r10xXNuK9xBA3qA	2022-10-11 17:40:09.197936+02
skd02z55cxv52ojtx7ikxxgyvt0iardp	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1odCq9:TvGJlaW8J6rxX2Yg1CtVjgJelanGobWjR7eqEZao328	2022-10-11 17:49:45.602483+02
k94l5ofbztc3140j5v8mm1do4f5vj7e9	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1odCuN:0Lf4qZxlERkwge_AvK8nQtrv4wcMxgM0A08Bzn1ZQkQ	2022-10-11 17:54:07.76352+02
dd5gnycj9v31mio1ey4jmg72zivqonjl	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYjo7:R-Olo1fN8ndtsSb5OOaOTXotqh8RRfCRscFtNtHdsDE	2022-09-29 10:01:11.341832+02
6f6k3eztcsyncne380txtzd9k87bz8qt	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYm2S:WfERMTJa-bKj8xXChqzcpdPoOJ0qtp9DbCeN19B-HTI	2022-09-29 12:24:08.958542+02
95nhnpvm13w90gp72f2zj9r60m4xzone	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1oYm8a:kbK6-0DTDSfDzKYTmL-weV3LuzjKB2Ykqbo6QQ7OT2A	2022-09-29 12:30:28.139903+02
x1kybzs9kownhxjd0vutl8mp824ev36r	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1odp6I:AipYBmpipr5tBzopheG82u71zJwUZB8vrnGTEHneO8k	2022-10-13 10:40:58.583482+02
f4bciysyluu68uus8nip75ifcql45gj6	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ofIoj:WdwWWDM762MWakv75_Dd8k-3S_IDz9Cw45YwfV1eWrE	2022-10-17 12:36:57.091436+02
87lpb1ud6829tytt3hatg7a4a78qgxgu	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1oiznj:5oEAoxCZsdGs7Xnefee9rLUOZmTJBzVqX6-VGhxesqc	2022-10-27 17:07:11.39653+02
h312hzmottrldemue4gef3lcz72o9lez	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ojEtG:jRBOX7S9sMcciV_oGA4Jqk_tskjL7SKQY02xXZFX-fw	2022-10-28 09:13:54.04131+02
yr7wuvzrf6t133n1gmt33mks5l1bhpys	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1onyYs:sgwDWubLr4Mq7YafVty9Zh2OLWtgDtTQ9_YfozUaRG8	2022-11-10 09:48:26.04172+01
cgnhse5ov8mxgptjtupqyqs4joxe9vds	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1oqCga:gH-dg3nYPoxxXpRLZGfifG45xtn6SW9Ft40orsSMSrk	2022-11-16 13:17:36.64847+01
ju0or0fepebqyqyip5d8oo7ed6i7ng80	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ot3FX:cyWH_ORXEWfZioMvDj4heVxHuC1yhn8SOob7JabncpU	2022-11-24 09:49:27.398785+01
9eeup4z1zypt2vfs61vhm27eprrvashg	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1ozM2P:_nGpi9SM2ABX_uW7DG0oUF7LaJeGDsRW_MsvZuMExds	2022-12-11 19:05:57.007843+01
qf70m91cyfvb26ol8ik54ptxx9x1xee9	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p2BVA:qrbovCFw485TCFGQwwcGguP04-9ZVDjRJb2BGCouEv8	2022-12-19 14:27:20.923612+01
c2lgylddella90qwhstzieg2kvs58inh	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p2HpF:dDngLTsHnXjgqm9ntgxsIlveVu1u83iMq9hXIygVIHY	2022-12-19 21:12:29.437791+01
o7quu0wcpalk320l01tgcfgudq2oe3gd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p5Tpb:-0BYsNu6urw5kxngR8Nyip9wflEe5BPkhuNPrajWmfY	2022-12-28 16:38:03.118965+01
l05r12nvfjvp1wdye7xefuty9pk0n1p0	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p5kCv:ZHxw27kZCoG16VZuioVwBD-lvqyEWY-f9DYce4zeXF4	2022-12-29 10:07:13.645138+01
3ify2a838klywke46bp3qtaivgnt3efd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p5opB:kOmBz9Rqqiobbw_oAgrhnald2O_om-lk1TOHVZNnfug	2022-12-29 15:03:01.527514+01
0uihokskgat4dyg1cbja6yapptzxtydg	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p7WvC:JINi4LxC6v3Qbt5GaHOWFiXtaC84bH_ZzDHfCYk_tec	2023-01-03 08:20:18.051796+01
acu5zv27r6ymh9t99kyktk9oru0otyse	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p7YZH:WPWtl69IFegOK78xat8INk40F8zB9_5LVmhBcSbtSbM	2023-01-03 10:05:47.050327+01
hojcwjz3zy652miola5z8brurch3kfdm	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p7Yb7:rVMXAYsC5JVUzIOkLiq82LCzfjC1YzJwW5FHVOym-CY	2023-01-03 10:07:41.93472+01
eq4g4kedojglw8bq3ghzqc8c4nnnvhx8	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1p7Ymw:hd-OKWdlUz0O1lzvdqIA4HBWbwWP2oUnKBEz07zzoWM	2023-01-03 10:19:54.19567+01
9wuw20wvv91d9h80539jo3hlmelbnd3n	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pGlk6:geVwT-c4sgjrcvV4x72-IUnUzcwbxVYW_6yI6pLA3Ow	2023-01-28 19:59:02.946881+01
wc5qaq5jp3spr2lbelwy35d0f1z1bgkd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pZ7S1:oBD49BYrC3Om-XKUKB2Vu59Ft52BxSpbYzH-GP7bBj8	2023-03-20 10:48:13.699726+01
yu2h4fd9m474njyjc1mhnhsa388gnsrj	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pIQww:mg--pWUy5N2nxeN6qwnObZFZBv97IR6FfiHmrAwNO1I	2023-02-02 10:11:10.114842+01
x4drmdacinpgu4e2a8ev5pagvoe6332x	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pJqui:Y_clGNIwUDJAoy99YD2lvJM48Az_taxr6Y8TX3Ifx5w	2023-02-06 08:06:44.461649+01
fjwo9nv5vb4ul5feqpr63ysy4gf1t1l0	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pbfvz:tzkfBPSGi0pcqDVaCL7t_vcfWVXBgXxTKJOPaxyZMQU	2023-03-27 13:01:43.358524+02
f1mgfg8sl39dtr6jro4kfwvm70350ezj	.eJxVjDkOwjAUBe_iGlnevhdK-pzB8vKNA8iW4qRC3J1ESgHtzLz3Jj5sa_XbwMXPmVwJl-TyC2NIT2yHyY_Q7p2m3tZljvRI6GkHnXrG1-1s_w5qGHVfW2VRGyWAOUCtkgMe0TJbBDdGWBQ6F-5YRiZkiJopAyihSCt2YiKQzxfUZDbF:1pHUld:4lkx_55qa4bUDoc9zGQyap7ey3qUxAdfNAeDa5Xr6iU	2023-01-30 20:03:37.399004+01
mhx4fv9jmdvpvixzgexpo8t8s1x7jfs9	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pHqq5:jIWGcffKSz97PwUPOFdOtW1EFQgwt8zSLmmLKk0Rfi8	2023-01-31 19:37:41.565989+01
r3xcc7m2tvwv72t4fgz1a7582k7knx2u	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLIXc:iZizt2ndvsXktFb2Kn9naOen9syHQp03TRniqy89234	2023-02-10 07:48:52.023761+01
o1ck4m6uffyzu58w39orrh1kcd1tpz7t	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLOXw:_pzOo_HVBH3iPjIGQnesW01rVBSFfLteylPcsqCgNDQ	2023-02-10 14:13:36.405636+01
9xcenl0ofx39oayt4oz6oezevvzuyf68	.eJxVjEsOAiEQBe_C2hBEPo1L956BNN0gowaSYWZlvLtOMgvdvqp6LxFxXWpcR57jxOIsnDj8bgnpkdsG-I7t1iX1tsxTkpsidzrktXN-Xnb376DiqN-a0BrF4BQV5gCUAWwh7RG8sYmNp6JVAa8o0BF84eyYk7XaGxVUPon3BwGpOFI:1peBvK:KISKc7opaTHX11SyGW7VLuhJ8CrgCeKUtahHFNaxuKA	2023-04-03 11:35:26.105342+02
f5usjgtksluetms2ba2s4uo0wngq7rbp	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peCdS:L0EPA0U8CCZQntJ2sYIi_Oqd2ZyH0jB_qPojQOeZlL0	2023-04-03 12:21:02.867355+02
wy40yajs2vzb0yzr7aez1np63gsk20p0	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peDCo:VIZ3BjcBxLR1CGkZ9by1-S4ESFDeyMgswXsl6ort8TI	2023-04-03 12:57:34.312706+02
1u1aafp3tqrdncuf3s0z2l4dyckc8co4	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pVeuL:y_g7cJkA8BQaJWorQIeWrC1huZumIX7uHhBEMiV3VZk	2023-03-10 21:43:09.978909+01
kx22rrfy7ajcjkc6q1g2kgsw1ufzo2zf	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pW122:7k320jADXNx0I0Z4gdzx4mYhqPLbfZtw-j6GmcsZ6Yg	2023-03-11 21:20:34.012953+01
fm96xr6u2bjsai4cs8q3qpoqo89hkmg9	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pXiBm:fQDPkNbvHCskDF0TneH_BBeJ4-Rae-Lg1zN0QcbWJXU	2023-03-16 13:37:38.552901+01
beszof5pnxz2e50llbtyyrivowcfw1jp	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLj9E:2q0NvG5RyO2AgFzW-14nDMu7wW3BkPLSkGXm7AM4CvE	2023-02-11 12:13:28.438752+01
3p2wdqnyjn2ix4v5fyvzk196yh5fkls1	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pZ7jw:GYBa4I8w956XFb1zKczysWOqnbhIwt_2xDSvGnorx4I	2023-03-20 11:06:44.698513+01
mh8vu0i7tv8kd6kiew4x76go6og5exr8	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pbdBD:CiAiFyAdmWpZdXtHydPEozIl7KRJcbtWrh4JuAdDaZo	2023-03-27 10:05:15.868982+02
0r3awdqarwjw6u6y1wcbpa0037ctffam	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pK16U:reYZG25_KMtW6fvRgs0pD8vQQnA_NmEOdGTU0dUg1xs	2023-02-06 18:59:34.737078+01
2660vki7lacnt4pq29nw2yii0xthz19r	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pbjr1:6gLDzx5Iv1VOina6D7wPd8BVXf9otJe_na0Xq4U4tQc	2023-03-27 17:12:51.549138+02
46nsb8d65rf4uwurz1pj6dhsewv54d2d	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pHqz5:ZoSK6kABOCSP3vxUhMOH2HX3oZphTv7bYLa9nTduJrw	2023-01-31 19:46:59.073069+01
41iulgk5jnwq3vjyttlwmsh0d2f97kzq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLOZR:Ez1iNgWUP6EBc-F5lx3SLi5sAqZCvF0fm4qAaGAzrCU	2023-02-10 14:15:09.353078+01
ftmi79wk4ihrrm0v6rjb1ia4kcmcnw70	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pclhp:tpC3h3PMBSSPwhYP93yrJNPY42GCMQcvEJvizc_pJY4	2023-03-30 13:23:37.096307+02
q2sdve0lany38825lo1cj61xyofpf0c2	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peC6D:T0KhuGMVNzsabW6OpvBAUuH2IuxsHfepw5OyuC3CB5I	2023-04-03 11:46:41.87635+02
fj1vn0r2x85sfanrl4qlt5sxtm9x7wl2	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pVz4b:0NbxKBXxodUBne7euOB3M-bfpQQgKtpkM4_lU-aNSEo	2023-03-11 19:15:05.455675+01
bcr602rxvsltx688tqz4ptdtoew1nfst	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peCs1:QrXUjnmqfr1gp3lf4YFLWzMSRpK-dmHhR29OBYJEUBY	2023-04-03 12:36:05.719917+02
ldf8v3hhka7k0um7fyb8zrdewymfp79v	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peDMQ:f0a-4ZXA86uyOqdNsTwwPIudt4ZoPIKqE63GsKQsiCQ	2023-04-03 13:07:30.149495+02
43nvwis1lteefkmyk38v0p8zt0xbo15f	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pZ7oR:Wp0mN4C7WzixOJcmfgH73AMHDXAcGu0GJrf-VVBkZzY	2023-03-20 11:11:23.45193+01
1f2t0wjz49tcg4dncchyadxzx9wj0308	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pJqI0:IhENB30yvIO9D-FBdN-8LeMH17fZA2NyIMwbUZL8uGo	2023-02-06 07:26:44.661737+01
x5ozlmryg40y2gcf99kk11fw1grxzj7w	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pbgsD:7J1pdnl94S0BtQIPhWLOqnk9OzxDpP3jpEZAFpj9_rg	2023-03-27 14:01:53.507985+02
zwp6y7qxwegbcl1radi4pdtgmz710x8y	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pR7lH:ALEZjNv9fHiYenukYKo0xJXEbNr0ppPcyiLrLu0zHiI	2023-02-26 09:31:03.551904+01
kh24v9ot7mgona4e6rihf29gvpfqgl4c	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLUVR:FhamlxrtE-Py3-OkEYj0XKkjEKGp_7eeTfjW3BDQkj0	2023-02-10 20:35:25.78793+01
7pal9wgkfnjk5e3dmm9xyo912azqij50	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pbjs9:gG_iIO9gzc2prPcugREvqZsPKoeb-ZCZOIEcKRlgxPM	2023-03-27 17:14:01.753614+02
gyudqf3aachqbj4mnybm1add62a2upit	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pVzBG:cmcxIJw9sirA6k10mfD2Hp8zCyQG5_fAWJC011LBHog	2023-03-11 19:21:58.337034+01
j2azutmi9i35mxb0g21413gryjvbi9nj	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peAuA:1Rat9iorBRIz0l42qxODc03nyW6mPt8hKX93wASC7yo	2023-04-03 10:30:10.242432+02
6penk9fg0fjohkrxlpyohbpdy7aodulc	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peC6b:7ttsZLxutQj0A01fuCJ-P583-Y-l7bwf5dl304QEbzw	2023-04-03 11:47:05.900394+02
46rcjarvs5d164zsqyicjjv7960k9w04	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peD5w:255TXciCD9lQkktwgZNIomphuADAvgmvKs1OfMdhSk4	2023-04-03 12:50:28.421484+02
y0srsknnyuug1zw4n56y2mt0royibs4r	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pY1w5:Calz4P0kDRBe9orVVuXNYrAZZxVoQjW0wgHbBbx9KXw	2023-03-17 10:42:45.94613+01
cz97vx9m8zyrs7osvvrocy2wf7ylolrt	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pZ6qM:dsVy0oe6HCtJEKLt8WMcYg22OcD-jiAU3viPrvtrhsI	2023-03-20 10:09:18.063547+01
8hdjhtfd2gfonu3x1h74hjev0rsgdo9g	e30:1pNHL6:l_dIZcFqaTk7ntCLFxZn1l1Kph5JEBkT6e91DsPuR74	2023-02-15 18:56:08.046837+01
hd4rddunmcpt6persf9ngyzhgaxbfydv	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pNIjP:urw4s_YEQJSa1CWVE4dl_qGkAQYkstcds3XXLSiwHu0	2023-02-15 20:25:19.561321+01
zfhdf0oit5rmukla4v8raz22rnta7hz9	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pH9Hx:LsbQJLKjP0_9_6idWAzyerocXvgEW37PwbKZ8uQLbzk	2023-01-29 21:07:33.694691+01
f10gry3w5xr8d7xrcnc2uf5dybm601r9	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pH9S4:tOGPg0AIGisqIpzK09Nrg8hRRkKA5bWJQkcpVXbajT0	2023-01-29 21:18:00.968282+01
0tnqdgwkdpk3ek6vvjs7mku90pss4l03	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pH9Uj:gkfeNKNibIeiAuL5jry88lTFFYVJiGEXOkkxoUfCl6Y	2023-01-29 21:20:45.242752+01
ugl82icc8xrwtv9b0f9ii3klcg7zn3tz	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pH9VW:aQE7Rgeushs20Jn-ulXDq2oFfq04gObkdQn_1VBQGtE	2023-01-29 21:21:34.405856+01
qn8r9z2a8dbwijgwsdd169x03uaqwdhj	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pbdq3:JX3wud-DC-hf33ehnFWH5PKM5cdw0faa14vVhKtL4tE	2023-03-27 10:47:27.330847+02
jsxud04sbedj2xlo9w2q9avgje2n8wks	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pH9Wi:5pgHEric1UC1E10RF770d2ECgrP2zxMwp7KH-ZNkSJ0	2023-01-29 21:22:48.376598+01
2rrm7foxablfgrri63vtire01rfp9pa2	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pbgur:Y7Pp_m3v3MY4vNZcxrftoQZ4P5fjgBymGNHtAG0GBvY	2023-03-27 14:04:37.727581+02
wxp0tjhsfc457r39lkobgie5udvpm04t	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pKx4L:zf0zwFf9lEHww97bwcdcZN69RLrGIuDVvr-xdkpGCpc	2023-02-09 08:53:13.788313+01
slqt17hgwl0vtt5ewk6wzorpx8l7heku	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pLKmx:CahgDjH4Na1f5_BWdEITpXLNP9IWypI9kk_GP95Iwf4	2023-02-10 10:12:51.947078+01
r9sxyjlt15w7zq0xmavi9273daot0xtr	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pHr7U:l3Zd5TuqImDNMN1unCprKYcwMt4d8u917WH2evwphVo	2023-01-31 19:55:40.2287+01
2rarycstz2x73dcdk5pz1fq0u3skpxsq	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pR7sT:G26sKV_j8w7vhKbnVExQ7-DSbuDyu4ezk2qqfr0wU6k	2023-02-26 09:38:29.906636+01
iwxg6t6vn2udznih2so02e1x70p8vuid	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pbnPi:HbTVfKnLl9-B1kYIV4r7d553tTkID6krTCyIUZ2XZvw	2023-03-27 21:00:54.132395+02
r35nvey3n14qekyo1au6oys9bw6kuto2	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pSMm4:1FMOOFwvicOQ64fiswBFHAUzbjJ_2VtIzjVHJsJGSjs	2023-03-01 19:45:00.828831+01
zrmhh78oa1iatw30qnwq7iim6t8locsy	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peAzI:Vg7rJhTiN9ugMG1L_lfPVvKNDNqS31hzVzqm2AUUVRg	2023-04-03 10:35:28.60621+02
ny0o0jiln5lnstr4qe52t5a91byil5uj	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peCC9:1JkJVu1BkvgpI7z5mZNQU04eY9G5fsJ32H9xCxaKDqo	2023-04-03 11:52:49.052387+02
8qqhcxzd6wr3wg7wm3me3zcf08y0e67r	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1peDBu:6YeSI-sSaVc72EBUk9o-5mA9HsloZ_cGfY4rFDLxI_A	2023-04-03 12:56:38.890045+02
s3ypq8dg9mjhrjzwebbak1qpyc64ydiv	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pVdeY:UEkw9ScHZblSfHd46-Ayc6ZT1eWXUtHTCWslVTOa594	2023-03-10 20:22:46.814584+01
gyf0cuq34wwq565ktr4hir3ty3s9uzrd	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pVzC3:0a7lB9KO_ToKxO2GaWD7ZVBfNS2AjWr0dSrmiKBoLZA	2023-03-11 19:22:47.328445+01
gad9whuyifwc2bp5zxiqs0lcv6w49b7c	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pesZm:LaPw8E2YI9Bwot0pO_tUCGVASSPRwicWvSFFO25zNIU	2023-04-05 09:08:02.047499+02
k7oj6te6dqvn2ufcn11bcqd7041s1hhk	.eJxVjEEOwiAURO_C2hA-lAIu3fcM5MMHqRpISrsy3t026UKXM-_NvJnHbS1-62nxM7ErA8cuv2XA-Ez1IPTAem88trouc-CHwk_a-dQovW6n-3dQsJd9HWzUYjDZZR1hTIMbIeeQpVJJkAEXQO4ZyaEyJMBaJTVJdKCjpSwF-3wBFpI4Pg:1pX2cA:elfcSvFbCLPm5FmszST4AYb1rMcGdfoofsl0pDMMJGE	2023-03-14 17:14:06.80433+01
ktnydcxylstjjq2z84mtrujdcxwo8xfw	.eJxVjDEOAiEQRe9CbQgYGcDS3jOQYWaQVQPJslsZ766bbKHtf-_9l0q4LjWtQ-Y0sTorUIffLSM9pG2A79huXVNvyzxlvSl6p0NfO8vzsrt_BxVH_dYhwhGQIhJy9o4EIIuLEEhMCcVaDibmk4_oLKIvUUSgGDYMkskX9f4ACXk5RA:1pXdxb:I2lFHZKa59KaAmxWsgq7e-8gKU9Xi3jVm_bJvVbhc78	2023-03-16 09:06:43.215196+01
sqxcduryr7pv0vtml81t3zs8o79h07t7	.eJxVjDsKwzAQBe-iOgjZq2_K9D6D2dXKkZMggWVXIXcPAhcJvOrNMG8x47Hn-Whpm1cWVzGIy-9HGJ-pdMAPLPcqYy37tpLsijxpk1Pl9Lqd7l8gY8s968ZFB48G-tgk0omBVPBBK2Zjg47gjHekoxpGsNY5WCwAGR8QQXy-y4g28Q:1pY22a:v4Cx4i0gBoiQ882_gALwnKJeGdIoaRdeUpaxzRg99pM	2023-03-17 10:49:28.202753+01
ps2eau5m5bscslnx5hmmuqvkqfo8wrds	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pqENw:UaF2vrk7qmtOO8u7WNLr6tTodBgFOpOHt_QEvjbxkss	2023-05-06 16:38:44.139539+02
mdg51snq65ca7ws90n3yzzn5yw3m9zz1	.eJxVjEsOAiEQBe_C2hBEPo1L956BNN0gowaSYWZlvLtOMgvdvqp6LxFxXWpcR57jxOIsnDj8bgnpkdsG-I7t1iX1tsxTkpsidzrktXN-Xnb376DiqN-a0BrF4BQV5gCUAWwh7RG8sYmNp6JVAa8o0BF84eyYk7XaGxVUPon3BwGpOFI:1pqEW0:Zv4Sd2m54WLm3jeevfdP1otItGGFtvVMYwgBep-lFyw	2023-05-06 16:47:04.380637+02
zt1ckb5hfd31dhcwevcyhec9uh66vwh4	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1prDK9:nhqsKGsP2-rmVEj1QhLU6ChPIJr327yca5_QiklsFAY	2023-05-09 09:42:53.518494+02
u9c1h1qavtya553c009193wyzzbqlnhs	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pseB9:evvuWS_MhbWl_7gltETzQOY-T0gBFJ39WbDNBVaBl-w	2023-05-13 08:35:31.315415+02
9st78p25qjqd1k7nizdbsclidvy5wdi4	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pseCc:WX7h9VjjhiILazFSbdyoYlx5e3quEx_7Ux8SyRf3HFo	2023-05-13 08:37:02.940811+02
j4980lg34frh71aprr3ctu6n11h2znti	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pseD9:a4KoYhpUWezzN_jTmllw-faZ2YMudSqtM1LORrBb_6U	2023-05-13 08:37:35.310698+02
6pgqs5k56nm6ravdnefs2zcs3hdrb1jb	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pseDc:B-EveLgKQFa7aABFqyhcH3c3igBGP2wRQB9UfvjBdcg	2023-05-13 08:38:04.05873+02
18t01m0k6rfkg6l3mmiq5wal3o9jkl3y	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1pseEB:v5I5u2zokA7pibP66vii2UuM7MCSEakmvGZFg3BqGTA	2023-05-13 08:38:39.19382+02
nvk0lbs24uygo6l43i0m056jyzddm2il	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1q2Yj2:7UsbbCSXqaFxA4YtJrMTzTZtBRvRCW0ThC_z8fmbc_c	2023-06-09 16:47:28.117548+02
9dakxv3we8dstoladagxobr3nvwk3qzc	.eJxVjTsOwyAQRO9CHSG-a0iZ3mdALKyDkwgkY1dR7h5bcpG0897MvFmI21rC1mkJc2ZXBuzym2FMT6oHyI9Y742nVtdlRn4o_KSdjy3T63a6fwMl9rK3jVFTpugSKu0mMJYsSvIg3JCM0h5JgFACpBE4WJ28zgSk4v6QvLSGfb7ddTed:1q6AHU:RsY6OK9MJ8wQj6pxIydxNX4EeP8J_8HM_8ZL67cep-o	2023-06-19 15:29:56.356755+02
c3ykrn2iilxriipdiilbs1g4xqi9r4yu	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qDW6l:hbi0Zas1RhJVL3QyP88W4Jg_-xDqMnJlWL6li248lGg	2023-07-09 22:13:15.771986+02
wx5e3mufsabhujhichd3ccwgvjww2jp2	.eJxVjEEOgjAQRe_StWlKW2Ycl-49Axk6U4saSCisjHcXEha6fe_9_zYdr0vp1qpzN4i5mGhOv6zn9NRxF_Lg8T7ZNI3LPPR2T-xhq71Noq_r0f4dFK5lWydEIm4YwYsnkkChBQ_BqeSNtSoCeKaoHGNWIofZZWwaDYAiEcznC8oFN0Y:1qE2s1:dkZT1ffuQJUrusHlSOHRCLrrHWbAtz3UL8eHm98_ZGI	2023-07-11 09:12:13.128309+02
a8s09rj1xty95b05vr41dsd0d4omrns1	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qH3tT:2CXIg-KTyF3XCfIlIa4J8taeyj2OzZZmvMlhdYEOHZQ	2023-07-19 16:54:11.123252+02
eqjln5w6un64smcsnlrvze5n7ohjst0k	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qM0DR:MiFEVFbuKXKUxdMd9qPduvNq0O5MuwdRjeawWvmzzUs	2023-08-02 07:59:13.117959+02
omqvvgd7w1edey3sjnnaj4t85xl634r5	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qPnaz:1wT8JB3Isvii0MzDsBLp4IUBTZ5jtkjjsdVAbLSiRa0	2023-08-12 19:19:13.007713+02
y437jxy6j5a36f89901aotsiwkno1ftn	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qaV9L:754Vti1yXc3MBmZUYfmW4PznLxq_1gi0siOBbwor8kI	2023-09-11 07:50:55.913111+02
vx3xdouxduuxa5crt3cazjj0a82w6o6e	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qdojx:P032777etwmjZ9_ifQzzIGz-KpuTQ47Cp3ZmKFw8Tuo	2023-09-20 11:22:25.737906+02
9l78yowv9wrpzwq6nq8xdwa8dnffyqu7	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qfKAB:5Elo0YwmooiWY9YJs_13_MUzQVUBIKV_MtbU-q1srM8	2023-09-24 15:07:43.441372+02
qacizuanr7rlt5edndzzb5fadfks1s6b	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1qnEGt:HTa-uXiuB6uPgXCRJYdLDh88II__ZrQyuq8oyMg8d3U	2023-10-16 10:27:19.447053+02
olvrnezx8kd3vgzqbdb9xy1hh1ri77h6	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1r3M01:Lkc2FqqoQxyVQmzYHWJrTZZ4MPX-6yf06A_Ky-l9mmA	2023-11-29 20:56:33.170666+01
f5qn1mcr2wov6ahui7avz3oujm8e6moy	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1rA2zI:eJMVd0HnZ3iByv1nan-zECGysdHRvvVvBWiFiwzmYAA	2023-12-18 08:03:28.587623+01
jaxveu9poeo6e519m0luv6e26gfu1xb5	.eJxVjEEOgjAQRe_StWlKW2Ycl-49Axk6U4saSCisjHcXEha6fe_9_zYdr0vp1qpzN4i5mGhOv6zn9NRxF_Lg8T7ZNI3LPPR2T-xhq71Noq_r0f4dFK5lWydEIm4YwYsnkkChBQ_BqeSNtSoCeKaoHGNWIofZZWwaDYAiEcznC8oFN0Y:1rCfno:2RRWzrDMWAIdjbx_uL7_yb6Ofx1byZ6bZBhUcVhsjLI	2023-12-25 13:54:28.844204+01
ysgjefgtwm3yagy8m6tdhkeijtbj5b5u	.eJxVjDsOwjAQRO_iGlmbrL-U9DlDtLbXOIAcKU4qxN1JpBTQTDHvzbzFSNtaxq3xMk5JXEXnxeW3DBSfXA-SHlTvs4xzXZcpyEORJ21ymBO_bqf7d1ColX3tTBcd75GzB7CstHYUCLNiC4QhYg-gAQ2gwt4qbTpAp7NnVORdFp8v8K025Q:1rDOCx:ZqmtpzmcFzh2CZMkWD_6gIW7ZvOvetNnLV-cad_id28	2023-12-27 13:19:23.53161+01
svb9uvumovv62rujrvzdzhpvvmb1gyfp	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1rKxum:fotETa0c-Qi2OYY4nj1Adl1j1QoCeq9xkzMBToBBSNc	2024-01-17 10:51:56.0256+01
gnidihteu2jlymcvsl2ui72s5u9ns27u	.eJxVjTsOwyAQRO9CHSG-a0iZ3mdALKyDkwgkY1dR7h5bcpG0897MvFmI21rC1mkJc2ZXBuzym2FMT6oHyI9Y742nVtdlRn4o_KSdjy3T63a6fwMl9rK3jVFTpugSKu0mMJYsSvIg3JCM0h5JgFACpBE4WJ28zgSk4v6QvLSGfb7ddTed:1rh70r:pJqpTIF74qs3N7PEWAyzs7SJErRHxsZUvw315hVTVEo	2024-03-18 13:01:45.606489+01
2j4r8ata6e8egcc7eim2fqoh32kkwz89	.eJxVjTsOwyAQRO9CHSG-a0iZ3mdALKyDkwgkY1dR7h5bcpG0897MvFmI21rC1mkJc2ZXBuzym2FMT6oHyI9Y742nVtdlRn4o_KSdjy3T63a6fwMl9rK3jVFTpugSKu0mMJYsSvIg3JCM0h5JgFACpBE4WJ28zgSk4v6QvLSGfb7ddTed:1rhOse:u9WA_XRC3vx8shAStJN9OSKKrPWeKkYdWbLlBpTYdjE	2024-03-19 08:06:28.420924+01
29t2evc99sav9v2m86suqxexglhqax3a	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1rsnlV:QXQoERl0frZmTIKlb4V9MqAPkIlPtKvbQnEoD4DcN6g	2024-04-19 19:54:13.554711+02
b9cc1vaes6v7zcp2sdjzrllvhbcyi5e5	.eJxVjEEOwiAQRe_C2pAMYTrg0r1nIAMMUjWQlHZlvLs26UK3_733XyrwttawDVnCnNVZoTr9bpHTQ9oO8p3brevU27rMUe-KPujQ157leTncv4PKo37rySRksZC8Sd5xZhYSSyARyIsTjLYgFUfkHAKYiZHBWm8xFhBy6v0B8yM3ww:1sMh5J:MfHNFmceEiKtgju-iafw5gt0PVMm-5VGiPPktoCK2PM	2024-07-11 06:50:13.0773+02
0x54b6wk0tsz6wb0b9s7dwpmb0ngexqr	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1sRTF0:On2TuAH735XSaLTNc_-Yqr5v0vks3znT4FnX29YxbCg	2024-07-24 11:03:58.576262+02
mwz8xew05yowipcyc892w2svrhf0gvad	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1sars5:--znmI--Oha3FV12218AQVQ1Pxr-uofkUIBDxQlQhVw	2024-08-19 09:11:09.057901+02
9pphh632qvu5vsqs36gnldx20vv88965	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1sezEX:gZpclVlhMCQgqpPpCzhhe460lPak-Y1xfSH1nXU0h_w	2024-08-30 17:51:21.853365+02
4o9n8r6y624394gxuslj290cd9eg7nj4	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1tU8K9:dnMaHV_1ZyaQF_B0-qt3fydbC4xMGUaOSwMSlMZhYwQ	2025-01-18 18:52:33.739437+01
az5x7gxszii0fi0axdqq9tdi5rvu3bxp	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1tcqja:nx3ruByDDoUSaZk1jgikXM3KbbZaf_v4EW67LBK__rY	2025-02-11 19:54:50.919652+01
h85sduttk6fw28gv070iuqlj52wrhxj9	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1tlYLb:FEAok6uNeKhuJivbytBSwRcFT-JLrGVuk5MeCX6eKwc	2025-03-07 20:06:03.089088+01
kal2ldgn0zbyawckxfw738mqd7b9378j	.eJxVjEEOwiAQRe_C2pAMYTrg0r1nIAMMUjWQlHZlvLs26UK3_733XyrwttawDVnCnNVZoTr9bpHTQ9oO8p3brevU27rMUe-KPujQ157leTncv4PKo37rySRksZC8Sd5xZhYSSyARyIsTjLYgFUfkHAKYiZHBWm8xFhBy6v0B8yM3ww:1tnmta:zxTjx_zJAaQX3qjWGD-TzcK_gxvi0woolj4Ezanuzsk	2025-03-14 00:02:22.117787+01
xos5lrtlyl5jale1qrghpygdececvw5x	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1txUhQ:VykVi0sFI-zHDsN_yM8Qzgk8ObL-OX_rA6e6aEi1mlE	2025-04-09 19:37:56.397604+02
4wnd5xic7ugbnjho6yi6qhfhdxiqmb7z	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1uACWW:6YTxJmbPfJbZP1qU4_q64jL103DrdjkpgwDlRhTpFFU	2025-05-14 20:51:12.795768+02
bxdu0pik3ad3ozbtfo58wkkpinp2zrtz	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1uJoGI:LSQsI556Jy9R2MMolMcU-G6E2RRSxg3pX_Yu_6Cy5vs	2025-06-10 08:58:10.090301+02
1yysxotjhixkrao5lrlxi5zh4zyebu24	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1ueHhG:b_0ZW2ZzwzzJ7FdlyPNUxYtmcVIhBZrBuSGXwAj9ySQ	2025-08-05 20:26:38.364826+02
biia2d6hzan62kw6zsxj28fpzd8ymrh7	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1uqErn:UB5RHqntDEeuhxz_WYWLJouBVC-w1scWqzGb2EGL5cE	2025-09-07 19:50:55.968593+02
zgz7hkw394buagbh5kxaqjfq1plri0yw	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1vhsaU:KewfvCfPsO7VsolVjS-0zRGLo7sbJUCXsbUfvrbmDXo	2026-02-02 17:58:46.232646+01
vfs5nt32hxwpi0l5qe7zftsdl9mco8at	.eJxVjTsOwyAQRO9CHSG-a0iZ3mdALKyDkwgkY1dR7h5bcpG0897MvFmI21rC1mkJc2ZXBuzym2FMT6oHyI9Y742nVtdlRn4o_KSdjy3T63a6fwMl9rK3jVFTpugSKu0mMJYsSvIg3JCM0h5JgFACpBE4WJ28zgSk4v6QvLSGfb7ddTed:1vhsbA:EwReNNjGLppma32rfJDfoCRGB9tkCUawfyLRlU-lgKs	2026-02-02 17:59:28.466524+01
i8a8pi9dcb55wiuikb1ob0triqy720ix	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1vrGDq:bjjWUozVxttEtw0fZBeafMZfRVuGdwSiPtSrsxJRRQM	2026-02-28 15:02:10.457728+01
kjjua6nad1pl9jsflkxit85ozyozmw3l	.eJxVjEEOwiAQRe_C2pAOUMO4dO8ZCDMMUjWQlHbVeHdt0oVu_3vvbyrEdSlh7TKHKamLAnX63SjyU-oO0iPWe9Pc6jJPpHdFH7TrW0vyuh7u30GJvXxrQm-tc84YOgtIREKGDDgM2YwsAGPCZIiAwGfMCIycBYg8J8nRqvcH4FI4vQ:1vrMRw:94So5MuPriLPLn7QDKOuGlinUYMP2Rg-P0h3UR0v-kY	2026-02-28 21:41:08.809228+01
\.


--
-- Data for Name: goods_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods_audit (id, staff_id, item_id, date_event) FROM stdin;
1	1	1	\N
2	\N	\N	2022-12-07 01:00:00+01
\.


--
-- Data for Name: rental_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rental_audit (id, staff_id, item_id, start_date, estimated_date, renter_id, datestamp) FROM stdin;
1	6	4	2022-09-07	2022-09-26	16	2022-09-07 02:00:00+02
2	6	93	2022-01-06	2022-03-23	8	2022-09-07 02:00:00+02
3	6	33	2022-01-08	2022-05-27	8	2022-09-07 02:00:00+02
4	6	81	2022-02-12	2022-04-20	8	2022-09-07 02:00:00+02
5	6	149	2022-01-24	2022-05-15	7	2022-09-07 02:00:00+02
6	6	55	2022-02-05	2022-03-14	7	2022-09-07 02:00:00+02
7	6	161	2022-02-09	2022-02-21	7	2022-09-07 02:00:00+02
8	6	154	2022-02-13	2022-02-22	7	2022-09-07 02:00:00+02
9	6	11	2022-02-07	2022-03-16	18	2022-09-07 02:00:00+02
10	6	95	2022-03-10	2022-05-04	18	2022-09-07 02:00:00+02
11	6	169	2022-02-25	2022-05-31	17	2022-09-07 02:00:00+02
12	6	109	2022-01-13	2022-05-15	14	2022-09-07 02:00:00+02
13	6	51	2022-01-29	2022-03-06	14	2022-09-07 02:00:00+02
14	6	181	2022-02-15	2022-03-04	14	2022-09-07 02:00:00+02
15	6	19	2022-01-25	2022-08-15	10	2022-09-07 02:00:00+02
16	6	10	2022-01-15	2022-06-22	16	2022-09-07 02:00:00+02
17	6	6	2022-07-21	2022-11-30	4	2022-09-07 02:00:00+02
18	6	68	2022-09-07	2022-09-23	4	2022-09-07 02:00:00+02
19	6	2	2022-02-12	2022-05-17	13	2022-09-06 23:00:00+02
20	6	2	2022-02-12	2022-05-17	13	2022-09-06 23:00:00+02
21	6	2	2022-02-12	2022-05-17	13	2022-09-06 23:00:00+02
22	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
23	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
24	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
25	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
26	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
27	6	2	2022-02-11	2022-05-18	13	2022-09-07 02:00:00+02
28	6	2	2022-02-11	2022-05-18	13	2022-09-07 02:00:00+02
29	6	2	2022-02-12	2022-05-18	13	2022-09-06 23:00:00+02
30	6	2	2022-02-11	2022-05-22	13	2022-09-07 02:00:00+02
31	6	2	2022-02-11	2022-05-22	13	2022-09-07 02:00:00+02
32	6	2	2022-09-13	2022-10-24	4	2022-09-13 02:00:00+02
33	6	92	2022-09-13	2022-10-24	4	2022-09-13 02:00:00+02
34	6	31	2022-09-13	2022-09-26	4	2022-09-13 02:00:00+02
35	6	102	2022-09-07	2022-10-20	3	2022-09-19 02:00:00+02
36	6	63	2022-09-25	2022-10-09	15	2022-09-25 02:00:00+02
37	6	62	2022-09-25	2022-10-09	15	2022-09-25 02:00:00+02
38	6	195	2022-03-02	2022-06-01	15	2022-09-25 02:00:00+02
39	6	175	2022-03-18	2022-06-01	15	2022-09-25 02:00:00+02
40	6	118	2022-02-22	2022-06-05	8	2022-09-25 02:00:00+02
41	6	118	2022-02-22	2022-10-09	8	2022-09-25 02:00:00+02
42	6	133	2022-03-05	2022-10-23	10	2022-09-25 02:00:00+02
43	6	31	2022-09-13	2022-10-01	4	2022-09-28 02:00:00+02
44	6	102	2022-09-07	2022-10-20	3	2022-09-28 23:00:00+02
45	6	48	2022-09-07	2022-10-21	3	2022-09-28 23:00:00+02
46	6	63	2022-09-25	2022-10-31	15	2022-10-12 02:00:00+02
47	6	62	2022-09-25	2022-10-31	15	2022-10-12 02:00:00+02
48	6	4	2022-09-07	2022-11-26	16	2022-10-12 02:00:00+02
49	6	49	2022-09-07	2022-11-28	16	2022-10-12 02:00:00+02
50	6	20	2022-03-25	2022-04-20	16	2022-10-12 02:00:00+02
51	6	20	2022-03-25	2022-11-20	16	2022-10-12 02:00:00+02
52	6	137	2022-03-20	2022-12-05	2	2022-10-12 02:00:00+02
53	6	88	2022-03-27	2022-12-05	2	2022-10-12 02:00:00+02
54	6	186	2022-03-12	2022-08-20	2	2022-10-12 02:00:00+02
55	6	23	2022-03-23	2022-11-30	10	2022-10-12 02:00:00+02
56	1	6	2022-10-12	2022-12-31	14	2022-10-12 02:00:00+02
57	1	8	2022-10-12	2022-12-31	14	2022-10-12 02:00:00+02
58	6	141	2022-03-10	2022-04-15	14	2022-10-12 02:00:00+02
59	6	38	2022-03-05	2022-03-13	14	2022-10-12 02:00:00+02
60	1	85	2022-10-12	2022-12-12	17	2022-10-12 02:00:00+02
61	1	13	2022-10-12	2022-12-12	17	2022-10-12 02:00:00+02
62	6	69	2022-03-10	2022-05-26	17	2022-10-12 02:00:00+02
63	1	64	2022-10-12	2022-12-12	18	2022-10-12 02:00:00+02
64	1	66	2022-10-12	2022-12-12	18	2022-10-12 02:00:00+02
65	1	71	2022-10-12	2022-12-12	18	2022-10-12 02:00:00+02
66	6	27	2022-03-06	2022-04-22	18	2022-10-12 02:00:00+02
67	6	16	2022-03-03	2022-06-28	18	2022-10-12 02:00:00+02
68	6	110	2022-03-03	2022-07-30	18	2022-10-12 02:00:00+02
69	6	138	2022-02-27	2022-06-27	7	2022-10-12 02:00:00+02
70	6	145	2022-02-27	2022-11-30	7	2022-10-12 02:00:00+02
71	6	118	2022-02-22	2022-11-09	8	2022-10-12 02:00:00+02
72	1	17	2022-10-12	2022-11-20	8	2022-10-12 02:00:00+02
73	1	18	2022-10-12	2022-11-20	8	2022-10-12 02:00:00+02
74	1	37	2022-10-12	2022-11-16	11	2022-10-12 02:00:00+02
75	1	33	2022-10-12	2022-11-16	11	2022-10-12 02:00:00+02
76	1	38	2022-10-12	2022-11-16	11	2022-10-12 02:00:00+02
77	1	34	2022-10-12	2022-11-16	11	2022-10-12 02:00:00+02
78	6	50	2022-01-23	2022-06-30	11	2022-10-12 02:00:00+02
79	1	258	2022-10-28	2022-11-28	12	2022-10-28 02:00:00+02
80	1	258	2022-10-28	2022-11-28	12	2022-11-18 23:00:00+01
81	1	258	2022-10-28	2022-11-28	12	2022-11-18 23:00:00+01
82	1	258	2022-10-28	2022-11-28	12	2022-11-18 23:00:00+01
83	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
84	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
85	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
86	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
87	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
88	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
89	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
90	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
91	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
92	1	260	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
93	1	260	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
94	1	260	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
95	1	258	2022-10-28	2022-11-28	12	2022-11-23 23:00:00+01
96	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
97	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
98	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
99	1	260	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
100	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
101	1	259	2022-11-24	2022-11-26	13	2022-11-24 01:00:00+01
102	1	260	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
103	1	260	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
104	1	259	2022-11-24	2022-11-26	13	2022-11-24 01:00:00+01
105	1	260	2022-11-24	2022-11-25	13	2022-11-24 01:00:00+01
106	1	260	2022-11-24	2022-11-25	13	2022-11-24 01:00:00+01
107	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
108	1	260	2022-11-24	2022-11-29	13	2022-11-24 01:00:00+01
109	1	261	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
110	1	260	2022-11-24	2022-11-29	13	2022-11-24 01:00:00+01
111	1	260	2022-11-24	2022-11-29	13	2022-11-24 01:00:00+01
112	1	260	2022-11-24	2022-11-29	13	2022-11-24 01:00:00+01
113	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
114	1	260	2022-11-24	2022-11-25	13	2022-11-23 23:00:00+01
115	1	260	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
116	1	258	2022-10-28	2022-11-28	12	2022-11-23 23:00:00+01
117	1	259	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
118	1	260	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
119	1	260	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
120	1	259	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
121	1	259	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
122	1	258	2022-10-28	2022-11-28	12	2022-11-23 23:00:00+01
123	1	261	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
124	1	261	2022-11-24	2022-11-27	13	2022-11-23 23:00:00+01
125	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
126	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
127	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
128	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
129	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
130	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
131	1	259	2022-11-24	2022-11-27	13	2022-11-24 01:00:00+01
132	1	259	2022-11-24	2022-11-30	13	2022-11-24 01:00:00+01
133	1	260	2022-11-24	2022-11-30	13	2022-11-24 01:00:00+01
134	1	260	2022-11-24	2022-11-30	13	2022-11-24 01:00:00+01
135	1	261	2022-11-26	2022-11-30	13	2022-11-26 01:00:00+01
136	1	261	2022-11-26	2022-11-30	13	2022-11-26 01:00:00+01
137	1	261	2022-11-26	2022-11-30	13	2022-11-26 01:00:00+01
138	1	261	2022-11-26	2022-11-30	13	2022-11-26 01:00:00+01
139	1	261	2022-11-26	2022-12-01	13	2022-11-26 01:00:00+01
140	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
141	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
142	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
143	1	3	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
144	1	5	2022-11-29	2022-12-09	13	2022-11-29 01:00:00+01
145	1	7	2022-11-29	2022-12-10	13	2022-11-29 01:00:00+01
146	1	5	2022-11-29	2022-12-09	13	2022-11-28 23:00:00+01
147	1	3	2022-11-29	2022-12-04	13	2022-11-28 23:00:00+01
148	1	261	2022-11-26	2022-11-30	13	2022-11-28 23:00:00+01
149	1	261	2022-11-26	2022-11-30	13	2022-11-28 23:00:00+01
150	1	259	2022-11-29	2022-12-03	13	2022-11-29 01:00:00+01
151	1	259	2022-11-29	2022-12-11	13	2022-11-29 01:00:00+01
152	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
153	1	259	2022-11-29	2022-12-10	13	2022-11-29 01:00:00+01
154	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
155	6	9	2022-03-28	2022-10-14	13	2022-11-29 01:00:00+01
156	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
157	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
158	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
159	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
160	1	7	2022-11-29	2022-12-10	13	2022-11-29 01:00:00+01
161	1	3	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
162	1	261	2022-11-26	2022-12-01	13	2022-11-29 01:00:00+01
163	1	259	2022-11-29	2022-12-08	13	2022-11-29 01:00:00+01
164	1	260	2022-11-29	2022-12-08	12	2022-11-29 01:00:00+01
165	1	260	2022-11-29	2022-12-11	12	2022-11-29 01:00:00+01
166	1	259	2022-11-29	2022-12-10	13	2022-11-29 01:00:00+01
167	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
168	1	259	2022-11-29	2022-12-25	13	2022-11-29 01:00:00+01
169	1	259	2022-11-29	2022-12-26	13	2022-11-29 01:00:00+01
170	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
171	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
172	1	259	2022-11-29	2022-12-04	13	2022-11-29 01:00:00+01
173	1	5	2022-11-29	2022-12-24	13	2022-11-29 01:00:00+01
174	1	5	2022-11-29	2022-12-24	13	2022-11-29 01:00:00+01
175	1	259	2022-11-29	2022-12-03	13	2022-11-29 01:00:00+01
176	1	259	2022-11-29	2022-12-26	13	2022-11-29 01:00:00+01
177	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
178	1	260	2022-11-29	2022-12-11	12	2022-11-30 01:00:00+01
179	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
180	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
181	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
182	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
183	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
184	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
185	1	261	2022-11-30	2022-12-11	12	2022-11-30 01:00:00+01
186	1	261	2022-11-30	2022-12-11	12	2022-12-01 01:00:00+01
187	1	261	2022-11-30	2022-12-11	12	2022-11-30 23:00:00+01
188	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
189	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
190	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
191	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
192	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
193	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
194	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
195	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
196	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
197	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
198	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
199	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
200	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
201	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
202	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
203	1	260	2022-11-29	2022-12-11	12	2022-11-30 23:00:00+01
204	1	260	2022-11-29	2022-12-11	12	2022-12-01 01:00:00+01
205	1	258	2022-10-28	2022-11-28	12	2022-12-01 01:00:00+01
206	1	259	2022-11-29	2022-12-08	13	2022-11-30 23:00:00+01
207	1	259	2022-11-29	2022-12-10	13	2022-11-30 23:00:00+01
208	1	259	2022-11-29	2022-12-04	13	2022-11-30 23:00:00+01
209	1	259	2022-11-29	2022-12-26	13	2022-11-30 23:00:00+01
210	1	259	2022-11-29	2022-12-03	13	2022-11-30 23:00:00+01
211	1	259	2022-11-29	2022-12-04	13	2022-11-30 23:00:00+01
212	1	259	2022-11-29	2022-12-04	13	2022-11-30 23:00:00+01
213	1	259	2022-11-29	2022-12-04	13	2022-11-30 23:00:00+01
214	1	261	2022-11-26	2022-12-01	13	2022-11-30 23:00:00+01
215	1	261	2022-11-26	2022-11-30	13	2022-11-30 23:00:00+01
216	1	261	2022-11-26	2022-11-30	13	2022-11-30 23:00:00+01
217	1	260	2022-11-24	2022-11-30	13	2022-11-30 23:00:00+01
218	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
219	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
220	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
221	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
222	1	260	2022-11-24	2022-11-29	13	2022-11-30 23:00:00+01
223	1	261	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
224	1	260	2022-11-24	2022-11-25	13	2022-11-30 23:00:00+01
225	1	260	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
226	1	259	2022-11-24	2022-11-26	13	2022-11-30 23:00:00+01
227	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
228	1	260	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
229	1	261	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
230	1	261	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
231	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
232	1	261	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
233	1	259	2022-11-24	2022-11-27	13	2022-11-30 23:00:00+01
234	1	258	2022-10-28	2022-11-28	12	2022-11-30 23:00:00+01
235	1	7	2022-11-29	2022-12-10	13	2022-11-30 23:00:00+01
236	1	5	2022-11-29	2022-12-24	13	2022-11-30 23:00:00+01
237	1	3	2022-11-29	2022-12-04	13	2022-11-30 23:00:00+01
238	1	259	2022-12-01	2022-12-30	13	2022-12-01 01:00:00+01
239	1	259	2022-12-01	2022-12-31	13	2022-12-01 01:00:00+01
240	1	255	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
241	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
242	1	258	2022-10-28	2022-11-28	12	2022-11-30 23:00:00+01
243	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
244	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
245	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
246	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
247	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
248	1	258	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
249	1	255	2022-12-01	2022-12-31	12	2022-12-01 01:00:00+01
250	1	259	2022-11-24	2022-11-30	13	2022-12-04 23:00:00+01
251	1	261	2022-11-30	2022-12-11	12	2022-12-04 23:00:00+01
252	1	260	2022-11-29	2022-12-11	12	2022-12-04 23:00:00+01
253	1	260	2022-11-29	2022-12-08	12	2022-12-04 23:00:00+01
254	1	259	2022-11-29	2022-12-08	13	2022-12-04 23:00:00+01
255	1	259	2022-11-29	2022-12-10	13	2022-12-04 23:00:00+01
256	1	259	2022-11-29	2022-12-04	13	2022-12-04 23:00:00+01
257	1	259	2022-11-29	2022-12-26	13	2022-12-04 23:00:00+01
258	1	259	2022-11-29	2022-12-03	13	2022-12-04 23:00:00+01
259	1	7	2022-11-29	2022-12-10	13	2022-12-04 23:00:00+01
260	1	5	2022-11-29	2022-12-24	13	2022-12-04 23:00:00+01
261	1	3	2022-11-29	2022-12-04	13	2022-12-04 23:00:00+01
262	1	259	2022-11-29	2022-12-04	13	2022-12-04 23:00:00+01
263	1	259	2022-11-29	2022-12-04	13	2022-12-04 23:00:00+01
264	1	259	2022-11-29	2022-12-04	13	2022-12-04 23:00:00+01
265	1	261	2022-11-26	2022-12-01	13	2022-12-04 23:00:00+01
266	1	261	2022-11-26	2022-11-30	13	2022-12-04 23:00:00+01
267	1	261	2022-11-26	2022-11-30	13	2022-12-04 23:00:00+01
268	1	260	2022-11-24	2022-11-30	13	2022-12-04 23:00:00+01
269	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
270	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
271	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
272	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
273	1	260	2022-11-24	2022-11-29	13	2022-12-04 23:00:00+01
274	1	261	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
275	1	260	2022-11-24	2022-11-25	13	2022-12-04 23:00:00+01
276	1	260	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
277	1	259	2022-11-24	2022-11-26	13	2022-12-04 23:00:00+01
278	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
279	1	260	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
280	1	261	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
281	1	261	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
282	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
283	1	261	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
284	1	259	2022-11-24	2022-11-27	13	2022-12-04 23:00:00+01
285	1	34	2022-10-12	2022-11-16	11	2022-12-04 23:00:00+01
286	1	38	2022-10-12	2022-11-16	11	2022-12-04 23:00:00+01
287	1	33	2022-10-12	2022-11-16	11	2022-12-04 23:00:00+01
288	1	37	2022-10-12	2022-11-16	11	2022-12-04 23:00:00+01
289	1	18	2022-10-12	2022-11-20	8	2022-12-04 23:00:00+01
290	1	17	2022-10-12	2022-11-20	8	2022-12-04 23:00:00+01
291	1	71	2022-10-12	2022-12-12	18	2022-12-04 23:00:00+01
292	1	66	2022-10-12	2022-12-12	18	2022-12-04 23:00:00+01
293	1	64	2022-10-12	2022-12-12	18	2022-12-04 23:00:00+01
294	1	13	2022-10-12	2022-12-12	17	2022-12-04 23:00:00+01
295	1	85	2022-10-12	2022-12-12	17	2022-12-04 23:00:00+01
296	1	8	2022-10-12	2022-12-31	14	2022-12-04 23:00:00+01
297	1	6	2022-10-12	2022-12-31	14	2022-12-04 23:00:00+01
298	1	258	2022-12-01	2022-12-31	12	2022-12-04 23:00:00+01
299	1	255	2022-12-01	2022-12-31	12	2022-12-04 23:00:00+01
300	1	259	2022-12-01	2022-12-31	13	2022-12-04 23:00:00+01
301	1	12	2022-12-07	2023-01-07	13	2022-12-07 01:00:00+01
302	1	261	2022-11-26	2022-11-30	13	2022-12-06 23:00:00+01
303	1	261	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
304	1	8	2022-10-12	2022-12-31	14	2022-12-06 23:00:00+01
305	1	6	2022-10-12	2022-12-31	14	2022-12-06 23:00:00+01
306	6	6	2022-07-21	2022-11-30	4	2022-12-06 23:00:00+01
307	6	2	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
308	6	92	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
309	6	81	2022-06-27	2022-06-30	4	2022-12-06 23:00:00+01
310	1	21	2022-05-18	2022-05-19	3	2022-12-06 23:00:00+01
311	1	255	2022-12-01	2022-12-31	12	2022-12-06 23:00:00+01
312	1	258	2022-10-28	2022-11-28	12	2022-12-06 23:00:00+01
313	6	24	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
314	1	261	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
315	6	104	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
316	6	165	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
317	6	102	2022-09-07	2022-10-20	3	2022-12-06 23:00:00+01
318	6	48	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
319	6	63	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
320	6	62	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
321	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
322	1	259	2022-11-29	2022-12-26	13	2022-12-06 23:00:00+01
323	1	12	2022-12-07	2023-01-07	13	2022-12-06 23:00:00+01
324	1	259	2022-11-29	2022-12-03	13	2022-12-06 23:00:00+01
325	1	258	2022-12-01	2022-12-31	12	2022-12-06 23:00:00+01
326	1	10	2022-05-18	2022-05-29	3	2022-12-06 23:00:00+01
327	6	31	2022-09-13	2022-10-01	4	2022-12-06 23:00:00+01
328	6	49	2022-09-07	2022-11-28	16	2022-12-06 23:00:00+01
329	1	259	2022-11-29	2022-12-04	13	2022-12-06 23:00:00+01
330	1	261	2022-11-26	2022-11-30	13	2022-12-06 23:00:00+01
331	1	260	2022-11-24	2022-11-29	13	2022-12-06 23:00:00+01
332	1	261	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
333	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
334	1	13	2022-10-12	2022-12-12	17	2022-12-06 23:00:00+01
335	1	85	2022-10-12	2022-12-12	17	2022-12-06 23:00:00+01
336	1	259	2022-11-29	2022-12-10	13	2022-12-06 23:00:00+01
337	1	261	2022-11-26	2022-12-01	13	2022-12-06 23:00:00+01
338	1	31	2022-05-18	2022-06-18	4	2022-12-06 23:00:00+01
339	1	29	2022-05-18	2022-06-18	4	2022-12-06 23:00:00+01
340	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
341	1	261	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
342	1	71	2022-10-12	2022-12-12	18	2022-12-06 23:00:00+01
343	1	66	2022-10-12	2022-12-12	18	2022-12-06 23:00:00+01
344	1	64	2022-10-12	2022-12-12	18	2022-12-06 23:00:00+01
345	6	4	2022-09-07	2022-11-26	16	2022-12-06 23:00:00+01
346	1	259	2022-11-29	2022-12-08	13	2022-12-06 23:00:00+01
347	1	259	2022-11-29	2022-12-04	13	2022-12-06 23:00:00+01
348	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
349	1	260	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
350	1	18	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
351	1	17	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
352	6	55	2022-06-22	2022-06-25	4	2022-12-06 23:00:00+01
353	6	68	2022-09-07	2022-09-23	4	2022-12-06 23:00:00+01
354	1	260	2022-11-29	2022-12-08	12	2022-12-06 23:00:00+01
355	1	259	2022-11-29	2022-12-04	13	2022-12-06 23:00:00+01
356	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
357	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
358	1	34	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
359	1	38	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
360	1	33	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
361	1	37	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
362	6	12	2022-06-22	2022-07-01	4	2022-12-06 23:00:00+01
363	1	260	2022-11-29	2022-12-11	12	2022-12-06 23:00:00+01
364	1	3	2022-11-29	2022-12-04	13	2022-12-06 23:00:00+01
365	1	259	2022-11-29	2022-12-04	13	2022-12-06 23:00:00+01
366	1	259	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
367	1	259	2022-11-24	2022-11-26	13	2022-12-06 23:00:00+01
368	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
369	1	261	2022-11-30	2022-12-11	12	2022-12-06 23:00:00+01
370	1	5	2022-11-29	2022-12-24	13	2022-12-06 23:00:00+01
371	1	260	2022-11-24	2022-11-27	13	2022-12-06 23:00:00+01
372	6	100	2022-06-22	2022-07-05	4	2022-12-06 23:00:00+01
373	1	7	2022-11-29	2022-12-10	13	2022-12-06 23:00:00+01
374	1	260	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
375	1	260	2022-11-24	2022-11-25	13	2022-12-06 23:00:00+01
376	1	259	2022-12-01	2022-12-31	13	2022-12-06 23:00:00+01
377	1	10	2022-12-07	2023-01-06	13	2022-12-07 01:00:00+01
378	1	12	2022-12-07	2023-01-07	13	2022-12-06 23:00:00+01
379	1	12	2022-12-07	2023-01-07	13	2022-12-06 23:00:00+01
381	1	12	2022-12-07	2023-01-07	13	2022-12-07 01:00:00+01
382	1	15	2022-12-07	2023-01-05	13	2022-12-07 01:00:00+01
383	6	137	2022-03-20	2022-12-05	2	2022-12-07 01:00:00+01
384	6	145	2022-02-27	2022-11-30	7	2022-12-07 01:00:00+01
385	6	2	2022-09-13	2022-10-24	4	2022-12-07 01:00:00+01
386	6	92	2022-09-13	2022-10-24	4	2022-12-07 01:00:00+01
387	6	24	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
388	6	104	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
389	6	165	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
390	6	102	2022-09-07	2022-10-20	3	2022-12-07 01:00:00+01
391	6	48	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
392	6	63	2022-09-25	2022-10-31	15	2022-12-07 01:00:00+01
393	6	62	2022-09-25	2022-10-31	15	2022-12-07 01:00:00+01
394	6	31	2022-09-13	2022-10-01	4	2022-12-07 01:00:00+01
395	6	49	2022-09-07	2022-11-28	16	2022-12-07 01:00:00+01
396	6	167	2022-01-07	2022-05-31	9	2022-12-07 01:00:00+01
397	6	23	2022-03-23	2022-11-30	10	2022-12-07 01:00:00+01
398	6	119	2022-03-25	2022-10-20	2	2022-12-07 01:00:00+01
399	6	88	2022-03-27	2022-12-05	2	2022-12-07 01:00:00+01
400	6	4	2022-09-07	2022-11-26	16	2022-12-07 01:00:00+01
401	1	18	2022-10-12	2022-11-20	8	2022-12-07 01:00:00+01
402	1	17	2022-10-12	2022-11-20	8	2022-12-07 01:00:00+01
403	6	118	2022-02-22	2022-11-09	8	2022-12-07 01:00:00+01
404	6	68	2022-09-07	2022-09-23	4	2022-12-07 01:00:00+01
405	6	20	2022-03-25	2022-11-20	16	2022-12-07 01:00:00+01
406	6	186	2022-03-12	2022-08-20	2	2022-12-07 01:00:00+01
407	1	34	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
408	1	38	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
409	1	33	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
410	1	37	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
411	6	143	2022-03-02	2022-05-27	12	2022-12-07 01:00:00+01
412	1	259	2022-11-24	2022-11-30	13	2022-12-07 01:00:00+01
413	6	133	2022-03-05	2022-10-23	10	2022-12-07 01:00:00+01
414	1	3	2022-12-07	2022-12-28	13	2022-12-07 01:00:00+01
415	6	137	2022-03-20	2022-12-05	2	2022-12-07 01:00:00+01
416	6	145	2022-02-27	2022-11-30	7	2022-12-07 01:00:00+01
417	6	2	2022-09-13	2022-10-24	4	2022-12-07 01:00:00+01
418	6	92	2022-09-13	2022-10-24	4	2022-12-07 01:00:00+01
419	6	24	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
420	6	104	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
421	6	165	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
422	6	102	2022-09-07	2022-10-20	3	2022-12-07 01:00:00+01
423	6	48	2022-09-07	2022-10-21	3	2022-12-07 01:00:00+01
424	6	63	2022-09-25	2022-10-31	15	2022-12-07 01:00:00+01
425	6	62	2022-09-25	2022-10-31	15	2022-12-07 01:00:00+01
426	6	31	2022-09-13	2022-10-01	4	2022-12-07 01:00:00+01
427	6	49	2022-09-07	2022-11-28	16	2022-12-07 01:00:00+01
428	6	167	2022-01-07	2022-05-31	9	2022-12-07 01:00:00+01
429	6	23	2022-03-23	2022-11-30	10	2022-12-07 01:00:00+01
430	6	119	2022-03-25	2022-10-20	2	2022-12-07 01:00:00+01
431	6	88	2022-03-27	2022-12-05	2	2022-12-07 01:00:00+01
432	6	4	2022-09-07	2022-11-26	16	2022-12-07 01:00:00+01
433	1	18	2022-10-12	2022-11-20	8	2022-12-07 01:00:00+01
434	1	17	2022-10-12	2022-11-20	8	2022-12-07 01:00:00+01
435	6	118	2022-02-22	2022-11-09	8	2022-12-07 01:00:00+01
436	6	68	2022-09-07	2022-09-23	4	2022-12-07 01:00:00+01
437	6	20	2022-03-25	2022-11-20	16	2022-12-07 01:00:00+01
438	6	186	2022-03-12	2022-08-20	2	2022-12-07 01:00:00+01
439	1	34	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
440	1	38	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
441	1	33	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
442	1	37	2022-10-12	2022-11-16	11	2022-12-07 01:00:00+01
443	6	143	2022-03-02	2022-05-27	12	2022-12-07 01:00:00+01
444	1	259	2022-11-24	2022-11-30	13	2022-12-07 01:00:00+01
445	6	133	2022-03-05	2022-10-23	10	2022-12-07 01:00:00+01
446	1	25	2022-12-07	2022-12-21	13	2022-12-07 01:00:00+01
447	6	137	2022-03-21	2022-12-05	2	2022-12-06 23:00:00+01
448	6	145	2022-02-28	2022-11-30	7	2022-12-06 23:00:00+01
449	6	2	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
450	6	92	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
451	6	24	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
452	6	104	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
453	6	165	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
454	6	102	2022-09-07	2022-10-20	3	2022-12-06 23:00:00+01
455	6	48	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
456	6	63	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
457	6	62	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
458	6	31	2022-09-13	2022-10-01	4	2022-12-06 23:00:00+01
459	6	49	2022-09-07	2022-11-28	16	2022-12-06 23:00:00+01
460	6	167	2022-01-08	2022-05-31	9	2022-12-06 23:00:00+01
461	6	23	2022-03-24	2022-11-30	10	2022-12-06 23:00:00+01
462	6	119	2022-03-26	2022-10-20	2	2022-12-06 23:00:00+01
463	6	88	2022-03-28	2022-12-05	2	2022-12-06 23:00:00+01
464	6	4	2022-09-07	2022-11-26	16	2022-12-06 23:00:00+01
465	1	18	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
466	1	17	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
467	6	118	2022-02-23	2022-11-09	8	2022-12-06 23:00:00+01
468	6	68	2022-09-07	2022-09-23	4	2022-12-06 23:00:00+01
469	6	20	2022-03-26	2022-11-20	16	2022-12-06 23:00:00+01
470	6	186	2022-03-13	2022-08-20	2	2022-12-06 23:00:00+01
471	1	34	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
472	1	38	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
473	1	33	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
474	1	37	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
475	6	143	2022-03-03	2022-05-27	12	2022-12-06 23:00:00+01
476	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
477	6	133	2022-03-06	2022-10-23	10	2022-12-06 23:00:00+01
478	6	137	2022-03-21	2022-12-05	2	2022-12-06 23:00:00+01
479	6	145	2022-02-28	2022-11-30	7	2022-12-06 23:00:00+01
480	6	2	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
481	6	92	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
482	6	24	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
483	6	104	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
484	6	165	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
485	6	102	2022-09-07	2022-10-20	3	2022-12-06 23:00:00+01
486	6	48	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
487	6	63	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
488	6	62	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
489	6	31	2022-09-13	2022-10-01	4	2022-12-06 23:00:00+01
490	6	49	2022-09-07	2022-11-28	16	2022-12-06 23:00:00+01
491	6	167	2022-01-08	2022-05-31	9	2022-12-06 23:00:00+01
492	6	23	2022-03-24	2022-11-30	10	2022-12-06 23:00:00+01
493	6	119	2022-03-26	2022-10-20	2	2022-12-06 23:00:00+01
494	6	88	2022-03-28	2022-12-05	2	2022-12-06 23:00:00+01
495	6	4	2022-09-07	2022-11-26	16	2022-12-06 23:00:00+01
496	1	18	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
497	1	17	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
498	6	118	2022-02-23	2022-11-09	8	2022-12-06 23:00:00+01
499	6	68	2022-09-07	2022-09-23	4	2022-12-06 23:00:00+01
500	6	20	2022-03-26	2022-11-20	16	2022-12-06 23:00:00+01
501	6	186	2022-03-13	2022-08-20	2	2022-12-06 23:00:00+01
502	1	34	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
503	1	38	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
504	1	33	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
505	1	37	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
506	6	143	2022-03-03	2022-05-27	12	2022-12-06 23:00:00+01
507	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
508	6	133	2022-03-06	2022-10-23	10	2022-12-06 23:00:00+01
509	6	137	2022-03-21	2022-12-05	2	2022-12-06 23:00:00+01
510	6	145	2022-02-28	2022-11-30	7	2022-12-06 23:00:00+01
511	6	2	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
512	6	92	2022-09-13	2022-10-24	4	2022-12-06 23:00:00+01
513	6	24	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
514	6	104	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
515	6	165	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
516	6	102	2022-09-07	2022-10-20	3	2022-12-06 23:00:00+01
517	6	48	2022-09-07	2022-10-21	3	2022-12-06 23:00:00+01
518	6	63	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
519	6	62	2022-09-25	2022-10-31	15	2022-12-06 23:00:00+01
520	6	31	2022-09-13	2022-10-01	4	2022-12-06 23:00:00+01
521	6	49	2022-09-07	2022-11-28	16	2022-12-06 23:00:00+01
522	6	167	2022-01-08	2022-05-31	9	2022-12-06 23:00:00+01
523	6	23	2022-03-24	2022-11-30	10	2022-12-06 23:00:00+01
524	6	119	2022-03-26	2022-10-20	2	2022-12-06 23:00:00+01
525	6	88	2022-03-28	2022-12-05	2	2022-12-06 23:00:00+01
526	6	4	2022-09-07	2022-11-26	16	2022-12-06 23:00:00+01
527	1	18	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
528	1	17	2022-10-12	2022-11-20	8	2022-12-06 23:00:00+01
529	6	118	2022-02-23	2022-11-09	8	2022-12-06 23:00:00+01
530	6	68	2022-09-07	2022-09-23	4	2022-12-06 23:00:00+01
531	6	20	2022-03-26	2022-11-20	16	2022-12-06 23:00:00+01
532	6	186	2022-03-13	2022-08-20	2	2022-12-06 23:00:00+01
533	1	34	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
534	1	38	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
535	1	33	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
536	1	37	2022-10-12	2022-11-16	11	2022-12-06 23:00:00+01
537	6	143	2022-03-03	2022-05-27	12	2022-12-06 23:00:00+01
538	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
539	6	133	2022-03-06	2022-10-23	10	2022-12-06 23:00:00+01
540	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
541	1	259	2022-11-24	2022-11-30	13	2022-12-06 23:00:00+01
542	1	259	2022-11-24	2022-11-30	13	2022-12-07 01:00:00+01
543	1	53	2022-12-07	2023-01-08	13	2022-12-07 01:00:00+01
544	1	259	2022-11-24	2022-11-30	13	2022-12-07 01:00:00+01
545	1	55	2022-12-07	2023-01-05	13	2022-12-07 01:00:00+01
546	1	28	2022-12-07	2023-01-21	13	2022-12-07 01:00:00+01
547	1	44	2022-12-07	2023-01-05	13	2022-12-07 01:00:00+01
548	1	260	2022-11-29	2022-12-08	12	2023-01-14 01:00:00+01
549	1	259	2022-12-01	2022-12-31	13	2023-01-14 01:00:00+01
550	1	275	2023-01-14	2023-02-28	8	2023-01-14 01:00:00+01
551	1	276	2023-01-14	2023-02-28	8	2023-01-14 01:00:00+01
552	19	294	2023-01-14	2023-02-25	16	2023-01-14 01:00:00+01
553	19	295	2023-01-14	2023-04-08	18	2023-01-14 01:00:00+01
554	19	296	2023-01-14	2023-03-17	10	2023-01-14 01:00:00+01
555	6	23	2022-03-23	2023-02-04	10	2023-01-15 01:00:00+01
556	6	133	2022-03-05	2023-02-23	10	2023-01-15 01:00:00+01
557	1	66	2022-10-12	2023-02-12	18	2023-01-15 01:00:00+01
558	1	71	2022-10-12	2023-03-12	18	2023-01-15 01:00:00+01
559	1	64	2022-10-12	2022-12-12	18	2023-01-15 01:00:00+01
560	1	38	2022-10-12	2022-11-16	11	2023-01-15 01:00:00+01
561	1	37	2022-10-12	2022-11-16	11	2023-01-15 01:00:00+01
562	1	33	2022-10-12	2022-11-16	11	2023-01-15 01:00:00+01
563	1	34	2022-10-12	2023-02-23	11	2023-01-15 01:00:00+01
564	1	12	2022-12-07	2023-01-07	13	2023-01-14 23:00:00+01
565	1	10	2022-12-07	2023-01-06	13	2023-01-14 23:00:00+01
566	1	15	2022-12-07	2023-01-05	13	2023-01-14 23:00:00+01
567	1	3	2022-12-07	2022-12-28	13	2023-01-14 23:00:00+01
568	1	25	2022-12-07	2022-12-21	13	2023-01-14 23:00:00+01
569	1	53	2022-12-07	2023-01-08	13	2023-01-14 23:00:00+01
570	1	55	2022-12-07	2023-01-05	13	2023-01-14 23:00:00+01
571	1	28	2022-12-07	2023-01-21	13	2023-01-14 23:00:00+01
572	1	44	2022-12-07	2023-01-05	13	2023-01-14 23:00:00+01
573	1	275	2023-01-14	2023-02-28	8	2023-01-14 23:00:00+01
574	1	276	2023-01-14	2023-02-28	8	2023-01-14 23:00:00+01
575	19	296	2023-01-15	2023-02-20	18	2023-01-15 01:00:00+01
576	4	183	2023-01-16	2023-02-03	6	2023-01-16 01:00:00+01
577	6	88	2022-03-27	2023-02-05	2	2023-01-23 01:00:00+01
578	1	274	2023-01-28	2023-03-09	16	2023-01-28 01:00:00+01
579	20	301	2023-01-28	2023-03-09	14	2023-01-28 01:00:00+01
580	20	102	2022-09-07	2022-10-20	3	2023-01-27 23:00:00+01
581	20	48	2022-09-07	2022-10-21	3	2023-01-27 23:00:00+01
582	20	102	2022-09-07	2023-03-03	3	2023-01-28 01:00:00+01
583	20	48	2022-09-07	2023-03-08	3	2023-01-28 01:00:00+01
584	4	51	2023-01-29	2023-03-10	7	2023-01-29 01:00:00+01
585	21	96	2023-01-29	2023-03-24	12	2023-01-29 01:00:00+01
586	21	100	2023-01-29	2023-03-31	15	2023-01-29 01:00:00+01
587	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
588	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
589	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
590	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
591	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
592	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
593	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
594	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
595	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
596	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
597	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
598	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
599	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
600	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
601	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
602	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
603	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
604	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
605	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
606	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
607	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
608	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
609	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
610	6	62	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
611	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
612	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
613	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
614	6	63	2022-09-25	2022-10-31	15	2023-01-29 01:00:00+01
615	21	100	2023-01-29	2023-03-31	15	2023-01-29 01:00:00+01
616	21	100	2023-01-29	2023-03-31	15	2023-01-29 01:00:00+01
617	21	100	2023-01-29	2023-03-31	15	2023-01-29 01:00:00+01
618	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
619	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
620	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
621	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
622	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
623	6	145	2022-02-27	2022-11-30	7	2023-01-29 01:00:00+01
624	6	68	2022-09-07	2022-09-23	4	2023-01-29 01:00:00+01
625	6	2	2022-09-13	2022-10-24	4	2023-01-29 01:00:00+01
626	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
627	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
628	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
629	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
630	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
631	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
632	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
633	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
634	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
635	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
636	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
637	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
638	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
639	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
640	6	145	2022-02-27	2022-11-30	7	2023-01-30 01:00:00+01
641	6	80	2023-01-30	2023-04-01	10	2023-01-30 01:00:00+01
642	21	303	2023-01-30	2023-03-30	11	2023-01-30 01:00:00+01
643	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
644	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
645	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
646	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
647	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
648	6	145	2022-02-27	2022-11-30	7	2023-02-12 01:00:00+01
649	6	118	2022-02-22	2022-11-09	8	2023-02-12 01:00:00+01
650	1	18	2022-10-12	2022-11-20	8	2023-02-12 01:00:00+01
651	1	17	2022-10-12	2022-11-20	8	2023-02-12 01:00:00+01
652	1	18	2022-10-12	2022-11-20	8	2023-02-12 01:00:00+01
653	1	17	2022-10-12	2022-11-20	8	2023-02-12 01:00:00+01
654	6	23	2022-03-23	2023-02-04	10	2023-02-12 01:00:00+01
655	6	266	2023-02-15	2023-02-24	13	2023-02-15 01:00:00+01
656	6	266	2023-02-15	2023-02-24	13	2023-02-15 01:00:00+01
657	6	266	2023-02-15	2023-02-24	15	2023-02-15 01:00:00+01
658	6	266	2023-02-15	2023-02-24	15	2023-02-15 01:00:00+01
659	6	266	2023-02-15	2023-02-24	15	2023-02-15 01:00:00+01
660	6	266	2023-02-15	2023-02-24	15	2023-02-15 01:00:00+01
661	6	266	2023-02-15	2023-02-24	16	2023-02-15 01:00:00+01
662	6	266	2023-02-15	2023-02-24	16	2023-02-15 01:00:00+01
663	6	266	2023-02-15	2023-02-25	17	2023-02-15 01:00:00+01
664	6	266	2023-02-15	2023-02-25	17	2023-02-15 01:00:00+01
665	6	266	2023-02-15	2023-02-26	18	2023-02-15 01:00:00+01
666	6	266	2023-02-15	2023-02-26	18	2023-02-15 01:00:00+01
667	6	266	2023-02-15	2023-02-18	18	2023-02-15 01:00:00+01
668	6	266	2023-02-15	2023-02-18	18	2023-02-15 01:00:00+01
669	6	266	2023-02-15	2023-03-03	18	2023-02-15 01:00:00+01
670	6	266	2023-02-15	2023-03-03	18	2023-02-15 01:00:00+01
671	6	266	2023-02-15	2023-03-04	18	2023-02-15 01:00:00+01
672	6	266	2023-02-15	2023-03-04	18	2023-02-15 01:00:00+01
673	6	266	2023-02-15	2023-03-04	18	2023-02-15 01:00:00+01
674	6	266	2023-02-15	2023-03-04	18	2023-02-15 01:00:00+01
675	6	266	2023-02-15	2023-03-08	18	2023-02-15 01:00:00+01
676	6	266	2023-02-15	2023-03-08	18	2023-02-15 01:00:00+01
677	6	266	2023-02-15	2023-03-11	18	2023-02-15 01:00:00+01
678	6	266	2023-02-15	2023-03-11	18	2023-02-15 01:00:00+01
679	6	266	2023-02-15	2023-03-03	18	2023-02-15 01:00:00+01
680	6	266	2023-02-15	2023-03-03	18	2023-02-15 01:00:00+01
681	1	66	2022-10-12	2023-02-12	18	2023-02-16 01:00:00+01
682	1	71	2022-10-12	2023-03-12	18	2023-02-16 01:00:00+01
683	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
684	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
685	6	266	2023-02-16	2023-02-24	18	2023-02-15 23:00:00+01
686	6	266	2023-02-16	2023-02-24	18	2023-02-15 23:00:00+01
687	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
688	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
689	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
690	6	266	2023-02-16	2023-02-18	18	2023-02-16 01:00:00+01
691	6	266	2023-02-16	2023-02-18	18	2023-02-16 01:00:00+01
692	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
693	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
694	6	276	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
695	6	276	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
696	6	266	2023-02-16	2023-03-04	18	2023-02-16 01:00:00+01
697	6	266	2023-02-16	2023-03-04	18	2023-02-16 01:00:00+01
698	6	266	2023-02-16	2023-02-18	18	2023-02-16 01:00:00+01
699	6	266	2023-02-16	2023-02-18	18	2023-02-16 01:00:00+01
700	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
701	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
702	6	266	2023-02-16	2023-03-05	18	2023-02-16 01:00:00+01
703	6	266	2023-02-16	2023-03-05	18	2023-02-16 01:00:00+01
704	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
705	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
706	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
707	6	266	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
708	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
709	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
710	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
711	6	266	2023-02-16	2023-02-25	18	2023-02-16 01:00:00+01
712	6	265	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
713	6	265	2023-02-16	2023-02-24	18	2023-02-16 01:00:00+01
714	6	266	2023-02-17	2023-02-22	18	2023-02-17 01:00:00+01
715	6	265	2023-02-17	2023-02-25	16	2023-02-17 01:00:00+01
716	6	265	2023-02-17	2023-02-27	16	2023-02-17 01:00:00+01
717	6	265	2023-02-17	2023-03-05	16	2023-02-17 01:00:00+01
718	6	265	2023-02-17	2023-03-05	16	2023-02-17 01:00:00+01
719	6	266	2023-02-17	2023-02-15	18	2023-02-17 01:00:00+01
720	6	266	2023-02-17	2023-02-18	18	2023-02-17 01:00:00+01
721	6	266	2023-02-17	2023-03-04	18	2023-02-17 01:00:00+01
722	1	12	2022-12-07	2023-01-07	13	2023-02-17 01:00:00+01
723	1	10	2022-12-07	2023-01-06	13	2023-02-17 01:00:00+01
724	1	15	2022-12-07	2023-01-05	13	2023-02-17 01:00:00+01
725	1	3	2022-12-07	2022-12-28	13	2023-02-17 01:00:00+01
726	1	25	2022-12-07	2022-12-21	13	2023-02-17 01:00:00+01
727	1	53	2022-12-07	2023-01-08	13	2023-02-17 01:00:00+01
728	1	55	2022-12-07	2023-01-05	13	2023-02-17 01:00:00+01
729	1	55	2022-12-07	2023-01-05	13	2023-02-17 01:00:00+01
730	1	55	2022-12-07	2023-01-05	13	2023-02-20 01:00:00+01
731	19	296	2023-01-15	2023-02-20	18	2023-02-20 01:00:00+01
732	6	313	2023-02-20	2023-02-22	18	2023-02-20 01:00:00+01
733	21	303	2023-01-30	2023-03-30	11	2023-02-24 01:00:00+01
734	6	266	2023-02-17	2023-03-11	18	2023-03-03 01:00:00+01
735	6	313	2023-02-20	2023-04-13	18	2023-03-03 01:00:00+01
736	1	276	2023-01-14	2023-02-28	8	2023-03-03 01:00:00+01
737	4	52	2023-03-03	2023-04-14	18	2023-03-03 01:00:00+01
738	4	136	2023-03-06	2023-03-30	3	2023-03-06 01:00:00+01
739	6	104	2022-09-07	2022-10-21	3	2023-03-06 01:00:00+01
740	6	24	2022-09-07	2022-10-21	3	2023-03-06 01:00:00+01
741	6	165	2022-09-07	2022-10-21	3	2023-03-06 01:00:00+01
742	6	165	2022-09-07	2022-10-21	3	2023-03-06 01:00:00+01
743	19	295	2023-01-14	2023-04-08	18	2023-03-06 01:00:00+01
744	4	322	2023-03-10	2023-03-30	12	2023-03-10 01:00:00+01
745	4	322	2023-03-10	2023-03-30	12	2023-03-10 01:00:00+01
746	4	323	2023-03-10	2023-03-26	12	2023-03-10 01:00:00+01
747	4	323	2023-03-10	2023-03-26	12	2023-03-10 01:00:00+01
748	4	337	2023-03-10	2023-03-23	12	2023-03-10 01:00:00+01
749	4	337	2023-03-10	2023-03-23	12	2023-03-10 01:00:00+01
750	4	338	2023-03-10	2023-04-08	12	2023-03-10 01:00:00+01
751	4	338	2023-03-10	2023-04-08	12	2023-03-10 01:00:00+01
752	4	\N	2023-03-10	2023-04-08	12	2023-03-10 01:00:00+01
753	4	\N	2023-03-10	2023-03-23	12	2023-03-10 01:00:00+01
754	4	\N	2023-03-10	2023-03-26	12	2023-03-10 01:00:00+01
755	4	\N	2023-03-10	2023-03-30	12	2023-03-10 01:00:00+01
756	6	266	2023-02-17	2023-03-25	18	2023-03-13 01:00:00+01
757	20	102	2022-09-07	2023-04-01	3	2023-03-13 01:00:00+01
758	20	48	2022-09-07	2023-03-23	3	2023-03-13 01:00:00+01
759	1	342	2023-03-13	2023-03-31	12	2023-03-13 01:00:00+01
760	1	342	2023-03-13	2023-03-31	12	2023-03-13 01:00:00+01
761	1	276	2023-03-13	2023-03-31	14	2023-03-13 01:00:00+01
762	1	6	2022-10-12	2022-12-31	14	2023-03-13 01:00:00+01
763	1	8	2022-10-12	2022-12-31	14	2023-03-13 01:00:00+01
764	20	301	2023-01-28	2023-04-08	14	2023-03-13 01:00:00+01
765	1	276	2023-03-13	2023-03-31	14	2023-03-13 01:00:00+01
\.


--
-- Data for Name: varasto_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_category (id, cat_name) FROM stdin;
2	Työkalut
3	Sähkötyökalut
1	Kulutusmateriaali (ruuvit, maalit, johdot)
\.


--
-- Data for Name: varasto_customuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone, code, photo, role, responsible_teacher_id, "group", storage_id, is_storage_staff) FROM stdin;
23	pbkdf2_sha256$320000$B527NksSM1oIur10mmCzVD$uolfQMRrdD4hjRVJTwRsqAO0jDgLQSxvaA9A4mfgx58=	2023-03-03 10:23:29.963445+01	f	user30	Dmitri	Mendelejev	Dmitri.Mendelejev1@example.com	f	t	2023-03-03 09:32:59+01	\N	\N		student	\N	\N	\N	f
11	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user10	Celine	Killwick	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358419753324	10010	images/students/daniel-monteiro-iK2MdOKSmj8-unsplash.jpg	student	5	Tivi21oa	\N	f
3	pbkdf2_sha256$320000$xGeGKH2uazzf10X89Gx7zA$Dc/Wd7PGKt5fLRvvE50y1xwij5+ys0NWWpDqWWS5+cc=	2023-03-13 19:58:39.614814+01	f	user2	Ivan	Fun	44741@edu.raseko.fi	f	t	2022-04-09 07:57:02+02	+358411236544	10002	images/students/jurica-koletic-7YVZYZeITc8-unsplash.jpg	student	5	Tivi20oa	\N	t
7	pbkdf2_sha256$320000$PqZm54D0lCgkwnejf49m2M$4NzOjVOnlA4IOh0YOqQFon2+00C8qieZ4cxc4qm5oFI=	2022-12-05 21:12:13+01	f	user6	James	Bond	44741@edu.raseko.fi	f	t	2022-04-13 04:47:05+02	+358419786430	10006	images/students/portrait-800.jpg	student	5	Tivi23oa	\N	f
8	pbkdf2_sha256$320000$clnjwQc1tqKhcxQxqouaw8$5ZLb7MM0Ix/n9I/+E3rQ0woy83TeKzPKYMaZ4gNf5oo=	\N	f	user7	Cory	Henry	44741@edu.raseko.fi	f	t	2022-04-13 04:55:32+02	+358414657798	10007	images/students/Cory_henry_iQAEJIl.jpg	student	22	Tivi20oa	\N	f
20	pbkdf2_sha256$320000$jgoNgiQ6dyeQ3fEA9rstG5$ERNyXabfHYPEzkbOm+MJwV3R4VjZID22FgFxCwWDhyI=	2023-03-13 09:36:55.647145+01	f	user26	Frank	Gehry	Frank.Gehry@edu.raseko.fi	t	t	2023-01-28 19:49:23+01	+3580551232345	10026	images/students/4125.97.jpg	storage_employee	\N	\N	2	t
12	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user11	Jerrome	Yekel	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358417784659	10011	images/students/erik-lucatero-d2MSDujJl2g-unsplash.jpg	student	22	Tivi23oa	\N	f
21	pbkdf2_sha256$320000$YyIcTDmB6dDt50OhSk1QZa$4vMfNz96oyebhkAdas2wYRiD163L567P+UvFGBwsGmQ=	2023-03-13 09:37:13.014265+01	f	user27	Nikola	Tesla	Nikola.Tesla@edu.raseko.fi	t	t	2023-01-29 11:22:17+01	+3580563212525	10027	images/varastousers/22-Nikola-Vesla.jpg.webp	storage_employee	\N	\N	3	t
14	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user13	Raff	Baulk	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358419786555	10013	images/students/nonsap-visuals-kMJp7620W6U-unsplash.jpg	student	22	Tivi20zz	\N	f
25	pbkdf2_sha256$320000$sv7Jn7IVFTZw6lDpR78jwa$Uwt7+GpZdrjYfk8o4rwQ2I5+d7e3InXw5bsUh+26BEE=	\N	f	user32	John	Travolta	44741@edu.raseko.fi	f	t	2023-03-22 08:09:14+01	\N	10032	images/varastousers/ian-dooley-d1UPkiFd04A-unsplash.jpg	student	5	Tivi20oa	1	f
16	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user15	Fabien	Lumsdall	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358417745121	10015	images/students/ospan-ali-GUmRXc-vOxw-unsplash.jpg	student	22	Tivi21oa	\N	f
17	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user16	Bern	Gamet	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358413216232	10016	images/students/prince-akachi-GqHeaHja5m0-unsplash.jpg	student	5	Tivi20oa	\N	f
18	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user17	Kayle	Cerman	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358417223255	10017	images/students/taylor-hernandez-DLKR_x3T_7s-unsplash.jpg	student	22	Tivi21oa	\N	f
22	pbkdf2_sha256$320000$GdElLv15tE315A6H8E3dzP$s31SFqes35OVGjT1C8Cf+DU2v3nTbJuconW6qJjW1Ak=	\N	f	user28	Isaac	Newton	itsnotamovie@gmail.com	f	t	2023-01-29 18:10:51+01	+3580603332525	10028	images/varastousers/isaac_newton.jpg	teacher	\N	\N	\N	f
13	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	2023-01-16 20:03:37+01	f	user12	Kate	Bate	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358412987825	10012	images/students/christopher-campbell-rDEOVtE7vOs-unsplash.jpg	student_extended	5	Tivi20zz	1	t
9	pbkdf2_sha256$320000$QelKsu2JnK6NcIuI2pLiqd$IKMoZgC8mM/VNiGJZl4DYHcWh44h538A8iFiP49a2pY=	\N	f	user8	Alexa	Liras	44741@edu.raseko.fi	f	t	2022-04-14 06:53:44+02	+358414657988	10008	images/students/aiony-haust-uUem73YWgSI-unsplash.jpg	student	5	Tivi20oa	\N	f
10	pbkdf2_sha256$320000$nUjPojFsFNSB2Xg7NNhe1N$fghRZLNKE+H83fytnjSHFItVHZOtmMhIGpuivAPJpaM=	\N	f	user9	Daniel	Thomas	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358415441232	10009	images/students/ryan.jpg	student	22	Tivi21oa	\N	f
15	pbkdf2_sha256$320000$4onLk40AZ0O597zstJkJts$cLDCK6N1OW5wFzLdTkgKCsZDLi5UtIrWD+TmmbB+RxI=	\N	f	user14	Janaye	Beevers	44741@edu.raseko.fi	f	t	2022-04-14 06:56:05+02	+358418859633	10014	images/students/shirish-suwal-YDDJlslq2Iw-unsplash.jpg	student	5	Tivi20zz	\N	t
2	pbkdf2_sha256$320000$WBPaLO037bq7twXDLBtRm4$qMDkz51ObcqJRpZd1d6ICs6U7yXjgRRWOHAgqe6qsas=	2023-01-16 14:00:07+01	f	user1	Jan	Ivanech	44741@edu.raseko.fi	f	t	2022-04-09 07:51:07+02	+358445554466	10001	images/students/ian-dooley-d1UPkiFd04A-unsplash.jpg	student	5	Tivi20oa	\N	f
24	pbkdf2_sha256$320000$RclFdarVsBfCnglOj0lJXq$jrjookUVZC30nOWRh1H76ijNjvhBxSJDdhWzgLgKwdQ=	2023-03-03 10:19:09.558829+01	f	user31	Albert	Einstein		f	t	2023-03-03 10:03:06+01	\N	\N		student	\N	\N	\N	f
4	pbkdf2_sha256$320000$40KgcggfsrL4gvAtur55fr$n7jDfVuXAftFO4kt7YWsid8OkDydNGe5uMdnyP3eBg0=	2023-12-11 13:54:28.840159+01	f	user3	John	Pon	44741@edu.raseko.fi	f	t	2022-04-09 08:01:18+02	+358415459494	10003	images/students/karsten-winegeart-kWm6bXPJl4s-unsplash_q2RkTDD.jpg	student_extended	22	Tivi21oa	1	t
19	pbkdf2_sha256$320000$0bkuHF49TEQt0pfHAznkqF$yPGpPl2rtzF+e7Qsx68dd/tgLxcJuRtpKtEMK57HT0w=	2023-12-13 13:19:23.526599+01	f	user25	Antonio	Banderas	Banderas.Antonio@edu.raseko.fi	t	t	2023-01-14 19:32:18+01	+358001234567	10025	images/students/antonio_banderas.jpg	storage_employee	\N	\N	4	t
5	pbkdf2_sha256$320000$Zrefc5zwMxbOHJJICrqhyF$OIPNkptlK2zbOK1GUVVDrxUFMX0BECnom1/yY1tiFCk=	2025-02-28 00:02:22.114024+01	f	user4	Phill	Collins	44741@edu.raseko.fi	t	t	2022-04-09 08:02:46+02	+358413121212	10004	images/students/craig-mckay-jmURdhtm7Ng-unsplash.jpg	management	\N	\N	\N	t
6	pbkdf2_sha256$320000$XuP7cYf1r79x2zET0KBLvG$fCCs/4Pgu3mxAtt3f7zLQjdzUKPm7Kx3Jjv9hgcnoAA=	2026-01-19 17:59:28.449114+01	f	user5	Jessica	Benz	10005@edu.raseko.fi	t	t	2022-04-09 08:22:58+02	+358412335645	10005	images/students/jessica-felicio-_cvwXhGqG-o-unsplash.jpg	storage_employee	\N	\N	1	t
1	pbkdf2_sha256$320000$3bKoV45jyEJjCSoooKybyd$Mb9hlscALo7/dt40YalfSwN9BlrbmCzHpc33ScZRZ1M=	2026-02-14 21:41:08.80383+01	t	admin	Elon	Musk	admin@admin.com	t	t	2022-04-09 07:44:53+02	+3588503450	00001		super	\N	\N	\N	t
\.


--
-- Data for Name: varasto_customuser_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_customuser_groups (id, customuser_id, group_id) FROM stdin;
2	6	5
3	5	2
4	2	3
5	3	3
6	4	4
7	7	3
8	8	3
9	9	3
10	10	3
11	11	3
12	12	3
13	13	4
14	14	3
15	15	3
16	16	3
17	17	3
18	18	3
19	1	1
20	19	5
21	20	5
22	21	5
23	22	6
24	25	3
\.


--
-- Data for Name: varasto_customuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: varasto_goods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_goods (id, item_name, brand, model, item_type, size, parameters, contents, picture, item_description, cost_centre, purchase_data, purchase_price, purchase_place, invoice_number, cat_name_id, storage_id, ean, amount, storage_place, unit_id, amount_x_contents) FROM stdin;
15	Ruuvitalttasarja	Stanley	DWE576K	Käsityökalu		\N	1.0000	images/goods/14.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	amet	2021-11-06	374.90	Sotka	859525238-6	3	1	5979575431115	1	B53	\N	\N
53	Ruuvitalttasarja	Patriot	PBC-380-35P	Käsityökalu		\N	1.0000	images/goods/52.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	dui	2021-04-19	373.39	Ikea	207493321-5	2	1	7935120513268	1	C11	\N	\N
110	Mitat	Elitech	PTK-305/1600P	sähkötyökalu		\N	1.0000	images/goods/42.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	eu	2021-01-16	39.34	Sotka	864665997-6	2	1	8195657609867	1	C18	\N	\N
19	Nitojat	Bosch	MS 3024 LMB	akkutyökalu		\N	1.0000	images/goods/18.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	phasellus	2021-09-03	352.82	Ikea	787309193-7	3	1	4661912732614	1	B24	\N	\N
73	Ruuvitalttasarja	Huter	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/5.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	faucibus	2021-08-09	279.60	Ikea	994064108-7	3	1	8063285591312	1	C14	\N	\N
131	Nitojat	AEG	UC250DZ	akkutyökalu		\N	1.0000	images/goods/63.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	accumsan	2021-08-01	347.79	K-Rauta	487018261-0	3	1	6534080956547	1	B73	\N	\N
134	Pyörösahat	Stanley	MMA 250H	Käsityökalu		\N	1.0000	images/goods/66.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	cursus	2021-06-08	97.50	Power	779936463-7	2	1	3832083890530	1	A94	\N	\N
141	Nitojat	Patriot	LM5347BS	\N		3000W 220V	1.0000	images/goods/6.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	ut	2021-01-04	163.83	Ikea	718082352-X	3	1	7948298541837	1	C12	\N	\N
17	Puukkosahat	Husqvarna	MS 3024 LMB	Käsityökalu		\N	1.0000	images/goods/16.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	ultrices	2021-11-08	91.73	Biltema	824727194-X	3	1	8300085296833	1	C23	\N	\N
274	Porakone	Bosch	553	\N	\N	\N	\N	images/goods/img_vF7AIYDPPQ1pQ022CVQ7Bp3Dr0EIsSoXslH5TmNHw90PBvu9lGFMTuPYmaTOMBi4.png		153344	2023-01-12	154.00	K-Rauta	31225556	2	1	1313131515	1	\N	\N	\N
82	Ruuvitalttasarja	Interskol	TKHS 315 C-2.8 DNB 103152100	sähkötyökalu		\N	1.0000	images/goods/14.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	nisl	2021-10-09	94.76	Biltema	356465275-2	3	1	3027832112844	1	A74	\N	\N
67	Lastulevyt	KoskiWall			50x90 mm	\N	1.0000	images/goods/66.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	ipsum	2021-04-09	372.44	Sotka	514930481-6	3	1	2010914554227	1	A49	\N	\N
27	Nitojat	Stanley	MMA 250H	akkutyökalu		\N	1.0000	images/goods/26.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	donec	2021-10-07	175.55	Sotka	156045005-3	2	1	0475666200655	1	A18	\N	\N
162	Mitat	PROF	PTK-305/1600P	Käsityökalu		\N	1.0000	images/goods/27.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	aliquet	2021-04-04	484.77	Verkkokauppa	087330190-0	2	1	6815746196084	1	B83	\N	\N
186	Porakone	PROF	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/51.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	quisque	2021-02-25	207.10	Power	187530167-4	2	1	3391269031062	1	A87	\N	\N
21	Puukkosahat	PROF	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/20.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	in	2021-11-10	77.03	Verkkokauppa	588312838-6	2	1	0619846352379	1	A21	\N	\N
39	Puukkosahat	FXA	Prestige 151/S	Käsityökalu		\N	1.0000	images/goods/38.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	amet	2021-12-23	362.47	Power	236956937-9	3	1	4130153480189	1	A97	\N	\N
41	Lastulevyt	KoskiWall			20x30x150 cm	\N	1.0000	images/goods/40.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	cursus	2021-11-20	173.37	K-Rauta	650634149-1	3	1	2305000316325	1	A56	\N	\N
264	Asennuskaapeli	OPAL	310	\N	\N	2x0,75mm² 10m musta	10.5000	images/goods/15_ZG4K3L8.jpg		\N	2022-11-16	154.00	K-Rauta	35204405	1	1	6419184705481	6	\N	4	63.0000
32	Pyörösahat	Daewoo	PTK-305/1600P	akkutyökalu		\N	1.0000	images/goods/31.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	sapien	2021-03-17	486.92	Power	268910264-1	3	1	4812253061152	1	B29	\N	\N
46	Lastulevyt	KoskiWall			5.5x10 m	\N	1.0000	images/goods/45.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	accumsan	2021-08-21	214.23	Verkkokauppa	088490703-1	3	1	6462082007685	1	B69	\N	\N
49	Pyörösahat	Patriot	MS 3024 LMB	Käsityökalu		\N	1.0000	images/goods/48.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	in	2021-07-04	460.55	Biltema	751597230-0	2	1	5859537588747	1	B48	\N	\N
54	Hitsauskone	BlueWeld	MS 3024 LMB	sähkötyökalu		3000W 220V	1.0000	images/goods/53.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	eget	2021-08-17	419.67	Sotka	051164039-0	3	1	4288733937276	1	B14	\N	\N
58	Puukkosahat	Stanley	UVO-1000-36-EL	Käsityökalu		\N	1.0000	images/goods/57.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	euismod	2021-03-05	145.98	Power	276240239-5	2	1	6652378078022	1	B76	\N	\N
60	Hitsauskone	Huter	MS 3024 LMB	akkutyökalu		3000W 220V	1.0000	images/goods/59.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	quisque	2021-01-12	411.80	K-Rauta	061711854-X	2	1	5941672119187	1	B52	\N	\N
188	Ruuvitalttasarja	DeWALT	UC250DZ	Käsityökalu		\N	1.0000	images/goods/53.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	ut	2021-09-24	130.42	Prisma	702545694-2	2	1	8501149996368	1	C25	\N	\N
177	Hiomakone	Daewoo	DWE576K	\N		3000W 220V	1.0000	images/goods/42.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	pretium	2021-04-25	336.23	Sotka	808720475-1	2	1	9890060711909	1	C49	\N	\N
68	Lastulevyt	KoskiWall			10x50x200 cm	\N	1.0000	images/goods/67.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	montes	2021-01-26	367.15	Gigantti	134407571-1	3	1	5005227135213	1	B32	\N	\N
37	Porakone	Interskol	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/36.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	pellentesque	2021-06-01	484.51	Verkkokauppa	343440399-X	2	1	1999946373408	1	A48	\N	\N
63	Porakone	FXA	LM5347BS	akkutyökalu		\N	1.0000	images/goods/62.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	id	2021-11-29	400.13	Gigantti	276509903-0	2	1	8029200572422	1	C13	\N	\N
74	Nitojat	Huter	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/6.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	accumsan	2021-07-10	351.27	Power	575847523-8	3	1	9586996517029	1	C45	\N	\N
273	Juotosbetoni	Lakka	310	\N	\N	\N	1.0000	images/goods/65_6n94Y6x.jpg		153344	2022-11-30	362.00	K-Rauta	35204405	2	1	6419184705481	1	\N	\N	\N
275	käsineet	Showa	GF	\N	\N	\N	1.0000	images/goods/img_7Puvy7QlNMy9KE65AYRYe31Vr3NtUT7x4v40Jv0du5xzv9ycjJGDw8Ngmd2zeC1E.png		\N	\N	\N	\N	\N	2	1	6419184705481	1	\N	\N	\N
93	Akku	Daewoo	MS 3024 LMB	\N		48V	1.0000	images/goods/25.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	velit	2021-05-07	478.26	Sotka	041927496-0	2	1	1018292563945	1	A31	\N	\N
83	Lastulevyt	KoskiWall			50x50x20 cm	\N	1.0000	images/goods/15.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	imperdiet	2021-10-04	150.20	Biltema	040583314-8	2	1	0619653373587	1	A19	\N	\N
85	Akku	PROF	TKHS 315 C-2.8 DNB 103152100	sähkötyökalu		\N	1.0000	images/goods/17.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	luctus	2021-08-22	277.48	Sotka	451880184-9	3	1	4039702216830	1	A96	\N	\N
105	Hiomakone	AEG	Prestige 151/S	\N		3000W 220V	1.0000	images/goods/37.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	tristique	2021-12-02	200.35	Sotka	947920614-5	2	1	5334073903293	1	B36	\N	\N
107	Pyörösahat	Daewoo	PBC-380-35P	\N		3000W 220V	1.0000	images/goods/39.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	pede	2021-09-08	389.74	Ikea	946684854-2	2	1	5935853790359	1	B51	\N	\N
123	Mitat	Husqvarna	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/55.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	luctus	2021-03-14	447.53	Power	149877444-X	2	1	5503503397094	1	B42	\N	\N
80	Hiomakone	PROF	PTK-305/1600P	akkutyökalu		\N	1.0000	images/goods/12.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	dui	2021-06-22	381.96	Sotka	289852297-X	2	1	6150234002419	1	B59	\N	\N
77	Pyörösahat	Elitech	UVO-1000-36-EL	Käsityökalu		\N	1.0000	images/goods/9.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	fusce	2021-08-20	246.84	Motonet	014666702-6	2	1	1755182479181	1	A43	\N	\N
113	Porakone	Patriot	PTK-305/1600P	Käsityökalu		\N	1.0000	images/goods/45.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	maecenas	2021-09-17	285.36	Verkkokauppa	146899073-X	3	1	0873215879200	1	A23	\N	\N
115	Akku	Patriot	DP-2.0-200	sähkötyökalu		\N	1.0000	images/goods/47.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	quis	2021-09-10	497.91	Motonet	130562019-4	2	1	4718839652597	1	B26	\N	\N
96	Akku	Makita	PTK-305/1600P	sähkötyökalu		\N	1.0000	images/goods/28.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	id	2021-09-13	62.32	Biltema	150975411-3	3	3	4549018865312	1	B22	\N	\N
98	Puukkosahat	BlueWeld	PBC-380-35P	\N		3000W 220V	1.0000	images/goods/30.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	accumsan	2021-05-20	459.01	Biltema	775122399-5	3	3	3192354513711	1	A82	\N	\N
52	Hiomakone	Elitech	DP-2.0-200	sähkötyökalu	\N	\N	1.0000	images/goods/51.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	vulputate	2021-01-12	414.69	K-Rauta	023147572-1	3	1	1720924868275	1	A44	\N	\N
90	Ruuvitalttasarja	Interskol	Prestige 151/S	sähkötyökalu		\N	1.0000	images/goods/22.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	donec	2021-06-15	452.34	Motonet	599544976-1	3	1	9239779558980	1	C37	\N	\N
139	Hiomakone	DeWALT	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/4.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	est	2021-07-09	102.78	Gigantti	648982192-3	2	1	4374117445491	1	B17	\N	\N
140	Mitat	Husqvarna	AKM-3605	akkutyökalu		\N	1.0000	images/goods/5.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	habitasse	2021-03-22	267.80	Power	926557044-X	3	1	2830155083288	1	A71	\N	\N
143	Pyörösahat	Husqvarna	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/8.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	aliquet	2021-09-08	464.84	Sotka	305402471-7	3	1	2036734690796	1	A51	\N	\N
126	Pyörösahat	BlueWeld	DWE576K	\N		3000W 220V	1.0000	images/goods/58.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	rhoncus	2021-08-11	220.57	Power	966161515-2	3	1	4695233694775	1	B25	\N	\N
164	Mitat	Stanley	BBK-2220	sähkötyökalu		\N	1.0000	images/goods/29.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	suspendisse	2021-08-30	64.98	Gigantti	234346464-2	3	1	3807938938146	1	A93	\N	\N
146	Porakone	Makita	MMA 250H	sähkötyökalu		\N	1.0000	images/goods/11.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	duis	2021-01-17	40.22	Sotka	209744009-6	2	1	9423290649875	1	C39	\N	\N
148	Nitojat	Makita	PTK-305/1600P	Käsityökalu		\N	1.0000	images/goods/13.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	parturient	2021-06-16	404.42	Power	247982400-4	2	1	4255211744651	1	B12	\N	\N
132	Puukkosahat	Interskol	PBC-380-35P	Käsityökalu		\N	1.0000	images/goods/64.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	interdum	2021-05-30	79.67	K-Rauta	271921714-X	2	1	1875961451803	1	A46	\N	\N
168	Hiomakone	FXA	DP-2.0-200	Käsityökalu		\N	1.0000	images/goods/33.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	dictumst	2021-01-09	241.07	Gigantti	423155135-9	3	1	5146593628858	1	B33	\N	\N
150	Ruuvitalttasarja	Huter	MS 3024 LMB	akkutyökalu		\N	1.0000	images/goods/15.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	nulla	2021-01-08	53.75	K-Rauta	757882400-7	2	1	5443543133670	1	B38	\N	\N
173	Hitsauskone	BlueWeld	LM5347BS	akkutyökalu		3000W 220V	1.0000	images/goods/38.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	et	2021-03-11	411.03	K-Rauta	452360388-X	2	1	7011951070176	1	B88	\N	\N
178	Ruuvitalttasarja	Huter	TKHS 315 C-2.8 DNB 103152100	sähkötyökalu		\N	1.0000	images/goods/43.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	congue	2021-10-21	62.54	Biltema	978794791-X	3	1	5657517164846	1	B46	\N	\N
159	Hitsauskone	Huter	BBK-2220	sähkötyökalu		3000W 220V	1.0000	images/goods/24.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	sit	2021-04-13	163.11	K-Rauta	992605515-X	2	1	2523535301926	1	A63	\N	\N
276	Puhdistus-suihke	Pirkka	\N	\N	\N	\N	0.1000	images/goods/img_BectBqFNnqETT09YXVdKTMLBVdVF4p5syUMYMOPF4JDjEvB5GG2pbRxWQnaLo8Zz.png		456654	2023-01-09	2.50	K-Market	654654654	1	1	23232323546	0	\N	2	0.2000
136	Mitat	Bosch	TKHS 315 C-2.8 DNB 103152100	akkutyökalu	\N	\N	1.0000	images/goods/1.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	posuere	2021-03-31	299.53	Verkkokauppa	378401538-7	2	1	1933228030858	1	A47	\N	\N
25	Porakone	Interskol	AKM-3605	akkutyökalu		\N	1.0000	images/goods/24.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	purus	2021-01-10	311.20	Motonet	864420727-X	2	1	0963805980869	1	A25	\N	\N
192	Puukkosahat	FXA	UC250DZ	Käsityökalu		\N	1.0000	images/goods/57.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	ante	2021-09-19	189.02	Motonet	712540976-8	2	1	4197526620283	1	B11	\N	\N
200	Lastulevyt	KoskiWall			5.5x10 m	\N	1.0000	images/goods/65.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	libero	2021-01-02	202.88	Verkkokauppa	324151896-5	2	1	0767834329922	1	A22	\N	\N
184	Ruuvitalttasarja	Husqvarna	MS 3024 LMB	Käsityökalu		\N	1.0000	images/goods/49.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	nulla	2021-02-13	472.99	Gigantti	427041345-X	3	1	4548123059789	1	B21	\N	\N
26	Hiomakone	Makita	PTK-305/1600P	akkutyökalu		\N	1.0000	images/goods/25.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	suscipit	2021-12-23	324.51	K-Rauta	544577187-3	2	1	3106042554305	1	A77	\N	\N
55	Pyörösahat	Stanley	UC250DZ	akkutyökalu		\N	1.0000	images/goods/54.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	dictumst	2021-02-26	253.68	Gigantti	183569812-3	2	1	2059364182028	1	A52	\N	\N
142	Nitojat	Interskol	LM5347BS	Käsityökalu		\N	1.0000	images/goods/7.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	venenatis	2021-07-28	147.94	Sotka	803508133-0	3	1	3201262459882	1	A83	\N	\N
151	Hitsauskone	Husqvarna	MS 3024 LMB	\N		3000W 220V	1.0000	images/goods/16.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	lacus	2021-01-30	431.96	K-Rauta	330821437-7	2	1	7705061199502	1	B98	\N	\N
70	Nitojat	PROF	PBC-380-35P	Käsityökalu		\N	1.0000	images/goods/2.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	condimentum	2021-03-20	121.45	Prisma	443894926-2	2	1	3702250217768	1	A91	\N	\N
155	Puukkosahat	Stanley	Prestige 151/S	\N		3000W 220V	1.0000	images/goods/20.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	faucibus	2021-02-16	113.07	Motonet	581311902-7	3	1	1771981785054	1	A44	\N	\N
175	Puukkosahat	DeWALT	AKM-3605	Käsityökalu		\N	1.0000	images/goods/40.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	augue	2021-04-10	397.41	Verkkokauppa	563731626-0	3	1	1265836048116	1	A34	\N	\N
181	Puukkosahat	Stanley	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/46.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	tristique	2021-10-16	104.50	Prisma	296354831-1	3	1	4264476404540	1	B13	\N	\N
190	Lastulevyt	KoskiWall			10x50x200 cm	\N	1.0000	images/goods/55.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	odio	2021-05-18	102.91	Biltema	764603163-1	3	1	3803673870458	1	A92	\N	\N
195	Ruuvitalttasarja	Husqvarna	UC250DZ	akkutyökalu		\N	1.0000	images/goods/60.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	sit	2021-02-13	207.49	Ikea	010745375-4	3	1	6392678593548	1	B66	\N	\N
18	Puukkosahat	Makita	DWE576K	\N		3000W 220V	1.0000	images/goods/17.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	lobortis	2021-04-04	293.45	Ikea	221755835-8	3	1	1351945523927	1	A35	\N	\N
20	Akku	BlueWeld	PTK-305/1600P	\N		48V	1.0000	images/goods/19.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	euismod	2021-05-12	177.06	Ikea	566324334-8	2	1	6549369290239	1	B74	\N	\N
4	Ruuvitalttasarja	BlueWeld	AKM-3605	sähkötyökalu	\N	1212	1.0000	images/goods/3.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	sodales	2021-03-13	60.87	Motonet	328371860-1	2	2	1422644111859	1	A37	\N	\N
6	Puukkosahat	Daewoo	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/5.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	sed	2021-05-23	431.48	Biltema	119019121-0	3	1	8902971109667	1	C32	\N	\N
7	Porakone	Makita	MS 3024 LMB	sähkötyökalu	\N	\N	1.0000	images/goods/6.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	metus1	2021-06-21	200.97	K-Rauta	425157711-6	\N	1	9554157150565	1	C43	\N	\N
5	Nitojat	Patriot	PTK-305/1600P	123	\N	\N	1.0000	images/goods/4.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	duis	2021-10-04	277.54	Gigantti	158457317-1	2	1	8934597067569	1	C33	\N	\N
51	Puukkosahat	AEG	PBC-380-35P	sähkötyökalu		\N	1.0000	images/goods/50.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	massa	2021-06-01	231.29	Ikea	488862171-3	3	1	2765197343363	1	A66	\N	\N
251	Speaker	Sven	310	\N	\N	\N	1.0000	images/goods/img_TNmNeoIbOivMswiwZ6pCKRYjndHx77Xco1GiTfxI84rUiOYnF0YAQwTq8paAC24S.png		\N	\N	\N	\N	\N	2	2	6419184705481	1	\N	\N	\N
259	Kuparijohdin	LM	550	2	\N	halkaisija 3mm	20.0000	images/goods/img_XEr4AwGK9sRbvAAjP0ewt4WplmIk3PQmsSLzfnvhteNjlSgavUNuzJRw6ybnyKX2_WEYaifn.png	Test kuvaus2	23253	2022-11-01	234.00	K-Rauta	2323	1	1	7894561233213	43	\N	4	870.0000
33	Puukkosahat	AEG	UVO-1000-36-EL	\N		3000W 220V	1.0000	images/goods/32.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	vitae	2021-08-04	254.65	Verkkokauppa	938996121-1	2	1	1016007180132	1	A29	\N	\N
10	Akku	Elitech	LM5347BS	sähkötyökalu		\N	1.0000	images/goods/9.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	lacus	2021-04-02	166.69	Gigantti	546300271-1	3	1	4318092522109	1	B15	\N	\N
9	Akku	Bosch	UC250DZ	\N		36V	1.0000	images/goods/8.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	nisl	2021-12-27	108.65	Prisma	606176881-8	2	1	3314078875543	1	A84	\N	\N
8	Porakone	Husqvarna	MS 3024 LMB	sähkötyökalu		\N	1.0000	images/goods/7.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	primis	2021-02-22	364.65	Biltema	604590908-9	2	1	6112630378684	1	B56	\N	\N
13	Pyörösahat	Husqvarna	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/12.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	quis	2021-03-21	475.49	K-Rauta	975649234-1	2	1	5994553021712	1	B54	\N	\N
14	Akku	AEG	DP-2.0-200	\N		50V	1.0000	images/goods/13.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	lectus	2021-05-19	191.24	Power	356566411-8	3	1	9321301361696	1	C38	\N	\N
16	Nitojat	Elitech	PBC-380-35P	akkutyökalu		\N	1.0000	images/goods/15.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	curabitur	2021-07-15	356.88	Ikea	350111731-0	3	1	6729770998156	1	B79	\N	\N
250	Speaker	Sven	310	\N	\N	\N	1.0000	images/goods/img_TNmNeoIbOivMswiwZ6pCKRYjndHx77Xco1GiTfxI84rUiOYnF0YAQwTq8paAC24S.png		\N	\N	\N	\N	\N	2	2	6419184705481	1	\N	\N	\N
2	Nitojat	AEG	MMA 250H	akkutyökalu	\N	\N	1.0000	images/goods/1.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	volutpat	2021-11-10	228.45	Gigantti	306815181-3	3	1	1041355626648	1	A32	\N	\N
11	Hiomakone	AEG	BBK-2220	akkutyökalu		\N	1.0000	images/goods/10.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	non	2021-03-18	275.13	Sotka	421877087-5	3	1	6220997072532	1	B61	\N	\N
12	Hiomakone	Interskol	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/11.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	lorem	2021-09-24	211.40	Verkkokauppa	314761777-7	3	1	6725866124632	1	B78	\N	\N
38	Mitat	FXA	LM5347BS	akkutyökalu		\N	1.0000	images/goods/37.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	vitae	2021-03-08	471.36	K-Rauta	261072184-6	2	1	0950132082745	1	A24	\N	\N
24	Ruuvitalttasarja	AEG	BBK-2220	sähkötyökalu		\N	1.0000	images/goods/23.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	purus	2021-12-21	468.83	Biltema	521442453-1	3	1	3101345022127	1	A76	\N	\N
28	Pyörösahat	FXA	MS 3024 LMB	\N		3000W 220V	1.0000	images/goods/27.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	et	2021-08-04	295.92	Verkkokauppa	244883514-4	3	1	0468170111479	1	A17	\N	\N
36	Hitsauskone	Huter	MS 3024 LMB	\N		3000W 220V	1.0000	images/goods/35.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	rutrum	2021-05-30	363.53	Motonet	160316366-2	3	1	4366169033239	1	B16	\N	\N
40	Hiomakone	PROF	AKM-3605	akkutyökalu		\N	1.0000	images/goods/39.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	et	2021-04-26	321.10	Biltema	919806814-8	3	1	6285947055970	1	B63	\N	\N
50	Puukkosahat	BlueWeld	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/49.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	in	2021-10-20	87.85	Power	760755143-3	2	1	7113723787117	1	B93	\N	\N
44	Hiomakone	Stanley	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/43.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	tellus	2021-08-12	435.27	Sotka	214050702-9	2	1	6870599055218	1	B86	\N	\N
22	Nitojat	Huter	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/21.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	tincidunt	2021-10-05	102.26	Sotka	010447804-7	3	1	5720023049552	1	B47	\N	\N
23	Hiomakone	Stanley	MS 3024 LMB	\N		3000W 220V	1.0000	images/goods/22.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	tempor	2021-07-14	184.05	Biltema	685521187-9	2	1	8125661423674	1	C16	\N	\N
34	Akku	Elitech	DP-2.0-200	sähkötyökalu		\N	1.0000	images/goods/33.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	pellentesque	2021-10-03	157.89	Verkkokauppa	363242453-5	2	1	2292122790366	1	A55	\N	\N
31	Pyörösahat	Interskol	UC250DZ	sähkötyökalu		\N	1.0000	images/goods/30.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	et	2021-05-15	101.69	Power	266986917-3	2	1	8155530567352	1	C17	\N	\N
35	Nitojat	Stanley	LM5347BS	akkutyökalu		\N	1.0000	images/goods/34.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	orci	2021-06-06	318.20	Gigantti	881175363-5	3	1	5459403771022	1	B39	\N	\N
29	Hiomakone	Bosch	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/28.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	dui	2021-10-18	245.22	Verkkokauppa	341968597-1	2	1	3056464169736	1	A75	\N	\N
45	Hitsauskone	Interskol	UC250DZ	sähkötyökalu		3000W 220V	1.0000	images/goods/44.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	sit	2021-02-05	409.77	Biltema	062997938-3	2	1	6769005552511	1	B81	\N	\N
48	Akku	DeWALT	AKM-3605	Käsityökalu		\N	1.0000	images/goods/47.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	non	2021-02-04	490.04	Ikea	303183468-2	2	1	2789850859850	1	A69	\N	\N
252	Juotosbetoni	Lakka	310	Stereo	\N	10Wt	1.0000	images/goods/img_GmHIrSdnQZUsZULn5h534ARpDT9PV4GkbA1d6J2UaLQAPcreLbE1afMwo5CSqZN0.png		153344	\N	\N	K-Rauta	35204405	2	1	6419184705481	1	\N	\N	\N
42	Puukkosahat	Daewoo	PTK-305/1600P	sähkötyökalu		\N	1.0000	images/goods/41.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	viverra	2021-11-01	462.94	Verkkokauppa	657162817-1	3	1	2446860541254	1	A59	\N	\N
56	Hitsauskone	Husqvarna	DWE576K	sähkötyökalu		3000W 220V	1.0000	images/goods/55.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	morbi	2021-04-02	175.12	Gigantti	569203520-0	3	1	3872544196061	1	A95	\N	\N
64	Mitat	Interskol	UC250DZ	\N		3000W 220V	1.0000	images/goods/63.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	lacus	2021-08-09	278.18	Ikea	845661411-4	2	1	8250083186364	1	C21	\N	\N
78	Lastulevyt	KoskiWall			150x300x500 cm	\N	1.0000	images/goods/10.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	tincidunt	2021-08-02	55.70	Power	198141591-2	2	1	3327699948376	1	A86	\N	\N
76	Porakone	Bosch	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/8.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	bibendum	2021-01-01	66.15	Biltema	213378240-0	2	1	3112190645428	1	A78	\N	\N
61	Hiomakone	BlueWeld	UC250DZ	akkutyökalu		\N	1.0000	images/goods/60.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	vitae	2021-03-03	424.83	Sotka	515739815-8	2	1	9907278956023	1	C51	\N	\N
62	Hitsauskone	Daewoo	DWE576K2	sähkötyökalu	\N	3000W 220V	1.0000	images/goods/61.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	\N	\N	\N	\N	\N	\N	\N	3607650823999	1	A88	\N	\N
65	Akku	Bosch	AKM-3605	\N		36V	1.0000	images/goods/64.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	bibendum	2021-09-15	78.60	Biltema	847280985-4	2	1	5876172494672	1	B49	\N	\N
79	Pyörösahat	AEG	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/11.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	pulvinar	2021-06-14	123.35	Power	285309380-8	2	1	5637421445439	1	B45	\N	\N
59	Pyörösahat	DeWALT	LM5347BS	akkutyökalu		\N	1.0000	images/goods/58.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	leo	2021-12-16	316.07	Motonet	985629576-9	2	1	2473672384261	1	A62	\N	\N
57	Akku	Huter	MMA 250H	Käsityökalu		\N	1.0000	images/goods/56.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	augue	2021-04-26	140.03	K-Rauta	060505657-9	3	1	2346483959715	1	A57	\N	\N
171	Mitat	Husqvarna	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/36.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	donec	2021-12-08	480.75	K-Rauta	723148326-7	3	1	0046175563540	1	A11	\N	\N
255	Juotosbetoni	Lakka	310	Stereo	\N	10Wt	1.0000	images/goods/img_hJQKUU5fcWLMLAckLX1s8XvbwxZoDjNxMXafzLUMwIHUBSSbrRAqeCqihJsr8eUd.png		\N	\N	362.02	\N	\N	2	1	6419184705481	1	\N	\N	\N
254	Juotosbetoni	Lakka	310	Stereo	\N	10Wt	1.0000	images/goods/img_GmHIrSdnQZUsZULn5h534ARpDT9PV4GkbA1d6J2UaLQAPcreLbE1afMwo5CSqZN0.png		153344	\N	\N	K-Rauta	35204405	2	1	6419184705481	1	\N	\N	\N
72	Akku	Patriot	MMA 250H	\N		36V	1.0000	images/goods/4.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	augue	2021-01-26	86.31	Ikea	882403522-1	3	1	5367977763439	1	B37	\N	\N
69	Puukkosahat	Patriot	LM5347BS	\N		3000W 220V	1.0000	images/goods/1.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	vestibulum	2021-02-22	362.76	Gigantti	323820808-X	2	1	9581930784519	1	C44	\N	\N
81	Porakone	Daewoo	DWE576K	sähkötyökalu		\N	1.0000	images/goods/13.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	tortor	2021-10-04	191.75	K-Rauta	017426228-0	2	1	6045257818462	1	B55	\N	\N
253	Juotosbetoni	Lakka	310	Stereo	\N	10Wt	1.0000	images/goods/img_GmHIrSdnQZUsZULn5h534ARpDT9PV4GkbA1d6J2UaLQAPcreLbE1afMwo5CSqZN0.png		153344	\N	\N	K-Rauta	35204405	2	1	6419184705481	1	\N	\N	\N
86	Porakone	Bosch	DWE576K	Käsityökalu		\N	1.0000	images/goods/18.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	sodales	2021-10-18	59.45	Prisma	880251447-X	2	1	4778747948105	1	B28	\N	\N
89	Puukkosahat	Patriot	MMA 250H	\N		3000W 220V	1.0000	images/goods/21.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	odio	2021-01-05	310.83	Biltema	024157413-7	2	1	6129147056319	1	B58	\N	\N
88	Nitojat	Daewoo	MS 3024 LMB	\N		3000W 220V	1.0000	images/goods/20.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	id	2021-05-20	317.53	Motonet	626495609-0	2	1	3315660057122	1	A85	\N	\N
91	Ruuvitalttasarja	Daewoo	MMA 250H	sähkötyökalu		\N	1.0000	images/goods/23.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	dolor	2021-04-05	330.31	Biltema	956962286-5	3	1	8829296191829	1	C31	\N	\N
84	Ruuvitalttasarja	PROF	BBK-2220	akkutyökalu		\N	1.0000	images/goods/16.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	nec	2021-01-21	136.80	Prisma	038243125-1	2	1	8394950887982	1	C24	\N	\N
101	Mitat	Husqvarna	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/33.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	donec	2021-12-25	163.78	Sotka	570133668-9	2	1	4178884215301	1	A99	\N	\N
100	Hiomakone	PROF	MMA 250H	sähkötyökalu		\N	1.0000	images/goods/32.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	vestibulum	2021-12-16	178.64	Biltema	399397357-7	2	3	6529112060565	1	B72	\N	\N
109	Nitojat	Husqvarna	UVO-1000-36-EL	Käsityökalu		\N	1.0000	images/goods/41.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	in	2021-09-18	178.52	Biltema	755235595-6	3	1	0982959606038	1	A27	\N	\N
106	Hiomakone	FXA	PBC-380-35P	Käsityökalu		\N	1.0000	images/goods/38.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	ut	2021-01-10	403.70	Gigantti	645130631-2	3	1	\N	1	C52	\N	\N
108	Pyörösahat	Huter	TKHS 315 C-2.8 DNB 103152100	akkutyökalu		\N	1.0000	images/goods/40.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	odio	2021-02-05	391.46	Sotka	165057090-2	3	1	5532414181633	1	B43	\N	\N
104	Hitsauskone	PROF	BBK-2220	\N		3000W 220V	1.0000	images/goods/36.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	turpis	2021-05-14	282.04	Ikea	779119197-0	3	1	8198373212525	1	C19	\N	\N
92	Hitsauskone	FXA	DP-2.0-200	sähkötyökalu		3000W 220V	1.0000	images/goods/24.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	in	2021-11-02	345.64	Motonet	166532689-1	2	1	9488143203023	1	C42	\N	\N
71	Ruuvitalttasarja	Makita	PBC-380-35P	sähkötyökalu		\N	1.0000	images/goods/3.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	pharetra	2021-09-19	393.56	Verkkokauppa	039203725-4	2	1	4131959210739	1	A98	\N	\N
172	Hitsauskone	Bosch	AKM-3605	\N		3000W 220V	1.0000	images/goods/37.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	nullam	2021-11-25	325.66	Power	790003683-0	3	1	2672291120791	1	A65	\N	\N
257	Juotosbetoni	Lakka	310	\N	\N	\N	1.0000	images/goods/img_kEWM3xJ6I1UZIBclraY9QBtBfHv7xkQSPSghIoyD2NQ7yTSc74x7WgoI0TYa2fXy.png		\N	\N	30.50	\N	\N	2	1	6419184705481	1	\N	\N	\N
94	Lastulevyt	KoskiWall		\N	50x90 mm	\N	1.0000	images/goods/26.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	vestibulum	2021-09-27	346.71	Prisma	725624066-X	3	3	6617720332665	1	B75	\N	\N
97	Ruuvitalttasarja	AEG	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/29.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	phasellus	2021-06-10	172.65	Power	203995405-8	2	3	1670774198987	1	A39	\N	\N
99	Pyörösahat	Husqvarna	DWE576K	sähkötyökalu		\N	1.0000	images/goods/31.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	elit	2021-05-03	415.88	Biltema	504031839-1	3	3	6129144693681	1	B57	\N	\N
313	Porakone	MILL	21513	\N	\N	\N	1.0000	images/goods/13_mLZXuLY.jpg		\N	\N	\N	\N	\N	2	1	\N	1	A30	\N	\N
312	qwqwq	wwwww	\N	\N	\N	\N	1.0000	images/goods/3_KB3h0rW.jpg		\N	\N	\N	\N	\N	2	1	\N	1	H31	\N	\N
314	Instr	IMN	MO-350	\N	\N	\N	1.0000	images/goods/7_xZ7uEEK.jpg		\N	\N	\N	\N	\N	2	1	1321213121515	1	\N	\N	\N
316	tttteeeessttt	tttteeeessttt	3213	\N	\N	\N	10.0000			\N	\N	\N	\N	\N	1	3	3434334341223	5	T35	3	45.0000
111	Puukkosahat	Interskol	TKHS 315 C-2.8 DNB 103152100	akkutyökalu		\N	1.0000	images/goods/43.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	aliquam	2021-11-30	52.21	Motonet	695513810-3	2	1	9613874252337	1	C46	\N	\N
121	Puukkosahat	Elitech	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/53.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	nunc	2021-04-03	129.46	Power	846853485-4	3	1	0336318702304	1	A14	\N	\N
135	Nitojat	PROF	Prestige 151/S	Käsityökalu		\N	1.0000	images/goods/67.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	risus	2021-03-28	152.03	Motonet	190349106-1	3	1	2562605021793	1	A64	\N	\N
112	Hiomakone	Interskol	DP-2.0-200	\N		3000W 220V	1.0000	images/goods/44.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	nibh	2021-09-15	259.29	Gigantti	458038964-6	2	1	8949827097964	1	C34	\N	\N
114	Pyörösahat	DeWALT	LM5347BS	Käsityökalu		\N	1.0000	images/goods/46.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	orci	2021-01-16	55.88	Ikea	007966097-5	2	1	6238277309735	1	B62	\N	\N
116	Hiomakone	Bosch	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/48.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	sagittis	2021-11-06	265.92	Motonet	013311968-8	3	1	0150960889331	1	A13	\N	\N
118	Hitsauskone	Makita	UVO-1000-36-EL	sähkötyökalu		3000W 220V	1.0000	images/goods/50.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	orci	2021-10-04	151.77	K-Rauta	676003711-1	2	1	7757377465004	1	B99	\N	\N
125	Hitsauskone	PROF	DWE576K	akkutyökalu		3000W 220V	1.0000	images/goods/57.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	at	2021-05-25	36.74	Sotka	064351957-2	2	1	8619876964475	1	C27	\N	\N
130	Hiomakone	FXA	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/62.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	purus	2021-07-23	170.75	Prisma	278401234-4	3	1	1197056596996	1	A33	\N	\N
122	Puukkosahat	Interskol	MMA 250H	Käsityökalu		\N	1.0000	images/goods/54.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	blandit	2021-04-09	238.92	K-Rauta	734546627-2	2	1	1451362800733	1	A38	\N	\N
138	Hitsauskone	Husqvarna	LM5347BS	sähkötyökalu		3000W 220V	1.0000	images/goods/3.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	venenatis	2021-02-02	245.79	Ikea	995105140-5	3	1	5281270473322	1	B34	\N	\N
124	Akku	Elitech	UC250DZ	\N		60V	1.0000	images/goods/56.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	at	2021-08-10	152.17	Verkkokauppa	490683152-4	2	1	6822118030988	1	B85	\N	\N
127	Hitsauskone	Huter	UVO-1000-36-EL	Käsityökalu		3000W 220V	1.0000	images/goods/59.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	ac	2021-05-20	254.27	Sotka	083109562-8	2	1	4393904845017	1	B18	\N	\N
137	Nitojat	Husqvarna	Prestige 151/S	Käsityökalu		\N	1.0000	images/goods/2.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	sit	2021-10-16	173.91	Prisma	601926594-3	2	1	2211990084874	1	A54	\N	\N
117	Mitat	Makita	PBC-380-35P	akkutyökalu		\N	1.0000	images/goods/49.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	eleifend	2021-01-29	470.71	Ikea	190150958-3	2	1	4574420604829	1	B23	\N	\N
133	Hiomakone	Elitech	BBK-2220	\N		3000W 220V	1.0000	images/goods/65.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	morbi	2021-11-13	143.94	Ikea	687723033-7	2	1	5470508684906	1	B41	\N	\N
153	Hitsauskone	Patriot	DP-2.0-200	sähkötyökalu		3000W 220V	1.0000	images/goods/18.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	lacus	2021-03-04	273.64	Motonet	235805438-0	2	1	8113938902195	1	C15	\N	\N
156	Nitojat	Patriot	PTK-305/1600P	akkutyökalu		\N	1.0000	images/goods/21.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	non	2021-02-05	126.46	Gigantti	835099854-7	3	1	5301901162101	1	B35	\N	\N
144	Lastulevyt	KoskiWall		\N	10x50x200 cm	\N	1.0000	images/goods/9.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	semper	2021-12-15	167.59	Sotka	813480249-4	2	1	6336537935811	1	B64	\N	\N
160	Hiomakone	Elitech	MMA 250H	\N		3000W 220V	1.0000	images/goods/25.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	neque	2021-01-15	368.08	Ikea	092647045-0	3	1	2787639112158	1	A68	\N	\N
145	Mitat	Makita	PTK-305/1600P	akkutyökalu		\N	1.0000	images/goods/10.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	amet	2021-01-06	133.33	Prisma	416820744-7	3	1	4743054274341	1	B27	\N	\N
154	Pyörösahat	FXA	AKM-3605	Käsityökalu		\N	1.0000	images/goods/19.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	ut	2021-07-04	464.15	Prisma	491271987-0	3	1	8527165784587	1	C26	\N	\N
170	Mitat	BlueWeld	TKHS 315 C-2.8 DNB 103152100	sähkötyökalu		\N	1.0000	images/goods/35.jpg	Weight (kg): 11; Power supply: mains; Carbon brush replacement indicator; Safety clutch; Vibration protection system; Functions: Speed limiter; Idle speed (rpm): 320; Number of strokes (bpm): 1900; Impact energy (J): 27; Power consumption (W): 1700; chiselling (jackhammer)	nisi	2021-09-18	66.07	Gigantti	816741678-X	2	1	6713100284792	1	B77	\N	\N
149	Hiomakone	Makita	AKM-3605	sähkötyökalu		\N	1.0000	images/goods/14.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	ipsum	2021-05-18	234.22	Power	795931958-8	3	1	7430702523987	1	B97	\N	\N
152	Ruuvitalttasarja	Interskol	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/17.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	interdum	2021-02-08	306.07	Biltema	784557489-9	2	1	9484523092345	1	C41	\N	\N
158	Ruuvitalttasarja	Daewoo	PBC-380-35P	Käsityökalu		\N	1.0000	images/goods/23.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	fringilla	2021-03-11	237.76	Power	263562850-5	3	1	0454196669983	1	A16	\N	\N
161	Hiomakone	Huter	UC250DZ	\N		3000W 220V	1.0000	images/goods/26.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	blandit	2021-01-15	367.06	Sotka	737350384-5	2	1	1008097996997	1	A28	\N	\N
180	Akku	DeWALT	LM5347BS	Käsityökalu		\N	1.0000	images/goods/45.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	turpis	2021-07-02	441.59	Motonet	318445012-0	3	1	7022218920889	1	B89	\N	\N
163	Puukkosahat	Interskol	PBC-380-35P	akkutyökalu		\N	1.0000	images/goods/28.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	enim	2021-02-27	146.14	Motonet	361318169-X	2	1	8687687422014	1	C28	\N	\N
165	Akku	Huter	LM5347BS	\N		\N	1.0000	images/goods/30.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	aliquet	2021-09-16	372.60	Power	244779293-X	2	1	7339387329999	1	B96	\N	\N
167	Akku	Husqvarna	DWE576K	sähkötyökalu		\N	1.0000	images/goods/32.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	velit	2021-12-11	210.49	Gigantti	067597433-X	2	1	3174200744982	1	A79	\N	\N
169	Ruuvitalttasarja	AEG	MMA 250H	Käsityökalu		\N	1.0000	images/goods/34.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	ante	2021-02-26	51.48	Gigantti	263078872-5	3	1	2771571585099	1	A67	\N	\N
191	Hitsauskone	Huter	AKM-3605	sähkötyökalu		3000W 220V	1.0000	images/goods/56.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	sed	2021-04-14	401.82	Gigantti	498871345-8	2	1	6412668120205	1	B67	\N	\N
147	Mitat	Huter	BBK-2220	sähkötyökalu	\N	\N	1.0000	images/goods/12.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	neque	2021-12-20	238.84	Prisma	437933810-X	2	1	0974284952586	1	A26	\N	\N
185	Hitsauskone	Stanley	PBC-380-35P	Käsityökalu		3000W 220V	1.0000	images/goods/50.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	in	2021-09-26	359.41	Verkkokauppa	460855770-X	3	1	4885852775842	1	B31	\N	\N
3	Ruuvitalttasarja	Daewoo	UVO-1000-36-EL	akkutyökalu	\N	\N	1.0000	images/goods/2.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	donec2	2021-05-21	175.00	Prisma	703590993-12	3	1	6527480985607	1	B71	\N	\N
176	Pyörösahat	Husqvarna	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/41.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	felis	2021-04-28	248.19	Prisma	739459154-9	3	1	7133943644075	1	B94	\N	\N
197	Hiomakone	PROF	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/62.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	posuere	2021-10-14	37.74	Gigantti	550053430-0	3	1	1685612034694	1	A41	\N	\N
183	Ruuvitalttasarja	Daewoo	Prestige 151/S	sähkötyökalu		\N	1.0000	images/goods/48.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	odio	2021-07-24	266.44	Prisma	770575548-3	3	1	3190645921936	1	A81	\N	\N
196	Akku	Daewoo	TKHS 315 C-2.8 DNB 103152100	Käsityökalu		\N	1.0000	images/goods/61.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	nisl	2021-05-28	147.14	K-Rauta	046283683-5	3	1	2947775795137	1	A73	\N	\N
119	Akku	Daewoo	LM5347BS	Käsityökalu		\N	1.0000	images/goods/51.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	in	2021-09-28	233.65	Ikea	790630431-4	2	1	6819295156717	1	B84	\N	\N
174	Lastulevyt	KoskiWall			150x300x500 cm	\N	1.0000	images/goods/39.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	ut	2021-02-09	485.48	K-Rauta	069239900-3	3	1	8816548642810	1	C29	\N	\N
179	Mitat	Husqvarna	UC250DZ	sähkötyökalu		\N	1.0000	images/goods/44.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	mauris	2021-10-08	406.81	Prisma	766906998-8	2	1	9179288701525	1	C35	\N	\N
187	Ruuvitalttasarja	Stanley	MS 3024 LMB	sähkötyökalu		\N	1.0000	images/goods/52.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	morbi	2021-11-02	131.29	Biltema	867985744-0	2	1	9625334853803	1	C47	\N	\N
189	Ruuvitalttasarja	Elitech	DWE576K	sähkötyökalu		\N	1.0000	images/goods/54.jpg	Storage case; Weight (g): 1083; Shovel length (mm): 580; foldable; Handle: D-shaped; Handle material: steel; Web width (mm): 150; Hoe; Serrated notch; Blade material: steel; Form: bayonet; Type: travel/automobile	tellus	2021-08-28	282.58	Biltema	057208290-8	2	1	6785604961142	1	B82	\N	\N
194	Mitat	Stanley	AKM-3605	akkutyökalu		\N	1.0000	images/goods/59.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	aenean	2021-07-05	317.04	Gigantti	379311330-2	2	1	7004931508550	1	B87	\N	\N
199	Porakone	DeWALT	UVO-1000-36-EL	akkutyökalu		\N	1.0000	images/goods/64.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	blandit	2021-04-18	418.15	Ikea	803831169-8	3	1	7337018250871	1	B95	\N	\N
256	Juotosbetoni	Lakka	310	Stereo	\N	10Wt	1.0000	images/goods/img_hJQKUU5fcWLMLAckLX1s8XvbwxZoDjNxMXafzLUMwIHUBSSbrRAqeCqihJsr8eUd.png		\N	\N	362.02	\N	\N	2	1	6419184705481	1	\N	\N	\N
258	Juotosbetoni	Lakka	310	\N	\N	\N	1.0000	images/goods/img_kEWM3xJ6I1UZIBclraY9QBtBfHv7xkQSPSghIoyD2NQ7yTSc74x7WgoI0TYa2fXy.png		\N	\N	30.50	\N	\N	2	1	6419184705481	1	\N	\N	\N
260	Porakone	Bosch	G55	220V	\N	100W	2.0000	images/goods/67_5HaBCeu.jpg		153344	2022-11-01	265.00	K-Rauta	35204405	1	1	1321321321321	22	\N	1	48.5000
261	Porakone	Bosch	G55	220V	\N	100W	0.1500	images/goods/67_5HaBCeu.jpg		153344	2022-11-01	265.00	K-Rauta	35204405	1	1	1321321321321	11	\N	2	2.1500
201	Hiomakone	Makita	DWE576K	\N	\N	3000W 220V	1.0000	images/goods/66.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	erat	2021-09-01	310.34	Gigantti	193232392-9	3	4	2112460183331	1	A53	\N	\N
341	sdsd11111	\N	\N	\N	\N	\N	1.0000			\N	\N	\N	\N	\N	2	\N	2333333333333	1	\N	\N	\N
102	Porakone	Elitech	MS 3024 LMB	akkutyökalu		\N	1.0000	images/goods/34.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	enim	2021-11-01	196.07	Biltema	391745950-7	3	1	9754904241906	1	C48	\N	\N
87	Akku	Elitech	UC250DZ	\N		36V	1.0000	images/goods/19.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	non	2021-12-03	215.88	Sotka	130665237-5	2	1	1816881869696	1	A45	\N	\N
43	Mitat	PROF	UVO-1000-36-EL	Käsityökalu		\N	1.0000	images/goods/42.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	in	2021-09-02	244.31	Verkkokauppa	588976198-6	2	1	7042614668834	1	B91	\N	\N
30	Hiomakone	AEG	DP-2.0-200	sähkötyökalu		\N	1.0000	images/goods/29.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	nisl	2021-08-08	270.05	Biltema	881924256-7	3	2	0397548154496	1	A15	\N	\N
75	Hitsauskone	Interskol	DP-2.0-200	sähkötyökalu		3000W 220V	1.0000	images/goods/7.jpg	Removable blade; Blade lock; return spring; Max. cut diameter (mm): 15; Design: one-handed; Type: secateurs	turpis	2021-04-20	381.61	Verkkokauppa	901471484-X	3	1	9201401960870	1	C36	\N	\N
263	Asennuskaapeli	OPAL	MSO	\N	\N	2x0,75mm² 10m musta	25.5000	images/goods/34_VtIBmhx.jpg	Ovaali taipuisa asennuskaapeli, jossa kaksi johdinta. Hienosäikeinen kuparijohdin. MSO 2 x 0,75 mm². Kelan pituus 10 m.	153344	2022-11-23	11.00	K-Rauta	35204405	1	1	6419184705481	8	\N	4	204.0000
103	Hitsauskone	Makita	Prestige 151/S	\N		3000W 220V	1.0000	images/goods/35.jpg	Weight (kg): 20.6; Dimensions (mm): 225x250x390; Efficiency (%): 98; Response speed (ms): 20; Output voltage accuracy (±), %: 6; Input voltage (V): 120-280; Power (kVA): 20; Input voltage: 220 V (1 phase);	proin	2021-05-25	239.15	Motonet	977758856-9	3	1	2408938927568	1	A58	\N	\N
129	Akku	Interskol	Prestige 151/S	sähkötyökalu		\N	1.0000	images/goods/61.jpg	The model is powered by the mains and is intended exclusively for the care of bushes and hedges. At the heart of this tool is a 550W motor. As for the cutting system: diamond-ground blades, bar length 52 cm, tooth spacing 18 mm, maximum stroke rate 3200 rpm. Let's pay attention to the built-in level, which will allow for perfectly even cutting. A cable protection system is provided. This tool weighs 3.6 kg.	molestie	2021-10-26	376.42	Ikea	079610248-1	3	1	6424382191242	1	B68	\N	\N
344	Porakone	\N	\N	\N	\N	\N	1.0000	images/goods/7_MWqTqRY.jpg		\N	\N	\N	\N	\N	2	1	\N	1	A30	\N	\N
157	Hitsauskone	Bosch	TKHS 315 C-2.8 DNB 103152100	\N		3000W 220V	1.0000	images/goods/22.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	justo	2021-08-03	124.37	Motonet	315748557-1	3	1	7049445627905	1	B92	\N	\N
166	Mitat	Bosch	MMA 250H	Käsityökalu		\N	1.0000	images/goods/31.jpg	Volume (ml): 200; Storage tank; Spray: pneumatic; Nominal pressure (bar): 3; Type: airbrush; Type: pneumatic	sem	2021-04-14	467.24	Power	757560364-6	2	1	3698486109379	1	A89	\N	\N
193	Pyörösahat	Elitech	Prestige 151/S	\N		3000W 220V	1.0000	images/goods/58.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	proin	2021-01-26	366.14	Verkkokauppa	238855806-9	2	1	6388732389176	1	B65	\N	\N
262	Asennuskaapeli	OPAL	MSO	\N	\N	2x0,75mm² 10m musta	18.0000	images/goods/34_t7WF5Vy.jpg	Ovaali taipuisa asennuskaapeli, jossa kaksi johdinta. Hienosäikeinen kuparijohdin. MSO 2 x 0,75 mm². Kelan pituus 10 m.	153344	2022-11-23	8.00	K-Rauta	35204405	1	1	6419184705481	7	\N	1	126.0000
267	key	Bosch	GF	\N	\N	\N	1.0000	images/goods/22_0LnyFUi.jpg		456654	2022-11-11	12.00	K-Rauta	35204405	2	1	9511111165656	1	\N	\N	\N
268	key	Bosch	GF	\N	\N	\N	1.0000	images/goods/22_0LnyFUi.jpg		456654	2022-11-11	12.00	K-Rauta	35204405	2	1	9511111165656	1	\N	\N	\N
301	building kit	Robotest	v1	\N	800 kpl	\N	1.0000	images/goods/Снимок_экрана_2022-07-16_165205.jpg		\N	\N	\N	\N	\N	2	2	6421585432135	1	\N	\N	\N
302	building kit	Robotest	v1	\N	800 kpl	\N	1.0000	images/goods/Снимок_экрана_2022-07-16_165205.jpg		\N	\N	\N	\N	\N	2	2	6421585432135	1	\N	\N	\N
95	Porakone	FXA	DP-2.0-200	Käsityökalu		\N	1.0000	images/goods/27.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	ipsum	2021-05-12	339.55	Power	866115901-6	3	3	8257385883267	1	C22	\N	\N
266	Koivu polttopuu	Noname	\N	\N	Korkeus 135cm, Ympärysmitta 390cm	\N	1.5000	images/goods/56_n8OjC34.jpg		153344	2022-11-10	875.00	tulenrako.fi	35204405	1	1	\N	1	\N	5	1.5000
265	Asennuskaapeli	OPAL	310	\N	\N	2x0,75mm² 10m musta	5.0000	images/goods/15_TGk4yJv.jpg		\N	2022-11-16	200.00	K-Rauta	35204405	1	1	6419184705481	1	\N	4	5.0000
120	Akku	Interskol	UC250DZ	sähkötyökalu		\N	1.0000	images/goods/52.jpg	Weight: 10.5; Powder spraying; Replaceable nozzles; Fuel tank volume (l): 1.5; Power (kW): 2.5; Cylinder volume (cm3): 56.5; ICE type: two-stroke; Tube material: plastic; Tube type: wide; Max. spraying distance (m): 15; Productivity (liquid) (l/min): 3.03; Volume (l): 14; Carry type: shoulder	non	2021-05-22	84.50	Verkkokauppa	708484971-8	3	1	4442749081856	1	B19	\N	\N
128	Ruuvitalttasarja	FXA	DP-2.0-200	akkutyökalu		\N	1.0000	images/goods/60.jpg	Weight (kg): 13.9; Support column: non-removable; Galvanized body; Body volume (l): 78; Load capacity (kg): 165; Wheel type: inflatable; Wheel diameter (mm): 400; Number of wheels (pcs): 2; Type: wheelbarrow	vestibulum	2021-10-27	415.64	Power	498411183-6	2	1	1357446329273	1	A36	\N	\N
182	Pyörösahat	Bosch	UVO-1000-36-EL	sähkötyökalu		\N	1.0000	images/goods/47.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	id	2021-12-23	164.01	Biltema	469711873-1	3	1	5595651112765	1	B44	\N	\N
198	Akku	FXA	MS 3024 LMB	akkutyökalu		\N	1.0000	images/goods/63.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	dictumst	2021-12-27	300.51	Biltema	834448320-4	2	1	0141651307003	1	A12	\N	\N
269	Ruuvitalttasarja	Daewoo	UVO-1000-36-EL	akkutyökalu	\N	\N	1.0000	images/goods/2.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	donec	2021-05-21	175.00	Prisma	703590993-12	3	1	6527480985607	1	\N	\N	\N
270	Ruuvitalttasarja	Daewoo	UVO-1000-36-EL	akkutyökalu	\N	\N	1.0000	images/goods/2.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	donec	2021-05-21	175.00	Prisma	703590993-12	3	1	6527480985607	1	\N	\N	\N
271	Ruuvitalttasarja	Daewoo	UVO-1000-36-EL	akkutyökalu	\N	\N	1.0000	images/goods/2.jpg	Weight (kg): 1.4; Power supply: mains; reverse; power button lock; Chuck diameter (mm): 10; Cartridge: key; Speed limiter; Number of speeds: 1; Revolutions (rpm): 3000; Power consumption (W): 350; Design: pistol; Device: drill	donec	2021-05-21	175.00	Prisma	703590993-12	3	1	6527480985607	1	\N	\N	\N
294	Hiustenleikkuukone	Philips	HC351015V2	\N	\N	\N	1.0000	images/goods/148670371.jpg	Philips-hiustenleikkuukoneen mukana toimitetaan hiustenleikkuuseen tarkoitettu ohjauskampa ja parran siistimiseen suunniteltu partakampa, jotka voit säätää haluamillesi pituusasetuksille. Mukana toimitettava puhdistusharja tekee laitteen huollosta vaivatonta, ja lisäksi se auttaa pidentämään hiustenleikkuukoneen elinkaarta.\r\n\r\nPituusasetukset: Kummankin pakkaukseen sisältyvän kampaosan pituusasetus voidaan säätää 0,5 mm ja 23 mm välille.\r\n\r\nPestävät terät ja lisävarusteet: Laitteen lisävarusteet ja trimmeriosa voidaan pestä helposti vedellä.\r\n\r\nJohdollinen: Johdollinen laite kytketään verkkovirtaan, ja näin ollen se tarjoaa riittävästi tehoa kaikentyyppisten hiusten leikkaamiseen.\r\n\r\nMyyntipakkaus sisältää:\r\n- Hiustenleikkuukone\r\n- Kampaosa hiuksille\r\n- Kampaosa parralle\r\n- Puhdistusharja\r\n\r\nTuotteella on kuluttajakäytössä 2 vuoden takuu.	\N	2023-01-10	19.95	Gigantti	4654513	3	4	8710103859703	1	\N	\N	\N
295	Hiustenkuivaajat	REMINGTON	AC8901 HYDRALUXE	AC-HIUSTENKUIVAIN	\N	2300W / 130 km/h	1.0000	images/goods/REMINGTONAC8901HYDRALUXEAC-HIUSTENKUIVAIN_5038061109825_ff3b5df304eb1046d0f_ahQNput.jpg	Hellävaraista hiustenkuivausta. Hydracare-asetus kuivaa hiukset hellävaraisesti matalalla lämpötilalla, saavuttaen kauniin lopputuloksen ilman lämpövaurioita. Kosteuden lukitsevat tehoaineet auttavat ylläpitämään hiusten täydellistä kosteustasapainoa. Erittäin kestävä ja pitkäikäinen ammattimainen AC-moottori. Ionisointi vapauttaa ioneja, varmistaen sileät ja kiiltävät hiukset. Mukana föönisuutin ja diffuusori, joka tuo esille hiusten luonnollisen taipuisuuden. 3 lämpötilaa ja 2 nopeutta. Tehokas kylmäpuhallus. 5 vuoden takuu.	68453	2023-01-05	55.00	Gigantti	654213	3	4	5038061109825	1	\N	\N	\N
303	Rautakloridi / Ferrikloridi	Noname	\N	\N	\N	FeCl3*6H2O	1.0000	images/goods/30_Cynp8vH.jpg	Käytetään kytkentälevyjen kuparipinnan syövyttämiseen. Kemiallinen kaava FeCl3*6H2O.\r\n\r\nLevylle jäävät kuparivedot voi merkitä käyttämällä piirroskynää tai valottamalla UV-herkällä lakkapinnalla päällystetty kytkentälevy (tarvitaan myös kehite). Syövytys kestää joitain kymmeniä minuutteja.\r\n\r\nvalmiiksi käyttökelpoista liuiosta\r\nmitä lämpimämpi liuos, sitä nopeampi prosessi\r\nsaman liuoksen voi käyttää useaan kertaan\r\naine on erittäin sotkevaa\r\ntoimita loppuunkäytetty liuos asianmukaiseen jätteenkeräyspisteeseen	\N	\N	\N	\N	\N	1	3	6546546854136	4	\N	2	5.0000
66	Hitsauskone	Interskol	MMA 250H	akkutyökalu	\N	3000W 220V	1.0000	images/goods/65.jpg	Noise level (dB): 105; Start type: manual; Power (kW): 0.9; Power (hp): 1.2; Engine displacement (cm3): 35; Engine type: gasoline; Max. rail length (m): 4.3; Vibration frequency (bpm): 8500; Type: vibrator	integer	2021-10-13	494.82	Verkkokauppa	775762857-1	3	1	2468228089062	1	A61	\N	\N
47	Hitsauskone	Daewoo	AKM-3605	sähkötyökalu	\N	3000W 220V	1.0000	images/goods/46.jpg	Weight (kg): 13; Noise level (dB): 98; Power source: mains (220 V); dust collector; pulling system; laser marker; Cutting depth (mm): 75; Mounting hole diameter (mm): 30; Tire/rim size (mm): 255; Maximum revolutions (rpm): 5000; Power (W): 1800;	vitae	2021-02-24	466.14	Power	631796558-7	2	1	2850897765526	1	A72	\N	\N
296	Nestesaippua	Pisara	3 l koivu	\N	\N	Paino: 3.18 kg	3.0000	images/goods/6419860837543.jpg	Pisara-nestesaippuakanisterilla on helppo täyttää kodin saippuapumput. Saippua soveltuu päivittäiseen käsien, vartalon ja hiustenpesuun. Siinä on iholle hellävarainen, pH-neutraali koostumus, joka jättää jälkeensä kesäisen koivun tuoksun.\r\n\r\nValmistettu Suomessa. Tuotteella on Avainlippu-tunnus.	\N	2023-01-12	3.50	Tokmanni	16546513	1	4	3165465213546	2	\N	2	9.0000
\.


--
-- Data for Name: varasto_rental_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_rental_event (id, remarks, item_id, renter_id, staff_id, storage_id, estimated_date, returned_date, start_date, amount, contents, units_id, returned) FROM stdin;
6	erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna	78	14	6	1	2022-04-23 23:00:00+02	2022-02-21 23:00:00+01	2022-02-03 23:00:00+01	1	\N	\N	\N
22	sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in	188	13	6	1	2022-04-04 23:00:00+02	2022-09-07 14:53:07.751943+02	2022-01-28 23:00:00+01	1	\N	\N	\N
226	4	2	4	6	1	2022-10-24 02:00:00+02	2023-01-29 23:36:45.206384+01	2022-09-13 11:17:39.942768+02	1	\N	\N	1.0000
14	morbi quis tortor id nulla ultrices aliquet maecenas leo	43	13	6	1	2022-03-29 23:00:00+02	2022-03-14 23:00:00+01	2022-01-19 23:00:00+01	1	\N	\N	\N
32	odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam	169	17	6	1	2022-05-31 02:00:00+02	2022-09-07 19:09:06.088903+02	2022-02-25 23:00:00+01	1	\N	\N	\N
3	vel augue vestibulum rutrum rutrum neque aenean auctor	5	3	6	1	2022-03-07 23:00:00+01	2022-03-05 23:00:00+01	2022-01-20 23:00:00+01	1	\N	\N	\N
9	ut odio cras mi pede malesuada in	10	16	6	1	2022-06-22 02:00:00+02	2022-09-07 19:12:49.753699+02	2022-01-15 23:00:00+01	1	\N	\N	\N
7	penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean	62	13	6	1	2022-04-28 23:00:00+02	2022-03-31 23:00:00+02	2022-03-19 23:00:00+01	1	\N	\N	\N
8	vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere	74	8	6	1	2022-01-31 23:00:00+01	2022-03-27 23:00:00+02	2022-01-27 23:00:00+01	1	\N	\N	\N
303	true	10	13	1	2	2023-01-06 01:00:00+01	2023-02-17 16:17:23.166834+01	2022-12-07 11:39:05.706421+01	1	\N	\N	1.0000
10	consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat	22	11	6	1	2022-02-25 23:00:00+01	2022-03-18 23:00:00+01	2022-02-25 23:00:00+01	1	\N	\N	\N
11	ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel	130	9	6	1	2022-05-11 23:00:00+02	2022-04-07 23:00:00+02	2022-02-26 23:00:00+01	1	\N	\N	\N
27	maecenas leo odio condimentum id luctus	29	17	6	1	2022-04-21 23:00:00+02	2022-03-21 23:00:00+01	2022-02-16 23:00:00+01	1	\N	\N	\N
15	orci luctus et ultrices posuere cubilia curae	21	17	6	1	2022-01-31 23:00:00+01	2022-03-24 23:00:00+01	2022-02-02 23:00:00+01	1	\N	\N	\N
41	erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget	168	4	6	1	2022-03-27 23:00:00+02	2022-07-21 11:16:20.646642+02	2022-01-26 23:00:00+01	1	\N	\N	\N
311	\N	275	8	1	2	2023-02-28 01:00:00+01	\N	2023-01-14 21:24:07.025787+01	1	\N	\N	0.0000
34	maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet	37	2	6	1	2022-03-02 23:00:00+01	2022-08-31 18:05:05.118769+02	2022-01-24 23:00:00+01	1	\N	\N	\N
23	proin at turpis a pede posuere nonummy integer non velit	47	13	6	1	2022-05-08 23:00:00+02	2022-03-04 23:00:00+01	2022-03-14 23:00:00+01	1	\N	\N	\N
30	justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus	105	16	6	1	2022-04-12 23:00:00+02	2022-03-02 23:00:00+01	2022-01-11 23:00:00+01	1	\N	\N	\N
35	est et tempus semper est quam	42	17	6	1	2022-04-26 23:00:00+02	2022-03-25 23:00:00+01	2022-03-05 23:00:00+01	1	\N	\N	\N
36	ac enim in tempor turpis nec euismod scelerisque quam turpis	28	15	6	1	2022-03-30 23:00:00+02	2022-03-06 23:00:00+01	2022-01-22 23:00:00+01	1	\N	\N	\N
37	diam id ornare imperdiet sapien	44	14	6	1	2022-03-02 23:00:00+01	2022-03-27 23:00:00+02	2022-01-24 23:00:00+01	1	\N	\N	\N
39	orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum	82	13	6	1	2022-05-17 23:00:00+02	2022-03-17 23:00:00+01	2022-02-07 23:00:00+01	1	\N	\N	\N
12	nisl ut volutpat sapien arcu sed	124	2	6	1	2022-03-19 23:00:00+01	2022-08-31 18:05:07.799768+02	2022-02-16 23:00:00+01	1	\N	\N	\N
33	iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis	12	18	6	1	2022-06-23 02:00:00+02	2022-08-31 20:19:33.286746+02	2022-01-22 23:00:00+01	1	\N	\N	\N
325	\N	266	13	6	1	2023-02-24 01:00:00+01	2023-02-15 21:57:08.946765+01	2023-02-15 21:45:36.531107+01	4	\N	\N	4.0000
333	\N	266	18	6	1	2023-03-04 01:00:00+01	2023-02-15 23:10:37.487834+01	2023-02-15 23:10:06.309304+01	4	\N	\N	4.0000
2	accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec	195	15	6	1	2022-06-01 02:00:00+02	2022-09-25 13:13:58.523137+02	2022-03-02 23:00:00+01	1	\N	\N	\N
18	ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet	175	15	6	1	2022-06-01 02:00:00+02	2022-09-25 13:14:01.297192+02	2022-03-18 23:00:00+01	1	\N	\N	\N
341	\N	266	18	6	1	2023-02-24 01:00:00+01	2023-02-16 15:49:26.991469+01	2023-02-16 15:22:36.536591+01	\N	0.0000	5	7.5000
349	\N	266	18	6	1	2023-02-25 01:00:00+01	2023-02-16 22:43:45.65834+01	2023-02-16 22:35:02.594967+01	\N	0.0000	5	5.0000
312	\N	276	8	1	2	2023-02-28 01:00:00+01	2023-03-03 19:52:34.983884+01	2023-01-14 21:24:07.025787+01	\N	0.1000	2	0.0000
26	est donec odio justo sollicitudin ut suscipit a feugiat	16	18	6	1	2022-06-28 02:00:00+02	2022-10-12 13:04:39.080536+02	2022-03-03 23:00:00+01	1	\N	\N	\N
231	1	6	14	1	1	2022-12-31 01:00:00+01	2023-03-13 18:17:21.352405+01	2022-10-12 13:03:11.883198+02	1	\N	\N	1.0000
232	1	8	14	1	1	2022-12-31 01:00:00+01	2023-03-13 18:17:23.634652+01	2022-10-12 13:03:11.883198+02	1	\N	\N	1.0000
362	\N	276	14	1	\N	2023-03-31 02:00:00+02	2023-03-13 18:17:54.324884+01	2023-03-13 18:17:13.314286+01	\N	0.1500	2	0.1500
361	\N	\N	12	1	\N	2023-03-31 02:00:00+02	2023-03-13 11:08:33.767089+01	2023-03-13 11:08:09.853175+01	1	\N	\N	1.0000
263	1	261	13	1	1	2022-11-30 01:00:00+01	2022-11-26 21:31:01.05738+01	2022-11-26 21:24:13.744073+01	\N	0.3000	2	0.3000
255	1	261	13	1	1	2022-11-27 01:00:00+01	2022-11-24 16:24:05.650922+01	2022-11-24 14:51:39.528104+01	12	\N	\N	12.0000
216	1	6	4	6	1	2022-11-30 01:00:00+01	2022-09-07 19:13:12.512461+02	2022-07-21 11:17:32.056678+02	1	\N	\N	\N
42	imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor	108	4	6	1	2022-05-24 23:00:00+02	2022-07-21 11:16:49.447093+02	2022-03-01 23:00:00+01	1	\N	\N	\N
50	nulla ac enim in tempor turpis nec euismod scelerisque quam	54	17	6	1	2022-05-31 02:00:00+02	2022-08-31 20:19:15.921774+02	2022-01-03 23:00:00+01	1	\N	\N	\N
51	vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit	159	16	6	1	2022-05-07 23:00:00+02	2022-03-23 23:00:00+01	2022-01-10 23:00:00+01	1	\N	\N	\N
354	\N	313	18	6	1	2023-06-22 02:00:00+02	2025-01-04 18:58:20.270275+01	2023-02-20 23:37:24.623781+01	1	\N	\N	1.0000
313	\N	294	16	19	4	2023-09-01 02:00:00+02	2025-01-04 18:59:26.463394+01	2023-01-14 22:21:11.129973+01	1	\N	\N	1.0000
355	\N	52	18	4	1	2023-06-23 02:00:00+02	2025-01-04 18:58:22.528394+01	2023-03-03 21:52:34.976484+01	1	\N	\N	1.0000
229	4	63	15	6	1	2022-10-31 01:00:00+01	2023-04-22 16:42:07.80325+02	2022-09-25 13:13:45.597493+02	1	\N	\N	1.0000
318	\N	274	16	1	\N	2023-03-09 01:00:00+01	2025-01-04 18:59:31.957762+01	2023-01-28 14:10:36.32655+01	1	\N	\N	1.0000
21	4	137	2	6	1	2022-12-05 01:00:00+01	2025-01-04 18:53:41.062795+01	2022-03-20 23:00:00+01	1	\N	\N	1.0000
356	\N	136	3	4	1	2024-06-05 02:00:00+02	2025-01-28 19:55:42.043838+01	2023-03-06 10:09:32.032842+01	1	\N	\N	1.0000
45	donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium	152	18	6	1	2022-04-08 23:00:00+02	2022-03-08 23:00:00+01	2022-03-27 23:00:00+02	1	\N	\N	\N
46	libero nullam sit amet turpis elementum ligula vehicula consequat	58	11	6	1	2022-04-18 23:00:00+02	2022-04-07 23:00:00+02	2022-01-11 23:00:00+01	1	\N	\N	\N
235	1	64	18	1	1	2022-12-12 01:00:00+01	2023-01-15 21:09:34.99184+01	2022-10-12 13:04:32.175748+02	1	\N	\N	1.0000
43	gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer	109	14	6	1	2022-05-15 23:00:00+02	2022-09-07 19:09:13.248066+02	2022-01-13 23:00:00+01	1	\N	\N	\N
47	elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor	110	18	6	1	2022-07-30 02:00:00+02	2022-10-12 13:04:41.88481+02	2022-03-03 23:00:00+01	1	\N	\N	\N
49	ultrices libero non mattis pulvinar nulla	50	11	6	1	2022-06-30 02:00:00+02	2022-10-12 13:06:19.470963+02	2022-01-23 23:00:00+01	1	\N	\N	\N
326	\N	266	15	6	1	2023-02-24 01:00:00+01	2023-02-15 21:58:14.580394+01	2023-02-15 21:57:31.243645+01	4	\N	\N	4.0000
334	\N	266	18	6	1	2023-03-04 01:00:00+01	2023-02-15 23:15:03.51612+01	2023-02-15 23:14:57.387965+01	4	\N	\N	4.0000
236	1	66	18	1	1	2023-02-12 01:00:00+01	2023-02-16 11:58:07.868902+01	2022-10-12 13:04:32.175748+02	1	\N	\N	1.0000
237	1	71	18	1	1	2023-03-12 01:00:00+01	2023-02-16 11:58:11.963516+01	2022-10-12 13:04:32.175748+02	1	\N	\N	1.0000
215	1	81	4	6	1	2022-06-30 02:00:00+02	2022-07-21 10:51:04.53964+02	2022-06-27 18:52:23.395313+02	1	\N	\N	\N
202	1	21	3	1	1	2022-05-19 02:00:00+02	2022-07-21 16:39:36.521618+02	2022-05-18 13:50:36.667625+02	1	\N	\N	\N
281	1	255	12	1	1	2022-12-31 01:00:00+01	2022-12-01 12:24:06.342205+01	2022-12-01 12:13:05.257705+01	1	\N	\N	1.0000
244	1	258	12	1	1	2022-11-28 01:00:00+01	2022-12-01 11:12:08.519556+01	2022-10-28 20:34:02.084289+02	1	\N	\N	1.0000
246	1	261	13	1	1	2022-11-27 01:00:00+01	2022-11-24 12:11:19.530714+01	2022-11-24 12:09:58.73511+01	9	\N	\N	9.0000
245	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 12:11:17.55356+01	2022-11-24 12:09:58.73511+01	4	\N	\N	4.0000
273	1	259	13	1	1	2022-12-26 01:00:00+01	2022-11-29 14:52:08.352046+01	2022-11-29 11:26:19.049776+01	\N	10.0000	4	10.0000
272	1	259	13	1	1	2022-12-03 01:00:00+01	2022-11-29 14:36:41.129123+01	2022-11-29 11:20:02.505423+01	\N	2.0000	4	2.0000
282	1	258	12	1	1	2022-12-31 01:00:00+01	2022-12-01 12:24:02.991071+01	2022-12-01 12:13:05.257705+01	1	\N	\N	1.0000
203	1	10	3	1	1	2022-05-29 02:00:00+02	2022-09-07 14:48:31.203451+02	2022-05-18 13:52:38.93962+02	1	\N	\N	\N
342	\N	276	18	6	1	2023-02-25 01:00:00+01	2023-02-16 15:51:28.560485+01	2023-02-16 15:50:45.517929+01	0	\N	\N	1.0000
274	1	259	13	1	1	2022-12-04 01:00:00+01	2022-11-29 12:04:18.228421+01	2022-11-29 11:26:51.117652+01	\N	0.5000	4	0.5000
264	1	261	13	1	1	2022-11-30 01:00:00+01	2022-11-26 21:37:57.885155+01	2022-11-26 21:31:38.226348+01	\N	0.2000	2	0.2000
256	1	260	13	1	1	2022-11-29 01:00:00+01	2022-11-24 16:25:32.038389+01	2022-11-24 14:51:59.896342+01	\N	23.0000	1	20.0000
248	1	261	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:07:39.750534+01	2022-11-24 12:11:56.479945+01	3	\N	\N	3.0000
247	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:46:39.825704+01	2022-11-24 12:11:56.479945+01	1	\N	\N	1.0000
350	\N	266	18	6	1	2023-02-25 01:00:00+01	2023-02-16 22:44:47.84913+01	2023-02-16 22:44:14.921365+01	\N	0.0000	5	5.0000
285	2	12	13	1	2	2023-01-07 01:00:00+01	2023-02-17 16:17:20.304759+01	2022-12-07 10:50:42.57387+01	1	\N	\N	1.0000
304	\N	15	13	1	2	2023-01-05 01:00:00+01	2023-02-17 16:17:26.041183+01	2022-12-07 11:58:51.843057+01	1	\N	\N	1.0000
220	4	104	3	6	1	2022-10-21 02:00:00+02	2023-03-06 10:10:15.346775+01	2022-09-07 14:48:19.754228+02	1	\N	\N	1.0000
218	4	24	3	6	1	2022-10-21 02:00:00+02	2023-03-06 10:10:30.874521+01	2022-09-07 14:48:19.754228+02	1	\N	\N	1.0000
357	\N	\N	12	4	1	2023-03-30 02:00:00+02	2023-03-10 12:33:04.10391+01	2023-03-10 12:32:36.459922+01	\N	1.0000	1	1.0000
221	4	165	3	6	1	2022-10-21 02:00:00+02	2023-03-06 10:10:51.987686+01	2022-09-07 14:48:19.754228+02	1	\N	\N	1.0000
314	\N	295	18	19	4	2023-04-08 02:00:00+02	2023-03-06 11:41:20.175699+01	2023-01-14 22:22:10.605107+01	1	\N	\N	1.0000
56	sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices	85	12	6	1	2022-02-09 23:00:00+01	2022-04-08 23:00:00+02	2022-02-21 23:00:00+01	1	\N	\N	\N
78	non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales	31	14	6	1	2022-05-28 23:00:00+02	2022-04-02 23:00:00+02	2022-03-22 23:00:00+01	1	\N	\N	\N
53	ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum	30	15	6	1	2022-05-29 23:00:00+02	2022-03-30 23:00:00+02	2022-03-24 23:00:00+01	1	\N	\N	\N
358	\N	\N	12	4	1	2023-03-26 01:00:00+01	2023-03-10 12:38:39.619517+01	2023-03-10 12:36:07.792819+01	3	\N	\N	3.0000
68	arcu adipiscing molestie hendrerit at vulputate vitae	127	5	6	1	2022-05-11 23:00:00+02	2022-02-24 23:00:00+01	2022-01-19 23:00:00+01	1	\N	\N	\N
61	vestibulum ante ipsum primis in faucibus orci luctus et	65	11	6	1	2022-03-21 23:00:00+01	2022-03-28 23:00:00+02	2022-01-22 23:00:00+01	1	\N	\N	\N
327	\N	266	15	6	1	2023-02-24 01:00:00+01	2023-02-15 22:01:30.058436+01	2023-02-15 21:59:15.282784+01	4	\N	\N	4.0000
72	libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum	200	9	6	1	2022-03-07 23:00:00+01	2022-03-02 23:00:00+01	2022-02-03 23:00:00+01	1	\N	\N	\N
73	etiam vel augue vestibulum rutrum rutrum neque aenean auctor	92	12	6	1	2022-03-24 23:00:00+01	2022-02-23 23:00:00+01	2022-02-19 23:00:00+01	1	\N	\N	\N
63	ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate	66	7	6	1	2022-04-11 23:00:00+02	2022-03-15 23:00:00+01	2022-02-11 23:00:00+01	1	\N	\N	\N
55	magna bibendum imperdiet nullam orci pede venenatis non sodales	90	2	6	1	2022-04-28 23:00:00+02	2022-08-31 18:05:12.367769+02	2022-02-28 23:00:00+01	1	\N	\N	\N
57	nulla suspendisse potenti cras in purus eu	162	2	6	1	2022-04-15 23:00:00+02	2022-08-31 18:05:18.081761+02	2022-03-24 23:00:00+01	1	\N	\N	\N
76	massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam	115	2	6	1	2022-05-05 23:00:00+02	2022-02-23 23:00:00+01	2022-02-22 23:00:00+01	1	\N	\N	\N
222	4	49	16	6	1	2022-11-28 01:00:00+01	2025-01-04 18:59:34.34997+01	2022-09-07 15:47:32.08654+02	1	\N	\N	1.0000
230	4	62	15	6	1	2022-10-31 01:00:00+01	2023-04-22 16:42:10.025863+02	2022-09-25 13:13:45.597493+02	1	\N	\N	1.0000
234	1	13	17	1	1	2023-07-14 02:00:00+02	\N	2022-10-12 13:03:48.872406+02	1	\N	\N	\N
363	\N	6	9	1	\N	2023-06-09 02:00:00+02	2025-01-04 18:57:07.526391+01	2023-03-15 11:12:30.401835+01	1	\N	\N	1.0000
228	4	31	4	6	1	2024-07-05 02:00:00+02	2025-01-04 18:54:31.428274+01	2022-09-13 11:28:58.280329+02	1	\N	\N	1.0000
319	\N	301	14	20	2	2023-04-08 02:00:00+02	2025-01-04 19:00:25.129789+01	2023-01-28 22:01:29.949468+01	1	\N	\N	1.0000
219	4	102	3	20	2	2023-04-01 02:00:00+02	2025-01-28 19:55:45.400679+01	2022-09-07 14:48:19.754228+02	1	\N	\N	1.0000
85	nascetur ridiculus mus vivamus vestibulum sagittis	189	8	6	1	2022-03-24 23:00:00+01	2022-03-04 23:00:00+01	2022-02-16 23:00:00+01	1	\N	\N	\N
71	vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper	33	8	6	1	2022-05-27 23:00:00+02	2022-09-07 19:08:07.752771+02	2022-01-08 23:00:00+01	1	\N	\N	\N
79	ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient	112	10	6	1	2022-03-17 23:00:00+01	2022-03-15 23:00:00+01	2022-01-23 23:00:00+01	1	\N	\N	\N
86	volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus	81	8	6	1	2022-04-20 23:00:00+02	2022-09-07 19:08:10.488659+02	2022-02-12 23:00:00+01	1	\N	\N	\N
90	morbi vel lectus in quam fringilla	149	7	6	1	2022-05-15 23:00:00+02	2022-09-07 19:08:24.238588+02	2022-01-24 23:00:00+01	1	\N	\N	\N
94	et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien	161	7	6	1	2022-02-21 23:00:00+01	2022-09-07 19:08:29.730953+02	2022-02-09 23:00:00+01	1	\N	\N	\N
60	elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus	95	18	6	1	2022-05-04 23:00:00+02	2022-09-07 19:08:54.720724+02	2022-03-10 23:00:00+01	1	\N	\N	\N
87	tellus semper interdum mauris ullamcorper purus sit	56	5	6	1	2022-02-06 23:00:00+01	2022-03-18 23:00:00+01	2022-01-28 23:00:00+01	1	\N	\N	\N
89	dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae	156	3	6	1	2022-03-07 23:00:00+01	2022-04-01 23:00:00+02	2022-02-17 23:00:00+01	1	\N	\N	\N
91	sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat	174	12	6	1	2022-02-17 23:00:00+01	2022-03-19 23:00:00+01	2022-01-22 23:00:00+01	1	\N	\N	\N
62	duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque	51	14	6	1	2022-03-06 23:00:00+01	2022-09-07 19:09:16.148993+02	2022-01-29 23:00:00+01	1	\N	\N	\N
93	duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum	181	14	6	1	2022-03-04 23:00:00+01	2022-09-07 19:09:18.359913+02	2022-02-15 23:00:00+01	1	\N	\N	\N
70	ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis	19	10	6	1	2022-08-15 02:00:00+02	2022-09-07 19:09:35.324871+02	2022-01-25 23:00:00+01	1	\N	\N	\N
335	\N	266	18	6	1	2023-03-08 01:00:00+01	2023-02-15 23:22:43.393075+01	2023-02-15 23:22:36.042725+01	4	\N	\N	4.0000
82	aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac	27	18	6	1	2022-04-22 23:00:00+02	2022-10-12 13:04:35.260767+02	2022-03-06 23:00:00+01	1	\N	\N	\N
343	\N	266	18	6	1	2023-03-04 01:00:00+01	2023-02-16 22:13:30.333313+01	2023-02-16 22:08:13.816946+01	\N	2.0000	5	3.0000
351	\N	265	18	6	1	2023-02-24 01:00:00+01	2023-02-16 22:47:57.505053+01	2023-02-16 22:46:53.417008+01	\N	0.0000	4	12.0000
305	\N	3	13	1	2	2022-12-28 01:00:00+01	2023-02-17 16:17:28.588483+01	2022-12-07 11:59:50.804849+01	1	\N	\N	1.0000
275	1	259	13	1	1	2022-12-10 01:00:00+01	2022-11-29 12:04:14.565205+01	2022-11-29 11:27:16.56987+01	\N	0.5000	4	0.5000
265	1	261	13	1	1	2022-12-01 01:00:00+01	2022-11-29 11:29:56.52133+01	2022-11-26 21:39:15.655709+01	\N	1.0000	2	1.0000
205	1	31	4	1	1	2022-06-18 02:00:00+02	2022-07-21 10:51:50.146637+02	2022-05-18 16:36:46.890879+02	1	\N	\N	\N
204	1	29	4	1	1	2022-06-18 02:00:00+02	2022-07-21 11:15:57.022302+02	2022-05-18 16:36:46.890879+02	1	\N	\N	\N
257	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 21:13:22.440714+01	2022-11-24 16:26:51.956424+01	\N	2.5000	4	2.5000
249	1	261	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:47:18.15915+01	2022-11-24 14:08:13.201529+01	2	\N	\N	2.0000
98	ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio	139	7	6	1	2022-03-28 23:00:00+02	2022-05-18 21:40:33.075922+02	2022-01-04 23:00:00+01	1	\N	\N	\N
103	mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec	196	9	6	1	2022-02-02 23:00:00+01	2022-04-05 23:00:00+02	2022-01-03 23:00:00+01	1	\N	\N	\N
106	ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes	129	18	6	1	2022-04-05 23:00:00+02	2022-03-09 23:00:00+01	2022-02-03 23:00:00+01	1	\N	\N	\N
109	duis ac nibh fusce lacus purus aliquet at feugiat non	176	9	6	1	2022-02-14 23:00:00+01	2022-03-18 23:00:00+01	2022-01-10 23:00:00+01	1	\N	\N	\N
110	ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien	114	17	6	1	2022-05-14 23:00:00+02	2022-04-01 23:00:00+02	2022-01-06 23:00:00+01	1	\N	\N	\N
104	sit amet lobortis sapien sapien non mi integer ac neque	39	12	6	1	2022-04-26 23:00:00+02	2022-03-01 23:00:00+01	2022-01-29 23:00:00+01	1	\N	\N	\N
137	hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer	80	3	6	1	2022-04-06 23:00:00+02	2022-07-21 16:39:25.392636+02	2022-02-28 23:00:00+01	1	\N	\N	\N
107	nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo	25	15	6	1	2022-03-07 23:00:00+01	2022-03-13 23:00:00+01	2022-02-24 23:00:00+01	1	\N	\N	\N
113	justo eu massa donec dapibus duis at velit eu est congue elementum in hac	178	11	6	1	2022-02-24 23:00:00+01	2022-03-20 23:00:00+01	2022-02-25 23:00:00+01	1	\N	\N	\N
111	nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo	172	11	6	1	2022-05-06 23:00:00+02	2022-04-08 23:00:00+02	2022-01-15 23:00:00+01	1	\N	\N	\N
131	lacinia sapien quis libero nullam sit amet	3	13	6	1	2022-02-03 23:00:00+01	2022-09-07 14:53:10.95634+02	2022-02-04 23:00:00+01	1	\N	\N	\N
130	morbi ut odio cras mi pede	93	8	6	1	2022-03-23 23:00:00+01	2022-09-07 19:08:06.205962+02	2022-01-06 23:00:00+01	1	\N	\N	\N
115	tellus semper interdum mauris ullamcorper purus sit amet	17	18	6	1	2022-03-03 23:00:00+01	2022-02-25 23:00:00+01	2022-03-18 23:00:00+01	1	\N	\N	\N
114	dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla	75	14	6	1	2022-05-25 23:00:00+02	2022-03-31 23:00:00+02	2022-03-21 23:00:00+01	1	\N	\N	\N
112	ultrices posuere cubilia curae donec pharetra	154	7	6	1	2022-02-22 23:00:00+01	2022-09-07 19:08:34.98602+02	2022-02-13 23:00:00+01	1	\N	\N	\N
344	\N	266	18	6	1	2023-02-18 01:00:00+01	2023-02-16 22:15:21.598183+01	2023-02-16 22:14:51.789376+01	\N	2.0000	5	3.0000
117	sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui	107	15	6	1	2022-03-26 23:00:00+01	2022-03-01 23:00:00+01	2022-02-13 23:00:00+01	1	\N	\N	\N
118	odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero	106	17	6	1	2022-02-17 23:00:00+01	2022-03-27 23:00:00+02	2022-03-28 23:00:00+02	1	\N	\N	\N
123	dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia	155	11	6	1	2022-03-06 23:00:00+01	2022-03-25 23:00:00+01	2022-01-14 23:00:00+01	1	\N	\N	\N
315	\N	296	10	19	4	2023-03-17 01:00:00+01	\N	2023-01-14 22:23:03.575802+01	1	\N	\N	0.0000
66	4	167	9	6	1	2022-05-31 02:00:00+02	2023-04-22 16:40:55.002792+02	2022-01-07 23:00:00+01	1	\N	\N	1.0000
224	4	4	16	6	1	2022-11-26 01:00:00+01	2025-01-04 18:59:36.84311+01	2022-09-07 16:50:02.740598+02	1	\N	\N	1.0000
124	feugiat et eros vestibulum ac est	191	15	6	1	2022-02-15 23:00:00+01	2022-02-25 23:00:00+01	2022-02-02 23:00:00+01	1	\N	\N	\N
127	pede ac diam cras pellentesque volutpat dui maecenas	120	15	6	1	2022-03-25 23:00:00+01	2022-04-05 23:00:00+02	2022-02-02 23:00:00+01	1	\N	\N	\N
125	eu massa donec dapibus duis at	91	18	6	1	2022-03-03 23:00:00+01	2022-02-19 23:00:00+01	2022-03-22 23:00:00+01	1	\N	\N	\N
133	sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui	57	13	6	1	2022-03-24 23:00:00+01	2022-04-07 23:00:00+02	2022-02-28 23:00:00+01	1	\N	\N	\N
136	natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor	166	4	6	1	2022-05-11 23:00:00+02	2022-03-06 23:00:00+01	2022-02-12 23:00:00+01	1	\N	\N	\N
139	ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris	40	7	6	1	2022-02-25 23:00:00+01	2022-03-01 23:00:00+01	2022-02-27 23:00:00+01	1	\N	\N	\N
239	4	18	8	1	1	2022-11-20 01:00:00+01	\N	2022-10-12 13:05:47.360871+02	1	\N	\N	\N
238	4	17	8	1	1	2022-11-20 01:00:00+01	\N	2022-10-12 13:05:47.360871+02	1	\N	\N	\N
141	id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat	121	17	6	1	2022-03-14 23:00:00+01	2022-02-22 23:00:00+01	2022-02-04 23:00:00+01	1	\N	\N	\N
328	\N	266	16	6	1	2023-02-24 01:00:00+01	2023-02-15 22:02:53.282592+01	2023-02-15 22:01:56.96338+01	4	\N	\N	4.0000
336	\N	266	18	6	1	2023-03-11 01:00:00+01	2023-02-15 23:24:39.213715+01	2023-02-15 23:24:36.294408+01	4	\N	\N	4.0000
306	\N	25	13	1	2	2022-12-21 01:00:00+01	2023-02-17 16:17:30.938916+01	2022-12-07 12:00:43.274134+01	1	\N	\N	1.0000
276	1	259	13	1	1	2022-12-08 01:00:00+01	2022-11-29 11:30:04.835881+01	2022-11-29 11:27:44.024643+01	\N	0.0500	4	0.0500
266	1	259	13	1	1	2022-12-04 01:00:00+01	2022-11-29 13:53:28.809884+01	2022-11-29 10:59:43.400722+01	\N	3.0000	4	3.0000
258	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 21:23:44.853222+01	2022-11-24 21:22:58.638295+01	5	\N	\N	5.0000
250	1	260	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:47:16.524393+01	2022-11-24 14:20:00.885819+01	\N	7.0000	1	7.0000
359	\N	\N	12	4	1	2023-03-23 01:00:00+01	2023-03-10 14:34:20.535593+01	2023-03-10 14:27:22.155039+01	1	\N	\N	1.0000
147	rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem	111	14	6	1	2022-05-22 23:00:00+02	2022-03-03 23:00:00+01	2022-02-23 23:00:00+01	1	\N	\N	\N
148	in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus	83	12	6	1	2022-02-02 23:00:00+01	2022-03-07 23:00:00+01	2022-03-20 23:00:00+01	1	\N	\N	\N
329	\N	266	17	6	1	2023-02-25 01:00:00+01	2023-02-15 22:46:28.850068+01	2023-02-15 22:03:17.753529+01	4	\N	\N	4.0000
171	posuere cubilia curae nulla dapibus	141	14	6	1	2022-04-15 23:00:00+02	2022-10-12 13:03:15.616899+02	2022-03-10 23:00:00+01	1	\N	\N	\N
187	sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo	134	13	6	1	2022-02-21 23:00:00+01	2022-09-07 14:53:04.645331+02	2022-01-25 23:00:00+01	1	\N	\N	\N
151	lectus aliquam sit amet diam in magna	76	13	6	1	2022-03-19 23:00:00+01	2022-09-07 14:53:12.886647+02	2022-02-07 23:00:00+01	1	\N	\N	\N
164	ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis	55	7	6	1	2022-03-14 23:00:00+01	2022-09-07 19:08:27.213167+02	2022-02-05 23:00:00+01	1	\N	\N	\N
156	adipiscing lorem vitae mattis nibh ligula nec	11	18	6	1	2022-03-16 23:00:00+01	2022-09-07 19:08:45.776716+02	2022-02-07 23:00:00+01	1	\N	\N	\N
149	duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis	182	18	6	1	2022-05-06 23:00:00+02	2022-02-19 23:00:00+01	2022-03-20 23:00:00+01	1	\N	\N	\N
150	convallis nulla neque libero convallis	116	18	6	1	2022-05-02 23:00:00+02	2022-02-24 23:00:00+01	2022-01-24 23:00:00+01	1	\N	\N	\N
186	amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus	38	14	6	1	2022-03-13 23:00:00+01	2022-10-12 13:03:17.14857+02	2022-03-05 23:00:00+01	1	\N	\N	\N
145	eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at	69	17	6	1	2022-05-26 02:00:00+02	2022-10-12 13:03:52.404422+02	2022-03-10 23:00:00+01	1	\N	\N	\N
337	\N	266	18	6	1	2023-03-03 01:00:00+01	2023-02-15 23:26:20.692282+01	2023-02-15 23:26:17.407595+01	4	\N	\N	4.0000
153	vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros	45	18	6	1	2022-04-15 23:00:00+02	2022-03-06 23:00:00+01	2022-03-08 23:00:00+01	1	\N	\N	\N
241	4	33	11	1	1	2022-11-16 01:00:00+01	2023-01-15 21:09:58.691548+01	2022-10-12 13:06:15.556367+02	1	\N	\N	1.0000
157	sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla	2	13	6	1	2022-05-22 02:00:00+02	2022-09-07 20:09:58.543141+02	2022-02-11 23:00:00+01	1	\N	\N	\N
158	lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a	177	10	6	1	2022-03-16 23:00:00+01	2022-03-11 23:00:00+01	2022-03-06 23:00:00+01	1	\N	\N	\N
211	1	55	4	6	1	2022-06-25 02:00:00+02	2022-07-21 11:16:11.959821+02	2022-06-22 12:10:28.722793+02	1	\N	\N	\N
159	orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu	46	12	6	1	2022-05-27 23:00:00+02	2022-03-06 23:00:00+01	2022-02-22 23:00:00+01	1	\N	\N	\N
243	4	34	11	1	1	2023-02-23 01:00:00+01	\N	2022-10-12 13:06:15.556367+02	1	\N	\N	\N
160	et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio	142	5	6	1	2022-04-02 23:00:00+02	2022-03-28 23:00:00+02	2022-02-15 23:00:00+01	1	\N	\N	\N
163	cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien	35	15	6	1	2022-02-19 23:00:00+01	2022-03-14 23:00:00+01	2022-03-15 23:00:00+01	1	\N	\N	\N
345	\N	266	18	6	1	2023-02-25 01:00:00+01	2023-02-16 22:16:33.352601+01	2023-02-16 22:16:25.866112+01	\N	0.0000	5	3.0000
167	turpis sed ante vivamus tortor duis mattis egestas	60	5	6	1	2022-04-30 23:00:00+02	2022-03-14 23:00:00+01	2022-03-27 23:00:00+02	1	\N	\N	\N
267	1	259	13	1	1	2022-12-04 01:00:00+01	2022-11-29 13:53:39.647833+01	2022-11-29 11:03:12.070535+01	\N	3.0000	4	3.0000
259	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 21:28:25.154232+01	2022-11-24 21:27:37.01884+01	5	\N	\N	5.0000
169	risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl	197	17	6	1	2022-03-12 23:00:00+01	2022-03-09 23:00:00+01	2022-01-24 23:00:00+01	1	\N	\N	\N
173	nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent	185	5	6	1	2022-02-03 23:00:00+01	2022-03-22 23:00:00+01	2022-03-03 23:00:00+01	1	\N	\N	\N
177	massa donec dapibus duis at velit eu est congue elementum in hac	164	7	6	1	2022-05-27 23:00:00+02	2022-05-18 21:40:38.598291+02	2022-01-17 23:00:00+01	1	\N	\N	\N
152	4	20	16	6	1	2023-07-22 02:00:00+02	2025-01-04 18:59:29.893578+01	2022-03-25 23:00:00+01	1	\N	\N	1.0000
168	4	186	2	6	1	2022-08-20 02:00:00+02	2025-01-04 18:53:39.066586+01	2022-03-12 23:00:00+01	1	\N	\N	1.0000
121	4	88	2	6	1	2023-02-05 01:00:00+01	2025-01-04 18:53:45.012073+01	2022-03-27 23:00:00+02	1	\N	\N	1.0000
352	\N	266	18	6	1	2023-07-14 02:00:00+02	2025-01-04 18:58:16.938743+01	2023-02-17 10:13:11.129054+01	\N	7.5000	5	0.0000
178	libero convallis eget eleifend luctus ultricies eu	128	16	6	1	2022-02-24 23:00:00+01	2022-03-16 23:00:00+01	2022-02-23 23:00:00+01	1	\N	\N	\N
180	est et tempus semper est quam pharetra magna ac consequat	41	7	6	1	2022-03-16 23:00:00+01	2022-03-04 23:00:00+01	2022-02-04 23:00:00+01	1	\N	\N	\N
181	curae donec pharetra magna vestibulum aliquet	87	2	6	1	2022-04-30 23:00:00+02	2022-03-19 23:00:00+01	2022-03-02 23:00:00+01	1	\N	\N	\N
182	ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris	163	5	6	1	2022-05-14 23:00:00+02	2022-03-07 23:00:00+01	2022-02-12 23:00:00+01	1	\N	\N	\N
184	augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id	131	18	6	1	2022-05-03 23:00:00+02	2022-03-14 23:00:00+01	2022-02-23 23:00:00+01	1	\N	\N	\N
251	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:47:14.83212+01	2022-11-24 14:35:14.319561+01	\N	3.3200	4	3.0000
225	4	68	4	6	1	2022-09-23 02:00:00+02	2023-01-29 23:32:59.300201+01	2022-09-07 19:13:46.171464+02	1	\N	\N	1.0000
174	4	118	8	6	1	2022-11-09 01:00:00+01	\N	2022-02-22 23:00:00+01	1	\N	\N	\N
277	1	260	12	1	1	2022-12-08 01:00:00+01	2023-01-14 19:24:07.036102+01	2022-11-29 11:46:58.272792+01	\N	7.0000	1	\N
242	4	38	11	1	1	2022-11-16 01:00:00+01	2023-01-15 21:09:54.736072+01	2022-10-12 13:06:15.556367+02	1	\N	\N	1.0000
240	4	37	11	1	1	2022-11-16 01:00:00+01	2023-01-15 21:09:56.225528+01	2022-10-12 13:06:15.556367+02	1	\N	\N	1.0000
353	\N	265	16	6	1	2023-03-05 01:00:00+01	2023-02-17 15:49:43.089462+01	2023-02-17 13:51:52.572542+01	1	\N	\N	1.0000
307	\N	53	13	1	2	2023-01-08 01:00:00+01	2023-02-17 16:17:32.930796+01	2022-12-07 12:22:02.385593+01	1	\N	\N	1.0000
316	\N	296	18	19	4	2023-02-20 01:00:00+01	2023-02-20 21:37:24.632289+01	2023-01-15 23:57:00.34676+01	\N	2.0000	2	0.0000
360	\N	\N	12	4	1	2023-04-08 02:00:00+02	2023-03-10 14:38:18.018464+01	2023-03-10 14:38:13.407712+01	1	\N	\N	1.0000
201	vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere	138	7	6	1	2022-06-27 02:00:00+02	2022-10-12 13:05:04.66481+02	2022-02-27 23:00:00+01	1	\N	\N	\N
193	hendrerit at vulputate vitae nisl aenean lectus pellentesque	147	9	6	1	2022-03-05 23:00:00+01	2022-03-30 23:00:00+02	2022-03-27 23:00:00+02	1	\N	\N	\N
197	adipiscing elit proin risus praesent	101	15	6	1	2022-05-12 23:00:00+02	2022-03-08 23:00:00+01	2021-12-31 23:00:00+01	1	\N	\N	\N
188	iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis	160	2	6	1	2022-02-22 23:00:00+01	2022-04-01 23:00:00+02	2022-02-21 23:00:00+01	1	\N	\N	\N
189	donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit	123	2	6	1	2022-03-16 23:00:00+01	2022-03-11 23:00:00+01	2022-03-10 23:00:00+01	1	\N	\N	\N
194	hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum	150	14	6	1	2022-02-12 23:00:00+01	2022-02-22 23:00:00+01	2022-02-02 23:00:00+01	1	\N	\N	\N
195	ligula sit amet eleifend pede	15	3	6	1	2022-05-15 23:00:00+02	2022-03-17 23:00:00+01	2022-03-14 23:00:00+01	1	\N	\N	\N
196	semper interdum mauris ullamcorper purus	8	12	6	1	2022-01-31 23:00:00+01	2022-05-17 11:29:04.804464+02	2022-01-28 23:00:00+01	1	\N	\N	\N
330	\N	266	18	6	1	2023-02-26 01:00:00+01	2023-02-15 22:47:54.522719+01	2023-02-15 22:47:34.144878+01	4	\N	\N	4.0000
338	\N	266	18	6	1	2023-02-24 01:00:00+01	2023-02-16 12:39:52.916856+01	2023-02-16 12:01:05.867607+01	0	\N	\N	4.0000
346	\N	266	18	6	1	2023-03-05 01:00:00+01	2023-02-16 22:24:42.231036+01	2023-02-16 22:20:58.979735+01	\N	0.0000	5	5.0000
308	\N	55	13	1	2	2023-01-05 01:00:00+01	2023-02-20 13:28:55.349588+01	2022-12-07 12:32:47.687267+01	1	\N	\N	1.0000
212	1	12	4	6	1	2022-07-01 02:00:00+02	2022-07-21 11:16:53.609219+02	2022-06-22 12:12:40.836858+02	1	\N	\N	\N
278	1	260	12	1	1	2022-12-11 01:00:00+01	2022-12-01 11:11:27.418725+01	2022-11-29 11:47:32.334517+01	\N	2.0000	1	1.5000
269	1	3	13	1	1	2022-12-04 01:00:00+01	2022-11-29 11:29:46.394566+01	2022-11-29 11:11:12.193282+01	1	\N	\N	1.0000
268	1	259	13	1	1	2022-12-04 01:00:00+01	2022-11-29 13:54:56.18836+01	2022-11-29 11:11:12.193282+01	\N	3.0000	4	3.0000
260	1	259	13	1	1	2022-11-27 01:00:00+01	2022-11-24 21:30:56.789102+01	2022-11-24 21:29:21.764897+01	5	\N	\N	5.0000
252	1	259	13	1	1	2022-11-26 01:00:00+01	2022-11-24 14:49:51.466431+01	2022-11-24 14:47:53.192879+01	\N	2.5430	4	2.0000
95	sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus	9	13	6	1	2022-10-14 02:00:00+02	2022-11-29 11:28:11.558453+01	2022-03-28 23:00:00+02	1	\N	\N	\N
261	6	259	13	1	1	2022-11-30 01:00:00+01	2022-12-07 10:32:47.696533+01	2022-11-24 21:31:07.064216+01	5	\N	\N	\N
331	\N	266	18	6	1	2023-02-18 01:00:00+01	2023-02-15 23:05:30.497356+01	2023-02-15 22:51:32.65806+01	4	\N	\N	4.0000
339	\N	266	18	6	1	2023-02-25 01:00:00+01	2023-02-16 12:53:10.00226+01	2023-02-16 12:50:14.753779+01	\N	0.0000	5	1.0000
347	\N	266	18	6	1	2023-02-25 01:00:00+01	2023-02-16 22:27:54.031885+01	2023-02-16 22:25:20.060469+01	\N	0.0000	5	5.0000
324	\N	303	11	21	3	2023-03-30 02:00:00+02	2023-02-24 23:15:53.917298+01	2023-01-30 14:47:07.943273+01	\N	0.0000	2	0.5000
279	1	261	12	1	1	2022-12-11 01:00:00+01	2022-12-01 10:00:33.355055+01	2022-11-30 12:33:32.282469+01	\N	0.0500	2	0.0500
270	1	5	13	1	1	2022-12-24 01:00:00+01	2022-11-29 14:35:27.136946+01	2022-11-29 11:12:33.098422+01	1	\N	\N	1.0000
253	1	260	13	1	1	2022-11-27 01:00:00+01	2022-11-24 14:49:49.024815+01	2022-11-24 14:48:38.47342+01	17	\N	\N	17.0000
280	1	259	13	1	1	2022-12-31 01:00:00+01	2023-01-14 19:24:07.036102+01	2022-12-01 11:53:04.625231+01	\N	24.9000	4	0.0000
332	\N	266	18	6	1	2023-03-03 01:00:00+01	2023-02-15 23:07:54.546568+01	2023-02-15 23:07:06.898816+01	1	\N	\N	1.0000
214	1	100	4	6	1	2022-07-05 02:00:00+02	2022-07-21 11:12:02.985323+02	2022-06-22 12:17:51.661525+02	1	\N	\N	\N
271	1	7	13	1	1	2022-12-10 01:00:00+01	2022-11-29 11:29:39.714444+01	2022-11-29 11:16:54.807058+01	1	\N	\N	1.0000
262	1	260	13	1	1	2022-11-30 01:00:00+01	2022-11-24 21:35:24.493459+01	2022-11-24 21:33:48.680988+01	\N	10.0000	1	10.0000
254	1	260	13	1	1	2022-11-25 01:00:00+01	2022-11-24 14:51:29.056755+01	2022-11-24 14:50:08.747927+01	11	\N	\N	11.0000
340	\N	266	18	6	1	2023-02-18 01:00:00+01	2023-02-16 13:01:08.450407+01	2023-02-16 12:56:43.07306+01	\N	0.0000	5	7.5000
348	\N	266	18	6	1	2023-02-24 01:00:00+01	2023-02-16 22:34:36.070206+01	2023-02-16 22:28:24.220599+01	\N	0.0000	5	5.0000
31	4	145	7	6	1	2022-11-30 01:00:00+01	2023-04-22 16:40:46.038291+02	2022-02-27 23:00:00+01	1	\N	\N	1.0000
132	4	133	10	6	1	2023-02-23 01:00:00+01	2023-04-22 16:41:52.203449+02	2022-03-05 23:00:00+01	1	\N	\N	1.0000
322	\N	100	15	21	3	2023-03-31 02:00:00+02	2023-04-22 16:42:11.987447+02	2023-01-29 13:32:17.959234+01	1	\N	\N	1.0000
317	\N	183	6	4	1	2023-07-15 02:00:00+02	\N	2023-01-16 11:34:38.486276+01	1	\N	\N	0.0000
309	\N	28	13	1	2	2023-07-05 02:00:00+02	2025-01-04 18:55:08.102071+01	2022-12-07 14:18:26.528654+01	1	\N	\N	1.0000
365	\N	68	15	1	1	2025-04-08 02:00:00+02	\N	2023-04-22 16:42:29.570319+02	1	\N	\N	0.0000
198	4	143	12	6	1	2022-05-27 02:00:00+02	2023-04-22 16:42:43.348847+02	2022-03-02 23:00:00+01	1	\N	\N	1.0000
321	\N	96	12	21	3	2023-03-24 01:00:00+01	2023-04-22 16:42:47.037591+02	2023-01-29 13:30:57.509886+01	1	\N	\N	1.0000
233	1	85	17	1	1	2023-07-14 02:00:00+02	\N	2022-10-12 13:03:48.872406+02	1	\N	\N	\N
368	\N	296	12	1	4	2023-06-17 02:00:00+02	2023-11-15 20:56:59.210507+01	2023-04-22 16:43:14.511759+02	\N	1.5000	2	1.5000
369	\N	8	2	1	1	2025-03-28 01:00:00+01	\N	2025-01-04 18:53:31.930111+01	1	\N	\N	0.0000
323	\N	80	10	6	1	2026-03-21 01:00:00+01	\N	2023-01-30 14:28:41.012667+01	1	\N	\N	0.0000
140	4	119	2	6	1	2022-10-20 02:00:00+02	2025-01-04 18:53:42.744114+01	2022-03-25 23:00:00+01	1	\N	\N	1.0000
370	\N	74	4	1	1	2025-04-02 02:00:00+02	\N	2025-01-04 18:54:25.3075+01	1	\N	\N	0.0000
371	\N	90	4	1	1	2025-04-02 02:00:00+02	\N	2025-01-04 18:54:25.3075+01	1	\N	\N	0.0000
227	4	92	4	6	1	2024-09-19 02:00:00+02	2025-01-04 18:54:29.467599+01	2022-09-13 11:17:39.942768+02	1	\N	\N	1.0000
373	\N	96	13	1	3	2025-02-28 01:00:00+01	\N	2025-01-04 18:55:04.572027+01	1	\N	\N	0.0000
310	\N	44	13	1	2	2023-07-06 02:00:00+02	2025-01-04 18:55:09.808529+01	2022-12-07 14:19:11.371178+01	1	\N	\N	1.0000
366	\N	70	15	1	1	2024-11-29 01:00:00+01	2025-01-04 18:55:29.499062+01	2023-04-22 16:42:29.570319+02	1	\N	\N	1.0000
374	\N	27	7	1	1	2025-02-22 01:00:00+01	\N	2025-01-04 18:56:04.873876+01	1	\N	\N	0.0000
375	\N	58	7	1	1	2025-02-22 01:00:00+01	\N	2025-01-04 18:56:04.873876+01	1	\N	\N	0.0000
377	\N	15	9	1	1	2025-01-30 01:00:00+01	\N	2025-01-04 18:57:04.664747+01	1	\N	\N	0.0000
367	\N	66	15	1	1	2024-11-05 01:00:00+01	2025-01-04 18:58:31.569427+01	2023-04-22 16:42:29.570319+02	1	\N	\N	1.0000
217	4	48	3	20	2	2025-03-28 01:00:00+01	2025-01-28 19:56:19.953176+01	2022-09-07 14:48:19.754228+02	1	\N	\N	1.0000
382	\N	117	16	1	1	2025-06-27 02:00:00+02	\N	2025-01-04 18:59:23.502548+01	1	\N	\N	0.0000
381	\N	106	16	1	1	2025-06-06 02:00:00+02	\N	2025-01-04 18:59:23.502548+01	1	\N	\N	0.0000
386	\N	53	3	6	1	2026-03-20 01:00:00+01	\N	2026-01-19 18:00:12.313871+01	1	\N	\N	0.0000
387	\N	19	3	6	1	2026-03-20 01:00:00+01	\N	2026-01-19 18:00:12.313871+01	1	\N	\N	0.0000
385	\N	7	3	1	1	2025-05-25 02:00:00+02	2026-01-19 18:00:19.387388+01	2025-03-26 19:50:31.345412+01	1	\N	\N	1.0000
384	\N	64	3	1	1	2025-05-17 02:00:00+02	2026-01-19 18:00:21.370457+01	2025-01-28 19:56:13.102188+01	1	\N	\N	1.0000
388	\N	70	18	6	1	2026-04-16 02:00:00+02	\N	2026-01-19 18:01:07.497546+01	1	\N	\N	0.0000
389	\N	264	18	6	1	2026-04-16 02:00:00+02	\N	2026-01-19 18:01:07.497546+01	1	\N	\N	0.0000
378	\N	107	18	1	1	2025-03-27 01:00:00+01	2026-01-19 18:01:12.326617+01	2025-01-04 18:57:57.281163+01	1	\N	\N	1.0000
380	\N	132	18	1	1	2025-03-27 01:00:00+01	2026-01-19 18:01:16.977994+01	2025-01-04 18:57:57.281163+01	1	\N	\N	1.0000
379	\N	148	18	1	1	2025-03-27 01:00:00+01	2026-01-19 18:01:19.213345+01	2025-01-04 18:57:57.281163+01	1	\N	\N	1.0000
390	\N	45	9	6	1	2026-03-12 01:00:00+01	\N	2026-01-19 18:01:37.863371+01	1	\N	\N	0.0000
376	\N	28	7	1	1	2026-03-06 01:00:00+01	\N	2025-01-04 18:56:04.873876+01	1	\N	\N	0.0000
320	\N	51	7	4	1	2024-12-25 01:00:00+01	2026-01-19 18:02:05.843264+01	2023-01-29 13:02:51.324+01	1	\N	\N	1.0000
364	\N	3	7	1	1	2024-11-25 01:00:00+01	2026-01-19 18:02:07.654432+01	2023-04-22 16:40:22.575121+02	1	\N	\N	1.0000
372	\N	46	13	1	1	2026-03-05 01:00:00+01	\N	2025-01-04 18:55:04.572027+01	1	\N	\N	0.0000
67	4	23	10	6	1	2026-06-12 02:00:00+02	\N	2022-03-23 23:00:00+01	1	\N	\N	\N
383	\N	296	14	1	4	2026-08-14 02:00:00+02	\N	2025-01-04 19:00:20.876066+01	1	\N	\N	0.0000
\.


--
-- Data for Name: varasto_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_settings (id, set_name, set_value, label) FROM stdin;
3	rental_page_field_ordering	Alkamispäivä	\N
2	rental_page_ordering	1	\N
5	storage_email	office.varasto@gmail.com	Varastonhallinnan sähköposti
6	email_pass	ztjzeaeqtddelbwq	Salasana
7	email_server	smtp.gmail.com	Palvelin nimi
1	rental_page_view	rental_events	Vuokratapahtumat
4	show_full_burger	0	\N
8	storage_email	\N	Varastonhallinnan sähköposti
9	email_pass	\N	Salasana
10	email_server	\N	Palvelin nimi
\.


--
-- Data for Name: varasto_settings_customuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_settings_customuser (id, set_value, setting_name_id, user_id, storage_id) FROM stdin;
63	rental_events	1	20	\N
62	1	2	20	\N
59	1	4	19	\N
61	Alkamispäivä	3	20	\N
15	rental_events	1	19	\N
48	Alkamispäivä	3	5	\N
49	1	2	5	\N
67	office.varasto@gmail.com	5	20	2
69	smtp.gmail.com	7	20	2
70	Alkamispäivä	3	21	\N
71	1	2	21	\N
19	Alkamispäivä	3	19	\N
18	1	2	19	\N
16	Alkamispäivä	3	6	\N
72	1	4	21	\N
73	rental_events	1	21	\N
50	office.varasto@gmail.com	5	19	4
52	smtp.gmail.com	7	19	4
47	smtp.gmail.com	7	6	1
53	Alkamispäivä	3	4	\N
45	office.varasto@gmail.com	5	6	1
75	rental_events	1	4	\N
54	1	2	4	\N
76	Alkamispäivä	3	3	\N
77	1	2	3	\N
68	dadzsfrgacqaatko	6	20	2
51	dadzsfrgacqaatko	6	19	4
46	dadzsfrgacqaatko	6	6	1
78	office.varasto@gmail.com	8	1	\N
79	dadzsfrgacqaatko	9	1	\N
80	smtp.gmail.com	10	1	\N
81	1	4	4	\N
60	1	4	5	\N
2	1	2	1	\N
74	1	4	6	\N
17	1	2	6	\N
14	rental_events	1	6	\N
4	1	4	1	\N
1	rental_events	1	1	\N
3	Alkamispäivä	3	1	\N
\.


--
-- Data for Name: varasto_staff_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_staff_audit (id, event_process, event_date, remarks, from_storage, item, person, staff, to_storage) FROM stdin;
1	Delete item	2023-01-21 22:02:27.581739+01	\N	\N	{'id': 201, 'item_name': 'Hiomakone', 'brand': 'Makita', 'model': 'DWE576K', 'contents': Decimal('1.0000'), 'amount': 1, 'unit_id': None, 'amount_x_contents': None, 'ean': '2112460183331', 'reg_number': '32538574', 'invoice_number': '193232392-9'}	\N	{'id': 19, 'first_name': 'Antonio', 'last_name': 'Banderas', 'phone': '+358001234567', 'code': '10025'}	Hius- ja kauneudenhoitoala
26	Delete item	2023-03-06 10:55:32.648239+01	\N	\N	{'id': 310, 'item_name': 'ersddn', 'brand': 'dfndfn', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
27	Delete item	2023-03-06 10:59:27.051769+01	\N	\N	{'id': 309, 'item_name': 'fb', 'brand': 'fbf', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
20	Delete item	2023-01-21 22:41:35.471674+01	\N	\N	{'id': 299, 'item_name': 'dsb', 'brand': 'cvn', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'phone': '+3588503450', 'code': '00001'}	\N
21	Delete item	2023-01-21 22:42:52.548395+01	\N	\N	{'id': 300, 'item_name': 'sdxcb', 'brand': 'xcbxb', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'phone': '+3588503450', 'code': '00001'}	\N
22	Delete item	2023-03-03 21:48:03.159604+01	\N	\N	{'id': 311, 'item_name': 'ersddn', 'brand': 'dfndfn', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
23	Delete item	2023-03-03 22:21:11.627077+01	\N	\N	{'id': 315, 'item_name': 'aawawg', 'brand': 'awfawf', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
24	Delete item	2023-03-06 10:24:59.141164+01	\N	\N	{'id': 304, 'item_name': 'sege', 'brand': 'egeg', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
25	Delete item	2023-03-06 10:46:42.412771+01	\N	\N	{'id': 306, 'item_name': 'sdb', 'brand': 'dbf', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
28	Delete item	2023-03-06 11:03:09.991821+01	\N	\N	{'id': 308, 'item_name': 'fb', 'brand': 'fbf', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
29	Delete item	2023-03-06 11:24:26.061944+01	\N	\N	{'id': 307, 'item_name': 'sdb', 'brand': 'dbf', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
30	Delete item	2023-03-06 11:29:07.648591+01	\N	\N	{'id': 305, 'item_name': 'sege', 'brand': 'egeg', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'reg_number': None, 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
31	Delete item	2023-03-10 12:21:50.609096+01	\N	\N	{'id': 318, 'item_name': 'sdsdd', 'brand': None, 'model': None, 'contents': '', 'amount': 2, 'unit_id': None, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
32	Delete item	2023-03-10 12:31:36.962673+01	\N	\N	{'id': 321, 'item_name': 'sedsgwew', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
33	Delete item	2023-03-10 12:31:41.35133+01	\N	\N	{'id': 320, 'item_name': 'seswbweg', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
34	Delete item	2023-03-10 12:31:45.086019+01	\N	\N	{'id': 319, 'item_name': 's3tw3t', 'brand': None, 'model': None, 'contents': '', 'amount': 2, 'unit_id': None, 'amount_x_contents': '2', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
35	Delete item	2023-03-10 12:31:49.614936+01	\N	\N	{'id': 317, 'item_name': 'sdbsed', 'brand': 'dfdfdfn', 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
36	Delete item	2023-03-10 13:01:29.626651+01	\N	\N	{'id': 326, 'item_name': 'seegegegegeg', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
37	Delete item	2023-03-10 14:35:52.899724+01	\N	\N	{'id': 324, 'item_name': 'tykyktyktkytyk', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
38	Delete item	2023-03-10 14:35:58.97511+01	\N	\N	{'id': 337, 'item_name': 'sdssd1222222', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
39	Delete item	2023-03-10 15:39:39.437343+01	\N	\N	{'id': 338, 'item_name': '123', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
40	Delete item	2023-03-10 15:56:28.427753+01	\N	\N	{'id': 340, 'item_name': '2345', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
41	Delete item	2023-03-10 15:56:32.82338+01	\N	\N	{'id': 337, 'item_name': 'sdssd1222222', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
42	Delete item	2023-03-10 15:57:17.415149+01	\N	\N	{'id': 336, 'item_name': 'wewewttttttttttt', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
43	Delete item	2023-03-10 15:57:20.567347+01	\N	\N	{'id': 335, 'item_name': 'sewewewewe', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
44	Delete item	2023-03-10 15:57:23.815301+01	\N	\N	{'id': 334, 'item_name': 'xcxcxccx', 'brand': None, 'model': None, 'contents': '2', 'amount': 2, 'unit_id': 1, 'amount_x_contents': '4', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
45	Delete item	2023-03-10 15:57:26.449252+01	\N	\N	{'id': 333, 'item_name': 'sdsdsdddd', 'brand': None, 'model': None, 'contents': '3', 'amount': 2, 'unit_id': 1, 'amount_x_contents': '6', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
46	Delete item	2023-03-10 15:57:29.40866+01	\N	\N	{'id': 332, 'item_name': 'eeegeggeeg', 'brand': None, 'model': None, 'contents': '2', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '2', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
47	Delete item	2023-03-10 15:57:32.175528+01	\N	\N	{'id': 331, 'item_name': 'xcxcbxcbxbx', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
48	Delete item	2023-03-10 15:57:35.094871+01	\N	\N	{'id': 330, 'item_name': 'sebseeegeeg', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
49	Delete item	2023-03-10 15:57:37.673519+01	\N	\N	{'id': 329, 'item_name': 'wewqqqqqqq', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
50	Delete item	2023-03-10 15:57:40.29079+01	\N	\N	{'id': 328, 'item_name': 'qwqwqw', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
51	Delete item	2023-03-10 15:57:43.918923+01	\N	\N	{'id': 327, 'item_name': 'eeeeeeeeeegggggg', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
52	Delete item	2023-03-10 15:57:52.218474+01	\N	\N	{'id': 325, 'item_name': 'wewewewewewewe', 'brand': None, 'model': None, 'contents': '', 'amount': 1, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
53	Delete item	2023-03-10 15:57:57.175922+01	\N	\N	{'id': 323, 'item_name': 'erereere', 'brand': None, 'model': None, 'contents': '', 'amount': 3, 'unit_id': None, 'amount_x_contents': '3', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
54	Delete item	2023-03-10 15:58:01.085517+01	\N	\N	{'id': 322, 'item_name': 'käsineet', 'brand': None, 'model': None, 'contents': '1', 'amount': 0, 'unit_id': 1, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 4, 'first_name': 'John', 'last_name': 'Pon', 'is_storage_staff': True, 'phone': '+358415459494', 'code': '10003'}	Auto-osasto
55	Delete item	2023-03-15 11:13:03.523307+01	\N	\N	{'id': 343, 'item_name': 'ddffffff', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'is_storage_staff': True, 'phone': '+3588503450', 'code': '00001'}	\N
56	Delete item	2023-03-22 10:36:13.253111+01	\N	\N	{'id': 345, 'item_name': 'Porakone', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'is_storage_staff': True, 'phone': '+3588503450', 'code': '00001'}	\N
57	Delete item	2023-03-22 10:38:26.308894+01	\N	\N	{'id': 346, 'item_name': 'Speaker', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '', 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'is_storage_staff': True, 'phone': '+3588503450', 'code': '00001'}	\N
58	Delete item	2023-03-22 17:17:17.967981+01	\N	\N	{'id': 342, 'item_name': '3wesegsds', 'brand': None, 'model': None, 'contents': '1', 'amount': 1, 'unit_id': None, 'amount_x_contents': '1', 'invoice_number': None}	\N	{'id': 1, 'first_name': 'Elon', 'last_name': 'Musk', 'is_storage_staff': True, 'phone': '+3588503450', 'code': '00001'}	\N
\.


--
-- Data for Name: varasto_storage_name; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_storage_name (id, name, storage_code) FROM stdin;
1	Auto-osasto	a
2	Rakennusala	r
3	Sähkö- ja automaatioala	s
4	Hius- ja kauneudenhoitoala	p
5	Kone- ja tuotantotekniikaala	k
6	Logistiikka ala	l
\.


--
-- Data for Name: varasto_storage_place; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_storage_place (id, rack, shelf, place) FROM stdin;
4	A1	4	1
5	A1	5	1
6	A1	6	1
7	A1	7	1
8	A1	8	1
9	A1	9	1
10	A1	1	2
11	A1	2	2
12	A1	3	2
13	A1	4	2
14	A1	5	2
15	A1	6	2
16	A1	7	2
17	A1	8	2
18	A1	9	2
1	A1	1	1
2	A1	2	1
3	A1	3	1
\.


--
-- Data for Name: varasto_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.varasto_units (id, unit_name) FROM stdin;
1	kpl
2	l
3	kg
4	m
5	m³
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 6, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 227, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 233, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 97, true);


--
-- Name: goods_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_audit_id_seq', 2, true);


--
-- Name: rental_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_audit_id_seq', 765, true);


--
-- Name: varasto_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_category_id_seq', 3, true);


--
-- Name: varasto_customuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_customuser_groups_id_seq', 25, true);


--
-- Name: varasto_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_customuser_id_seq', 26, true);


--
-- Name: varasto_customuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_customuser_user_permissions_id_seq', 1, true);


--
-- Name: varasto_goods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_goods_id_seq', 346, true);


--
-- Name: varasto_rental_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_rental_event_id_seq', 390, true);


--
-- Name: varasto_settings_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_settings_customuser_id_seq', 81, true);


--
-- Name: varasto_staff_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_staff_audit_id_seq', 58, true);


--
-- Name: varasto_storage_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_storage_name_id_seq', 6, true);


--
-- Name: varasto_storage_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_storage_place_id_seq', 18, true);


--
-- Name: varasto_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_units_id_seq', 5, true);


--
-- Name: varasto_varasto_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.varasto_varasto_settings_id_seq', 10, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: goods_audit goods_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_audit
    ADD CONSTRAINT goods_audit_pkey PRIMARY KEY (id);


--
-- Name: rental_audit rental_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_audit
    ADD CONSTRAINT rental_audit_pkey PRIMARY KEY (id);


--
-- Name: varasto_category varasto_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_category
    ADD CONSTRAINT varasto_category_pkey PRIMARY KEY (id);


--
-- Name: varasto_customuser_groups varasto_customuser_groups_customuser_id_group_id_85903810_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_groups
    ADD CONSTRAINT varasto_customuser_groups_customuser_id_group_id_85903810_uniq UNIQUE (customuser_id, group_id);


--
-- Name: varasto_customuser_groups varasto_customuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_groups
    ADD CONSTRAINT varasto_customuser_groups_pkey PRIMARY KEY (id);


--
-- Name: varasto_customuser varasto_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser
    ADD CONSTRAINT varasto_customuser_pkey PRIMARY KEY (id);


--
-- Name: varasto_customuser_user_permissions varasto_customuser_user__customuser_id_permission_881b0858_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_user_permissions
    ADD CONSTRAINT varasto_customuser_user__customuser_id_permission_881b0858_uniq UNIQUE (customuser_id, permission_id);


--
-- Name: varasto_customuser_user_permissions varasto_customuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_user_permissions
    ADD CONSTRAINT varasto_customuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: varasto_customuser varasto_customuser_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser
    ADD CONSTRAINT varasto_customuser_username_key UNIQUE (username);


--
-- Name: varasto_goods varasto_goods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_goods
    ADD CONSTRAINT varasto_goods_pkey PRIMARY KEY (id);


--
-- Name: varasto_rental_event varasto_rental_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_pkey PRIMARY KEY (id);


--
-- Name: varasto_settings_customuser varasto_settings_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings_customuser
    ADD CONSTRAINT varasto_settings_customuser_pkey PRIMARY KEY (id);


--
-- Name: varasto_staff_audit varasto_staff_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_staff_audit
    ADD CONSTRAINT varasto_staff_audit_pkey PRIMARY KEY (id);


--
-- Name: varasto_storage_name varasto_storage_name_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_storage_name
    ADD CONSTRAINT varasto_storage_name_pkey PRIMARY KEY (id);


--
-- Name: varasto_storage_place varasto_storage_place_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_storage_place
    ADD CONSTRAINT varasto_storage_place_pkey PRIMARY KEY (id);


--
-- Name: varasto_units varasto_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_units
    ADD CONSTRAINT varasto_units_pkey PRIMARY KEY (id);


--
-- Name: varasto_units varasto_units_unit_name_e674d57e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_units
    ADD CONSTRAINT varasto_units_unit_name_e674d57e_uniq UNIQUE (unit_name);


--
-- Name: varasto_settings varasto_varasto_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings
    ADD CONSTRAINT varasto_varasto_settings_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: varasto_customuser_groups_customuser_id_d046b9b7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_groups_customuser_id_d046b9b7 ON public.varasto_customuser_groups USING btree (customuser_id);


--
-- Name: varasto_customuser_groups_group_id_0ce3efa3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_groups_group_id_0ce3efa3 ON public.varasto_customuser_groups USING btree (group_id);


--
-- Name: varasto_customuser_responsible_teacher_id_4383ad09; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_responsible_teacher_id_4383ad09 ON public.varasto_customuser USING btree (responsible_teacher_id);


--
-- Name: varasto_customuser_storge_id_8b132538; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_storge_id_8b132538 ON public.varasto_customuser USING btree (storage_id);


--
-- Name: varasto_customuser_user_permissions_customuser_id_de6f62af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_user_permissions_customuser_id_de6f62af ON public.varasto_customuser_user_permissions USING btree (customuser_id);


--
-- Name: varasto_customuser_user_permissions_permission_id_e629ad63; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_user_permissions_permission_id_e629ad63 ON public.varasto_customuser_user_permissions USING btree (permission_id);


--
-- Name: varasto_customuser_username_4b774198_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_customuser_username_4b774198_like ON public.varasto_customuser USING btree (username varchar_pattern_ops);


--
-- Name: varasto_goods_cat_name_id_15662a87; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_goods_cat_name_id_15662a87 ON public.varasto_goods USING btree (cat_name_id);


--
-- Name: varasto_goods_storage_id_82cf6b8d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_goods_storage_id_82cf6b8d ON public.varasto_goods USING btree (storage_id);


--
-- Name: varasto_goods_unit_id_930a05ed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_goods_unit_id_930a05ed ON public.varasto_goods USING btree (unit_id);


--
-- Name: varasto_rental_event_item_id_12f6b00a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_rental_event_item_id_12f6b00a ON public.varasto_rental_event USING btree (item_id);


--
-- Name: varasto_rental_event_renter_id_8e9b6f32; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_rental_event_renter_id_8e9b6f32 ON public.varasto_rental_event USING btree (renter_id);


--
-- Name: varasto_rental_event_staff_id_fb444d23; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_rental_event_staff_id_fb444d23 ON public.varasto_rental_event USING btree (staff_id);


--
-- Name: varasto_rental_event_storage_id_f4a37666; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_rental_event_storage_id_f4a37666 ON public.varasto_rental_event USING btree (storage_id);


--
-- Name: varasto_rental_event_units_id_e6e1ef22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_rental_event_units_id_e6e1ef22 ON public.varasto_rental_event USING btree (units_id);


--
-- Name: varasto_settings_customuser_setting_name_id_887d1015; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_settings_customuser_setting_name_id_887d1015 ON public.varasto_settings_customuser USING btree (setting_name_id);


--
-- Name: varasto_settings_customuser_storage_id_50791d5e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_settings_customuser_storage_id_50791d5e ON public.varasto_settings_customuser USING btree (storage_id);


--
-- Name: varasto_settings_customuser_user_id_da5654c4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_settings_customuser_user_id_da5654c4 ON public.varasto_settings_customuser USING btree (user_id);


--
-- Name: varasto_units_unit_name_e674d57e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX varasto_units_unit_name_e674d57e_like ON public.varasto_units USING btree (unit_name varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_varasto_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_varasto_customuser_id FOREIGN KEY (user_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser_groups varasto_customuser_g_customuser_id_d046b9b7_fk_varasto_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_groups
    ADD CONSTRAINT varasto_customuser_g_customuser_id_d046b9b7_fk_varasto_c FOREIGN KEY (customuser_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser_groups varasto_customuser_groups_group_id_0ce3efa3_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_groups
    ADD CONSTRAINT varasto_customuser_groups_group_id_0ce3efa3_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser varasto_customuser_responsible_teacher__4383ad09_fk_varasto_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser
    ADD CONSTRAINT varasto_customuser_responsible_teacher__4383ad09_fk_varasto_c FOREIGN KEY (responsible_teacher_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser varasto_customuser_storage_id_0d03389d_fk_varasto_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser
    ADD CONSTRAINT varasto_customuser_storage_id_0d03389d_fk_varasto_s FOREIGN KEY (storage_id) REFERENCES public.varasto_storage_name(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser_user_permissions varasto_customuser_u_customuser_id_de6f62af_fk_varasto_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_user_permissions
    ADD CONSTRAINT varasto_customuser_u_customuser_id_de6f62af_fk_varasto_c FOREIGN KEY (customuser_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_customuser_user_permissions varasto_customuser_u_permission_id_e629ad63_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_customuser_user_permissions
    ADD CONSTRAINT varasto_customuser_u_permission_id_e629ad63_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_goods varasto_goods_cat_name_id_15662a87_fk_varasto_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_goods
    ADD CONSTRAINT varasto_goods_cat_name_id_15662a87_fk_varasto_category_id FOREIGN KEY (cat_name_id) REFERENCES public.varasto_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_goods varasto_goods_storage_id_82cf6b8d_fk_varasto_storage_name_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_goods
    ADD CONSTRAINT varasto_goods_storage_id_82cf6b8d_fk_varasto_storage_name_id FOREIGN KEY (storage_id) REFERENCES public.varasto_storage_name(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_goods varasto_goods_unit_id_930a05ed_fk_varasto_units_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_goods
    ADD CONSTRAINT varasto_goods_unit_id_930a05ed_fk_varasto_units_id FOREIGN KEY (unit_id) REFERENCES public.varasto_units(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_rental_event varasto_rental_event_item_id_12f6b00a_fk_varasto_goods_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_item_id_12f6b00a_fk_varasto_goods_id FOREIGN KEY (item_id) REFERENCES public.varasto_goods(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_rental_event varasto_rental_event_renter_id_8e9b6f32_fk_varasto_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_renter_id_8e9b6f32_fk_varasto_c FOREIGN KEY (renter_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_rental_event varasto_rental_event_staff_id_fb444d23_fk_varasto_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_staff_id_fb444d23_fk_varasto_customuser_id FOREIGN KEY (staff_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_rental_event varasto_rental_event_storage_id_f4a37666_fk_varasto_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_storage_id_f4a37666_fk_varasto_s FOREIGN KEY (storage_id) REFERENCES public.varasto_storage_name(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_rental_event varasto_rental_event_units_id_e6e1ef22_fk_varasto_units_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_rental_event
    ADD CONSTRAINT varasto_rental_event_units_id_e6e1ef22_fk_varasto_units_id FOREIGN KEY (units_id) REFERENCES public.varasto_units(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_settings_customuser varasto_settings_cus_setting_name_id_887d1015_fk_varasto_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings_customuser
    ADD CONSTRAINT varasto_settings_cus_setting_name_id_887d1015_fk_varasto_s FOREIGN KEY (setting_name_id) REFERENCES public.varasto_settings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_settings_customuser varasto_settings_cus_storage_id_50791d5e_fk_varasto_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings_customuser
    ADD CONSTRAINT varasto_settings_cus_storage_id_50791d5e_fk_varasto_s FOREIGN KEY (storage_id) REFERENCES public.varasto_storage_name(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: varasto_settings_customuser varasto_settings_cus_user_id_da5654c4_fk_varasto_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.varasto_settings_customuser
    ADD CONSTRAINT varasto_settings_cus_user_id_da5654c4_fk_varasto_c FOREIGN KEY (user_id) REFERENCES public.varasto_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

