# Q. Avg temprature trend over time  
select 
	year, round(avg(`Avg Temperature (Â°C)`),2) as avg_temprature
from climate_change
group by year
order by year;

# Q. Avg temprature comparision for countries
select 
	country, round(avg(`Avg Temperature (Â°C)`),2) as avg_temprature
from climate_change
group by country
order by avg_temprature asc;

# Q. Avg CO2 Emission comparision for countries
select 
	country, round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_CO2_emissions
from climate_change
group by country
order by avg_CO2_emissions asc;

# Q. Avg CO2 Emission over time 
select 
	Year, round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_CO2_emissions
from climate_change
group by year
order by year;

# Q. Avg Extreme weather comparision for countries
select 
	country,
    round(avg(`Extreme Weather Events`),2) as extreme_weather
from climate_change
group by country
order by extreme_weather;

# Q. Avg Extreme weather over time
select 
	year,
    round(avg(`Extreme Weather Events`),2) as extreme_weather
from climate_change
group by year
order by year;

# Q. Avg Sea level comparision for countries
select 
	country,
    round(avg(`Sea Level Rise (mm)`),2) as avg_sea_level
from climate_change
group by country
order by avg_sea_level desc;

# Q. Avg Sea level comparision over time
select 
	Year,
    round(avg(`Sea Level Rise (mm)`),2) as avg_sea_level
from climate_change
group by year
order by year desc;

# Q. Avg Rainfall comparision for countries
select 
	country,
    round(avg(`Rainfall (mm)`),2) as avg_rainfall
from climate_change
group by country
order by avg_rainfall desc;

# Q. Avg Rainfall comparision over time
select 
	Year,
    round(avg(`Rainfall (mm)`),2) as avg_rainfall
from climate_change
group by year
order by year desc;

# Q. Avg Forest Area comparision for countries
select 
	country,
    round(avg(`Forest Area (%)`),2) as avg_forest_area
from climate_change
group by country
order by avg_forest_area desc;

# Q. Avg Renewable Energy comparision for countries
select 
	country,
    round(avg(`Renewable Energy (%)`),2) as avg_renewable_energy
from climate_change
group by country
order by avg_renewable_energy desc;

# Q. Avg Population comparision for countries
select 
	country,
    round(avg(Population),2) as avg_population
from climate_change
group by country
order by avg_population;