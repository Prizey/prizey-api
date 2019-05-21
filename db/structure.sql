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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: updating_ticket_transactions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.updating_ticket_transactions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF (TG_OP = 'DELETE') THEN
          UPDATE users
          SET balance = (
            SELECT SUM(amount) FROM ticket_transactions
            WHERE user_id = OLD.user_id
          )
          WHERE id = OLD.user_id;
        ELSIF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
          UPDATE users
          SET balance = (
            SELECT SUM(amount) FROM ticket_transactions
            WHERE user_id = NEW.user_id
          )
          WHERE id = NEW.user_id;
        END IF;

        RETURN NULL;
      END;
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: game_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_settings (
    id bigint NOT NULL,
    price_multiplier double precision DEFAULT 1 NOT NULL,
    easy_carousel_speed integer DEFAULT 1 NOT NULL,
    medium_carousel_speed integer DEFAULT 2 NOT NULL,
    hard_carousel_speed integer DEFAULT 3 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    easy_ticket_amount integer DEFAULT 1 NOT NULL,
    medium_ticket_amount integer DEFAULT 2 NOT NULL,
    hard_ticket_amount integer DEFAULT 3 NOT NULL,
    game_blocked boolean,
    fairness_text text,
    terms_of_service text
);


--
-- Name: game_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.game_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.game_settings_id_seq OWNED BY public.game_settings.id;


--
-- Name: purchase_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_options (
    id bigint NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    price numeric(10,2) DEFAULT 0.0,
    ticket_amount integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: purchase_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.purchase_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.purchase_options_id_seq OWNED BY public.purchase_options.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: ticket_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_transactions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    amount integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ticket_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ticket_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ticket_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ticket_transactions_id_seq OWNED BY public.ticket_transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    provider character varying DEFAULT 'email'::character varying NOT NULL,
    uid character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    allow_password_change boolean DEFAULT false,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    email character varying,
    fullname character varying,
    address character varying,
    city character varying,
    state_province_region character varying,
    zipcode character varying,
    clothing_size character varying,
    shoe_size character varying,
    tokens json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blocked boolean DEFAULT false,
    stripe_customer_id character varying DEFAULT ''::character varying,
    balance integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: game_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_settings ALTER COLUMN id SET DEFAULT nextval('public.game_settings_id_seq'::regclass);


--
-- Name: purchase_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_options ALTER COLUMN id SET DEFAULT nextval('public.purchase_options_id_seq'::regclass);


--
-- Name: ticket_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_transactions ALTER COLUMN id SET DEFAULT nextval('public.ticket_transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: game_settings game_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_settings
    ADD CONSTRAINT game_settings_pkey PRIMARY KEY (id);


--
-- Name: purchase_options purchase_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_options
    ADD CONSTRAINT purchase_options_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: ticket_transactions ticket_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_transactions
    ADD CONSTRAINT ticket_transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_ticket_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ticket_transactions_on_user_id ON public.ticket_transactions USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_uid_and_provider ON public.users USING btree (uid, provider);


--
-- Name: ticket_transactions update_user_balance; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_balance AFTER INSERT OR DELETE OR UPDATE ON public.ticket_transactions FOR EACH ROW EXECUTE PROCEDURE public.updating_ticket_transactions();


--
-- Name: ticket_transactions fk_rails_9a3843a6de; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_transactions
    ADD CONSTRAINT fk_rails_9a3843a6de FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190410164802'),
('20190411200927'),
('20190415172907'),
('20190415213101'),
('20190418165929'),
('20190418213220'),
('20190424205904'),
('20190425131306'),
('20190429170031'),
('20190502180338'),
('20190513233200'),
('20190520191909'),
('20190520205603');


