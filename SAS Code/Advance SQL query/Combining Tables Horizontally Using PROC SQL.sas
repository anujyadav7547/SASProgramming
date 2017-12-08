/****************************************************************************************************
To view the expected PROC SQL output, click the related link in the text for each step.
- Write a PROC SQL query that displays LastName, FirstName, JobCode, and DateofHire for employees who 
	have more than 20 years of service as of January 1, 2001. Your query should meet the following requirements:
	- Use an inner join to combine the two tables.
	- Use the following table aliases: s for Sasuser.Staffmaster and p for Sasuser.Payrollmaster.
	- Order the output by LastName.
	- In the WHERE statement, use a function to calculate each employee’s years of service, rounded to an integer value. (Remember to divide by 365.25 when calculating the number of years.) 
	- Display the title Employees with More than 20 Years of Service.

Add a QUIT statement to the query. Submit the query and view the output. 

- Modify the query to display the column Years (years of service) after DateOfHire. 
(Hint: Remember to use the CALCULATED keyword in the WHERE clause.) Submit this modified query and view the output. 

- Modify the query as follows:

	- Remove the columns LastName, FirstName, DateOfHire, and Years from the output.
		Note Your query should still display data for employees with more than 20 years of service, 
		so you will need to copy the Years calculation to the WHERE clause. (Because Years is no longer 
		listed in the SELECT clause, you can not reference it by a column alias in the WHERE clause.)
	- After JobCode, use a summary function to create the new column Employees, which displays the number of employees.
	- Group and sort the data by JobCode. 

Submit this modified query and view the output. 

- Submit a null TITLE statement to cancel titles.
****************************************************************************************************/
proc sql;
	select s.LastName, s.FirstName, p.JobCode,  p.DateofHire , int(('01jan2001'd-DateofHire)/365.25) as years
	from SASUser1.Staffmaster as s, SASUser1.Payrollmaster as p
	where s.empid = p.empid
	and calculated  years >20
	order by s.lastname;
quit;
/****************************************************************************************************
To view the expected PROC SQL output, click the related link in the text for each step.
- Write a PROC SQL join that displays rows for both of the following:

	- all scheduled flights (all rows in Sasuser.Flightschedule)
	- all employees who have had a payroll change and are scheduled on a flight (a subset of rows in Sasuser.Payrollchanges).

 The output should display the following columns, in the order in which they are listed:

	- from Sasuser.Flightschedule: Date, Destination, FlightNumber, EmpID.
	- from Sasuser.Payrollchanges: JobCode and Salary. Use the alias NewSalary for the Salary column.

The rows for scheduled flights on which a scheduled employee has had a payroll change 
(the matching rows from the two tables) should have nonmissing values in all six columns.
The remaining rows (the nonmatching rows from Sasuser.Flightschedule) should contain missing values for JobCode and NewSalary. 
(The nonmatching rows are the rows for scheduled flights on which a scheduled employee has not had a payroll change.)

In the FROM clause, specify Sasuser.Flightschedule as the first table. 
Use the table alias f for Sasuser.Flightschedule and p for Sasuser.Payrollchanges. 

Specify two title lines: 

	- Title 1: All Scheduled Employees
	- Title 2: and Any Payroll Changes

Sort the output by JobCode. Add a QUIT statement to the query. Submit the query and view the output.

- Modify the query so that it displays rows for both of the following: 

	- all employees who have had a payroll change (all rows in Sasuser.Payrollchanges)
	- flights that have the flightnumber 622 on which a scheduled employee has had a payroll change 
	(a subset of rows in Sasuser.Flightschedule).

The output should display the following columns, in the order in which they are listed:

	- from Sasuser.Payrollchanges: EmpID, JobCode, and Salary. As before, use the column alias NewSalary for Salary.
	- from Sasuser.Flightschedule: FlightNumber and Date. Use the column alias FlightDate for Date.

The rows for employees who have had a payroll change and are scheduled on flight 622 
	(the matching rows from the two tables) should have nonmissing values in all five columns. 
	The remaining rows (the nonmatching rows from Sasuser.Payrollchanges) should contain missing values for FlightNumber and 
	FlightDate. (The nonmatching rows are the rows for employees who have had a payroll change but who are 
	not scheduled on flight 622.) 

Continue to list Sasuser.Flightschedule as the first table and use the same table aliases as before. Change the title as follows: 

	- Title 1: All Employees with Payroll Changes
	- Title 2: and Any Flight 622 Assignments 

Sort the output by EmpID. Submit this modified query and view the output.

- Modify the query so that it displays rows for both of the following:

	- all employees who have had a payroll change (all rows in Sasuser.Payrollchanges)
	- all scheduled flights (all rows in Sasuser.Flightschedule).

The output should display the following columns, in the order in which they are listed:

	- from Sasuser.Payrollchanges: EmpID, JobCode, and Salary
	- from Sasuser.Flightschedule: FlightNumber and Date.

The rows for employees who have had a payroll change and are assigned to a flight (the matching rows from the two tables) 
should have nonmissing values in all five columns. All other rows (the nonmatching rows from the two tables) 
should contain missing values in some of the columns.

Continue to list Sasuser.Flightschedule as the first table and use the same table aliases as before. 

Change the title as follows: 

	- Title 1: All Employees with Payroll Changes,
	- Title 2: Their Flight Assignments (If Any),
	- Title 3: and All Scheduled Flights

Sort the output by the fourth column listed in the SELECT clause (FlightNumber). Submit this modified query and view the output. 

- Submit a null TITLE statement to cancel titles.
****************************************************************************************************/
data SASUser1.Flightschedule;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Flightschedule.csv" dlm=','firstobs=2 dsd missover;   
   input Date	Destination $ 	FlightNumber	EmpID;
   informat date date9.;
   format date date9.;
run;
proc sql;
	select *
	from Sasuser1.Flightschedule as f
	left join Sasuser1.Payrollchanges as p on input(p.empid, 8.) = f.empid
;
quit;

