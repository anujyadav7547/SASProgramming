data work.nonsales2;
   infile "E:\Tutorial\SAS Programming Essential\Orion\nonsales.csv" dlm=',';   
   input Employee_ID First $ Last;
run;

proc print data=work.nonsales2;
run;

/**********************************************************************

Practice: Reading a Comma-Delimited Raw Data File

***********************************************************************/
/******************Copy and paste this starter code into the editor.*/
data work.newemployees;
run;

/**********  Add the appropriate INFILE, INPUT, and LENGTH statements to read the comma-delimited 
raw data file newemps.csv from the practice data folder.   ****/

data work.newemps;
   infile "E:\Tutorial\SAS Programming Essential\Orion\newemps.csv" dlm=',';   
   length First $12 Last $18 Title $ 25  Salary 8;
   input First$  Last$  Title $   Salary ;
run;

proc contents data = work.newemps;
run;



/**********************************************************************

Practice: Reading Nonstandard Data from a Comma-Delimited Raw Data File

***********************************************************************/

data work.canada_customers;
	infile "E:\Tutorial\SAS Programming Essential\Orion\custca.csv"  dlm=',';
	length Country $2 Gender $1 FirstName $12 LastName $18;
	input id Country $ Gender $ FirstName $ LastName $ BirthDate :mmddyy.;
	format BirthDate date.;
run;


/**********************************************************************

In this practice, you write a DATA step to read delimited instream data.

***********************************************************************/
Data newEmp;
infile datalines dlm='/';
length id 8 FirstName $ 12 LastName $ 12  Gender $1 Title $25.;
input id FirstName $ LastName $ Gender $ Salary :dollar. Title $ BirthDate :date.;
format Salary dollar10. BirthDate date.;
datalines;
120102/Tom/Zhou/M/108,255/Sales Manager/01Jun1993
120103/Wilson/Dawes/M/87,975/Sales Manager/01Jan1978
120261/Harry/Highpoint/M/243,190/Chief Sales Officer/01Aug1991
121143/Louis/Favaron/M/95,090/Senior Sales Manager/01Jul2001
121144/Renee/Capachietti/F/83,505/Sales Manager/01Nov1995
121145/Dennis/Lansberry/M/84,260/Sales Manager/01Apr1980
;
run;

/**********************************************************************

Read the comma-delimited raw data file donation.csv, which contains missing data, to create a new SAS data set.

***********************************************************************/
Data Donation;
infile "E:\Tutorial\SAS Programming Essential\Orion\Donation.csv" dlm=',' dsd missover;
input EmpID Q1 Q2 Q3 Q4;
run;

/**********************************************************************

Write a DATA step to read the asterisk-delimited raw data file prices.dat, 
which might have missing data at the end of some records

***********************************************************************/
Data prices;
infile "E:\Tutorial\SAS Programming Essential\Orion\Prices.dat" dlm='*' dsd missover;
input ProductID StartDate :date. EndDate :date. UnitCostPrice :dollar. UnitSalesPrice :dollar.;
format StartDate  MMDDYY10. EndDate  MMDDYY10. UnitCostPrice dollar.2 UnitSalesPrice dollar.2;
label ProductID = 'Product ID'
	StartDate = 'Start of Date Range'
	EndDate = 'End of Date Range'
	UnitCostPrice = 'Cost Price per Unit'
	UnitSalesPrice = 'Sales Price per Unit'
run;
proc print data = prices;
run;
