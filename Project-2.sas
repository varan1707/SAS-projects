*********************************;
*Varan Mehta;
*Date: Feb 27, 2022;
*********************************;

*Task 1;

*Answer 1). The two common types of coloumn manipulatons include changing variable names using RENAME and LABEL 
statements and adding a newlly created variable to a dataset using a DATA and a PROC step 

*Answer 2). The most common type of row manipulation is subsetting or filtering rows using WHERE and IF statements.



*Task 2;

*Question 1:
*Stand alone LIBNAME statement for creating a permanent library called HOMEWORK which stores the datasets in SAS in the required form;
LIBNAME HOMEWORK '/home/u59239858/myLib';

*Question 2;
* The tab delimited raw data type is imported into the permanent library HOMEWORK using the PROC IMPORT step;
FILENAME REFFILE '/home/u59239858/hateCrime.tsv';


PROC IMPORT DATAFILE=REFFILE
	DBMS=TAB
	OUT=HOMEWORK.IMPORT2;
	GETNAMES=NO;
RUN;	

*Question 3;
*Using a DATA step we will change the variable names to the ones given in the question as there are no 
column names in the raw data file;

DATA HOMEWORK.mycrime;
		*3a = Chaging the variable names from default names to the ones privided in the description using RENAME;
		SET HOMEWORK.IMPORT2 (RENAME =('VAR1'n = state 'VAR2'n = med_inc 'VAR3'n = unemp 'VAR4'n = pop_metro
		'VAR5'n = pop_hs 'VAR6'n = non_citizen 'VAR7'n= white_poverty 'VAR8'n= non_white'VAR9'n= vote_trump
		'VAR10'n= hate_crimes_per_100k 'VAR11'n= avg_hatecrimes_per_100k));
		
		*3b = Adding descriptive labels to the given variables as per the requirement;
		LABEL med_inc = 'Median household income' non_citizen = 'Share of population not U.S. citizens'
		vote_trump = 'Share of voters for Trump';
		
		*3c = Using the missing function and the IF statements in the DATA step 
		we will remove observations that are missing values in the following two variables;
		IF Missing(hate_crimes_per_100k) THEN DELETE;
		IF Missing(avg_hatecrimes_per_100k) THEN DELETE;
		
		*3d = A new variable is created that gives an estimated crime rate per 100k during the entire year;
		est_crimes_per_100k_annual = (365 * hate_crimes_per_100k)/10;
		
		*3e = A new variable "Status" is created that sets the value as T or F based 
		on the values of white_poverty and unemp ;
		IF(white_poverty > 0.1) OR (unemp < 0.05) THEN Status = "T";
		ELSE Status = "F";
RUN;


*3f = The PROC Step to print the temporary dataset with the created labels;
PROC PRINT DATA=homework.mycrime LABEL;
RUN;

		
