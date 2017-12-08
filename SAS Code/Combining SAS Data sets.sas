/******************************************************************************************************
								Combining SAS Data sets
******************************************************************************************************/

/*****************************************************************************************************
Practice: Concatenating Like-Structured Data Sets
In this practice, you write a DATA step to concatenate three data sets and create a new data set named work.thirdqtr.
*****************************************************************************************************/

data work.thirdqtr;
set orion.mnth7_2011 orion.mnth8_2011 orion.mnth9_2011;
run;

/*****************************************************************************************************
Practice: Concatenating Unlike-Structured Data Sets
In this practice, you write a DATA step to concatenate orion.sales and orion.nonsales to create work.allemployees.
*****************************************************************************************************/
proc contents data = orion.sales;
run;
proc contents data = orion.nonsales;
run;
data work.allemployees;
	set orion.sales  orion.nonsales(rename=(first=First_Name
											last = last_name));
run;

proc print data = work.allemployees;
run;


/*****************************************************************************************************
Practice: Concatenating Data Sets with Variables of Different Lengths and Types
In this practice, you concatenate three data sets and examine how variable attributes are assigned.
*****************************************************************************************************/
proc contents data=orion.charities;
run;

proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;

data work.contacts;
	set orion.charities   orion.us_suppliers;
run;
proc contents data=contacts;
run;

data work.contacts2;
	set   orion.us_suppliers orion.charities ;
run;
proc contents data=contacts2;
run;

data work.contacts3;
	set   orion.us_suppliers  orion.consultants ;   /* this gives error because of different data type*/
run;
proc contents data=contacts3;
run;



/*****************************************************************************************************
Practice: Merging Two Data Sets One-to-One
In this practice, you merge orion.employee_payroll and orion.employee_addresses by Employee_ID to create work.payadd.
*****************************************************************************************************/
proc sort data=orion.employee_payroll
          out=work.payroll;
   by Employee_ID;
run;

proc sort data=orion.employee_addresses
          out=work.addresses;
   by Employee_ID;
run;

data payadd;
merge payroll addresses;
by Employee_ID;
run;

proc print data = payadd;
run;

/*****************************************************************************************************
Practice: Merging Two Sorted Data Sets in a One-to-Many Merge
In this practice, you match-merge two data sets by their common variable to create a new data set named work.allorders.
*****************************************************************************************************/
proc contents data=orion.orders;
run;

proc contents data=orion.order_item;
run;



data allorders;
merge orion.orders orion.order_item;
by Order_ID;
keep Order_ID Order_Item_Num Order_Type Order_Date Quantity Total_Retail_Price;
run;
proc print data=allorders;
run;
/*****************************************************************************************************
Practice: Merging Data Sets in a One-to-Many Merge
In this practice, you merge a sorted data set and an unsorted data set by their common variable.
*****************************************************************************************************/
proc sort data =  orion.product_list
	out =product_list_sort;
	by Product_Level ;
run;
proc sort data =  orion.product_level
	out =listlevel;
	by Product_Level ;
run;

data listlevel1;
	merge listlevel product_list_sort;
	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

proc print data = listlevel1;
run;

/*****************************************************************************************************
Practice: Using the MERGENOBY Option
Learn on your own
*****************************************************************************************************/





/*****************************************************************************************************
Practice: Merging Using the IN= Option
In this practice, you match-merge a sorted version of orion.product_list, named work.product, 
and orion.supplier by a common variable. Then you modify the match-merge so that the output 
data set contains only observations from one of the data sets.
*****************************************************************************************************/
proc sort data=orion.product_list
          out=work.product;
   by Supplier_ID;
run;
data prodsup;
	merge 	product(In = P) 
			orion.supplier(in = S) ;
	by supplier_id;
	if p and not s;
run;


/*****************************************************************************************************
Practice: Merging Using the IN= and RENAME= Options
In this practice, you match-merge orion.customer and orion.lookup_country. 
You rename variables and create an output data set that includes only observations that contain both 
customer information and country information.
*****************************************************************************************************/
proc sort data=orion.customer 
          out=work.customer_sort;
   by Country ;
run;

data allcustomer;
	merge 	customer_sort (In = Cust) 
			orion.lookup_country (rename=	(Start = Country
											Label = Country_Name) in = LookUp) ;
	by Country ;
	if Cust and LookUp;
	keep Customer_ID Country Customer_Name Country_Name;
run;


/*****************************************************************************************************
Practice: Merging and Outputting to Multiple Data Sets
In this practice, you match-merge a sorted version of orion.orders and orion.staff by Employee_ID. 
You create multiple output data sets.
*****************************************************************************************************/
proc sort data=orion.orders 
          out=work.orders_sort;
   by Employee_ID  ;
run;

data work.allorders work.noorders;
   merge orion.staff(in=Staff) 
         work.orders_sort(in=Ord);
   by Employee_ID;
   if Ord=1 then output work.allorders;
   else if Staff=1 and Ord=0 
      then output work.noorders;
   keep Employee_ID Job_Title Gender 
        Order_ID Order_Type Order_Date;
run;
title "work.allorders Data Set";
proc print data=work.allorders;
run;

title "work.noorders Data Set";
proc print data=work.noorders;
run;

title;

