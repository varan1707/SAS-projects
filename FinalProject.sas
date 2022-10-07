*********************************
*Author: Varan Mehta;
*Program Purpose: Final Project SAS Program;
*Date: April 28, 2022;
*********************************;


*Question 1:
*Created a permanent library called vmehta4 using the LIBNAME statement;
LIBNAME vmehta4 '/home/u59239858/myLib';

*Question 2:
*Imported the file directly from the URL and saved the data in a dataset called house in the permanent 
library ;
FILENAME house URL 'https://www4.stat.ncsu.edu/~online/ST307/Data/vmehta4.csv';

PROC IMPORT DATAFILE = house
	DBMS=CSV
	OUT=WORK.IMPORT4;
	GETNAMES=YES;
	*Added the GUESSINGROWS = MAX statement as the dataset contains a lost of columns and this ensures that 
	all the columns are covered;
	GUESSINGROWS=MAX;

RUN;

*Question 3:
*Using a data step we have created a;
DATA WORK.myhouse;
	SET WORK.IMPORT4;
	*Using a conditional statement we remove all observations where the following variables take certain values;
	IF (MSZoning = 'C(all)') OR (BsmtUnfSF <= 222.5) THEN DELETE;
	*Label statement to provide decriptive labels to the following variables;
	LABEL YrSold = 'Year of sale of residential home' 
		   OverallCond = 'Rating for the overall condition of the house'
	       MSZoning = 'Zoning Classification of the sale'
	       Functional = 'Functionality of the home';
	*DecimalSalePrice is the new variable that provides the SalePrice values when divided by 100000;
	DecimalSalePrice = SalePrice/100000;
	
	
RUN;
*Question 4:
Using a PROC PRINT step we print the myhouse dataset along with the descriptive labels for certain 
variables ;
PROC PRINT DATA = Work.myhouse LABEL;
RUN;


*Question 5:
*Using a PROC FREQ step we have created a two way contingency table between the Functional and BsmtFinType1
variables using the myhouse temp dataset we created;
PROC FREQ DATA = Work.myhouse; 
	TABLES Functional*BsmtFinType1;
RUN;
*The upper left most value in the table is zero and it means that when Functional Variable is (Maj 1) its 
value is equal to the value when BsmtFinType1 variable is ALQ.



*Question 6:
*Using a PROC MEANS step we will produce a summary statistics for the SalePrice and BedRoomAbvGr variables*;

*We need to sort the data of the myhouse dataset in ascending order since we are using the BY Functionality;
PROC SORT DATA = Work.myhouse;
		BY Functional;
RUN;
*PROC MEANS step produces a summary statistics of sample mean, standard deviation, minimum, 1st quartie, 
3rd quartile and maximum for SalePrice and BedroomAbvGr variables at every level of Functional variable;
PROC MEANS DATA = Work.myhouse MEAN STDDEV MIN Q1 Q3 MAX;
		BY Functional;
		VAR SalePrice BedroomAbvGr;
RUN;

* For the SalePrice variable where the Functional variable takes on the values Typ, the sample mean
is 195365.14 and the sample standard deviation is 82698.00;
		

*Question 7:
*Using a PROC SGPLOT we have created a scatterplot for the myhouse dataset with BedroomAbvGr variable on
the x-axis and SalePrice variable on the y-axis. The GROUP option colors the points by the Bsmt Qual 
variable;
*Used the MARKERATTRS option to color the points on the scatterplot of the temporary dataset;
PROC SGPLOT DATA = WORK.myhouse;
		SCATTER X = BedroomAbvGr Y = SalePrice / GROUP = BsmtQual
		MARKERATTRS= (COLOR = Red SIZE = 10);
RUN;

*Question 8:
*Using PROC GLM we are fitting a MLR model with Sale Price as the respone variable and OverallCond and 
BedroomAbvGr as the predictor variables. We have used the CLPARM option to produce Confidence intervals
for the regression coefficient;
*PLOTS = ALL is used to produce diagnostic plots that could be used to check assumptions;
PROC GLM DATA = WORK.myhouse PLOTS= ALL;
		MODEL SalePrice = OverallCond BedroomAbvGr /CLPARM;
RUN;
QUIT;

*The estimated reqression line is: y = 213762.8384x1 - 14189.7714y1 + 20226.3494

*The 95% confidence interval for the slope corresponding to the OverallCond variable is 
(-21235.0753,-7144.4675)


	
