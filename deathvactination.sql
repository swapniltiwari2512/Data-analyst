select * from death order by 3,4

select * from death
--select the data we are going to using

select location,date,total_cases,new_cases,total_deaths,population   from  death order by 1,2

update death set continent = null where continent = ''

select * from death where total_cases = '0'


--looking for total case vs total death

select location,date,total_cases,total_deaths,population,(cast(total_deaths as float)/cast(total_cases as float)*100)as deathpercentage
from  death order by 1,2

--looking at total cases vs population
select location,date,total_cases,population,(cast(total_cases as float)/cast(population as float)*100)as deathpercentage
from death
order by 1,2

--

select location,MAX(total_cases) as highestinfectioncount,population,(cast(total_cases as float)/cast(population as float)*100)as totalcaseoverpopulation
from death
group by location,population,total_cases
order by totalcaseoverpopulation desc

--showing countries with highest death per count

select location, cast(MAX(total_deaths)as int)as total_death_count
from death where continent is not null 
group by location
order by total_death_count desc

---break down by continent

select continent, cast(MAX(total_deaths)as int)as total_death_count
from death where continent is not null 
group by continent
order by total_death_count desc 

select * from death where location = 'high income'

--global number

select date,sum(cast(new_cases as int)) as new_cases--total_cases,total_deaths,population,(cast(total_deaths as float)/cast(total_cases as float)*100)as deathpercentage
from  death
where continent is not null
group by date
order by new_cases

select date,sum(cast(new_cases as int)) as new_cases--sum(cast(new_deaths as int))as new_death--total_cases,total_deaths,population,(cast(total_deaths as float)/cast(total_cases as float)*100)as deathpercentage
from  death
where continent is not null
group by date
order by new_cases




 

--death percantange ion india
select location,date,total_cases,total_deaths,population,(cast(total_deaths as float)/cast(total_cases as float)*100)as deathpercentage
from death where location = 'India' order by 1,2

select location,date,total_cases,population,(cast(total_cases as float)/cast(population as float)*100)as totalcaseoverpopulation
from death where location = 'India' order by 1,2

----Total death percentage

select sum(cast(new_cases as int)),sum(cast(new_deaths as int)),(sum(cast(new_deaths as float))/sum(cast(new_cases as float))*100) as totaldeathpercentage
from death
where continent is not null
order by 1,2

--150574977
--671972476

select location, * from vactiation

update vactiation set continent = null where continent = ''

update death set continent = null where continent = ''


select *
from death d
join vactiation v on
d.date = v.date


select top 100 date,  * from death order by 1
select top 100 date, * from vactiation order by 1

truncate table vactiation
drop table vactiation
delete  vactiation









