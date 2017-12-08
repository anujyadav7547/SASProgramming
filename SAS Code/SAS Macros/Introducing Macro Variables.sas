libname sasuser1 'E:\Tutorial\SAS Programming Essential\SASUser';
proc print data=sasuser1.flightschedule noobs label uniform;
   title 'Courses Taken by Selected Students:';
   title2 'Those with Babbit in Their Name';
   footnote "Report Created on &sysdate9.";
run;



/******************************************************************
Define and use macro variables with the Sasuser.All data set.
Submit a null FOOTNOTE statement in order to clear any existing footnotes.

Copy the program shown below and paste it into the code editing window:
proc print data=sasuser.all noobs label uniform;
   where student_name contains 'Babbit';
   by student_name student_company;
   var course_title begin_date location teacher;
   title 'Courses Taken by Selected Students:';
   title2 'Those with Babbit in Their Name';
run;
Submit the program and examine the output that it creates.

Change the search pattern in the WHERE statement and TITLE2 statement from Babbit to Ba. 
Then resubmit the program and examine the output. 

Modify the program so that the two occurrences of Ba are replaced by references to the macro variable pattern. 
Assign the value Ba to pattern. 
Modify the quotation marks as needed. Submit the program and examine the output. 
******************************************************************/
footnote;
%let pattern = Ba ;
proc print data=sasuser.all noobs label uniform;
   where student_name contains "&pattern";
   by student_name student_company;
   var course_title begin_date location teacher;
   title 'Courses Taken by Selected Students:';
   title2 "Those with &pattern in Their Name";
run;


/**************************************************
Display resolved macro variables in the SAS log.
****************************************************/
option  symbolgen;
%let num=8;
proc print data=sasuser.all label noobs n;
   /*where course_number=#*/
   var student_name Student_Company;
   title "Enrollment for Course &num";
run;

/*******************************************************************
	Use macro quoting functions with the Sasuser.All data set.
********************************************************************/
option symbolgen;
%let name = %str(O%'Savio);
proc print data=sasuser.all noobs label uniform;
   where student_name contains "&name";
   by student_name student_company;
   var course_title begin_date location teacher;
   title 'Courses Taken by Selected Students:';
   title2 "Those with &name in Their Name";
run;
/*******************************************************************
	Use macro character functions with the Sasuser.Schedule data set.
********************************************************************/
title;
proc sort data=sasuser.schedule out=work.sorted;
   by course_number begin_date;
run;

%let dsn= SASUSER.SCHEDULE;
title "Variables in &dsn";

proc sql;
   select name, type, length
      from dictionary.columns
      where libname="%scan(&dsn,1,.)" and
            memname="%scan(&dsn,2,.)";
quit;
/****** Change the %LET statement to assign the value of the SYSLAST automatic macro variable to the 
dsn macro variable. Submit the modified program to see the new report.  *****************/
%let dsn= &syslast;
title "Variables in &dsn";

proc sql;
   select name, type, length
      from dictionary.columns
      where libname="%scan(&dsn,1,.)" and
            memname="%scan(&dsn,2,.)";
quit;

/****************************************************************************************
Combine macro variable references with text and use delimiters with macro variable names, 
using the Sasuser.Schedule and Sasuser.Courses data sets.
****************************************************************************************/
title;
%let table1 = schedule;
%let table2 = register;
%let joinvar = course_number;
%let freqvar = location;
proc sql;
   select location,n(location) label='Count'
      from sasuser.&table1,sasuser.&table2
      where &table1..&joinvar=
            &table2..&joinvar
      group by &freqvar;
	  
quit;
