*********************************;
*Varan J Mehta;
*Homework 1 SAS Program;
*Date: 09/06/2021;
*********************************;

*Task 1;

*Answer 1). The difference between a SAS step and a SAS statement is that SAS step consists of multiple SAS statements 
that are required in order to run the program. A SAS statement in most cases starts with a keyword and ends with a semicolon whereas a SAS 
step depending on the type of the SAS step starts with a DATA or a PROC statement and ends with a RUN command and a semicolon.

*Answer 2). A SAS library is a folder that exists on our computer and it contains the SAS  datasets and the SAS Programs in it.

*Answer 3). We should check the LOG window every time after we run our code in order to ensure that there are no warnings or errors 
in the code that we are running.

*Task 2;

*Question 1:
*Stand alone LIBNAME statement for creating a permanent library called HOMEWORK which stores the datasets in SAS in the required form;
LIBNAME HOMEWORK '/home/u59239858/myLib';

*Question 2:
*PROC IMPORT STEP used to import the data in the abalone csv file into SAS. A datafile is created in the PROC STATEMENT in order to store 
the location of the raw dataset and REFFILE is the variable that holds the location, the DBMS defines the data type of the raw file based 
on the type of delimiter used, the OUT represents the two level location of the library name followed by the folder name in SAS for the 
dataset, GETNAMES is a boolean value to check if the first row of the data set consits of the variable name;

*Code to import the first dataset (a csv file called abalone) into the permanent library HOMEWORK;
FILENAME REFFILE '/home/u59239858/myLib/abalone.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=HOMEWORK.IMPORT1;
	GETNAMES=YES;
RUN;

*Code to import the second dataset (a tsv file called balanceScaleNoVarNames) into the permanent library HOMEWORK;
FILENAME REFFILE2 '/home/u59239858/myLib/balanceScaleNoVarNames.tsv';

PROC IMPORT DATAFILE=REFFILE2
	DBMS=TAB
	OUT=HOMEWORK.IMPORT2;
	GETNAMES=NO;
RUN;

*Code to import the third dataset (an excel file called bupa) into the permanenet library HOMEWORK;
FILENAME REFFILE3 '/home/u59239858/myLib/bupa.xlsx';

PROC IMPORT DATAFILE=REFFILE3
	DBMS=XLSX
	OUT=HOMEWORK.IMPORT3;
	GETNAMES=YES;
RUN;

*Question 3
*As the second dataset that is the dataset with the tsv file type does not have variable names included in the dataset, 
we can write a DATA STEP to rename the variables in the data set;
DATA HOMEWORK.IMPORT2;
		SET HOMEWORK.IMPORT2;
		RENAME VAR1 = ClassName
			   VAR2 = LeftWeight
			   VAR3 = LeftDistance 
			   VAR4 = RightWeight
			   VAR5 = RightDistance;
RUN;


*Question 4;

*PROC PRINT STEP that has been created in order to print the data for the abalone dataset;
PROC PRINT DATA= HOMEWORK.IMPORT1;
RUN;

*PROC PRINT STEP that has been created in order to print the data for the balanceScaleNoVarNames dataset;
PROC PRINT DATA= HOMEWORK.IMPORT2;
RUN;

*PROC PRINT STEP that has been created in order to print the data for the bupa dataset;
PROC PRINT DATA= HOMEWORK.IMPORT3;
RUN;





