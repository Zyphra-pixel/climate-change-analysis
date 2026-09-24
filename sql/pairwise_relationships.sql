-- Q. Comparing average Temprature and CO2 Emission by country 
select 
	country, 
    round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_CO2_emissions,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_temprature 
from climate_change
group by country;

-- Q. Using  Pearson correlation coefficients to observe any apparent relationship between CO2 Emission and Temprature
select 
    (count(*) * sum(`Avg Temperature (Â°C)` * `CO2 Emissions (Tons/Capita)`) - 
     sum(`Avg Temperature (Â°C)`) * sum(`CO2 Emissions (Tons/Capita)`)) / 
    (sqrt(count(*) * sum(pow(`Avg Temperature (Â°C)`, 2)) - pow(sum(`Avg Temperature (Â°C)`), 2)) * 
     sqrt(count(*) * sum(pow(`CO2 Emissions (Tons/Capita)`, 2)) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2))) 
    as correlation
from climate_change
where `Avg Temperature (Â°C)` is not null 
and `CO2 Emissions (Tons/Capita)` is not null;
  
-- Q. Comparing average Renewable Energy and CO2 Emission by country
select 
	country,
    round(avg(`Renewable Energy (%)`),2) as renewable_energy,
	round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_CO2_emissions
from climate_change
group by country
order by renewable_energy desc;

-- Q. Using  Pearson correlation coefficients to observe any apparent relationship between 
-- CO2 Emission and Renewable energy
select 
    (count(*) * sum(`Renewable Energy (%)` * `CO2 Emissions (Tons/Capita)`) - 
     sum(`Renewable Energy (%)`) * sum(`CO2 Emissions (Tons/Capita)`)) / 
    (sqrt(count(*) * sum(pow(`Renewable Energy (%)`, 2)) - pow(sum(`Renewable Energy (%)`), 2)) * 
     sqrt(count(*) * sum(pow(`CO2 Emissions (Tons/Capita)`, 2)) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2))) 
    as correlation
from climate_change
where `Renewable Energy (%)` is not null 
and `CO2 Emissions (Tons/Capita)` is not null;

-- Q. Comparing average Population and CO2 Emision by country
select 
	country,
    round(avg(Population),2) as avg_population,
	round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_CO2_emissions
from climate_change
group by country
order by avg_population desc;

-- Q. Using  Pearson correlation coefficients to observe any apparent relationship between 
-- CO2 Emission and Population
select 
    (count(*) * sum(Population * `CO2 Emissions (Tons/Capita)`) - 
     sum(Population) * sum(`CO2 Emissions (Tons/Capita)`)) / 
    (sqrt(count(*) * sum(pow(Population, 2)) - pow(sum(Population), 2)) * 
     sqrt(count(*) * sum(pow(`CO2 Emissions (Tons/Capita)`, 2)) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2))) 
    as correlation
from climate_change
where Population is not null 
and `CO2 Emissions (Tons/Capita)` is not null;

-- Q. Comparing average Extreme Weather Events and Sea Level Rise by country
select 
	country,
    round(avg(`Extreme Weather Events`),2) as avg_extreme_weather,
	round(avg(`Sea Level Rise (mm)`),2) as avg_sea_level
from climate_change
group by country
order by avg_extreme_weather desc;

-- Q. Using  Pearson correlation coefficients to observe any apparent relationship between 
-- Extreme weather and Sea level rise
select 
    (count(*) * sum(`Extreme Weather Events` * `Sea Level Rise (mm)`) - 
     sum(`Extreme Weather Events`) * sum(`Sea Level Rise (mm)`)) / 
    (sqrt(count(*) * sum(pow(`Extreme Weather Events`, 2)) - pow(sum(`Extreme Weather Events`), 2)) * 
     sqrt(count(*) * sum(pow(`Sea Level Rise (mm)`, 2)) - pow(sum(`Sea Level Rise (mm)`), 2))) 
    as correlation
from climate_change
where `Extreme Weather Events` is not null 
and `Sea Level Rise (mm)` is not null;

-- Q. Comparing average Forest Area and Temprature by country
select 
	country, 
    round(avg(`Forest Area (%)`),2) as avg_forest_area,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_temprature 
from climate_change
group by country;

-- Q. Using  Pearson correlation coefficients to observe any apparent relationship between Forest area and Temprature
select 
    (count(*) * sum(`Avg Temperature (Â°C)` * `Forest Area (%)`) - 
     sum(`Avg Temperature (Â°C)`) * sum(`Forest Area (%)`)) / 
    (sqrt(count(*) * sum(pow(`Avg Temperature (Â°C)`, 2)) - pow(sum(`Avg Temperature (Â°C)`), 2)) * 
     sqrt(count(*) * sum(pow(`Forest Area (%)`, 2)) - pow(sum(`Forest Area (%)`), 2))) 
    as correlation
from climate_change
where `Avg Temperature (Â°C)` is not null 
and `Forest Area (%)` is not null;