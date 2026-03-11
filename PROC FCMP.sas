/********************************************************
Creating custom functions in SAS

PROC FCMP - Function Compiler 

Author: Abhishek Jaiswal

Purpose: To demonstrate custom function creation in SAS
         using Function Compiler
********************************************************/


/* Example 1: Basic Square Function */
proc fcmp outlib=work.funcs.math;
	function square(x);
	return(x*x);
	endsub;
quit;

options cmplib=work.funcs;

data example1;
	x=5;
	result=square(x);
run;


/* Example 2: Percentage Change */

proc fcmp outlib=work.funcs.calc;
	function pct_change(new, old);

	if old=0 then return(.);
	return(((new-old)/old)*100);
	endsub;
quit;
	
options cmplib=work.funcs;

data example2;
	old=100;
	new=120;
	pct=pct_change(new, old);
run;



/* Example 3: Character Function */
proc fcmp outlib=work.funcs.text;
	function fullname(first $, last $) $50;
	name=catx(' ', first, last);
	return(name);
	endsub;
quit;
	
options cmplib=work.funcs;

data example3;
	name=fullname("John", "Doe");
run;


/* Example 4: Grade Classification */
proc fcmp outlib=work.funcs.logic;
	function grade(score);

	if score>=90 then
		g=1;
	else if score>=75 then
		g=2;
	else if score>=50 then
		g=3;
	else
		g=4;
	return(g);
	endsub;
quit;
	
options cmplib=work.funcs;

data example4;
	score=82;
	grade=grade(score);
run;



/* Example 5: Nested Functions */
proc fcmp outlib=work.funcs.math;
	function square(x);
	return(x*x);
	endsub;
	function cube(x);
	return(x*square(x));
	endsub;
quit;
	
options cmplib=work.funcs;

data example5;
	x=3;
	sq=square(x);
	cb=cube(x);
run;


/* Example 6: Date Difference */
proc fcmp outlib=work.funcs.date;
	function days_between(d1, d2);
	return(d2-d1);
	endsub;
quit;

options cmplib=work.funcs;

data example6;
	date1='01JAN2024'd;
	date2='15JAN2024'd;
	diff=days_between(date1, date2);
run;



/* Example 7: Safe Division */
proc fcmp outlib=work.funcs.utils;
	function safe_div(a, b);

	if b=0 then
		return(.);
	return(a/b);
	endsub;
quit;

options cmplib=work.funcs;

data example7;
	a=10;
	b=0;
	result=safe_div(a, b);
run;


/* Example 8: Subroutine */
proc fcmp outlib=work.funcs.calc;
	subroutine circle(r, area, circ);
	outargs area, circ;
	area=3.14*r*r;
	circ=2*3.14*r;
	endsub;
quit;

options cmplib=work.funcs;

data example8;
	area=.;
	circ=.;
	radius=5;
	call circle(radius, area, circ);
run;



/* Example 9: PROC SQL Usage */

options cmplib=work.funcs;

proc sql;
     select name, weight,
            square(weight) as weight_sq
       from sashelp.class;
quit;



/* Example 10: Z-score */
proc fcmp outlib=work.funcs.stats;
	function zscore(x, mean, std);

	if std=0 then
		return(.);
	return((x-mean)/std);
	endsub;
quit;

options cmplib=work.funcs;

data example10;
	x=85;
	mean=70;
	std=10;
	z=zscore(x, mean, std);
run;


/* Example 11: Unit Conversion Utility */

proc fcmp outlib=work.funcs.conv;
	function convert_weight(value, unit $);
	length result 8;

	if upcase(unit)='lb' then
		result=value/2.20462;
	else if upcase(unit)='kg' then
		result=value;
	else
		result=.;
	return(result);
	endsub;
quit;

options cmplib=work.funcs;

data patients;
	input id weight unit $;
	weight_kg=convert_weight(weight, unit);
	datalines;

101 180 LB
102 75 KG
103 150 LB
;
run;



/* Example 12: eGFR Calculation  */
proc fcmp outlib=work.fcmp.clinical;
	function egfr(creatinine, age, sex $);
	length factor 8;

	if upcase(sex)='f' then
		factor=0.85;
	else
		factor=1;
	egfr=175 * (creatinine**(-1.154)) * (age**(-0.203)) * factor;
	return(egfr);
	endsub;
quit;

options cmplib=work.fcmp;

data labs;
	input USUBJID $ creatinine age sex $;
	egfr_value=egfr(creatinine, age, sex);
	datalines;

SUBJ001 1.1 45 M
SUBJ002 0.9 52 F
SUBJ003 1.5 60 M
SUBJ004 1.0 38 F
;
run;

