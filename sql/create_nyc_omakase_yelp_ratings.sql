-- Ensure name is unique in nyc_omakase
ALTER TABLE public.nyc_omakase ADD CONSTRAINT uq_omakase_name UNIQUE (name);    

-- Create ratings table
CREATE TABLE nyc_omakase_yelp_ratings (
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(100)  NOT NULL UNIQUE,
    overall_rating NUMERIC(3,1),
    one_star       SMALLINT      DEFAULT 0,
    two_star       SMALLINT      DEFAULT 0,
    three_star     SMALLINT      DEFAULT 0,
    four_star      SMALLINT      DEFAULT 0,
    five_star      SMALLINT      DEFAULT 0,
    total_review   SMALLINT      DEFAULT 0,
    CONSTRAINT fk_omakase_name FOREIGN KEY (name)
        REFERENCES nyc_omakase(name)
);