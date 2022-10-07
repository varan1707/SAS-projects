*********************************
*Author: Varan Mehta;
*Program Purpose: Homework 4 SAS Program;
*Date: April 17, 2022;
*********************************;

*Task 1;

*Answer 1). Simple Linear Regression and Investigation correlation both prove the same point that if the 
slope is 0, there is no linear relationship. However, Simple Linear Regression allows us to predict future values or 
observations like the value of the y variable if we are given the x variable which correaltion cannot do.

*Answer 2). Simple Linear regresson includes a response and a predictor variable to create a model and 
find the confidence interval. A Mulitple regression model on the other hand includes more than one predictor 
variable and can also incldue interaction and polynomial terms.

*Task 2;

*Question 1:

*Stand alone LIBNAME statement for creating a permanent library called ABALONE;
LIBNAME ABALONE '/home/u59239858/myLib';

*Question 2:

*Code to import the abalone dataset into the ABALONE permanent library that has been created before;
FILENAME REFFILE '/home/u59239858/myLib/abalone.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT3;
	GETNAMES=YES;
RUN;

*Question 3;

*Code to conduct a correlation analysis between Length, Height and Shell Weight and report 95% confidence intervals between 
Length and the other two variables using the Fisher option. 
*Used the PLOTS option to produce a matrix of scatterplots;

PROC CORR DATA=WORK.IMPORT3 FISHER PLOTS(MAXPOINTS = 50000)=MATRIX(HIST);
		VAR Length Height ShellWeight;
RUN;

*The confidence intervals for the correlation between Length and Height variable is (0.817714, 0.836847)
*The confidence intervals for the correlation between Length and ShellWeight variable is (0.891622, 0.903410);

*Question 4;

*Code to fit a SLR model using Length as the response variable and Height as the predictor variable;
*Used the CLPARM option to access the confidence intervals for out parameters;

PROC GLM DATA=WORK.IMPORT3 PLOTS=ALL;
	MODEL Length = Height/ CLPARM;
RUN;
QUIT;

*The confidence interval for our slope parameter is (2.327360296, 2.425195115);

*Question 5;

*Code to fit a MLR model using Length as the response variable and Height and ShellWeight as the predictor variables;
*Used the PLOTS option to produce diagnostic plots that could be used to check assumptions and the multiplier term is the 
interaction term;

PROC GLM DATA=WORK.IMPORT3 PLOTS=ALL;
	MODEL Length = Height ShellWeight Height*ShellWeight;
RUN;


*Question 6;

*Code to create a 95% interval for the difference between the mean whole weight of male and female;
*Used the TTEST option and specified the conditon to make the Sex variable a two level variable. We are
asked to calculate the 95% Confidence interval so alpha = 0.05;
 
PROC TTEST DATA = WORK.IMPORT3 ALPHA = 0.05;
		WHERE Sex = 'M' or Sex ='F';
		CLASS Sex;
		VAR WholeWeight;
RUN;

*We are 95% confident that the difference between the mean whole weight of abalone that are male and female lies in the interval 
(0.0213,0.0882).









