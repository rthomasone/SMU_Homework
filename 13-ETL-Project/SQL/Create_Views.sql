--- View 1: Top 200 // Global


CREATE VIEW top_200_global AS
	SELECT
		t."position",
		t.title,
		t.artist,
		t.streams,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	FROM 
		"tracks" t
		JOIN "chart_type" c ON t.chart_id = c.chart_id
		JOIN "region" r ON t.region_id = r.region_id 
	WHERE
		t.chart_id = 2 AND t.region_id = 1
	ORDER BY
		t."position";


--- View 2: Top 200 // US


CREATE VIEW top_200_us AS
	select
		t."position",
		t.title,
		t.artist,
		t.streams,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	from 
		"tracks" t
		join "chart_type" c on t.chart_id = c.chart_id
		join "region" r on t.region_id = r.region_id 
	where
		t.chart_id = 2 and t.region_id = 2
	order by
		t."position";


--- View 3: Top 200 // UK


CREATE VIEW top_200_uk AS
	select
		t."position",
		t.title,
		t.artist,
		t.streams,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	from 
		"tracks" t
		join "chart_type" c on t.chart_id = c.chart_id
		join "region" r on t.region_id = r.region_id 
	where
		t.chart_id = 2 and t.region_id = 3
	order by
		t."position";


--- View 4: Viral 50 // Global


CREATE VIEW viral_50_global AS
	select
		t."position",
		t.title,
		t.artist,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	from 
		"tracks" t
		join "chart_type" c on t.chart_id = c.chart_id
		join "region" r on t.region_id = r.region_id 
	where
		t.chart_id = 1 and t.region_id = 1
	order by
		t."position";


--- View 5: Viral 50 // US


CREATE VIEW viral_50_us AS
	select
		t."position",
		t.title,
		t.artist,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	from 
		"tracks" t
		join "chart_type" c on t.chart_id = c.chart_id
		join "region" r on t.region_id = r.region_id 
	where
		t.chart_id = 1 and t.region_id = 2
	order by
		t."position";


--- View 6: Viral 50 // UK


CREATE VIEW viral_50_uk AS
	select
		t."position",
		t.title,
		t.artist,
		c.chart_name,
		r.region_name, 
		t.last_updated 
	from 
		"tracks" t
		join "chart_type" c on t.chart_id = c.chart_id
		join "region" r on t.region_id = r.region_id 
	where
		t.chart_id = 1 and t.region_id = 3
	order by
		t."position";
