-- Stub tables/views for StInfoSys compatibility
-- These are required by the ingestion service but don't exist in the LARD database
-- In production, STINFO_CONN_STRING points to the actual StInfoSys database

-- Stub view for v_station_param_policy (used by permissions::fetch_permits)
-- Columns: stationid, message_formatid, paramid, permitid
CREATE OR REPLACE VIEW v_station_param_policy AS
SELECT 
    0::INT4 as stationid,
    0::INT4 as message_formatid,
    0::INT4 as paramid,
    0::INT4 as permitid
WHERE FALSE; -- Empty result set

-- Stub table for station_policy (used by permissions::fetch_permits)
-- Columns: stationid, permitid
CREATE TABLE IF NOT EXISTS station_policy (
    stationid INT4 NOT NULL,
    permitid INT4 NOT NULL,
    PRIMARY KEY (stationid)
);

-- Stub tables for levels::fetch_levels
-- Query: SELECT standard_hlevel, hlevel_scale, paramid, sensorlevel_id FROM param JOIN element_info ON param.element_id = element_info.element_id WHERE hlevel_scale IS NOT NULL
CREATE TABLE IF NOT EXISTS param (
    paramid INT4 PRIMARY KEY,
    element_id INT4
);

CREATE TABLE IF NOT EXISTS element_info (
    element_id INT4 PRIMARY KEY,
    standard_hlevel INT4,
    hlevel_scale INT4,
    sensorlevel_id TEXT
);

-- Stub table for message_priority_default (used by egress service)
-- Columns: message_formatid, paramid, priority, fromtime, totime
CREATE TABLE IF NOT EXISTS message_priority_default (
    message_formatid INT4 NOT NULL,
    paramid INT4 NOT NULL,
    priority INT4 NOT NULL,
    fromtime TIMESTAMP,
    totime TIMESTAMP,
    PRIMARY KEY (message_formatid, paramid)
);

