--- Query 1: Top 200 // Global


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
	t.chart_id = 2 and t.region_id = 1
order by
	t."position" 
limit 10;


--- Query 2: Top 200 // US


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
	t."position" 
limit 10;


--- Query 3: Top 200 // UK


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
	t."position" 
limit 10;


--- Query 4: Viral 50 // Global


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
	t."position" 
limit 10;


--- Query 5: Viral 50 // US


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
	t."position" 
limit 10;


--- Query 6: Viral 50 // UK


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
	t."position" 
limit 10;

