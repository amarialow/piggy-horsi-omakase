CREATE TABLE nyc_omakase (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    neighborhood    VARCHAR(50)     NOT NULL,
    courses_min     SMALLINT,
    courses_max     SMALLINT,
    price_min       SMALLINT,
    price_max       SMALLINT,
    gratuity_included BOOLEAN       DEFAULT FALSE,
    notes           TEXT,
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);