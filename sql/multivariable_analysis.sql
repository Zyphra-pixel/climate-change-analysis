# How are temperature, CO₂ emissions, and renewable energy associated with one another
select 
    -- 1. Correlation between Temperature and CO2 Emissions
    (count(*) * sum(`Avg Temperature (Â°C)` * `CO2 Emissions (Tons/Capita)`) - sum(`Avg Temperature (Â°C)`) * sum(`CO2 Emissions (Tons/Capita)`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2))) as r_xy,

    -- 2. Correlation between CO2 Emissions and Renewable Energy
    (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Renewable Energy (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Renewable Energy (%)`)) / 
    (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_yz,

    -- 3. Correlation between Temperature and Renewable Energy
    (count(*) * sum(`Avg Temperature (Â°C)` * `Renewable Energy (%)`) - sum(`Avg Temperature (Â°C)`) * sum(`Renewable Energy (%)`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_xz
from climate_change
where `Avg Temperature (Â°C)` is not null
and `CO2 Emissions (Tons/Capita)` is not null
and `Renewable Energy (%)` is not null;

select 
	country,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_co2_emission,
    round(avg(`Renewable Energy (%)`),2) as avg_renewable_energy
from climate_change
where `Avg Temperature (Â°C)` is not null
and `CO2 Emissions (Tons/Capita)` is not null
and `Renewable Energy (%)` is not null
group by country
order by country desc;
       
select 
	Year,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_co2_emission,
    round(avg(`Renewable Energy (%)`),2) as avg_renewable_energy
from climate_change
where `Avg Temperature (Â°C)` is not null
and `CO2 Emissions (Tons/Capita)` is not null
and `Renewable Energy (%)` is not null
group by Year
order by Year desc;

with base_correlations as (
    select 
        -- 1. Pairwise Temperature and CO2 Emissions
        (count(*) * sum(`Avg Temperature (Â°C)` * `CO2 Emissions (Tons/Capita)`) - sum(`Avg Temperature (Â°C)`) * sum(`CO2 Emissions (Tons/Capita)`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2))) as r_xy,

        -- 2. Pairwise CO2 Emissions and Renewable Energy
        (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Renewable Energy (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Renewable Energy (%)`)) / 
        (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_yz,

        -- 3. Pairwise Temperature and Renewable Energy
        (count(*) * sum(`Avg Temperature (Â°C)` * `Renewable Energy (%)`) - sum(`Avg Temperature (Â°C)`) * sum(`Renewable Energy (%)`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_xz
    from climate_change
    where `Avg Temperature (Â°C)` is not null 
    and `CO2 Emissions (Tons/Capita)` is not null 
    and `Renewable Energy (%)` is not null
)
select 
    -- Relationship between Temperature and CO2 Emissions, isolating Renewable Energy
    (r_xy - (r_xz * r_yz)) / 
    (sqrt(1 - pow(r_xz, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xy_control_z,

    -- Relationship between Temperature and Renewable Energy, isolating CO2 Emissions
    (r_xz - (r_xy * r_yz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xz_control_y,

    -- Relationship between CO2 Emissions and Renewable Energy, isolating Temperature
    (r_yz - (r_xy * r_xz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_xz, 2))) as partial_r_yz_control_x
from base_correlations;

# How are temperature, rainfall, and extreme weather events associated with one another?
select 
    -- 1. Correlation between Temperature and Rainfall
    (count(*) * sum(`Avg Temperature (Â°C)` * `Rainfall (mm)`) - sum(`Avg Temperature (Â°C)`) * sum(`Rainfall (mm)`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Rainfall (mm)` * `Rainfall (mm)`) - pow(sum(`Rainfall (mm)`), 2))) as r_xy,

    -- 2. Correlation between Rainfall and Extreme Weather
    (count(*) * sum(`Rainfall (mm)` * `Extreme Weather Events`) - sum(`Rainfall (mm)`) * sum(`Extreme Weather Events`)) / 
    (sqrt(count(*) * sum(`Rainfall (mm)` * `Rainfall (mm)`) - pow(sum(`Rainfall (mm)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_yz,

    -- 3. Correlation between Temperature and Extreme Weather
    (count(*) * sum(`Avg Temperature (Â°C)` * `Extreme Weather Events`) - sum(`Avg Temperature (Â°C)`) * sum(`Extreme Weather Events`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_xz
from climate_change
where `Avg Temperature (Â°C)` is not null
and `Rainfall (mm)` is not null
and `Extreme Weather Events` is not null;
                                                                                    
select 
	country,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`Rainfall (mm)`),2) as avg_rainfall,
    round(avg(`Extreme Weather Events`),2) as avg_extreme_weather_events
from climate_change
where `Avg Temperature (Â°C)` is not null
and `Rainfall (mm)` is not null
and `Extreme Weather Events` is not null
group by country
order by country desc;

select 
	Year,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`Rainfall (mm)`),2) as avg_rainfall,
    round(avg(`Extreme Weather Events`),2) as avg_extreme_weather_events
from climate_change
where `Avg Temperature (Â°C)` is not null
and `Rainfall (mm)` is not null
and `Extreme Weather Events` is not null
group by Year
order by Year desc;

with base_correlations as (
    select 
        -- Pairwise Temperature and Rainfall
        (count(*) * sum(`Avg Temperature (Â°C)` * `Rainfall (mm)`) - sum(`Avg Temperature (Â°C)`) * sum(`Rainfall (mm)`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Rainfall (mm)` * `Rainfall (mm)`) - pow(sum(`Rainfall (mm)`), 2))) as r_xy,

        -- Pairwise Rainfall and Extreme Weather
        (count(*) * sum(`Rainfall (mm)` * `Extreme Weather Events`) - sum(`Rainfall (mm)`) * sum(`Extreme Weather Events`)) / 
        (sqrt(count(*) * sum(`Rainfall (mm)` * `Rainfall (mm)`) - pow(sum(`Rainfall (mm)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_yz,

        -- Pairwise Temperature and Extreme Weather
        (count(*) * sum(`Avg Temperature (Â°C)` * `Extreme Weather Events`) - sum(`Avg Temperature (Â°C)`) * sum(`Extreme Weather Events`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_xz
    from climate_change
    where `Avg Temperature (Â°C)` is not null 
    and `Rainfall (mm)` is not null 
    and `Extreme Weather Events` is not null
)
select 
    -- Relationship between Temperature and Rainfall, isolating Extreme Weather
    (r_xy - (r_xz * r_yz)) / 
    (sqrt(1 - pow(r_xz, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xy_control_z,

    -- Relationship between Temperature and Extreme Weather, isolating Rainfall
    (r_xz - (r_xy * r_yz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xz_control_y,

    -- Relationship between Rainfall and Extreme Weather, isolating Temperature
    (r_yz - (r_xy * r_xz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_xz, 2))) as partial_r_yz_control_x
from base_correlations;   

# How are CO₂ emissions, renewable energy, and forest area associated with one another?
select 
    -- 1. Correlation between CO2 Emissions and CO2 Emissions
    (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Renewable Energy (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Renewable Energy (%)`)) / 
    (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_xy,

    -- 2. Correlation between Renewable Energy and Forest area
    (count(*) * sum(`Renewable Energy (%)` * `Forest Area (%)`) - sum(`Renewable Energy (%)`) * sum(`Forest Area (%)`)) / 
    (sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2)) * sqrt(count(*) * sum(`Forest Area (%)` * `Forest Area (%)`) - pow(sum(`Forest Area (%)`), 2))) as r_yz,

    -- 3. Correlation between CO2 Emissions and Forest area
    (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Forest Area (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Forest Area (%)`)) / 
    (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Forest Area (%)` * `Forest Area (%)`) - pow(sum(`Forest Area (%)`), 2))) as r_xz
from climate_change;

select 
	country,
    round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_co2_emission,
    round(avg(`Renewable Energy (%)`),2) as avg_renewable_energy,
    round(avg(`Forest Area (%)`),2) as avg_Temperature
from climate_change
where `CO2 Emissions (Tons/Capita)` is not null
and `Forest Area (%)` is not null
and `Renewable Energy (%)` is not null
group by country
order by country desc;
       
select 
	Year,
    round(avg(`CO2 Emissions (Tons/Capita)`),2) as avg_co2_emission,
    round(avg(`Renewable Energy (%)`),2) as avg_renewable_energy,
    round(avg(`Forest Area (%)`),2) as avg_Temperature
from climate_change
where `CO2 Emissions (Tons/Capita)` is not null
and `Forest Area (%)` is not null
and `Renewable Energy (%)` is not null
group by Year
order by Year desc;

with base_correlations as (
    select 
        -- 1. Pairwise CO2 Emissions and Renewable Energy
        (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Renewable Energy (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Renewable Energy (%)`)) / 
        (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2))) as r_xy,

        -- 2. Pairwise Renewable Energy and Forest Area
        (count(*) * sum(`Renewable Energy (%)` * `Forest Area (%)`) - sum(`Renewable Energy (%)`) * sum(`Forest Area (%)`)) / 
        (sqrt(count(*) * sum(`Renewable Energy (%)` * `Renewable Energy (%)`) - pow(sum(`Renewable Energy (%)`), 2)) * sqrt(count(*) * sum(`Forest Area (%)` * `Forest Area (%)`) - pow(sum(`Forest Area (%)`), 2))) as r_yz,

        -- 3. Pairwise CO2 Emissions and Forest Area
        (count(*) * sum(`CO2 Emissions (Tons/Capita)` * `Forest Area (%)`) - sum(`CO2 Emissions (Tons/Capita)`) * sum(`Forest Area (%)`)) / 
        (sqrt(count(*) * sum(`CO2 Emissions (Tons/Capita)` * `CO2 Emissions (Tons/Capita)`) - 
        pow(sum(`CO2 Emissions (Tons/Capita)`), 2)) * sqrt(count(*) * sum(`Forest Area (%)` * `Forest Area (%)`) - pow(sum(`Forest Area (%)`), 2))) as r_xz
    from climate_change
    where `CO2 Emissions (Tons/Capita)` is not null 
    and `Renewable Energy (%)` is not null 
    and `Forest Area (%)` is not null
)
select 
    -- Relationship between CO2 Emissions and Renewable Energy, isolating Forest Area
    (r_xy - (r_xz * r_yz)) / 
    (sqrt(1 - pow(r_xz, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xy_control_z,

    -- Relationship between CO2 Emissions and Forest Area, isolating Renewable Energy
    (r_xz - (r_xy * r_yz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xz_control_y,

    -- Relationship between Renewable Energy and Forest Area, isolating CO2 Emissions
    (r_yz - (r_xy * r_xz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_xz, 2))) as partial_r_yz_control_x
from base_correlations;

# How are Temperature, Sea level, and Extreme weather events associated with one another?
select 
    -- 1. Correlation between Temperature and Sea level
    (count(*) * sum(`Avg Temperature (Â°C)` * `Sea Level Rise (mm)`) - sum(`Avg Temperature (Â°C)`) * sum(`Sea Level Rise (mm)`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Sea Level Rise (mm)` * `Sea Level Rise (mm)`) - pow(sum(`Sea Level Rise (mm)`), 2))) as r_xy,

    -- 2. Correlation between Sea level and Extreme weather
    (count(*) * sum(`Sea Level Rise (mm)` * `Extreme Weather Events`) - sum(`Sea Level Rise (mm)`) * sum(`Extreme Weather Events`)) / 
    (sqrt(count(*) * sum(`Sea Level Rise (mm)` * `Sea Level Rise (mm)`) - pow(sum(`Sea Level Rise (mm)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_yz,

    -- 3. Correlation between Temperature and Extreme weather
    (count(*) * sum(`Avg Temperature (Â°C)` * `Extreme Weather Events`) - sum(`Avg Temperature (Â°C)`) * sum(`Extreme Weather Events`)) / 
    (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_xz
from climate_change;


select 
	country,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`Sea Level Rise (mm)`),2) as avg_sea_level_rise,
    round(avg(`Extreme Weather Events`),2) as avg_extreme_weather_events
from climate_change
where `Avg Temperature (Â°C)` is not null
and `Sea Level Rise (mm)` is not null
and `Extreme Weather Events` is not null
group by country
order by country desc;
       
select 
	Year,
    round(avg(`Avg Temperature (Â°C)`),2) as avg_Temperature,
    round(avg(`Sea Level Rise (mm)`),2) as avg_sea_level_rise,
    round(avg(`Extreme Weather Events`),2) as avg_extreme_weather_events
from climate_change
where `Avg Temperature (Â°C)` is not null
and `Sea Level Rise (mm)` is not null
and `Extreme Weather Events` is not null
group by Year
order by Year desc;

with base_correlations as (
    select 
        -- 1. Pairwise Temperature  and Sea level
        (count(*) * sum(`Avg Temperature (Â°C)` * `Sea Level Rise (mm)`) - sum(`Avg Temperature (Â°C)`) * sum(`Sea Level Rise (mm)`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Sea Level Rise (mm)` * `Sea Level Rise (mm)`) - pow(sum(`Sea Level Rise (mm)`), 2))) as r_xy,

        -- 2. Pairwise Sea level and Extreme weather
        (count(*) * sum(`Sea Level Rise (mm)` * `Extreme Weather Events`) - sum(`Sea Level Rise (mm)`) * sum(`Extreme Weather Events`)) / 
        (sqrt(count(*) * sum(`Sea Level Rise (mm)` * `Sea Level Rise (mm)`) - pow(sum(`Sea Level Rise (mm)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_yz,

        -- 3. Pairwise Temperature  and Extreme weather
        (count(*) * sum(`Avg Temperature (Â°C)` * `Extreme Weather Events`) - sum(`Avg Temperature (Â°C)`) * sum(`Extreme Weather Events`)) / 
        (sqrt(count(*) * sum(`Avg Temperature (Â°C)` * `Avg Temperature (Â°C)`) - pow(sum(`Avg Temperature (Â°C)`), 2)) * sqrt(count(*) * sum(`Extreme Weather Events` * `Extreme Weather Events`) - pow(sum(`Extreme Weather Events`), 2))) as r_xz
    from climate_change
    where `Avg Temperature (Â°C)` is not null 
    and `Sea Level Rise (mm)` is not null 
    and `Extreme Weather Events` is not null
)
select 
    -- Relationship between Temperature and Sea level, isolating Extreme weather
    (r_xy - (r_xz * r_yz)) / 
    (sqrt(1 - pow(r_xz, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xy_control_z,

    -- Relationship between Temperature and Extreme weather, isolating Sea level
    (r_xz - (r_xy * r_yz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_yz, 2))) as partial_r_xz_control_y,

    -- Relationship between Sea level and Extreme weather, isolating Temperature
    (r_yz - (r_xy * r_xz)) / 
    (sqrt(1 - pow(r_xy, 2)) * sqrt(1 - pow(r_xz, 2))) as partial_r_yz_control_x
from base_correlations;