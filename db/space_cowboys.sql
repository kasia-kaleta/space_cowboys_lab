DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT4,
  homeworld VARCHAR(255),
  collected_by VARCHAR(255)
);
