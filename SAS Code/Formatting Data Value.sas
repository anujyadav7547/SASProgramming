libname anuj 'E:\Tutorial\SAS Programming Essential';
libname orion 'E:\Tutorial\SAS Programming Essential\Orion';
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
