data SASUser1.Marchflights;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Marchflights.csv" dlm=','firstobs=2 dsd missover;   
   input Date	DepartureTime	FlightNumber	Origin $	Destination $	Distance	Mail	Freight 	 Boarded 	Transferred  	NonRevenue	Deplaned	PassengerCapacity;
   informat Date date. DepartureTime time.;
   format Date date. DepartureTime time.;
run;


/****************************************************************************************************
Create a PROC SQL query that displays all columns from Sasuser.Marchflights 
and lists the expanded column list in the SAS log. Limit the number of rows displayed to 10. 
Sort the results by FlightNumber. Add a QUIT statement at the end of the query. 
Submit the query and view both the output and the SAS log.\
****************************************************************************************************/

Proc sql feedback outobs = 10;
	select * from SASUser1.Marchflights
	order by FlightNumber;
quit;

/****************************************************************************************************
Modify the query to display only the unique values of the column FlightNumber. 
Remove the options that limit the number of rows and display an expanded column list in the SAS log. 
Submit this modified query and view the output and the SAS log.
****************************************************************************************************/

Proc sql feedback ;
	select distinct FlightNumber from SASUser1.Marchflights
	order by FlightNumber;
quit;



/****************************************************************************************************
Modify the query as follows: 

	-	Display the existing columns FlightNumber, Date, and Destination.

	-	Define a new column, Total, as the sum of the values of Boarded, Transferred, and Nonrevenue. 
		Use the SUM function. Display this new column as the fourth column in the output.

	-	Following Total, display the existing column PassengerCapacity.

	-	Display only the rows for which the value of Total is less than one-third of the airplane's capacity.

	-	Sort the ouput by the values of Total. 

Submit the query and view the output. 

****************************************************************************************************/

Proc sql ;
	select FlightNumber, Date,  Destination , 
		sum(Boarded, Transferred,Nonrevenue) as total,
		PassengerCapacity
	from SASUser1.Marchflights
	where calculated total  < PassengerCapacity/3
	order by  total ;
quit;


data SASUser1.Payrollchanges;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Payrollchanges.csv" dlm=','firstobs=2 dsd missover;   
   input DateOfBirth	DateOfHire	EmpID $	Gender $	 JobCode $	Salary;
   informat DateOfBirth date. DateOfHire date. Salary dolLAR.;
   format DateOfBirth date. DateOfHire date. Salary dolLAR.;
run;
/****************************************************************************************************
Write a PROC SQL query that displays all columns and all rows from Sasuser.Payrollchanges. 
Add a QUIT statement to the query. Submit the query and view the output.

Modify the query as follows:

	-Display the existing columns EmpID, Gender, Jobcode, and Salary.
	-Specify a fifth column named Tax, which is calculated as one-third of the employee's salary.
	-Display information for male employees only.
	-Sort the output by JobCode.
Submit the query and view the output.
Modify the query as follows:

	-Display the Tax and Salary columns with commas and two decimal places.
	-Label the EmpID column Employee ID Number.
	-Display two title lines: the first title is Federal Taxes and the second is Male Employees with Payroll Changes.

****************************************************************************************************/

proc sql;
title1 'Federal Taxes';
title2 'Male Employees with Payroll Changes';
   select empid label='Employee ID Number',
          gender,
          jobcode,
          salary format=comma10.2,
          salary/3 as Tax format=comma10.2
      from SASUser1.payrollchanges
      where gender='M'
      order by jobcode;
quit;

/****************************************************************************************************
	To view the expected PROC SQL output, click the related link in the text for each step.
-Create a PROC SQL query to display the total miles traveled by frequent-flyer program members. 
	From the table Sasuser.Frequentflyers, select the columns Name, State, and MilesTraveled. 
	Sort the results by state. Add a QUIT statement at the end of the query. 
	Submit the query and view the output.

-Modify the query to display summary results by state, as follows: 

	- Remove the columns Name and MilesTraveled from the output.
	- Define the new column TotTravelMiles as the sum of MilesTraveled.
	- Define the new column Members as the count of all frequent-flyer program members (rows).
	- Group and sort the results by state.
Submit the query and view the output.

-Modify the query to display summary results only for those states that have fewer than five frequent-flyer program members. 
	Include the following: 

	- Add a HAVING clause to subset groups.
	- Add this text as the first title line: Total Miles Traveled for States.
	- Add this text as the second title line: with Fewer Than 5 Members.
	- As before, sort the results by state.
Submit the query and view the output.

-Submit a null TITLE statement to cancel the titles.

****************************************************************************************************/
data SASUser1.Frequentflyers;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Frequentflyers.csv" dlm=','firstobs=2 dsd missover;   
   input FFID $	MemberType $	Name :$20.	Address :$ 20.	PhoneNumber :$20.	City $	State $	ZipCode 	MilesTraveled	PointsEarned	PointsUsed;
run;

proc sql;
		title1 = 'Total Miles Traveled for States';
		title2 = 'with Fewer Than 5 Members';
	select state, count(MemberType) AS NumOfMembers,  sum(MilesTraveled) as TotTravelMiles
		from SASUser1.Frequentflyers
		group by state
		having NumOfMembers < 5
		order by state;
quit;
title;

/****************************************************************************************************
To view the expected PROC SQL output, click the related link in the text for each step.
-Create a PROC SQL query to display the names of all employees who were hired in the month of February in any year. 
Use a subquery, as follows:

	- In the subquery, select EmpID from Sasuser.Payrollmaster for all employees whose hire month, in DateOfHire, is 2.
	- In the outer query, select FirstName, LastName, and State from Sasuser.Staffmaster for all employees with an EmpID 
		that matches the EmpID returned by the subquery.

Order the report by LastName. Add the title Employees with February Anniversaries. Add a QUIT statement to the query. 
Submit the query and view the output.

- the query to group and order results by state, and list the number of employees in each state who have February anniversaries. 
	Make the following changes:

	- Add a second title: by State.
	- Add a GROUP BY clause and modify the ORDER BY clause.
	- In the SELECT clause list, delete FirstName and LastName, leaving State. 
		At the end of the SELECT clause, define a new column using the COUNT function to count employees (by EmpID). 
		Use the alias Employees for the new column.

Submit the query and view the output.

-Submit a null TITLE statement to cancel titles.

****************************************************************************************************/
data SASUser1.Payrollmaster;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Payrollmaster.csv" dlm=',' firstobs=2 dsd missover;   
   input DateOfBirth	DateOfHire	EmpID	Gender $	JobCode	$ Salary;
   informat DateOfBirth date9. DateOfHire date9. salary dollar10.;
   format DateOfBirth date9. DateOfHire date9. salary dollar10.;
run;
data SASUser1.Staffmaster;
   infile "E:\Tutorial\SAS Programming Essential\SASUser\Staffmaster.csv" dlm=','firstobs=2 dsd missover;   
   input EmpID	LastName :$ 10.	FirstName :$ 10.	City $	State $	PhoneNumber :$ 20.;
run;

proc sql;
	select catx(' ' ,firstname, lastname) as Name
	from SASUser1.Staffmaster
	where Staffmaster.empid = ( select Payrollmaster.empid
								from SASUser1.Payrollmaster
								where month(dateofhire) = 2)
								;
quit;

/****************************************************************************************************
To view the expected PROC SQL output, click the related link in the text for each step.
-Create a PROC SQL query to list all frequent-flyer program members who are also airline employees. 
	Use a correlated subquery, as follows:
	- In the subquery, select employee data from Sasuser.Staffmaster.
	- In the outer query, select Name from Sasuser.Frequentflyers for all employees whose name is returned from the subquery.
Note that the names are stored differently in the two tables. 
(Hint: Use the TRIM function and concatenation operator in the subquery.)
Order the report by Name. Add the title Frequent Flyers Who Are Employees. 
Add a QUIT statement to the query. Submit the query and view the output.
- Modify the previous query to list all frequent-flyer program members who are not employees. 
	Change the title to Frequent Flyers Who Are Not Employees. Submit the query and view the output.
- Modify the previous query to display the total number of frequent-flyer program members who are not employees. 
	The output should display a single column called Count. Submit the query and view the output.
- Submit a null TITLE statement to cancel titles.

****************************************************************************************************/

proc sql;
	title1 'Frequent Flyers Who Are Employees';
	select count(name) from Sasuser1.Frequentflyers
	where  exists ( select catx(", ", lastname, firstname) as name
						from SASUser1.Staffmaster
						where Frequentflyers.name = calculated name);
quit;
title;
