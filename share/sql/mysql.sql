CREATE TABLE entities (id SMALLINT AUTO_INCREMENT NOT NULL, uuid VARCHAR(36) NOT NULL, type VARCHAR(255) NOT NULL, class VARCHAR(255) NOT NULL, UNIQUE INDEX entities_uuid_uniq (uuid), PRIMARY KEY(id)) ENGINE = InnoDB;
CREATE TABLE entities_in_aggregator (parent_id SMALLINT NOT NULL, child_id SMALLINT NOT NULL, PRIMARY KEY(parent_id, child_id)) ENGINE = InnoDB;
CREATE TABLE data (id SMALLINT AUTO_INCREMENT NOT NULL, channel_id SMALLINT DEFAULT NULL, timestamp BIGINT NOT NULL, value NUMERIC(5, 2) NOT NULL, UNIQUE INDEX unique_timestamp (timestamp, channel_id), PRIMARY KEY(id)) ENGINE = InnoDB;
CREATE TABLE tokens (id SMALLINT AUTO_INCREMENT NOT NULL, entity_id SMALLINT DEFAULT NULL, token VARCHAR(255) NOT NULL, valid BIGINT NOT NULL, UNIQUE INDEX tokens_token_uniq (token), PRIMARY KEY(id)) ENGINE = InnoDB;
CREATE TABLE properties (id SMALLINT AUTO_INCREMENT NOT NULL, entity_id SMALLINT DEFAULT NULL, `key` VARCHAR(255) NOT NULL, value VARCHAR(255) NOT NULL, UNIQUE INDEX unique_keys (entity_id, `key`), PRIMARY KEY(id)) ENGINE = InnoDB;
ALTER TABLE entities_in_aggregator ADD FOREIGN KEY (parent_id) REFERENCES entities(id);
ALTER TABLE entities_in_aggregator ADD FOREIGN KEY (child_id) REFERENCES entities(id);
ALTER TABLE data ADD FOREIGN KEY (channel_id) REFERENCES entities(id);
ALTER TABLE tokens ADD FOREIGN KEY (entity_id) REFERENCES entities(id);
ALTER TABLE properties ADD FOREIGN KEY (entity_id) REFERENCES entities(id)
