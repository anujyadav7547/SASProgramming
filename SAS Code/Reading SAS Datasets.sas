/*Practice: Subsetting Observations Based on Two Conditions*/


data work.increase;
   set orion.staff;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
run;

/*Modify the DATA step to select only the observations with Emp_Hire_Date values on or after July 1, 2010. 
Subset the observations as they are being read into the PDV.*/
data work.increase;
   set orion.staff;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
   where Emp_Hire_Date >= '01jul2010'd;
run;


/*Modify the DATA step to select only the observations that have an Increase value greater than 3000.*/
data work.increase;
   set orion.staff;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
   where Emp_Hire_Date >= '01jul2010'd;
   if increase > 3000;
run;

/*The new data set should contain only the following variables: Employee_ID, Emp_Hire_Date, Salary, Increase, and NewSalary.*/
data work.increase;
   set orion.staff;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
   where Emp_Hire_Date >= '01jul2010'd;
   if increase > 3000;
   keep Employee_ID  Emp_Hire_Date  Salary  Increase  NewSalary;
run;

/*Add permanent labels for Employee_ID, Emp_Hire_Date, and NewSalary. 
Add a PROC CONTENTS step and submit the program to verify that the labels are stored in the 
descriptor portion of the new data set work.increase.*/

data work.increase;
   set orion.staff;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
   where Emp_Hire_Date >= '01jul2010'd;
   if increase > 3000;
   keep Employee_ID  Emp_Hire_Date  Salary  Increase  NewSalary;
   label Employee_ID = 'Employee Id'
   		Emp_Hire_Date = 'Hire date'
		NewSalary = 'Increased Salary';
run;

proc contents data = work.increase;
run;

/*Write a PROC PRINT step to create this report, with labels split over multiple lines. The results should contain 10 observations.*/
proc print data = work.increase label split = ' ';
run;



/*******           Practice: Subsetting Observations Based on Three Conditions     **************/
/***   Write a DATA step to create a new data set named work.delays. 
Use the data set orion.orders as input. Submit the code to confirm that work.delays contains 490 observations and 6 variables. **/

data delays;
set orion.orders;
run;

/**** Modify the DATA step to create a new variable, Order_Month, and set it to the month of the Order_Date. 
Hint: Use an assignment statement to extract the month from the Order_Date value.  ***/
data delays;
	set orion.orders;
	Order_month = month(Order_Date);
run;



/************************************************************************************
Use a WHERE statement and a subsetting IF statement to select only the observations 
that meet all of the following conditions:
 - Delivery_Date values that are more than four days beyond Order_Date
 - Employee_ID values that are equal to 99999999
 - Order_Month values occurring in August
************************************************************************************/
data delays;
	set orion.orders;
	Order_month = month(Order_Date);
	where Delivery_Date > 4 + Order_Date and 
	Employee_ID = 99999999;
	if order_month = 8;
run;


/************************************************************************************
The new data set should include only Employee_ID, Customer_ID, Order_Date, Delivery_Date, and Order_Month.
************************************************************************************/

data delays;
	set orion.orders;
	Order_month = month(Order_Date);
	where Delivery_Date > 4 + Order_Date and 
	Employee_ID = 99999999;
	if order_month = 8;
	keep Employee_ID  Customer_ID  Order_Date  Delivery_Date  Order_Month;
run;

/************************************************************************************
Add permanent labels for Order_Date, Delivery_Date, and Order_Month as shown in this report. 
************************************************************************************/

data delays;
	set orion.orders;
	Order_month = month(Order_Date);
	where Delivery_Date > 4 + Order_Date and 
	Employee_ID = 99999999;
	if order_month = 8;
	keep Employee_ID  Customer_ID  Order_Date  Delivery_Date  Order_Month;
	label Order_Date = 'Order Date'
		Delivery_Date = 'Delivery Date'
		Order_Month = 'Order Month';
run;
/************************************************************************************
Add permanent formats to display Order_Date and Delivery_Date as MM/DD/YYYY. 
Add a PROC CONTENTS step and submit it to verify that the labels and formats were stored permanently.
************************************************************************************/
data delays;
	set orion.orders;
	Order_month = month(Order_Date);
	where Delivery_Date > 4 + Order_Date and 
	Employee_ID = 99999999;
	if order_month = 8;
	keep Employee_ID  Customer_ID  Order_Date  Delivery_Date  Order_Month;
	label Order_Date = 'Order Date'
		Delivery_Date = 'Delivery Date'
		Order_Month = 'Order Month';

	format Order_Date Delivery_Date mmddyy10.;
run;

proc contents data = delays;
run;

proc Print data = delays;
run;
