/***********************************************************************************************************
	SYMPUT routine, using the Sasuser.Schedule data set.
- Copy the following program and paste it into the code editing window:
data practice;
  set sasuser.schedule;
run;
Modify the program so that it creates two macro variables:
	- same_val with a value of Hallis, Dr. George
	- current_val with a value of the data set variable Teacher.
- Following the DATA step, add one or more %PUT statements that will write the value of the macro variables 
	that were created in step 1 to the SAS log.
	Submit the code and examine the log for messages about the macro variables.
- Add a WHERE statement to the program so that only courses that are offered in Boston are included in the Practice data set. 
	Submit the program and examine the log for messages about the macro variables.
***********************************************************************************************************/

data practice;
  	set sasuser.schedule;
	call symput('same_val', 'Hallis, Dr. George');
	call symput('current_val', Teacher);
	where location = 'Boston';
	%put &same_val &current_val;
run;

/***********************************************************************************************************
	Create macro variables with the SYMPUT routine, using the Sasuser.Courses data set.	 
- Submit an OPTIONS statement to reset the system option DATE | NODATE to NODATE, and to activate the SYMBOLGEN option.

- Write a DATA step that creates a macro variable named date. This macro variable's value should be 
	today's date in the MMDDYY10. format.
Note	The TODAY function returns today's date as a SAS date value.

- Write a PROC PRINT step that prints data in the Sasuser.Courses data set. 
Precede this step with a TITLE statement that prints the following title on the report, 
substituting the value of the macro variable date for the Xs:
	"Courses Offered as of XXXXXX"
	Submit the program and examine the output.

- Modify the DATA step so that value of the macro variable date is written using the WORDDATE20. 
	format (month dd, year). Submit the program and examine the output.

- If you are using listing output, make sure there are no blanks in the title.
***********************************************************************************************************/

options nodate symbolgen;

data Courses;
	set sasuser.Courses;
	call symput('date', put(TODAY(),mmddyy10.));
run;

%put &date;






