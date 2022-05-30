# EDai_exercise

## Overview

My task was to compute the job growth rate in the US by county and use linear regression to identify the factors most associated with those changes.

## Methodology

My input data came from a County Health Rankings dataset provided by EDai, and 2015 and 2020 employment counts from field DP03_0004E from the Census Bureau's 5 year American Community Survey. The DP03_0004E field is a count of the population aged 16 and older who are actively employed in a civilian job. I saved the County Health Rankings dataset as a comma separated value file, and then imported it into Python. For the census data, I created a function in python to make an API call to the census bureau, and saved tables containing each year's employment numbers. I merged the 2015 and 2020 employment numbers into the County Health Data. I cleaned the merged data, checking for duplicate rows and columns, and then handled null values.  I decided not to use any column where greater than 30% of the rows had a null value. For all other null values, I substituted the average of the values that were present in the data. I then performed a multiple linear regression in Python and also in R to determine which of the factors/features are most correlated with the employment growth rate. In the multiple regression I used a significance level of 0.01. I then compared the resulting p-values to the significance level, and those factors whose p-value is below 0.01 are considered to be significant.

## Findings

The significant factors associated with the Employment Growth Rate according to the regression analysis are:

![significant_factors](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/all_top_pvalues.png)

The r squared value from the analysis is 25.1%, which mens that the model would be a weak predictor of the employment growth rate.

## Limitations

The two greatest limitations I can see for this analysis are the broadness of the dataset and the volume of missing data. The dataset is very diverse - the analysis includes 77 different independent factors that were used to predict the job growth rate in more than 3,000 counties across the US. That is likely why the accuracy is low, because there are so many things going on that it is hard to predict well using the entire dataset. Also, many of the columns are missing data. I filled in the average for those where the columns contained data for at least 70% of the rows to preserve the information that was provided in those fields, but filling in more of the missing values would likely result in a more robust and accurate model.   

## Proposed Improvements

Two ways to improve the accuracy of the predictions are through breaking the data into smaller, more homogenous subsets, and also by trying other predictive models.  For example, when I reran the regression with data broken into 7 ranges based on the percentage rural, the accuracy improved for all but the most rural 2 groups, with rates of 49.8% to 67.3%, a great improvement in accuracy. I also used unsupervised learning to create 7 clusters, and when I ran those separately, the accuracy improved to as much as 56.4%. Also, when the data is broken into subsets, the significant factors which emerge reveal trends in the individual subgroups which are not apparent when you look at the data as a whole.

Additionally, other types of machine learning analysis could also be helpful, such as random forest models or neural network models. I set up models for each of these types with the whole dataset  and their outcomes were only slightly improved, with an accuracy of 26.8% for the random forest model and 25.2% for the best of the neural networks.
