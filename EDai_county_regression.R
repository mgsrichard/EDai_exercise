
#import dependencies
library("tidyverse")

#Linear regression of county data to predict employment growth rate

#import cleaned data file
County_data <- read.csv(file ='resources/Cleaned_Data_For_R.csv',check.names=F,stringsAsFactors=F)

#Perform multiple linear regression
County_Multiple_Regression <- lm(emp_growth_rate~Deaths+life_lost+fair_poor_health+unhealthy_days+mental_days+low_birth+
                                   smoker+obesity+food_index+inactive+exercise+drinking+drinking_driving_deaths+chlamydia+
                                   teen_birth+uninsured_1+prevent_hosp+mammogram+vaccinated+high_school+some_college+
                                   unemployed+labor_force+unemployed_pct+child_poverty+income_pctile_80+income_pctile_20+
                                   income_ratio+single_parent+social+violent_crime+injury_death+avg_pm25+water_violation+
                                   pct_housing_problems+drive_alone+long_commute+life_expect+death_rate+physical_dist + mental_dist+
                                   diabetes+hiv+food_insecure+limited_food+vehicle_mortality+sleep+uninsured_2+uninsured_3+
                                   avg_grade_1+avg_grade_2+median_income+free_lunch+segregation_2+suicide+firearm_deaths+
                                   traffic_per_meter+homeowners+pct_homeowners+severe_cost+pct_severe_cost+population+
                                   under_18+over_65+Black+pct_native_american+pct_asian+pct_pacific+pct_hispanic+
                                   pct_nonhis_white+poor_english+pct_female+pct_rural+pcp_ratio+dentist_ratio+mental_ratio+
                                   opcp_ratio, data = County_data)
print(County_Multiple_Regression)

#Use summary() to get p value and r squared value for linear regression model
County_summary <- summary(County_Multiple_Regression <- lm(emp_growth_rate~Deaths+life_lost+fair_poor_health+unhealthy_days+
                                       mental_days+low_birth+smoker+obesity+food_index+inactive+exercise +drinking+
                                       drinking_driving_deaths+chlamydia+teen_birth+uninsured_1+prevent_hosp+
                                       mammogram+vaccinated+high_school+some_college+unemployed+labor_force+unemployed_pct+
                                       child_poverty+income_pctile_80+income_pctile_20+income_ratio+single_parent+social+violent_crime+
                                       injury_death+avg_pm25+water_violation+pct_housing_problems+drive_alone+long_commute+
                                       life_expect+death_rate+physical_dist + mental_dist+diabetes+hiv+food_insecure+
                                       limited_food+vehicle_mortality+sleep+uninsured_2+uninsured_3+avg_grade_1+avg_grade_2+
                                       median_income+free_lunch+segregation_2+suicide+firearm_deaths+traffic_per_meter+homeowners+
                                       pct_homeowners+severe_cost+pct_severe_cost+population+under_18+over_65+Black+
                                       pct_native_american+pct_asian+pct_pacific+pct_hispanic+pct_nonhis_white+poor_english+pct_female+
                                       pct_rural+pcp_ratio+dentist_ratio+mental_ratio+opcp_ratio, data = County_data))
                                       
                      
print(County_summary)
