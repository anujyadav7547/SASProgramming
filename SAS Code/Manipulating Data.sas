/******************************************************************************************************
								Practice: Creating New Variables
******************************************************************************************************/

/*****************************************************************************************************
You create three new variables, specify variables to include in the results and specify the format of the variables.
*****************************************************************************************************/
proc print data = orion.staff;
run;
data work.increase;
   set orion.staff;
   Increase = salary* 0.10;
   NewSalary = sum(salary, increase);
   BdayQtr = qtr(Birth_Date);
   keep Employee_ID Salary Birth_Date Increase NewSalary BdayQtr;
   format salary increase newsalary comma20.;
run;
proc print data = increase;
run;

/*****************************************************************************************************
In this practice, you use the orion.customer data set to create the temporary data set work.birthday. 
You create three new variables by using date functions and other methods. You specify variables to 
include in the results, and specify the format of the variables.
*****************************************************************************************************/
data work.birthday;
   set orion.customer ;
   Bday2012 = MDY(month(Birth_Date),day(Birth_Date), 2012); 
   BdayDOW2012 = Weekday(Birth_Date);
   Age2012 =(Bday2012- Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date. Age2012 3.;
run;
proc print data = birthday;
run;

/*****************************************************************************************************
Practice: Using the CATX and INTCK Functions to Create Variables
*****************************************************************************************************/
data work.employees;
   set orion.sales ;
   FullName = CATX("", First_Name, Last_Name);
   Yrs2012 = INTCK('year', Hire_Date, '01JAN2012'd);
   format Hire_Date ddmmyy.;
   label Yrs2012  = 'Years of Employment in 2012';
run;
proc print data = employees;
run;





/*****************************************************************************************************
Practice: Using Conditional Processing with DO Groups
In this practice, you create variables based on the value of an existing variable in the data set orion.supplier. 
You also set the length of a variable and specify variables to include in the output.
*****************************************************************************************************/
data work.region;
   set orion.supplier;
   length Region $ 20.;
	if upcase(country) in ('CA','US') then
		do;
			Discount = 0.10;
			DiscountType = 'Required';
			Region = 'North America';
		end;
	else
		do;
			Discount = 0.05;
			DiscountType = 'Optional';
			Region = 'Not North America';
		end;
	keep Supplier_Name  Country  Discount  DiscountType Region;
run;

proc print data = region;
run;



/*****************************************************************************************************
Practice: Creating Multiple Variables in Conditional Processing
In this practice, you create the new data set work.season and use orion.customer_dim as input. 
You create two new variables whose values are assigned conditionally.
*****************************************************************************************************/
data work.season;
   set orion.customer_dim ;
   Length Promo2 $20.;
	if qtr(Customer_BirthDate) =1  then
		do;
			Promo = 'Winter';
		end;
	else if qtr(Customer_BirthDate) =2  then
		do;
			Promo = 'Spring';
		end;
	else if qtr(Customer_BirthDate) =3  then
		do;
			Promo = 'Summer';
		end;
	else if qtr(Customer_BirthDate) =4  then
		do;
			Promo = 'Fall';
		end;
	if Customer_Age > 18 and Customer_Age < 25 then
		Promo2 = 'YA';
	else if Customer_Age >= 65 then
		Promo2 = 'Senior';

	keep Customer_FirstName  Customer_LastName  Customer_BirthDate  Customer_Age  Promo  Promo2;
run;

proc print data = work.season;
run;


/*****************************************************************************************************
Practice: Using WHEN Statements in a SELECT Group to Create Variables Conditionally
In this practice, you create the temporary data set work.gifts using the data set orion.nonsales. 
You use SAS Help or the SAS product documentation online to research the SELECT group with WHEN 
statements to create variables conditionally.
*****************************************************************************************************/
data work.gifts;
   set orion.nonsales ;
   Length Gift1 Gift2 $20.;
   Select (Gender);
	When('F')  
		do;
			Gift1 = 'Scarf';
			Gift2 = 'Pedometer';
		end;
	When('M')  
		do;
			Gift1 = 'Gloves';
			Gift2 = 'Money Clip';
		end;
	otherwise  
		do;
			Gift1 = 'Coffee';
			Gift2 = 'Calendar';
		end;
	end;

	keep Employee_ID  First  Last  Gender  Gift1  Gift2;
run;

proc print data = work.gifts;
run;
