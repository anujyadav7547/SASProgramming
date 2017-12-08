libname anuj 'E:\Tutorial\SAS Programming Essential';
libname orion 'E:\Tutorial\SAS Programming Essential\SASProgramming\Orion Data set';
proc import 
datafile = "E:\Tutorial\SAS Programming Essential\train_aWnotuB.csv"
dbms= CSV
out= anuj.train_aWnotuB
replace;
run;

proc import 
datafile = "E:\Tutorial\SAS Programming Essential\Orion\sales.xls"
dbms= xls
out= orion.sales
replace;
run;

proc import 
datafile = "E:\Tutorial\SAS Programming Essential\Orion\custcaus.xls"
dbms= xls
out= orion.custcaus
replace;
run;

proc import 
datafile = "E:\Tutorial\SAS Programming Essential\Orion\custfm.xls"
dbms= xls
out= orion.custfm
replace;
run;

proc import 
datafile = "E:\Tutorial\SAS Programming Essential\Orion\products.xls"
dbms= xls
out= orion.products
replace;
run;


proc print data=orion.sales;
format Hire_Date mmddyy8. Salary dollar10.;
run;

/* extract month from date*/
data q1birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;

/*Add a PROC FORMAT step after the DATA step to create a character format named $GENDER that displays gender codes as follows:*/
proc format ;
 value $GENDER 'F' = 'Female'
 				'M' = 'Male';
run;

/*Add another step to create a numeric format named MNAME that displays month numbers as name*/
proc format ;
 value MNAME 1 = 'January'
 				2 = 'Febraury'
				3 = 'March'
				4 = 'April'
 				5 = 'May'
				6 = 'June'
 				7 = 'July'
				8 = 'August'
 				9 = 'September'
				10 = 'October'
 				11 = 'November'
				12= 'December';
run;

Proc print data = Q1birthdays;
format Employee_Gender $GENDER. BirthMonth MNAME.;
run;

/*Add format for Other gender type*/
proc format ;
 value $GENDER 'F' = 'Female'
 				'M' = 'Male'
				OTHER = 'Invalid code';
run;

/*create a numeric format named SALRANGE that displays salary ranges*/
proc format ;
 value SALRANGE 
			20000 - < 100000 = 'Below $100,000'
 			100000 - 500000 = '$100,000 or more'
			. = 'Missing Salary'
			other='Invalid salary';

run;

PROC PRINT data = orion.nonsales;
format salary SALRANGE. Gender $GENDER.;
run;

/*   subset sales based on country, job title and hiring date */
proc means data = orion.sales;
run;
proc print data = orion.sales;
var country hire_date;
format hire_date date9.;
run;
data subset1;
	set orion.sales;
	where country= 'AU' and 
	Job_Title contains 'Rep' and 
	Hire_Date < '01jan2000'd;

	Bonus= Salary * .10;
run;
proc print data = subset1;
var country hire_date;
format hire_date date9.;
run;


/***Practice: Creating a SAS Data Set****/
proc print data=orion.customer_dim;
run;

/************ select only female customers****************/
data youngadult;
	set orion.customer_dim;
	where Customer_Gender = 'F';
run;
/************  select female customers whose age is between 18 and 36 in Gold Group ****************/

data youngadult;
	set orion.customer_dim;
	where Customer_Gender = 'F' and 
		Customer_Group contains 'Gold' and
		Customer_Age >= 18 and
		Customer_Age <= 36;
run;
proc print data=youngadult;
run;
/*Add an assignment statement to the DATA step to create a new variable, Discount, and assign it a value of .25. 
Submit the program and check the log to confirm that work.youngadult was created with 5 observations and 12 variables.*/
data youngadult;
set youngadult;
discount = 0.25;
run;

/*Print the new data set. Use an ID statement in the PROC PRINT step to display Customer_ID instead of the Obs column. 
The results should contain 5 observations.*/
proc print data=youngadult;
id customer_id;
run;


data work.subset1;
   set orion.sales;
   Bonus=Salary*.10;
   where Country='AU' and
         Bonus>=3000;
run;

proc contents data=work.subset1;
run;
