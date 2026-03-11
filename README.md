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

   /* programming statements */

RETURN(expression);

ENDSUB;
QUIT;
