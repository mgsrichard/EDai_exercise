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

Additionally, other types of machine learning analysis could also be helpful, such as random forest models or neural network models. I set up models for each of these types with the whole dataset and their outcomes were only slightly improved, with an accuracy of 26.8% for the random forest model and 25.2% for the best of the neural networks.

A third way to improve accuracy might be to have fewer features in the model by combining factors from the data. For example, a column for health-related features could be created by combining health related fields, and similarly this could be done for other areas. A model like this would show broader results by category of factor, and some detail would be lost, but also probably a lot of noise would be eliminated from the data. I didn’t perform this analysis, but it would be interesting to run it and see what the impact on the accuracy would be. 

As to which model should be selected, you should be guided by the accuracy of the model and by what you are seeking from the data. If you are really interested in creating a predictor of job growth, you need to choose the model that is the most accurate. If you are more interested in finding what factors are significant, accuracy is less important, because the regression will still likely return the factors with the most importance. You need to choose your data on the right scale as well – if you are looking for predictors or significant factors analysis for large urban areas, the above model of the whole US is not the best choice. From these models, I would choose one of the rural vs. urban subset groups as a predictor based on the location of the requested analysis, unless the request was for information on a national level. 

## Summary of Model Accuracies
![accuracies](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/Accuracies_Summary.png)

## Random Forest Model Analysis
### Overview
A random forest machine learning algorithm combines many small decision tree predictors to create a complex ensemble model that can be very powerful. The combination of many small samples of the data to build the predictions can lead to much greater accuracy, and because each decision tree is based on only a small bit of the underlying data, it provides protection against overfitting the data. (Overfitting is when the model fits the data too well, and can predict that dataset, but performs poorly when presented with new data). Random forest models make categorical predictions instead of the continuous numeric predictions returned by a linear regression. 

### Methodology
I created a random forest model to predict job growth.  Since the random forest model returns a categorical prediction, I converted the employment growth rate into bands 2.5% wide, with all growth rates greater than 15% going into the top band and all rates below -10% going into the lowest band. I converted the state field to 50 Boolean fields using a function called get_dummies. For example, the new variable state_virginia is 1 when the county is in Virginia, and 0 for all other counties. I then scaled the data to eliminate noise from very large and very small values in the data, and fit and tested the model and ran the predictions. 
### Results 
The random forest model performed slightly better than the multiple regression, with an accuracy of 26.8%. One of the interesting outputs from the random forest model is a report of feature importance, which is similar to the significant factors that emerge from regression analysis. As with the significant factors from regression, these factors can be used to narrow down your model or to simply inform you of what features in the data have the most weight in the prediction. Here are the top 20 features from the analysis:

 ![RF ranked importances](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/RF_Ranked_Importances.png)
 
Interestingly, only two factors appear on both the list for regression significant factors and the random forest feature importances list: Primary Care Physician Ratio and % Less than 18 years of age. That suggests that these two factors are important no matter how you look at the data. The differences in other factors reported is likely due to the differences in the models and the large amount of noise in the data. Figuring out why the factors that emerge are otherwise different would be an interesting topic to explore. 

## Unsupervised Learning/Clustering Analysis
### Overview
In contrast to the linear regression and random forest models, unsupervised models do not have an accuracy score. Rather, unsupervised machine learning looks for clusters within the data that may not be obvious otherwise. In an unsupervised analysis, the first step is to determine how many clusters to instruct the algorithm to look for. Next, the model is fit to the data and predictions are made. Then comes the fun part, which is exploring how the algorithm grouped the data.

### Methodology
To create my unsupervised learning model, I first imported the preprocessed data from my random forest model. Then, as in the random forest model, I scaled the data. Next, I reduced the dimensions in the data using principal component analysis, which reduced the number of features being input into the model to 30, which accounted for about 80% of the information in the data. The next step was an elbow curve analysis which suggested that 7 was a good number of clusters to look for in the data. Finally, I fit and ran a K-Means clustering model which predicted a class for each county between 0-6. 

### Results 
The clusters that emerged from the analysis can be seen in the diagram below, or for a better (and bigger) look at the same chart, click this [link](https://public.tableau.com/app/profile/martha.richardson/viz/JobGrowth_16536764067130/Clusters?publish=yes) to view it on Tableau Public. 
 
![clusters tableau](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/Clusters_tableau.png)
 
The clusters here can be used in a variety of ways. They can help you understand trends you already know about. They can be used to inform how you split data into subsets for more accurate models. I reran the multiple regression for each cluster individually, and the accuracy of the results was an improvement over the whole dataset regression for every group. Just looking at these clusters suggested to me that location is an important part of the underlying factors that influence rates of job growth. Location is very closely related to % rural, and so I decided to rerun the multiple regression with subsets based on how rural or urban a county is, and those results were the most accurate ones I got. <br>
 
Below are three scatter charts that show the average job growth rate for each class against three different measurements: average % rural, average median income, and average rate of high school graduation. The tables can help to identify some of the characteristics of the clusters, though there are dozens of other charts we could make also.

### Average Employment Growth Rate Vs. Average % Rural
![growth vs rural](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/Clusters_scatter_rural_vs_rate.png) <br>
 
### Average Employment Growth Rate Vs. Average Median Household Income
![growth vs income](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/Clusters_scatter_income_vs_rate.png)
 
### Average Employment Growth Rate Vs. Average High School Graduation Rate
![growth vs hs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/Clusters_scatter_education_vs_rate.png)

## Results of Multiple Regression Subset Analysis
The following section shows bar charts for each of the multiple regressions I ran on subsets of the data. For each group I noted the r-squared value, which is a measure of predictive ability. The bar charts show the factors in each subset's regression that were statistically significant, i.e., those factors whose p-values were less than 0.01. To include a bit more information in the charts, I programmed the bars to print blue if there was a positive correlation between the factor and the employment growth rate, and to print red if there was a negative correlation between the factor and the employment growth rate.

### Subsets by Employment Growth Rate

### Counties With A Good Growth Rate (>5%)
R-squared value = 25.8%
![good growth sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/good_top_pvalues.png) <br>
### Counties With A Negative Growth Rate (<0%, Job Loss)
R-squared value = 37.5%
![neg growth sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/negative_top_pvalues.png) <br>
 
### Counties With A High Growth Rate (>9%)
R-squared value = 28.4%
 ![high growth sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/high_top_pvalues.png) <br>
### Subsets by Unsupervised Class/Cluster

### Class 0 – Deep South
R-squared value – 42.9%
![class 0 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_0top_pvalues.png) <br>
 
### Class 1 – North Central
R-squared value – 36.5%
![class 1 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_1top_pvalues.png) <br>
 
### Class 2 – Upper Midwest and Friends
R-squared value – 62.0%
![class 2 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_2top_pvalues.png) <br>
 
### Class 3 – Appalachians and Near to Texas 
R-squared value – 35.6%
![class 3 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_3top_pvalues.png) <br>
 
### Class 4 – Missouri and Indiana Plus
R-squared value – 33.6%
![class 4 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_4top_pvalues.png) <br>
 
### Class 5 – Coasts and Rockies
R-squared value – 59.7%
![class 5 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_5top_pvalues.png) <br>

### Class 6 – Texas
R-squared value – 47.0%
![class 6 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/class_6top_pvalues.png)
 
### Subsets by % Rural

### 0-17% Rural
R-squared value – 62.8%
![rural 1 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_1top_pvalues.png)
 
### 17-33% Rural
R-squared value – 67.3%
![rural 2 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_2top_pvalues.png)
 
### 33-47% Rural
R-squared value – 55.0%
![rural 3 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_3top_pvalues.png)
 
### 47-59% Rural
R-squared value – 49.3%
![rural 4 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_4top_pvalues.png)
 
### 59-71% Rural
R-squared value – 49.8%
![rural 5 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_5top_pvalues.png)
 
### 71-88% Rural
R-squared value – 37.4%
![rural 6 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_6top_pvalues.png)
 
### 88-100% Rural
R-squared value – 21.5%
![rural 7 sigfacs](https://github.com/mgsrichard/EDai_exercise/blob/main/resources/rural8_7top_pvalues.png)
