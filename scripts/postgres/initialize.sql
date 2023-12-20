-- DROP TABLE IF EXISTS players;
-- DROP TABLE IF EXISTS games;
-- DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS productdetails;
-- CREATE TABLE players (
--  id SERIAL PRIMARY KEY,
--  age SMALLINT NOT NULL,
--  username VARCHAR(50) NOT NULL,
--  budget INTEGER
-- );
-- CREATE TABLE games (
--  id SERIAL PRIMARY KEY,
--  winner_id SMALLINT NOT NULL,
--  location VARCHAR(50) NOT NULL,
--  prize INTEGER
-- );
CREATE TABLE users (
 id SERIAL PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 password VARCHAR(50) NOT NULL,
 identity INTEGER NOT NULL
);
CREATE TABLE products (
 id SERIAL PRIMARY KEY,
 title VARCHAR(50) NOT NULL,
 price INTEGER NOT NULL,
 newprice INTEGER
);
CREATE TABLE productdetails(
 id INTEGER PRIMARY KEY,
 titlepic TEXT NOT NULL,
 otherpic TEXT,
 FOREIGN KEY (id) REFERENCES products (id)
);