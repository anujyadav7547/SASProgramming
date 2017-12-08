/*****************************************************************************************************
Practice: Producing Frequency Reports with PROC FREQ
*****************************************************************************************************/
proc format;
   value ordertypes
         1='Retail'
         2='Catalog'
         3='Internet';
run;

proc freq data=orion.orders;
	table Order_Date/nocum nopercent;
	table Order_Type/nocum nopercent;
	format Order_Date year4.;
run;


proc freq data=orion.nonsales2 nlevels
          order=freq;
   tables Job_Title/nocum nopercent;
run;

/*****************************************************************************************************
Practice: Counting Levels of a Variable with PROC FREQ
In this practice, you create two frequency reports based on the data set orion.orders. 
Each report displays the number of distinct levels for specific variables.
*****************************************************************************************************/
title 'Unique Customers and Salespersons for Retail Sales';
proc freq data=orion.orders nlevels;
   tables Customer_ID Employee_ID/noprint;
   where Order_Type=1;
run;
title;
/*****************************************************************************************************
Add another PROC FREQ step based on the following criteria:

- Display the number of distinct levels of Customer_ID for catalog and Internet orders.
- Use a WHERE statement to limit the report to catalog and Internet sales by selecting observations 
	with Order_Type values other than 1.
- Specify an option to display the results in decreasing frequency order.
- Specify an option to suppress the cumulative statistics.
- Display the title Catalog and Internet Customers.
- Submit the program to create this report.
*****************************************************************************************************/
title 'Catalog and Internet Customers';
proc freq data=orion.orders nlevels order=freq;
   tables Customer_ID /nocum;
   where Order_Type ne 1;
run;
title;


title;
/*****************************************************************************************************
Practice: Creating a Summary Report with PROC MEANS
In this practice, you create a PROC MEANS report that shows the revenue from Orion Star orders by 
year and by order type using the data set orion.order_fact.
*****************************************************************************************************/
proc format;
   value ordertypes
         1='Retail'
         2='Catalog'
         3='Internet';
run;

title 'Revenue from All Orders';

proc means data=orion.order_fact sum;
var Total_Retail_Price;
class Order_Date  Order_Type;
format Order_date YEAR4. order_type ordertypes.;
run;

title;

/*****************************************************************************************************
Practice: Analyzing Missing Numeric Values with PROC MEANS
In this practice, you create a PROC MEANS report that shows the number of missing values and 
non-missing values for several variables in orion.staff.
*****************************************************************************************************/
title 'Number of Missing and Non-Missing 
      Date Values';
proc means data=orion.staff n nmiss noobs;
	var Birth_Date Emp_Hire_Date Emp_Term_Date;
	class Gender;
run;
title;

/*****************************************************************************************************
Practice: Creating an Output Data Set with PROC MEANS
In this practice, you use PROC MEANS to create a temporary output data set using orion.order_fact.
*****************************************************************************************************/	

proc means data=orion.order_fact noprint nway;
   class Product_ID;
   var Total_Retail_Price ;
	output out= product_orders
			sum = Product_Revenue;
run;

data product_names ;
	merge product_orders orion.product_list;
	by product_id;
	keep Product_ID Product_Name Product_Revenue;
run;

proc sort data = product_names ;
	by Product_Revenue ;
run;

/*****************************************************************************************************
Practice: Validating Data Using PROC UNIVARIATE
In this practice, you use PROC UNIVARIATE to validate data in the data set orion.price_current.
*****************************************************************************************************/	
proc univariate data=orion.price_current;
	var Unit_Sales_Price  Factor ;
run;
