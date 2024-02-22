create database project_sql
use project_sql
show tables;
select * from dataset1;

# Q1. dataset for bihar and jharkhand
select * from dataset1 where State in ('Bihar','Jharkhand')

# Q2. population of india
select sum(Population) as Total_Population from dataset2;

# Q3. average growth
select avg(Growth) as Average_Growth from dataset1;

# Q4. average growth per state
select State, round(avg(Growth),2) as Average_Growth from dataset1 group by 1;

# Q5. average sex ratio per state
select State, round(avg(Sex_Ratio),2) as Sex_Ratio from dataset1 group by 1;

# Q6. average literacy rate state wise which is greater than 85
select State, round(avg(Literacy),2) as Literacy from dataset1 where Literacy > 90 group by 1 order by Literacy desc;

# Q7. top 3 state showing highest average growth rate
select State, avg(Growth) as Average_Growth from dataset1 group by State order by Average_Growth desc limit 3;

# Q8. bottom 5 state showing lowest average sex ratio
select State, round(avg(Sex_Ratio),0) as Average_Sex_Ratio from dataset1 group by State order by Average_Sex_Ratio asc limit 5;

# Q9. top & bottom 3 state in Literacy
select State as Top_3_State, avg(Literacy) as Average_Literacy from dataset1 group by State order by Average_Literacy desc limit 3;
select State as Bottom_3_State, avg(Literacy) as Average_Literacy from dataset1 group by State order by Average_Literacy asc limit 3;

# Q10. STATES STARTING WITH LETTER A or B
select distinct(State) from dataset1 where State like 'A%' or State like 'B%';

#Q11. Joining both tables
select d1.District, d1.State, d1.Sex_Ratio, d2.Population from dataset1 as d1 inner join dataset2 as d2 on d1.District = d2.District;

#Q12. Calculate No of Male & Female(District Wise)
select d3.District, d3.State, round(d3.Population/(d3.Sex_Ratio+1),0) as Males, round((d3.Population*d3.Sex_Ratio)/(d3.Sex_Ratio+1),0) as Female from 
(select d1.District, d1.State, d1.Sex_Ratio/1000 as Sex_Ratio, d2.Population from dataset1 as d1 inner join dataset2 as d2 on d1.District = d2.District) as d3

#Q13. Calculate No of Male & Female(State Wise)
select d4.State, sum(d4.Males) as Male, sum(d4.Female) as Female from 
(
select d3.District, d3.State, round(d3.Population/(d3.Sex_Ratio+1),0) as Males, round((d3.Population*d3.Sex_Ratio)/(d3.Sex_Ratio+1),0) as Female from 
(select d1.District, d1.State, d1.Sex_Ratio/1000 as Sex_Ratio, d2.Population from dataset1 as d1 inner join dataset2 as d2 on d1.District = d2.District) as d3)
as d4 group by d4.State

#Q14. Calculate Total No of Literate & Illetrate People( District Wise)

select d3.District,d3.State, round(d3.Literacy*d3.Population,0) as Literate_People, round((1-d3.Literacy)*d3.Population,0) as Illerate_People from
(
select d1.District, d1.State, d1.Literacy/100 as Literacy, d2.Population from dataset1 as d1 inner join dataset2 as d2 on d1.District = d2.District
) as d3

#Q15. Calculate Population for Previous census(Distict wise)

select d3.District, d3.State, d3.Population, round(d3.Population/(1+d3.Growth)*100000,0) as Previous_Cencus_Population from 
(
select d1.District, d1.State, d1.Growth/100 as Growth, d2.Population from dataset1 as d1 inner join dataset2 as d2 on d1.District = d2.District)
as d3


	







