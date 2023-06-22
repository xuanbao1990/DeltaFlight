--Sample generate start
/*created sample table with duplicates for testing purposes*/

/*drop table if exists flight;
create temp table flight (
"Carrier Code" VARCHAR,
flight_dt DATE,
flightnum BIGINT,
orig_arpt VARCHAR,
dest_arpt VARCHAR,
flightstatus VARCHAR,
lastupdt TIMESTAMP,
flightkey VARCHAR);

insert into flight("Carrier Code",flight_dt,flightnum, orig_arpt,dest_arpt,flightstatus,lastupdt,flightkey)
VALUES
('DL',	'01/01/2023',	15,	'ATL',	'TPA',	'Boarding',	'2023-01-01T19:48:00',	'DL4346615ATLTPA'),
('DL',	'01/01/2023',	15,	'ATL',	'TPA',	'Boarding',	'2023-01-01T19:48:00',	'DL4346615ATLTPA'),--duplicate record
('DL',	'01/02/2023',	31,	'ATL','DFW','Boarding','2023-01-02T21:48:00', 'DL4346631ATLDFW'),
('DL',	'01/02/2023',   31,	'ATL','DFW','Boarding','2023-01-02T23:30:00', 'DL4346631ATLDFW'); -- same flightkey,different timestamp

select * from flight;*/
--END

/*Please replace table <flight> with the actual name of Dummy_flight_leg_data*/
WITH flight_uniq AS(
SELECT DISTINCT
"Carrier Code",
flight_dt,
flightnum,
orig_arpt,
dest_arpt,
flightstatus,
lastupdt,
flightkey
FROM
flight)
,

flight_rank AS(
SELECT
"Carrier Code",
flight_dt,
flightnum,
orig_arpt,
dest_arpt,
flightstatus,
lastupdt,
flightkey,
ROW_NUMBER() over(PARTITION BY flightkey ORDER BY lastupdt DESC)  rank
FROM flight_uniq)

SELECT "Carrier Code",
flight_dt,
flightnum,
orig_arpt,
dest_arpt,
flightstatus,
lastupdt,
flightkey
FROM flight_rank WHERE RANK=1;


