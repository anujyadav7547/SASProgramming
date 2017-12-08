/****************************************************************************************
					Performing Queries Using PROC SQL
****************************************************************************************/
libname SASUser1 'E:\Tutorial\SAS Programming Essential\SASUser';

data sasuser1.newadmit;
	infile "E:\Tutorial\SAS Programming Essential\SASUser\newadmit.csv" delimiter=',' firstobs=2 dsd missover;
	input
                  ID
                  Name :$16.
                  Sex $
                  Age
                  Date
                  Height
                  Weight
                  ActLevel $
                  Fee
                  MeterHgt
                  KgWgt
      ;
run;


/*******************************************************************************************************************************
Using PROC SQL, select the columns ActLevel, Age, KgWgt, and MeterHgt from Sasuser.Newadmit. 
Create a new column named BodyMass as kgwgt/meterhgt**2. (The symbol ** indicates exponentiation.) 
Select only females (F), and order rows by values of ActLevel. Add a QUIT statement to the query to end the procedure.
*******************************************************************************************************************************/
proc sql;
	select ActLevel, Age, KgWgt,  MeterHgt
		from Sasuser1.Newadmit
		where sex = 'F'
		order by actlevel;
quit;

/*******************************************************************************************************************************
Join Sasuser.Therapy1999 and Sasuser.Totals2000 using PROC SQL.
Write a PROC SQL step to select Month, WalkJogRun, and Swim from Sasuser.Therapy1999 and to 
select Treadmill and Newadmit from Sasuser.Totals2000 (Month is in both tables). 
Create the new column Exercise by adding the values of the columns WalkJogRun and Swim. 
Select rows for which the values of Month match. End the step with a QUIT statement.
*******************************************************************************************************************************/
data sasuser1.Therapy1999;
	infile "E:\Tutorial\SAS Programming Essential\SASUser\Therapy1999.csv" delimiter=',' firstobs=2 dsd missover;
	input Month	Year	AerClass	WalkJogRun	Swim

      ;
run;
data sasuser1.Totals2000;
	infile "E:\Tutorial\SAS Programming Essential\SASUser\Totals2000.csv" delimiter=',' firstobs=2 dsd missover;
	input Month	Therapy	NewAdmit	Treadmill

      ;
run;
proc sql;
	select  Therapy1999.Month, WalkJogRun, Swim, Treadmill , Newadmit
			, sum( WalkJogRun , Swim) as Exercise 
		from Sasuser1.Therapy1999, Sasuser1.Totals2000
		where Therapy1999.month = Totals2000.month
		;
quit;


/*******************************************************************************************************************************
Summarize and group data in Sasuser.Diabetes using PROC SQL.
Write a PROC SQL step to select Sex from Sasuser.Diabetes. Create AverageAge by calculating the average value of Age. 
Create AverageWeight by calculating the average value of Weight. Group the results by the values of Sex. 
End the step with a QUIT statement.
*******************************************************************************************************************************/
data sasuser1.Diabetes;
	infile "E:\Tutorial\SAS Programming Essential\SASUser\Diabetes.csv" delimiter=',' firstobs=2 dsd missover;
	input ID	Sex $	Age	Height	Weight	Pulse	FastGluc	PostGluc

      ;
run;

proc sql;
	select  Sex 
		, avg(age) as AverageAge 
		, avg(Weight) as AverageWeight  
		from Sasuser1.Diabetes
		group by Sex
		;
quit;


proc sql feedback;
	select  Sex 
		, avg(age) as AverageAge 
		, avg(Weight) as AverageWeight  
		from Sasuser1.Diabetes
		group by Sex
		;
quit;

proc sql feedback;
	title1 "test";
	select * from orion.customer_dim
	where Customer_Gender = 'F' and 
		Customer_Group like '%Gold%' and
		Customer_Age >= 18 and
		Customer_Age <= 36;
quit;

