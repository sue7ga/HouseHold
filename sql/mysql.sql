CREATE TABLE IF NOT EXISTS income (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    income INTEGER,
    extra INTEGER,
    business INTEGER,
    bonus INTEGER,
    advances_paid INTEGER,
    allowance INTEGER,
    pocket INTEGER,
    other INTEGER,
    user_id INTEGER,
    date  VARCHAR(255),
    total INTEGER,
    balance INTEGER
);

CREATE TABLE IF NOT EXISTS user(
 id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
 email VARCHAR(255),
 name VARCHAR(255),
 password VARCHAR(255),
 sex INTEGER
);

CREATE TABLE IF NOT EXISTS expense(
 id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
 food INTEGER,
 good INTEGER,
 fare INTEGER,
 society INTEGER,
 entertainment INTEGER,
 teaching INTEGER,
 dress INTEGER,
 clinic INTEGER,
 communicate INTEGER,
 water INTEGER,
 living INTEGER,
 car INTEGER,
 tax INTEGER,
 large_consume INTEGER,
 other INTEGER,
 user_id INTEGER,
 date VARCHAR(255),
 total INTEGER,
 balance INTEGER
);
