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

select location,cast(MAX(total_cases)as int) as highestinfectioncount,
population,Max(cast(total_cases as float)/cast(population as float)*100)as totalcaseoverpopulation
--population,cast(Max((total_cases/population)*100) as int)as totalcaseoverpopulation
from death
group by location,population
order by totalcaseoverpopulation desc



--showing countries with highest death per count

select location, cast(MAX(total_deaths)as int)as total_death_count
from death where continent is not null 
group by location
order by total_death_count desc

---break down by continent

select continent, cast(MAX(total_deaths)as float)as total_death_count
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

select location, * from vactination

update vactination set continent = null where continent = ''

update death set continent = null where continent = ''


select *
from death d
join vactination v on
d.date = v.date
and d.location = v.location

--258060


select count( location)   from death order by 1
select top 100 date, * from vactination order by 1


update  vactination set new_vaccinations = '' where new_vaccinations = null

select d.continent, d.location,d.date,d.population,v.new_vaccinations
from death d
join vactination v on
d.date = v.date
and d.location = v.location
where d.continent is not null
order by 1,3


select d.continent, d.location,d.date,d.population,v.new_vaccinations,
sum(convert(float,v.new_vaccinations)) over (partition by d.location order by d.location,d.date)as rollingpepolevactinated
from death d
join vactination v on
d.date = v.date
and d.location = v.location
where d.continent is not null
order by 2,3


---with cte

	with PopvsVac(continent,loaction,date,population,new_vaccination,rollingpepolevactinated)
	as(

	select d.continent, d.location,d.date,d.population,v.new_vaccinations,
	sum(convert(float,v.new_vaccinations)) over (partition by d.location order by d.location,d.date)as rollingpepolevactinated
	from death d
	join vactination v on
	d.date = v.date
	and d.location = v.location
	where d.continent is not null
	--	order by 2,3
	)
	select *, (rollingpepolevactinated/population)*100 from PopvsVac


	--temp table

	create table #perpopvacctinated(
	continent nvarchar(255),
	loaction nvarchar(255),
	date datetime,
	population numeric,
	new_vaccination numeric,
	rollingpepolevactinated numeric
	)
	insert into #perpopvacctinated
		select d.continent, d.location,d.date,d.population,v.new_vaccinations,
	sum(convert(float,v.new_vaccinations)) over (partition by d.location order by d.location,d.date)as rollingpepolevactinated
	from death d
	join vactination v on
	d.date = v.date
	and d.location = v.location
	where d.continent is not null
	--	order by 2,3
		select *, (rollingpepolevactinated/population)*100 from #perpopvacctinated

		--global
		select continent, max(cast(total_deaths as int))as totaldeaths
		from death
		where continent is not null
		group by continent
		order by totaldeaths


		select sum(cast(new_cases as float))as totalcases,SUM(cast(new_deaths as float))as totaldeaths,
		sum(cast(new_deaths as float))/sum(cast(new_cases as int))*100 as deathperntage
		from death
		where continent is not null
		order by 1,2


		--create view

		create view perpopvacctinated as
				select d.continent, d.location,d.date,d.population,v.new_vaccinations,
	sum(convert(float,v.new_vaccinations)) over (partition by d.location order by d.location,d.date)as rollingpepolevactinated
	from death d
	join vactination v on
	d.date = v.date
	and d.location = v.location
	where d.continent is not null
	--	order by 2,3

--2
	select continent,sum(cast(new_deaths as int))as totaldeathcount
	from death
	where continent is not null
	and location not in ('world','European union','international')
	group by continent
	order by totaldeathcount desc

--3
	select location,population,MAX(total_cases) as highestinfectioncount,
Max(cast(total_cases as float)/cast(population as float)*100)as totalcaseoverpopulation
--population,cast(Max((total_cases/population)*100) as int)as totalcaseoverpopulation
from death
group by location,population
order by totalcaseoverpopulation desc

 

select total_cases  from death where total_cases = ''
update death set total_cases = null where total_cases = ''



