--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

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
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    price integer,
    titlepic text NOT NULL,
    otherpic text,
    newprice integer,
    createdate date
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    userid integer,
    productid integer,
    numberbuy integer,
    spec text,
    createtime date,
    cartid integer DEFAULT nextval('public.products_id_seq'::regclass),
    ispay boolean
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    winner_id smallint NOT NULL,
    location character varying(50) NOT NULL,
    prize integer
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer NOT NULL,
    age smallint NOT NULL,
    username character varying(50) NOT NULL,
    budget integer
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: productdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productdetails (
    id integer NOT NULL,
    option text,
    feature text,
    content text,
    spec text
);


ALTER TABLE public.productdetails OWNER TO postgres;

--
-- Name: userFavorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."userFavorite" (
    favoriteproductid integer,
    userid integer
);


ALTER TABLE public."userFavorite" OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (userid, productid, numberbuy, spec, createtime, cartid, ispay) FROM stdin;
10	5	1		2024-02-21	0	f
10	5	1		2024-02-21	0	f
10	6	1		2024-02-21	0	f
10	7	1	 馬鈴薯	2024-02-21	0	f
10	8	1		2024-02-21	0	f
10	8	1		2024-02-21	0	f
12	5	1		2024-02-22	26	f
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, winner_id, location, prize) FROM stdin;
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, age, username, budget) FROM stdin;
\.


--
-- Data for Name: productdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productdetails (id, option, feature, content, spec) FROM stdin;
10	尺寸, M , L; 顏色,黑,鐵灰;	商品特色\n輕著上身，舒適恆溫\n親膚柔軟，不易刺癢\n貼合式袖口設計，防風聚暖\nHeatTex蓄熱技術，國際認證升溫效果\n銷售重點\n恆暖 / 圓領 / 升溫 / 透氣	<p>提醒您:\n\n※ 商品圖檔顯示顏色會依個人手機/電腦螢幕顯示不同而有差異，商品依實際供貨為準。\n\n※ 依據行政院公布「通訊交易解除權合理例外情事適用準則」，個人衛生用品除商品本身瑕疵外，則以下商品將不適用於七天猶豫期，若經購買後恕無法辦理退換貨: \n\n已拆封之個人衛生用品(口罩、刮鬍刀、除毛刀、紙尿褲、內衣褲(含隱形胸罩、胸扥、胸貼、透明肩帶、水餃墊/美胸墊、襯裙)、塑身衣(含馬甲、束褲、束腿、腰夾、內搭、泳裝、襪子。)</p>\n<img src="https://ims-static.91app.com/IMS/Images/133/Product/5e260eb4-5fc5-4916-9ffc-33918eeaacb2"></img>	品牌, 瑪術;材質, 嫘縈68％、聚丙烯腈纖維25％、彈性纖維7％;產地,中國;
9	口味, 炭燒, 原味;	商品特色\n真茶葉。真奶茶，首創「茶包式奶茶」\n採用原片茶葉，台灣烏龍茶搭配紅茶作為基底\n印尼MUI清真認證，無人工茶精、奶素可食\n銷售重點\n多層次的焦香味，入口滑順，齒頰馨香，茶香濃郁及口感不甜	<div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7076954/0.jpg?ts=161720" data-filename="4urf2tkm"></p><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7076954/1.jpg?ts=161720" data-filename="idckdzea"></p><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7076954/2.jpg?ts=161720" data-filename="5wtcpbmn" style="width: 100%"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【商品規格】</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">品牌：3點1刻</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">包裝組合：袋裝</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">炭燒奶茶-成分：細糖、奶精(氫化棕仁油、葡萄糖漿、牛奶蛋白、磷酸氫二鉀、多磷酸鈉、單及雙脂肪酸甘油酯、單及雙脂肪酸甘油二乙醯酒石酸酯、二氧化矽、胡蘿蔔素)、紅茶、烏龍茶、咖啡粉</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">炭燒奶茶-營養標示: </p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">※營養標示數據若與包裝上略有差異時，以實際包裝上標示為準※</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">每一份量20公克；本包裝含15份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">熱量              92.7大卡/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">蛋白質            0.5公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">脂肪                3.0公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  飽和脂肪       2.9公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  反式脂肪       0.0公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">碳水化合物   15.9公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  糖                11.0公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">鈉                  11.2毫克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">原味奶茶-成分：細糖、奶精(氫化棕仁油、葡萄糖漿、牛奶蛋白、磷酸氫二鉀、多磷酸鈉、單及雙脂肪酸甘油酯、單及雙脂肪酸甘油二乙醯酒石酸酯、二氧化矽、胡蘿蔔素)、紅茶、烏龍茶</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">原味奶茶-營養標示: </p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">※營養標示數據若與包裝上略有差異時，以實際包裝上標示為準※</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">每一份量20公克；本包裝含15份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">熱量              93.4大卡/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">蛋白質            0.4公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">脂肪                3.1公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  飽和脂肪       3.1公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  反式脂肪       0.0公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">碳水化合物   15.9公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">  糖                12.1公克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">鈉                       6毫克/每份</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">保存期限：2年</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">有效日期：標示於包裝上</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">產地：台灣</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">產品重量：20gx15包</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">警語：本產品含有牛奶製品，請消費者購買時仔細閱讀成份標示</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">保存方法：開封後儘早飲用，避免直接日照，置於陰涼乾燥處</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商名稱：石城實業股份有限公司</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商地址：台中市台灣大道四段847號15樓</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商電話：04-23587898</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">食品業者登錄字號：B-186117471-00000-4</p></div>	\N
8	\N	商品特色\n最高溫度65℃，平均溫度51℃\n日本原裝進口，第一大品牌\n認証-國際ISO9001認證工廠製造\n使用方法：外袋打開取出後，輕輕搖晃、即產生熱度\n使用時機︰通勤、旅遊、登山露營、工作疲勞、肩頸酸痛、生理期等\n銷售重點\n驅寒保暖，無論外出或在家中，皆使用方便	<div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p style="text-align: center; display: block; font-size: 1em"></p><p style="text-align: center; display: block; font-size: 1em"><img src="https://ims-static.91app.com/IMS/Images/55/Product/707136a9-7878-4f7f-9e60-d6cfb4fcb698"></p></div>	\N
7	口味, 玉米, 馬鈴薯, 南瓜, 起司;	商品特色\n商品編號\n7044968\n銷售重點\n來自北海道的自然美味	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">\n                <div class="salepage-detail-info-top">\n                    <!----><ns-video ng-if="SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl!==''" data-height="360" data-width="640" data-auto-play="false" data-video-url="https://www.youtube.com/watch?v=lYAjh3Xy9VM"><iframe frameborder="0" allowfullscreen="" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" title="鮮甜美味🌽「VONO®」玉米濃湯" width="640" height="360" src="https://www.youtube.com/embed/lYAjh3Xy9VM?autoplay=0&amp;html5=1&amp;theme=light&amp;modesbranding=0&amp;color=white&amp;iv_load_policy=3&amp;showinfo=1&amp;controls=1&amp;enablejsapi=1&amp;rel=0&amp;origin=https%3A%2F%2Fwww.poyabuy.com.tw&amp;widgetid=1" id="widget2"></iframe></ns-video><!---->\n                </div>\n                <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/0.png?ts=152835" data-filename="xvso4c4d"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/1.jpg?ts=152835" data-filename="asm1apqz"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/2.jpg?ts=152835" data-filename="5imsmqnc"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/3.jpg?ts=152835" data-filename="y4ahbpek"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/4.jpg?ts=152835" data-filename="5pwh2fy2"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/5.jpg?ts=152835" data-filename="bxhj02f5"><br></p><p><br></p><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7044968/6.jpg?ts=152835" data-filename="q4zapcpk" style="width: 100%"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【商品規格】</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">品牌: VONO醇緻原味</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【玉米濃湯口味】重量:19.2g*3袋(57.6g)</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【玉米濃湯口味】成分: 甜玉米粉、砂糖、馬鈴薯澱粉、麥芽糊精、脫脂牛乳、棕櫚油、乳糖、玉米糖漿、食鹽、玉米粒、玉米油、棕櫚仁油、調味劑(L-麩酸鈉、5'-次黃嘌呤核苷磷酸二鈉)、酸酪蛋白、關華豆膠、洋蔥、糊精、酵母抽出物、大豆卵磷脂、白胡椒、香料、麵粉、葡萄糖、油菜籽油</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【馬鈴薯濃湯口味】重量:15.5g*3袋(46.5g)</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【馬鈴薯濃湯口味】成分: 馬鈴薯澱粉、麥芽糊精、砂糖、棕櫚油、食鹽、全脂牛乳、玉米糖漿、脫脂牛乳、馬鈴薯粉、洋蔥粉、調味劑(L-麩酸鈉、5‘-次黃嘌呤核苷磷酸二鈉、胺基乙酸)、卡門貝爾起司、洋蔥、棕櫚仁油、還原水飴、酵母抽出物、糊精、玉米油、關華豆膠、豬肉(丹麥)、酸酪蛋白、醬油、白胡椒、鰹魚抽出物、荷蘭芹、大豆卵磷脂、薑黃、玉米芯抽出物、芹菜籽、玉米澱粉、月桂、陳皮、麵粉、葡萄糖、油菜籽油、迷迭香抽出物 </p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【南瓜濃湯口味】重量:17.4g*3袋(52.2g)</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【南瓜濃湯口味】成分: 馬鈴薯澱粉、南瓜粉、砂糖、脫脂牛乳、棕櫚油、玉米糖漿、食鹽、麥芽糊精、馬鈴薯粉、棕櫚仁油、玉米油、糊精、調味劑(L-麩酸鈉、5’-次黃嘌呤核磷酸二鈉)、酵母抽出物、酸酪蛋白、洋蔥抽出物、椰子油、全脂牛乳、葡萄糖糖漿、米糠油、洋蔥、荷蘭芹、大豆卵磷脂、乳糖、白胡椒、豆蔻、月桂、肉桂、陳皮、葡萄糖</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【起司濃湯口味】重量:18g*3袋(54g) </p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">【起司濃湯口味】成分: 馬鈴薯澱粉、麥芽糊精、乳糖、棕櫚油、卡門貝爾起司、全脂牛乳、砂糖、馬鈴薯粉、玉米糖漿、食鹽、戈爾根佐拉起司、棕櫚仁油、調味劑(L-麩酸鈉、5'-次黃嘌呤核苷磷酸二鈉、胺基乙酸)、切達起司、椰子油、洋蔥粉、洋蔥、玉米油、關華豆膠、葡萄糖糖漿、脫脂牛乳、酵母抽出物、糊精、酸酪蛋白、鰹魚抽出物、大豆卵磷脂、荷蘭芹、玉米芯抽出物、白胡椒、薑黃、芹菜籽、玉米澱粉、月桂、陳皮。</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap"><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">保存期限: 常溫未開封18個月</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">有效日期: 印於盒底</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">產地: 日本</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">警語: 本產品含有奶類、麩質穀物類、大豆及其製品</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">保存方法: 常溫未開封18個月</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商名稱: Ajinomoto Co., Inc.</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商地址: 15-1, Kyobashi 1-chome, Chuo-ku, Tokyo 104-8315, Japan.</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">製造廠商電話: Tel. 81 3 5250 8111</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">進口廠商名稱: 台灣味之素股份有限公司</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">進口廠商地址: 台北市中正區忠孝東路二段123號6樓</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">進口廠商電話: 0800-022-000</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">食品業者登錄字號: A-127999300-00000-7</p></div>\n            </div>	\N
6	\N	商品特色\n商品編號\n7308249\n商品特色\n原廠正品 潤姬桃子\n用吃的米潤神經醯胺\n蜜桃風味無須配水僅4.28卡	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">\n                <div class="salepage-detail-info-top">\n                    <!---->\n                </div>\n                <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7308249/0.jpg?ts=084755" data-filename="qlapbivx"><br></p></div>\n            </div>	品牌,潤姬桃子;\n對象族群,想保持光澤滋潤的肌膚的人;\n內容物成分,麥芽糖醇（甜味劑）、α環狀糊精、桃子果汁粉（糊精、桃子汁、檸檬酸、維生素Ｃ（抗氧化劑））、大米胚芽萃取物（α環狀糊精、大米胚芽萃取物）、桃子香料（糊精、辛烯基丁二酸鈉澱粉、甘油、香料）、膠原蛋白（魚來源）、維生素C（抗壞血酸）、維生素B1（硝酸硫胺明）、維生素B2（核黃素）、維生素B6（鹽酸吡哆辛）、維生素B12粉末（麥芽糊精、檸檬酸鈉、檸檬酸、氰鈷胺明）;\n原產地國,日本;\n廠商地址.日本 靜岡縣;\n食品業者登錄字號,A－150903783－00000－3;\n保存期限\t3年
5	\N	商品特色\n商品編號\n7198243\n商品特色\n衛福部公告最高濃度2%水楊酸\n溫和安全pH3.5-4，有效去除角質\n絲滑細緻水乳液，清爽保濕不油膩\n預防前胸後背之粉刺、青春痘\n改善粗大毛孔、粗糙顆粒、乾燥細紋\n去除粗厚角質，勻亮黯沉膚色\n富含抗氧化物，還原年輕肌膚\n多樣舒緩因子，預防皮膚不適\n無人工香料、無色素、無酒精\n銷售重點\n美體煥膚，細緻勻亮\n抗痘去角質，保濕升級\n含藥化妝品:2%水楊酸最高濃度\n改善六大問題肌膚\n通過美國BioScreen 貼膚敏感測試\n無添加人工香料、色素、酒精	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">\n                <div class="salepage-detail-info-top">\n                    <!---->\n                </div>\n                <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/0.jpg?ts=114046" data-filename="wnq3uu5i"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/1.jpg?ts=114046" data-filename="s0gdfqas"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/2.jpg?ts=114046" data-filename="fmitapf2"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/3.jpg?ts=114046" data-filename="54vlbaho"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/4.jpg?ts=114046" data-filename="wbajaryc"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7198243/5.jpg?ts=114046" data-filename="owblyfte"><br></p><p><br></p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">品牌：寶拉珍選</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">適用對象族群：各種膚質適用</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">原產地：美國</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">廠商名稱：寶拉培岡股份有限公司</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">廠商地址：彰化縣彰化市彰美路一段186號8樓之1及8樓之2</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">廠商電話：0423019701</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">保存期限：4年</p><p style="margin-bottom: 0px; padding: 0px; border-style: initial; border-color: initial; line-height: 1.7; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;\\\\6587泉驛正黑&quot;, &quot;WenQuanYi Zen Hei&quot;, &quot;Hiragino Sans GB&quot;, &quot;\\\\5137黑Pro&quot;, &quot;LiHei Pro&quot;, &quot;Heiti TC&quot;, &quot;\\\\5FAE軟正黑體&quot;, &quot;Microsoft JhengHei UI&quot;, &quot;Microsoft JhengHei&quot;, san-serif; vertical-align: baseline; color: rgb(51, 51, 51); white-space: pre-wrap">內容物成分：Water, Butylene Glycol(保濕成分), Cetyl Alcohol(質感加強劑), PPG-14 Butyl Ether(質感加強劑), Salicylic Acid(水楊酸/去角質), Dimethicone(保濕成分), Tocopheryl Acetate(維他命E/抗氧化物), Chamomilla Recutita (Matricaria) Flower Extract(洋甘菊萃取/舒緩成分), Epilobium Angustifolium Flower/Leaf/Stem (Willowherb) Extract(舒緩成分), Camellia Oleifera (Green Tea) Leaf Extract(舒緩成分), Vanilla Planifolia Fruit Extract(舒緩成分), Bisabolol(舒緩成分), Allantoin(舒緩成分), Cyclopentasiloxane(保濕成分), Cyclohexasiloxane(保濕成分), Dimethiconol(保濕成分/質感加強劑), PEG-40 Stearate(質感加強劑), Sorbitan Stearate(質感加強劑), PVM/MA Decadiene Crosspolymer(質感加強劑), Polyacrylamide(質感加強劑), C13-14 Isoparaffin(質感加強劑), Laureth-7(質感加強劑), Disodium EDTA(穩定劑), Sodium Hydroxide(pH值調節劑), Hexylene Glycol(保濕成分/質感加強劑), Caprylyl Glycol(防腐劑), Caprylic/Capric Triglyceride(皮膚補充成分), Ethylhexylglycerin(防腐劑), Phenoxyethanol(防腐劑).</p></div>\n            </div>	\N
4	\N	商品特色\n商品編號\n7063471\n商品特色\n水潤肌膚，提升彈性\n減少細紋與皺紋\n滋潤配方，令肌膚充盈飽滿	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">\n                <div class="salepage-detail-info-top">\n                    <!---->\n                </div>\n                <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7063471/0.jpg?ts=102311" data-filename="elf1khcl"><br></p><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/7063471/1.jpg?ts=102311" data-filename="e1quqevz"><br></p><p>品牌:OLAY</p><p>規格:50G</p><p>適用於:一般性肌膚</p><p>製造廠商名稱:廣州寶潔有限公司</p><p>製造廠商地址:廣州市經濟技術開發區濱河路1號</p><p>進口廠商名稱:寶僑家品股份有限公司</p><p>進口廠商地址:台北市信義路五段106號7樓</p><p>台灣消費者服務專線: 0800-051-088</p><p>成分:WATER, GLYCERIN, ISOHEXADECANE, NIACINAMIDE, ISOPROPYL ISOSTEARATE, ALUMINUM STARCH OCTENYLSUCCINATE, NYLON-12, DIMETHICONE, PANTHENOL, STEARYL ALCOHOL, POLYETHYLENE, CETYL ALCOHOL, BEHENYL ALCOHOL, SODIUM ACRYLATES COPOLYMER, TITANIUM DIOXIDE, CAPRYLIC/CAPRIC TRIGLYCERIDE, BENZYL ALCOHOL, TOCOPHERYL ACETATE, CI 77019, ETHYLPARABEN, METHYLPARABEN, DIMETHICONOL, POLYACRYLAMIDE, CERATONIA SILIQUA (CAROB) FRUIT EXTRACT, FRAGRANCE, PEG-100 STEARATE, CETEARYL ALCOHOL, CETEARYL GLUCOSIDE, PROPYLPARABEN, SODIUM HYALURONATE, C13-14 ISOPARAFFIN, DISODIUM EDTA, CITRIC ACID, SODIUM PEG-7 OLIVE OIL CARBOXYLATE, PALMITIC ACID, STEARIC ACID, C12-13 PARETH-3, LAURETH-7, SODIUM HYDROXIDE, ETHYLHEXYLGLYCERIN, PALMITOYL PENTAPEPTIDE-4</p><p>質地:霜狀</p><p>適用膚況/膚色:一般性肌膚</p><p>功效:滋潤、緊緻</p><p>保存期限:36個月</p></div>\n            </div>	\N
3	\N	商品特色\n商品編號\n8227026\n商品特色\n突破性高效潤澤修復精華，獨家輕盈油狀質地，能迅速為疲憊肌膚注入年輕活力，蘊含高濃度植萃角鯊烷，結合有機摩洛哥堅果油、夏威夷堅果油與荷荷巴油，親膚性極佳，能形成天然防護膜，立即潤澤柔軟肌膚；全面修復肌膚屏障，改善乾繃、細紋、粗糙，重現潤澤、柔嫩、細緻肌！\n銷售重點\n全面修復肌膚屏障，改善乾繃、細紋、粗糙，重現潤澤、柔嫩、細緻肌	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">\n                <div class="salepage-detail-info-top">\n                    <!----><ns-video ng-if="SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl!==''" data-height="360" data-width="640" data-auto-play="false" data-video-url="https://youtu.be/nLTQ3yPBJDQ"><iframe frameborder="0" allowfullscreen="" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" title="柳燕老師精華油正確使用大解析！肌膚不只需要補水，更要補油🔥 @HI-lq8gt" width="640" height="360" src="https://www.youtube.com/embed/nLTQ3yPBJDQ?autoplay=0&amp;html5=1&amp;theme=light&amp;modesbranding=0&amp;color=white&amp;iv_load_policy=3&amp;showinfo=1&amp;controls=1&amp;enablejsapi=1&amp;rel=0&amp;origin=https%3A%2F%2Fwww.poyabuy.com.tw&amp;widgetid=1" id="widget2"></iframe></ns-video><!---->\n                </div>\n                <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/8227026/0.jpg?ts=103305" data-filename="13lsn5ub"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/8227026/1.jpg?ts=103305" data-filename="x4nquyda"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/8227026/2.jpg?ts=103305" data-filename="nwkscxi1"><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/8227026/3.jpg?ts=103305" data-filename="p4optxi0"><br></p></div>\n            </div>	品牌,DR.WU;\n規格,單入組;\n適用於,全膚質適用;\n功效,保濕、控油、緊緻、舒敏、修護、舒緩;\n容量,30ml;\n保存期限,36個月;\n質地油狀;\n產地,台灣;
14	6	7	8	9
15		商品編號 9522959 商品特色 消費者實測肌膚保濕彈嫩、亮澤水光度94%有感! 專櫃級成份「黑鑽松露精華」迅速潤澤，注入滿滿保濕能量! 搭配橄欖植萃精華、活泉舒緩因子等，集中修護，膚況直升頭等艙，展現潤亮水光。 銷售重點 頂級黑松露精華  奢華保濕 膚況升級。	<div id="salepage-detail-info" class="salepage-detail-info" ns-scope-css=".salepage-detail-info" ng-if="SalePageIndexCtrl.SalePageDesc||(SalePageIndexCtrl.MoreInfoVideo&amp;&amp;SalePageIndexCtrl.MoreInfoVideo.VideoUrl)" style="">                 <div class="salepage-detail-info-top">                     <!---->                 </div>                 <div class="salepage-detail-desc" ng-bind-html="SalePageIndexCtrl.SalePageDesc"><p><img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/r/SalePageDesc/9522959/0.jpg?ts=112138" data-filename="galzzkti"><br></p><p>內容物成分:AQUA,&nbsp; BUTYLENE GLYCOL,&nbsp; PANTHENOL,&nbsp; HYDROXYETHYL UREA,&nbsp; ALLANTOIN,&nbsp; CHLORPHENESIN,&nbsp; ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER,&nbsp; ARGININE,&nbsp; SODIUM POLYACRYLATE,&nbsp; DISODIUM EDTA,&nbsp; PROPYLENE GLYCOL,&nbsp; PHENOXYETHANOL,&nbsp; COCETH-7,&nbsp; PPG-1-PEG-9 LAURYL GLYCOL ETHER,&nbsp; SODIUM HYALURONATE,&nbsp; UREA,&nbsp; PEG-40 HYDROGENATED CASTOR OIL,&nbsp; GLYCERIN,&nbsp; AMMONIUM LACTATE,&nbsp; POLYQUATERNIUM-51,&nbsp; ALBIZIA JULIBRISSIN BARK EXTRACT,&nbsp; ALOE BARBADENSIS LEAF JUICE POWDER,&nbsp; FRAGRANCE,&nbsp; IODOPROPYNYL BUTYLCARBAMATE,&nbsp; ETHANOLAMINE,&nbsp; AUREOBASIDIUM PULLULANS FERMENT,&nbsp; HYDROGENATED OLIVE OIL UNSAPONIFIABLES,&nbsp; ALTEROMONAS FERMENT EXTRACT,&nbsp; LEONTOPODIUM ALPINUM FLOWER/LEAF EXTRACT,&nbsp; ETHYLHEXYLGLYCERIN,&nbsp; POTASSIUM SORBATE,&nbsp; CITRIC ACID,&nbsp; SODIUM BENZOATE,&nbsp; TUBER MELANOSPORUM EXTRACT.<br></p></div>             </div>	品牌\t氧顏森活 規格\t25ml／片 產地\t台灣 保存期限\t3年
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, price, titlepic, otherpic, newprice, createdate) FROM stdin;
4	OLAY新生高效緊緻護膚霜 50G	1000	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7063471/0/638421277568800000?v=1	\N	879	2024-01-30
5	寶拉珍選2%水楊酸身體乳210ml	1220	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7198243/0/638421279057730000?v=1	\N	972	2024-01-30
6	潤姬桃子1.5g*30條	1280	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7308249/0/638421277820230000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7308249/1/638421277820230000?v=1, //diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7308249/1/638421277820230000?v=1	\N	2024-01-30
7	VONO味之素醇緻濃湯-多款任選	59	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7044968/0/638412682597070000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7044968/1/638412682597070000?v=1, //diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7044968/2/638412682597070000?v=1, \n//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7044968/3/638412682597070000?v=1	\N	2024-01-30
8	小白兔暖暖包24hr/10p/日文版	149	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7327145/0/638409968082730000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7327145/1/638409968082730000?v=1	139	2024-01-30
10	瑪榭-女恆暖圓領發熱衣	429	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/9340149/0/638403069382870000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/9340149/1/638403069382870000?v=1, //diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/9340149/2/638403069382870000?v=1	379	2024-01-30
9	3點一刻經典奶茶袋裝300g-多款任選	170	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7076954/0/638418690243830000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7076954/1/638424894690000000?v=1,\n//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7076954/2/638424894690000000?v=1	\N	2024-01-30
15	【限時特賣】氧顏森活黑鑽松露保濕光采面膜25ml	109	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/9522959/0/638422108066400000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/9522959/1/638422108066400000?v=1	49	2024-02-07
3	DR.WU角鯊潤澤修復精華油30ml	2000	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/8227026/0/638421278487030000?v=1	//diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/8227026/1/638429237215600000?v=1, //diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/8227026/2/638429237215600000?v=1	\N	2024-01-30
\.


--
-- Data for Name: userFavorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."userFavorite" (favoriteproductid, userid) FROM stdin;
7	9
4	10
5	10
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password) FROM stdin;
1		6974da39a3ee5e6b4b0d3255bfef95601890afd80709
4	a001@hotmail.com	6974f47a37a7e1117ac332b6bd3aeb30abb6ad128653
5	a002@hotmail.com	6974ec46e05a0316377763ba362c136a5bbcfa5674a6
6	a@a.com	6974c58a03e5842fa1ad52d6781faaf0921bf039c2f0
8	123	697440bd001563085fc35165329ea1ff5c5ecbdbbeef
9	a01@a.com	QcVShpivH0JdA5Og/5wPzA==
10	aaa@hotmail.com	Cf0TWT2/wp2RwO40O4nYxg==
12	a0@a.com	TiZZjaEpqzYmzbm44EQ3qA==
13	testing@example.com	sKBle/ABrDHf2hFwskyGOJY7cQ9m+YJ1erK75hrRJxM=
\.


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 1, false);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 26, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: productdetails productdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productdetails
    ADD CONSTRAINT productdetails_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

