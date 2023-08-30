


select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject.dbo.CovidDeaths
where continent is not null
order by 1,2

-- Total Cases vs Total Deaths
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as 'Death/cases'
from PortfolioProject.dbo.CovidDeaths
where continent is not null
order by 1,2

--Total Cases vs population in US
--percantage of infected population in US
select location,date,population,total_cases,(total_cases/population)*100 as 'cases/population'
from PortfolioProject.dbo.CovidDeaths
where continent is not null and location like '%state%'
order by 1,2

-- Highest Infection Rate
select  location,population,max(total_cases) as max_count,max(total_cases/population)*100 as infected_population
from PortfolioProject.dbo.CovidDeaths
where continent is not null
group by location,population
order by infected_population desc


--Highest Death Rate (Countries)

select  location,max(cast(total_deaths as int)) as Total_Deaths
from PortfolioProject.dbo.CovidDeaths
where continent is not null
group by location
order by Total_Deaths desc

--Highest Death Rate (Continents)
select  location,sum(cast(total_deaths as int)) as Total_Deaths
from PortfolioProject.dbo.CovidDeaths
where continent is null
group by location
order by Total_Deaths desc

--Global Numbers 

--Global New Cases counter for each day 
select date,sum(new_cases) as NewCasesPerDay
from PortfolioProject.dbo.CovidDeaths
where continent is not null
group by date
order by 1,2


--Global death percentage to new cases 
select date,sum(new_cases) as NewCasesPerDay,sum(cast(new_deaths as int)) as DeathsCountPerDay,sum(cast(new_deaths as int))/sum(new_cases) *100 as DeathPercentagePerDay
from PortfolioProject.dbo.CovidDeaths
where continent is not null
group by date
order by 1,2



--Total Cases, Total Deaths , and Death Percentage
select sum(new_cases) as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths,sum(cast(new_deaths as int))/sum(new_cases) *100 as DeathPercentage
from PortfolioProject.dbo.CovidDeaths
where continent is not null
order by 1,2

--TotalPopulation vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as TotalVaccinatedOverTime
from PortfolioProject..CovidVaccinations vac 
join PortfolioProject..CovidDeaths dea on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null
order by 2,3


with popvsvac (continent,location,date,population, new_vaccinations,TotalVaccinatedOverTime)
 
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as TotalVaccinatedOverTime
from PortfolioProject..CovidVaccinations vac 
join PortfolioProject..CovidDeaths dea on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null
)
select *,(TotalVaccinatedOverTime/population*100)as VaccinatedPercantage from popvsvac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 