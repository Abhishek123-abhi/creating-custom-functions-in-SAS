# creating-custom-functions-in-SAS
## "This repository provides a clear and practical introduction to PROC FCMP in SAS, covering the concepts of custom function and subroutine creation, implementation techniques, and examples demonstrating reusable programming practices across various analytical tasks."

**"If you're already familiar with R or Python, you understand how custom functions help eliminate repetition and make code more modular and maintainable. PROC FCMP is SAS’s answer to this need, enabling programmers to extend SAS with their own reusable functions and subroutines."**

## Why PROC FCMP?
In many SAS programs, developers frequently encounter situations where the same logic must be implemented repeatedly, whether for routine calculations, standardized business rules, or commonly used data transformations. As projects grow, this repetition can make programs harder to maintain, less consistent, and more difficult to scale.

**PROC FCMP** addresses this challenge by enabling programmers to encapsulate such logic into reusable functions and subroutines. This promotes a more structured programming approach, improves code readability, and supports consistency across projects. Whether working in healthcare, finance, research, or any data-driven domain, this ability to build reusable components helps streamline workflows and encourages more efficient and maintainable SAS programming practices.

## PROC FCMP Workflow
A typical PROC FCMP workflow follows these steps:

**Create the function → Store it in a library → Enable CMPLIB → Use it like a built-in function**

**Steps involved:**
- Define the function using PROC FCMP
- Store the compiled function using the OUTLIB option
- Enable access using the OPTIONS CMPLIB statement
- Call the function inside DATA steps like any standard SAS function


## Syntax:

```sas
PROC FCMP OUTLIB=libref.table.package;
     FUNCTION function_name(arguments) <$> <length>;

             ... programming statements ...

            RETURN(expression);

      ENDSUB;
QUIT;
```

## Syntax Components Explained

### OUTLIB = libref.dataset.package
Specifies where the compiled function is stored.

- **libref** → Library name  
- **dataset** → Dataset storing functions  
- **package** → Function group name  

*Required option in PROC FCMP.*

---

### FUNCTION Statement

Defines the function name, arguments, and return type.

**Syntax:**

FUNCTION function_name(arguments) <$> <length>;

- **function_name** → Custom function name  
- **arguments** → Input parameters  
- **$** → Character return type (default numeric)  
- **length** → Length of character return value  

Example:

FUNCTION fullname(first $, last $) $50;

---

### RETURN Statement

Specifies the value returned by the function.

RETURN(expression);

*Every function must contain a RETURN statement.*

---

### ENDSUB Statement

Marks the end of the function definition.

ENDSUB;


## Making the Function Available (CMPLIB Option)

After creating a function using PROC FCMP, it must be made available before it can be used in a DATA step. This is done using the **CMPLIB** system option.

**Syntax:**

```sas
options cmplib = libref.dataset;
```

**"After enabling the CMPLIB option, the custom function can be used just like any built-in SAS function, allowing the same logic to be reused across DATA steps, PROC steps, and other SAS workflows."**
```sas
PROC FCMP OUTLIB=work.functions.math;

FUNCTION square(x);
   RETURN(x*x);
ENDSUB;

QUIT;

/* Enable custom functions */
options cmplib=work.functions;

/* Using the function like a built-in SAS function */
data example;

x = 8;

y = square(x);

run;
```

## Using PROC FCMP Functions Inside Other Functions

PROC FCMP supports modular programming by allowing user-defined functions to call other user-defined functions. This helps break complex logic into smaller reusable components.

Example:

```sas
PROC FCMP OUTLIB=work.functions.math;

FUNCTION square(x);
   RETURN(x*x);
ENDSUB;

FUNCTION cube(x);
   RETURN(x*square(x));   /* Calling another FCMP function */
ENDSUB;

QUIT;

options cmplib=work.functions;

data example;

x = 4;

sq = square(x);

cb = cube(x);

run;

```



## PROC FCMP vs SAS Macro

Although both PROC FCMP and SAS Macros improve reusability, they address different aspects of SAS programming.

### Conceptual Difference

**PROC FCMP → Reusable logic (functions)**  
**SAS Macro → Reusable code (automation)**

---

### Key Differences Between PROC FCMP and SAS Macro

| Aspect | PROC FCMP (Function Compiler) | SAS Macro Facility |
|--------|--------------------------------|--------------------|
| Primary role | Creates user-defined functions | Generates reusable SAS code |
| Programming level | Works at data value level | Works at program text level |
| Execution timing | Executes during DATA step runtime | Resolves during compile phase |
| How it is used | Called like built-in SAS functions | Invoked using macro calls |
| Typical usage | Calculations, derivations, transformations | Automation, looping, dynamic programs |
| Programming concept | Similar to functions in R/Python | Similar to code templates |
| Return behavior | Returns computed values | Produces SAS code |


### When to use PROC FCMP
Use PROC FCMP when you need:
- Reusable calculations
- Data transformation logic
- Validation functions
- Statistical utilities

### When to use Macros
Use macros when you need:
- Dynamic code generation
- Repetitive PROC execution
- Parameterized programs
- Workflow automation

### Key takeaway

**Use PROC FCMP for reusable logic.  
Use Macros for reusable code.**
