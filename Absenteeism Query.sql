-- create join table
select *
from Absenteeism_at_work as A
left join dbo.compensation as B
on A.ID = B.ID
left join Reasons as C
on A.Reason_for_absence = C.Number
-- healthiest individuals
select *
from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 and Body_mass_index < 25
and Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours)from Absenteeism_at_work)

-- compensation rate for non-smokers
select count(*) as Non_Smokers
from Absenteeism_at_work
where Social_smoker = 0
-- optimize the query
select 
A.ID,
C.Reason,
Month_of_absence,
Body_mass_index,
case when Body_mass_index < 18 then 'Under Weight'
     when Body_mass_index between 18 and 25 then 'Healthy Weight'
	 when Body_mass_index between 25 and 30 then 'Overweight'
	 when Body_mass_index > 30 then 'Obese'
	 else 'Unknown' end as BMI_Category,
case when Month_of_absence in (12,1,2) then 'Winter'
     when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Autumn'
	 else 'Unknown' end as Season_Name,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Distance_from_Residence_to_Work,
Service_time,
Age,
Work_load_Average_day,
Hit_target,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Absenteeism_time_in_hours
from Absenteeism_at_work as A
left join dbo.compensation as B
on A.ID = B.ID
left join Reasons as C
on A.Reason_for_absence = C.Number