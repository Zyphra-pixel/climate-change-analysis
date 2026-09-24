# Number of rows 
select count(*) as total_rows from climate_change;

# Number of countries 
select count(distinct Country) as total_countries from climate_change;

# Year range 
select min(year) as start_year , max(year) as end_year from climate_change;

# Number of observations per country 
select
	Country,
    count(*) as observation
from climate_change
group by Country;

# Missing values 
select 
	sum(case when year is null then 1 else 0 end) as year_nulls,
    sum(case when country is null then 1 else 0 end) as country_nulls,
    sum(case when `Avg Temperature (Â°C)` is null then 1 else 0 end) as temperature_nulls,
    sum(case when `CO2 Emissions (Tons/Capita)` is null then 1 else 0 end) as co2_emission_nulls,
    sum(case when `Sea Level Rise (mm)` is null then 1 else 0 end) as sea_level_nulls,
    sum(case when `Rainfall (mm)` is null then 1 else 0 end) as rainfall_nulls,
    sum(case when Population is null then 1 else 0 end) as population_nulls,
    sum(case when `Renewable Energy (%)` is null then 1 else 0 end) as renewable_energy_nulls,
    sum(case when `Extreme Weather Events` is null then 1 else 0 end) as extreme_weather_nulls,
    sum(case when `Forest Area (%)` is null then 1 else 0 end) as forest_area_nulls
from climate_change;

# Information abut dataset
desc climate_change;